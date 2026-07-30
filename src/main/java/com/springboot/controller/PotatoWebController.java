package com.springboot.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.springboot.dto.BrokerRequisitionListDTO;
import com.springboot.dto.FarmerCycleHistoryDTO;
import com.springboot.dto.FarmerCycleHistoryDetailDTO;
import com.springboot.dto.FarmlandDTO;
import com.springboot.dto.RegisterCycleDTO;
import com.springboot.dto.RegisterLandForm;
import com.springboot.dto.RequisitionFormDTO;
import com.springboot.model.Broker;
import com.springboot.model.CropCycle;
import com.springboot.model.CycleRegister;
import com.springboot.model.Farmer;
import com.springboot.model.Farmland;
import com.springboot.model.ItemRequisition;
import com.springboot.repository.ItemRequisitionRepository;
import com.springboot.service.BrokerRequisitionService;
import com.springboot.service.BrokerService;
import com.springboot.service.CropCycleService;
import com.springboot.service.CycleRegisterService;
import com.springboot.service.FarmerCycleHistoryDetailService;
import com.springboot.service.FarmerCycleHistoryService;
import com.springboot.service.FarmerService;
import com.springboot.service.FarmlandService;
import com.springboot.service.ItemRequisitionService;

import jakarta.servlet.http.HttpSession;


@Controller
public class PotatoWebController{
	 @Autowired
     private FarmerService farmerService;
	 
	 @Autowired
	 private BrokerService brokerService;
	 
	 @Autowired CropCycleService cropCycleService;
	 
	 @Autowired
	 private FarmlandService farmlandService;
	 
	 @Autowired
	 private CycleRegisterService cycleRegisterService;
	
	 @Autowired
	 private FarmerCycleHistoryService farmerCycleHistoryService;
	 
	 @Autowired
	 private FarmerCycleHistoryDetailService farmerCycleHistoryDetailService;
	 
	 @Autowired
	 private ItemRequisitionService itemRequisitionService;
	 
	 @Autowired
	 private ItemRequisitionRepository itemRequisitionRepository;
	 
	 @Autowired
	 private BrokerRequisitionService brokerRequisitionService;

	 
	   @GetMapping("/broker/login")
	   public String showBrokerLogin() {
	       return "broker_login";
	   }
	   
	   @GetMapping("/")
	   public String websiteHome(){
	       return "homepage";
	   }
	
	   @GetMapping("/farmer/login")
	    public ModelAndView showFarnmerLoginPage() {
	        ModelAndView mav = new ModelAndView("farmer_login");
	        mav.addObject("farmer", new Farmer());
	        return mav;
	    }
	   
	   @GetMapping("/register")
	    public ModelAndView showRegisterPage() {
	        ModelAndView mav = new ModelAndView("register_farmer");
	        mav.addObject("farmer", new Farmer());
	        return mav;
	    }
	   
	   @GetMapping("/broker/home")
	   public ModelAndView showBrokerHome(HttpSession session){
	       if(session.getAttribute("brokerId") == null){
	           return new ModelAndView("redirect:/broker/login");
	       }
	       ModelAndView mav = new ModelAndView("broker_home");
	       mav.addObject("firstname",session.getAttribute("firstname"));
	       mav.addObject("lastname",session.getAttribute("lastname"));
	       return mav;
	   }
	
	   @GetMapping("/broker/cycles")
	   public ModelAndView brokerCycleList(
	           @RequestParam(required = false, defaultValue = "date") String sort,
	           HttpSession session) {

	       if(session.getAttribute("brokerId") == null){
	           return new ModelAndView("redirect:/broker/login");
	       }

	       List<CropCycle> cycles;

	       switch(sort){
	           case "name":
	               cycles = cropCycleService.findAllOrderByName();
	               break;

	           case "status":
	               cycles = cropCycleService.findAllOrderByStatus();
	               break;

	           default:
	               cycles = cropCycleService.findAllOrderByDate();
	               break;
	       }

	       Map<Integer, Long> registeredCount = new HashMap<>();
	       Map<Integer, Integer> percentMap = new HashMap<>();

	       for(CropCycle cycle : cycles){
	           long count = cycleRegisterService.countFarmersByCycleId(cycle.getCyleId());

	           registeredCount.put(cycle.getCyleId(), count);

	           int percent = 0;
	           if(cycle.getMaxpeople() > 0){
	               percent = (int)((count * 100) / cycle.getMaxpeople());
	           }

	           percentMap.put(cycle.getCyleId(), percent);
	       }

	       long openCount = cycles.stream()
	               .filter(c -> "OPEN".equals(c.getStatus()))
	               .count();

	       long progressCount = cycles.stream()
	               .filter(c -> "PROGRESS".equals(c.getStatus()))
	               .count();

	       long closeCount = cycles.stream()
	               .filter(c -> "CLOSE".equals(c.getStatus()))
	               .count();

	       ModelAndView mav = new ModelAndView("broker_list_cycle");

	       mav.addObject("cycles", cycles);
	       mav.addObject("sort", sort);

	       mav.addObject("totalCycle", cycles.size());
	       mav.addObject("openCount", openCount);
	       mav.addObject("progressCount", progressCount);
	       mav.addObject("closeCount", closeCount);

	       mav.addObject("registeredCount", registeredCount);
	       mav.addObject("percentMap", percentMap);

	       return mav;
	   }
	   
	   @GetMapping("/broker/cycle/detail/{cycleId}")
	   public ModelAndView brokerCycleDetail(
	           @PathVariable("cycleId") int cycleId,
	           HttpSession session) {

	       if (session.getAttribute("brokerId") == null) {
	           return new ModelAndView("redirect:/broker/login");
	       }

	       CropCycle cycle = cropCycleService.findById(cycleId).orElseThrow();

	       long registered =
	               cycleRegisterService.countFarmersByCycleId(cycleId);

	       long remaining =
	               cycle.getMaxpeople() - registered;

	       int percent = 0;
	       if (cycle.getMaxpeople() > 0) {
	           percent = (int) ((registered * 100) / cycle.getMaxpeople());
	       }

	       ModelAndView mav =
	               new ModelAndView("broker_cycle_detail");

	       mav.addObject("cycle", cycle);
	       mav.addObject("registered", registered);
	       mav.addObject("remaining", remaining);
	       mav.addObject("percent", percent);

	       return mav;
	   }
	   
	   @GetMapping("/broker/cycle/add")
	   public ModelAndView showAddCyclePage() {
	       ModelAndView mav = new ModelAndView("broker_add_cycle");
	       mav.addObject("cycle", new CropCycle());

	       return mav;
	   }
	   
	   @PostMapping("/broker/cycle/save")
	   public ModelAndView saveCycle( @ModelAttribute("cycle") CropCycle cycle){
	       ModelAndView mav = new ModelAndView("broker_add_cycle");
	       try {
	           if(cycle.getCycleName() == null ||
	              cycle.getCycleName().trim().isEmpty()){

	               mav.addObject("error","กรุณากรอกชื่อรอบ");
	               return mav;
	           }

	           if(cycle.getPurchasePrice() == null){
	               mav.addObject("error","กรุณากรอกราคารับซื้อ");
	               return mav;
	           }

	           if(cycle.getMaxpeople() <= 0){
	               mav.addObject("error","จำนวนเกษตรกรต้องมากกว่า 0");
	               return mav;
	           }
	           
	           if(cycle.getEndRegDate().isBefore(cycle.getOpenRegDate())){
	               mav.addObject("error","วันปิดลงทะเบียนต้องมากกว่าวันเปิด");
	               return mav;
	           }

	           if(cycle.getPlantDate().isBefore(cycle.getEndRegDate())){
	               mav.addObject("error","วันปลูกต้องอยู่หลังวันปิดลงทะเบียน");
	               return mav;
	           }

	           if(cycle.getHarvestDate().isBefore(cycle.getPlantDate())){
	               mav.addObject("error","วันเก็บเกี่ยวต้องอยู่หลังวันปลูก");
	               return mav;
	           }

	           cycle.setStatus("OPEN");
	           cropCycleService.save(cycle);
	           return new ModelAndView("redirect:/broker/cycles");

	       }
	       catch(Exception e){
	           e.printStackTrace();
	           mav.addObject("error","เกิดข้อผิดพลาดในการบันทึกข้อมูล");
	           return mav;
	       }
	   }
	   
	   @GetMapping("/broker/cycle/edit/{cycleId}")	
	   public ModelAndView showEditCyclePage(
	           @PathVariable("cycleId") int cycleId,
	           HttpSession session) {

	       if (session.getAttribute("brokerId") == null) {
	           return new ModelAndView("redirect:/broker/login");
	       }

	       CropCycle cycle = cropCycleService.findById(cycleId).orElseThrow();

	       ModelAndView mav = new ModelAndView("broker_edit_cycle");
	       mav.addObject("cycle", cycle);

	       return mav;
	   }
	   
	   @GetMapping("/broker/cycle/{cycleId}/farmers")
	   public ModelAndView registeredFarmers(
	           @PathVariable("cycleId") int cycleId,
	           @RequestParam(required = false) String success,
	           HttpSession session) {

	       if(session.getAttribute("brokerId") == null){
	           return new ModelAndView("redirect:/broker/login");
	       }

	       CropCycle cycle =
	               cropCycleService.findById(cycleId).orElseThrow();

	       List<Farmer> farmers =
	               cycleRegisterService.findFarmersByCycleIdAndStatus(
	                       cycleId,
	                       "PENDING");

	       ModelAndView mav =
	               new ModelAndView("broker_registered_farmer");

	       mav.addObject("cycle", cycle);
	       mav.addObject("farmers", farmers);
	       mav.addObject("total", farmers.size());
	       mav.addObject("success", success);

	       return mav;
	   }
	   
	   @GetMapping("/broker/cycle/{cycleId}/farmer/{farmerId}")
	   public ModelAndView farmerRegisterDetail(
	           @PathVariable("cycleId") int cycleId,
	           @PathVariable("farmerId") int farmerId,
	           @RequestParam(required = false) String success,
	           @RequestParam(required = false) Integer registerId,
	           HttpSession session) {

	       if(session.getAttribute("brokerId") == null) {
	           return new ModelAndView("redirect:/broker/login");
	       }

	       CropCycle cycle = cropCycleService.findById(cycleId).orElseThrow();
	       Farmer farmer = farmerService.findById(farmerId).orElseThrow();

	       List<Farmland> lands =
	               farmlandService.findByFarmerIdAndCycleId(farmerId, cycleId);

	       CycleRegister register;

	       if(registerId != null) {
	           register = cycleRegisterService.findById(registerId).orElseThrow();
	       } else {
	           List<CycleRegister> registers =
	                   cycleRegisterService.findByCycleIdAndFarmerIdAndStatus(
	                           cycleId,
	                           farmerId,
	                           "PENDING");

	           if(registers.isEmpty()) {
	               return new ModelAndView(
	                   "redirect:/broker/cycle/" + cycleId + "/farmers"
	               );
	           }

	           register = registers.get(0);
	       }

	       ModelAndView mav =
	               new ModelAndView("broker_registered_farmer_detail");

	       mav.addObject("cycle", cycle);
	       mav.addObject("farmer", farmer);
	       mav.addObject("lands", lands);
	       mav.addObject("landCount", lands.size());
	       mav.addObject("register", register);
	       mav.addObject("success", success);

	       return mav;
	   }
	   
	   @PostMapping("/broker/register/update-status")
	   public ModelAndView updateRegistrationStatus(
	           @RequestParam("registerId") int registerId,
	           @RequestParam("cycleId") int cycleId,
	           @RequestParam("farmerId") int farmerId,
	           @RequestParam("status") String status,
	           HttpSession session) {
	       if (session.getAttribute("brokerId") == null) {
	           return new ModelAndView("redirect:/broker/login");
	       }
	       try {
	           cycleRegisterService.reviewRegistration(
	                   registerId,
	                   status
	           );

	           String success =
	                   "APPROVED".equalsIgnoreCase(status)
	                           ? "approved"
	                           : "rejected";

	           return new ModelAndView(
	                   "redirect:/broker/cycle/"
	                           + cycleId
	                           + "/farmers?success="
	                           + success
	           );

	       } catch (IllegalArgumentException e) {

	           ModelAndView mav =
	                   new ModelAndView(
	                           "redirect:/broker/cycle/"
	                                   + cycleId
	                                   + "/farmer/"
	                                   + farmerId
	           );

	           mav.addObject(
	                   "error",
	                   e.getMessage()
	           );

	           return mav;
	       }
	   }
	   
	   @PostMapping("/broker/cycle/update")
	   public ModelAndView updateCycle(
	           @ModelAttribute("cycle") CropCycle cycle) {

	       try {
	           cropCycleService.save(cycle);
	           return new ModelAndView("redirect:/broker/cycle/detail/" + cycle.getCyleId());

	       } catch (Exception e) {
	           e.printStackTrace();

	           ModelAndView mav = new ModelAndView("broker_edit_cycle");
	           mav.addObject("cycle", cycle);
	           mav.addObject("error", "แก้ไขรอบไม่สำเร็จ");
	           return mav;
	       }
	   }
	   
	   @GetMapping("/farmer/home")
	    public ModelAndView showFarmerHome(HttpSession session) {
	        if(session.getAttribute("farmerId") == null) {
	            return new ModelAndView("redirect:/");
	        }

	        ModelAndView mav = new ModelAndView("farmer_home");
	        Integer farmerId = (Integer) session.getAttribute("farmerId");
	        Farmer farmer = farmerService.findById(farmerId).orElse(null);
	        mav.addObject("farmer", farmer);
	        
	        return mav;
	    }
	   
	   @RequestMapping(value = "/logout", method = RequestMethod.GET)
	 		public  String doLogout(HttpSession session) {
	 			session.removeAttribute("userName");
	 			session.setMaxInactiveInterval(0);
	 			return "redirect:/";	
	   }
	   
	   @PostMapping("/broker/doLogin")
	   public ModelAndView doLogin(@ModelAttribute("broker") Broker formBroker,HttpSession session) {

	       ModelAndView mav = new ModelAndView("broker_login");

	       try {

	           String username = formBroker.getUserName();
	           String password = formBroker.getPassword();

	           if(username == null || username.trim().isEmpty()
	                   || password == null || password.trim().isEmpty()) {
	               mav.addObject("error","กรุณากรอกชื่อผู้ใช้และรหัสผ่าน");
	               return mav;
	           }

	           Optional<Broker> brokerOpt =brokerService.findByUserName(username);
	        
	           if(brokerOpt.isEmpty()) {
	               mav.addObject("error","ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	               return mav;
	           }
	           
	           Broker broker = brokerOpt.get();
	           if(!password.equals(broker.getPassword())) {
	               mav.addObject("error","ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	               return mav;
	           }
	           
	           session.setAttribute("brokerId",broker.getBrokerId());
	           session.setAttribute("userName",broker.getUserName());
	           session.setAttribute("firstname",broker.getFirstname());
	           session.setAttribute("lastname",broker.getLastname());
	           session.setAttribute("email",broker.getEmail());
	           return new ModelAndView("redirect:/broker/home");

	       }
	       catch(Exception e) {
	           e.printStackTrace();
	           mav.addObject("error","เกิดข้อผิดพลาดในการเข้าสู่ระบบ");
	           return mav;
	       }
	   }
	   
		   
	   @PostMapping("/doRegister")
	   public ModelAndView processRegister(  @ModelAttribute("farmer") Farmer newFarmer,@RequestParam("confirmPassword") String confirmPassword,  
			   @RequestParam(value = "profileImage", required = false) MultipartFile profileImage) {
	       ModelAndView mav = new ModelAndView("register_farmer");
	       try {
	           String username = newFarmer.getUserName().trim();
	           if (!username.matches("^[a-zA-Z0-9_]+$")) {mav.addObject("error","ชื่อผู้ใช้ใช้ได้เฉพาะ a-z A-Z 0-9");
	               return mav;
	           }

	           if (!newFarmer.getPhoneNumber().matches("^\\d{10}$")) {mav.addObject("error","เบอร์โทรศัพท์ต้องมี 10 หลัก");
	               return mav;
	           }

	           if (!newFarmer.getPassword().equals(confirmPassword)) {mav.addObject("error","รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน");
	               return mav;
	           }

	           if (farmerService.findByUserName(username).isPresent()) {
	               mav.addObject("error","ชื่อผู้ใช้นี้ถูกใช้งานแล้ว");
	               return mav;
	           }
	           	
	           try{
	        	    if(profileImage!=null && !profileImage.isEmpty()){
	        	        String fileName= System.currentTimeMillis()+"_"+profileImage.getOriginalFilename();
	        	        Path uploadPath=Paths.get("src/main/resources/static/uploads/profile");
	        	        Files.createDirectories(uploadPath);
	        	        profileImage.transferTo(uploadPath.resolve(fileName));
	        	        newFarmer.setProfileImagePath(fileName);

	        	    }
	        	    else{
	        	        newFarmer.setProfileImagePath("default-profile.png");
	        	    }
	        	}catch(Exception e){
	        	    e.printStackTrace();
	        	}
	           
	           newFarmer.setOnboardingCompleted(false);
	           farmerService.save(newFarmer);
	           ModelAndView success = new ModelAndView("farmer_login");
	           success.addObject("success","สมัครสมาชิกสำเร็จ");
	           return success;

	       } catch (Exception e) {
	           e.printStackTrace();
	           mav.addObject("error","เกิดข้อผิดพลาดในการสมัครสมาชิก");
	           return mav;
	       }
	   }
	   
	    @PostMapping("/doLogin")
	    public ModelAndView doLogin(@ModelAttribute("farmer") Farmer formFarmer,HttpSession session) {
	        ModelAndView mav = new ModelAndView("farmer_login");

	        try {

	            String username = formFarmer.getUserName();
	            String password = formFarmer.getPassword();

	            if(username == null || username.trim().isEmpty()|| password == null || password.trim().isEmpty()) {
	                mav.addObject("error","กรุณากรอกชื่อผู้ใช้และรหัสผ่าน");
	                return mav;
	            }

	            Optional<Farmer> farmerOpt = farmerService.findByUserName(username);
	            if(farmerOpt.isEmpty()) {
	                mav.addObject("error","ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	                return mav;
	            }

	            Farmer farmer = farmerOpt.get();
	            if(!password.equals(farmer.getPassword())) {
	                mav.addObject("error","ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	                return mav;
	            }
	            session.setAttribute("farmerId",farmer.getFarmerId());
	            session.setAttribute("userName",farmer.getUserName());
	            session.setAttribute("firstname",farmer.getFirstname());
	            session.setAttribute("lastname",farmer.getLastname());
	            if(!farmer.isOnboardingCompleted()){
	                return new ModelAndView("redirect:/farmer/onboarding");
	            }
	            return new ModelAndView("redirect:/farmer/home");
	        }
	        catch(Exception e) {
	            e.printStackTrace();
	            mav.addObject("error","เกิดข้อผิดพลาดในการเข้าสู่ระบบ");
	            return mav;
	        }
	    }
	    
	    @GetMapping("/farmer/onboarding")
	    public ModelAndView showFarmerOnboarding(HttpSession session) {

	        if(session.getAttribute("farmerId") == null) {
	            return new ModelAndView("redirect:/");
	        }

	        ModelAndView mav = new ModelAndView("farmer_onboarding");

	        mav.addObject("firstname", session.getAttribute("firstname"));
	        mav.addObject("lastname", session.getAttribute("lastname"));

	        return mav;
	    }
	    
	    @PostMapping("/farmer/onboarding/complete")
	    public ModelAndView completeFarmerOnboarding(HttpSession session) {

	        if(session.getAttribute("farmerId") == null) {
	            return new ModelAndView("redirect:/");
	        }

	        Integer farmerId = (Integer) session.getAttribute("farmerId");

	        Farmer farmer = farmerService.findById(farmerId).orElseThrow();

	        farmer.setOnboardingCompleted(true);

	        farmerService.save(farmer);

	        return new ModelAndView("redirect:/farmer/cycles");
	    }
	    
	    
	    @GetMapping("/farmer/cycles")
	    public ModelAndView farmerCycleList(@RequestParam(required = false) String keyword, HttpSession session) {

	        Integer farmerId = (Integer) session.getAttribute("farmerId");
	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        ModelAndView mav = new ModelAndView("farmer_list_cycle");

	        List<CropCycle> cycles;
	        if (keyword != null && !keyword.trim().isEmpty()) {
	            cycles = cropCycleService.searchOpenCycles(keyword.trim());
	        } else {
	            cycles = cropCycleService.getOpenCycles();
	        }

	        Map<Integer, Long> registeredCount = new HashMap<>();
	        Map<Integer, Long> remainingCount = new HashMap<>();

	        for (CropCycle cycle : cycles) {
	            Integer cycleId = cycle.getCyleId();
	            long count = cycleRegisterService.countFarmersByCycleId(cycleId);
	            long remaining = Math.max(0, cycle.getMaxpeople() - count);

	            registeredCount.put(cycleId, count);
	            remainingCount.put(cycleId, remaining);
	        }

	        List<CycleRegister> farmerRegisters = cycleRegisterService.findByFarmerId(farmerId);

	        Set<Integer> registeredCycleIds = farmerRegisters.stream()
	                .filter(register -> register.getCycle() != null)
	                .filter(register -> "PENDING".equalsIgnoreCase(register.getRegStatus())
	                                 || "APPROVED".equalsIgnoreCase(register.getRegStatus()))
	                .map(register -> register.getCycle().getCyleId())
	                .collect(Collectors.toSet());

	        mav.addObject("cycles", cycles);
	        mav.addObject("keyword", keyword);
	        mav.addObject("registeredCount", registeredCount);
	        mav.addObject("remainingCount", remainingCount);
	        mav.addObject("registeredCycleIds", registeredCycleIds);

	        return mav;
	    }
	    
	    @GetMapping("/farmer/cycle/detail/{cycleId}")
	    public ModelAndView farmerCycleDetail(
	            @PathVariable("cycleId") int cycleId,
	            HttpSession session) {

	        if (session.getAttribute("farmerId") == null) {
	            return new ModelAndView("redirect:/");
	        }

	        Integer farmerId = (Integer) session.getAttribute("farmerId");

	        CropCycle cycle = cropCycleService.findById(cycleId).orElseThrow();
	        Farmer farmer = farmerService.findById(farmerId).orElseThrow();

	        long registered = cycleRegisterService.countFarmersByCycleId(cycleId);
	        long remaining = cycle.getMaxpeople() - registered;

	        boolean alreadyRegistered =
	                cycleRegisterService.alreadyRegistered(cycleId, farmerId);

	        ModelAndView mav = new ModelAndView("farmer_cycle_detail");

	        mav.addObject("cycle", cycle);
	        mav.addObject("farmer", farmer);
	        mav.addObject("registered", registered);
	        mav.addObject("remaining", remaining);
	        mav.addObject("alreadyRegistered", alreadyRegistered);

	        return mav;
	    }
	  
	    @PostMapping("/farmer/register-cycle-land")
	    @ResponseBody
	    public String registerOneLand(
	            @RequestParam("cycleId") int cycleId,
	            @RequestParam("titleDeedNo") String titleDeedNo,
	            @RequestParam("location") String location,
	            @RequestParam("rai") BigDecimal rai,
	            @RequestParam("ngan") BigDecimal ngan,
	            @RequestParam("squreWah") BigDecimal squreWah,
	            @RequestParam("frontImage") MultipartFile frontImage,
	            @RequestParam("backImage") MultipartFile backImage,
	            HttpSession session) {

	        try {
	            Integer farmerId = (Integer) session.getAttribute("farmerId");

	            if (farmerId == null) {
	                return "login";
	            }

	            Farmer farmer =
	                    farmerService.findById(farmerId).orElseThrow();

	            CropCycle cycle =
	                    cropCycleService.findById(cycleId).orElseThrow();

	            CycleRegister register =
	                    cycleRegisterService.findOrCreateRegister(cycle, farmer);

	            Path uploadPath =
	                    Paths.get("src/main/resources/static/uploads/titledeed");

	            Files.createDirectories(uploadPath);

	            String frontFileName =
	                    System.currentTimeMillis() + "_front_" +
	                    frontImage.getOriginalFilename();

	            frontImage.transferTo(uploadPath.resolve(frontFileName));

	            String backFileName =
	                    System.currentTimeMillis() + "_back_" +
	                    backImage.getOriginalFilename();

	            backImage.transferTo(uploadPath.resolve(backFileName));

	            Farmland land = new Farmland();

	            land.setTitleDeedNo(titleDeedNo);
	            land.setLocation(location);
	            land.setRai(rai);
	            land.setNgan(ngan);
	            land.setSqureWah(squreWah);
	            land.setTitleDeedImagePath(frontFileName);
	            land.setTitleDeedBackImagePath(backFileName);
	            land.setFarmer(farmer);
	            land.setCycleRegisters(Arrays.asList(register));

	            farmlandService.save(land);

	            return "success";

	        } catch (Exception e) {
	            e.printStackTrace();
	            return "error";
	        }
	    }
	    
	    @GetMapping("/farmer/registered-cycles")
	    public ModelAndView showFarmerRegisteredCycles(
	            @RequestParam(
	                    name = "tab",
	                    defaultValue = "current"
	            ) String tab,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        if (!"current".equals(tab) &&
	            !"history".equals(tab)) {

	            tab = "current";
	        }

	        List<CycleRegister> currentRegisters =cycleRegisterService.findCurrentByFarmerId(farmerId);

	        List<CycleRegister> historyRegisters =cycleRegisterService.findHistoryByFarmerId(farmerId);

	        List<FarmerCycleHistoryDTO> histories =farmerCycleHistoryService.buildHistories(historyRegisters);

	        ModelAndView mav =
	                new ModelAndView("farmer_registered_cycle");

	        mav.addObject("tab", tab);

	        mav.addObject(
	                "currentRegisters",
	                currentRegisters
	        );

	        mav.addObject(
	                "histories",
	                histories
	        );

	        mav.addObject(
	                "currentTotal",
	                currentRegisters.size()
	        );

	        mav.addObject(
	                "historyTotal",
	                histories.size()
	        );

	        mav.addObject(
	                "firstname",
	                session.getAttribute("firstname")
	        );

	        mav.addObject(
	                "lastname",
	                session.getAttribute("lastname")
	        );

	        return mav;
	    }
	    
	    
	    @GetMapping("/broker/cycle/{cycleId}/approved-farmers")
	    public ModelAndView approvedFarmers(
	            @PathVariable("cycleId") int cycleId,
	            HttpSession session) {

	        if(session.getAttribute("brokerId") == null){
	            return new ModelAndView("redirect:/broker/login");
	        }

	        CropCycle cycle =
	                cropCycleService.findById(cycleId).orElseThrow();

	        List<Farmer> farmers =
	                cycleRegisterService.findFarmersByCycleIdAndStatus(
	                        cycleId,
	                        "APPROVED");

	        ModelAndView mav =
	                new ModelAndView("broker_approved_farmer");

	        mav.addObject("cycle", cycle);
	        mav.addObject("farmers", farmers);
	        mav.addObject("total", farmers.size());

	        return mav;
	    }
	    
	    @GetMapping("/farmer/registered-cycle/detail/{cycleId}")
	    public ModelAndView farmerRegisteredCycleDetail(
	            @PathVariable("cycleId") int cycleId,
	            HttpSession session) {

	        if(session.getAttribute("farmerId") == null) {
	            return new ModelAndView("redirect:/");
	        }

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        CropCycle cycle =
	                cropCycleService.findById(cycleId).orElseThrow();

	        CycleRegister register =
	                cycleRegisterService.findMainRegisterByCycleAndFarmer(
	                        cycleId,
	                        farmerId);

	        List<Farmland> lands =
	                farmlandService.findByFarmerIdAndCycleId(
	                        farmerId,
	                        cycleId);
	        
	        ItemRequisition initialAllocation =
	                itemRequisitionRepository
	                        .findByRegisterIdAndTypeWithDetails(
	                                register.getRegisterId(),
	                                "INITIAL_ALLOCATION"
	                        )
	                        .orElse(null);
	        
	        	
	        ModelAndView mav =
	                new ModelAndView("farmer_registered_cycle_detail");
	        
	        mav.addObject("initialAllocation",initialAllocation);
	        mav.addObject("cycle", cycle);
	        mav.addObject("register", register);
	        mav.addObject("lands", lands);
	        mav.addObject("landCount", lands.size());

	        return mav;
	    }
	    
	    @GetMapping("/broker/cycle/{cycleId}/approved-farmer/{farmerId}")
	    public ModelAndView approvedFarmerDetail(
	            @PathVariable("cycleId") int cycleId,
	            @PathVariable("farmerId") int farmerId,
	            HttpSession session) {

	        if(session.getAttribute("brokerId") == null) {
	            return new ModelAndView("redirect:/broker/login");
	        }

	        CropCycle cycle = cropCycleService.findById(cycleId).orElseThrow();
	        Farmer farmer = farmerService.findById(farmerId).orElseThrow();

	        List<Farmland> lands =
	                farmlandService.findByFarmerIdAndCycleId(farmerId, cycleId);

	        CycleRegister register =
	                cycleRegisterService.findMainRegisterByCycleAndFarmer(cycleId, farmerId);
	        
	        ItemRequisition initialAllocation =
	                itemRequisitionRepository
	                        .findByRegisterIdAndTypeWithDetails(
	                                register.getRegisterId(),
	                                "INITIAL_ALLOCATION"
	                        )
	                        .orElse(null);

	        ModelAndView mav =
	                new ModelAndView("broker_approved_farmer_detail");
	     

	        mav.addObject(
	                "initialAllocation",
	                initialAllocation
	        );
	        mav.addObject("cycle", cycle);
	        mav.addObject("farmer", farmer);
	        mav.addObject("lands", lands);
	        mav.addObject("landCount", lands.size());
	        mav.addObject("register", register);

	        return mav;
	    }
	    
	    @GetMapping("/farmer/profile")
	    public ModelAndView profile(HttpSession session){

	        Integer farmerId=(Integer)session.getAttribute("farmerId");

	        if(farmerId==null){
	            return new ModelAndView("redirect:/");
	        }

	        Farmer farmer=farmerService.findById(farmerId).orElseThrow();

	        ModelAndView mav=new ModelAndView("farmer_profile");
	        mav.addObject("farmer",farmer);

	        return mav;
	    }
	    
	    @PostMapping("/farmer/profile/update")
	    public ModelAndView updateProfile(
	            @ModelAttribute Farmer form,
	            @RequestParam("image") MultipartFile image,
	            HttpSession session)throws Exception{

	        Integer farmerId=(Integer)session.getAttribute("farmerId");

	        Farmer farmer=farmerService.findById(farmerId).orElseThrow();

	        farmer.setFirstname(form.getFirstname());
	        farmer.setLastname(form.getLastname());
	        farmer.setPhoneNumber(form.getPhoneNumber());
	        farmer.setAddress(form.getAddress());

	        if(!image.isEmpty()){

	            String fileName=
	                    System.currentTimeMillis()+"_"+image.getOriginalFilename();

	            Path uploadPath=
	                    Paths.get("src/main/resources/static/uploads/profile");

	            Files.createDirectories(uploadPath);

	            image.transferTo(uploadPath.resolve(fileName));

	            farmer.setProfileImagePath(fileName);
	        }

	        farmerService.save(farmer);

	        return new ModelAndView("redirect:/farmer/profile?success");
	    }
	    
	    @GetMapping(
	    	    "/farmer/registered-cycle/history/{registerId}"
	    	)
	    	public ModelAndView showFarmerCycleHistoryDetail(
	    	        @PathVariable("registerId") int registerId,
	    	        HttpSession session) {

	    	    Integer farmerId =
	    	            (Integer) session.getAttribute("farmerId");

	    	    if (farmerId == null) {
	    	        return new ModelAndView("redirect:/");
	    	    }

	    	    CycleRegister register =
	    	            cycleRegisterService
	    	                .findHistoryRegisterForFarmer(
	    	                    registerId,
	    	                    farmerId
	    	                )
	    	                .orElse(null);

	    	    if (register == null) {
	    	        return new ModelAndView(
	    	            "redirect:/farmer/registered-cycles?tab=history"
	    	        );
	    	    }

	    	    FarmerCycleHistoryDetailDTO history =
	    	            farmerCycleHistoryDetailService
	    	                .buildDetail(register);

	    	    ModelAndView mav =
	    	            new ModelAndView(
	    	                "farmer_cycle_history_detail"
	    	            );

	    	    mav.addObject("history", history);
	    	    mav.addObject("register", register);
	    	    mav.addObject("cycle", register.getCycle());

	    	    mav.addObject(
	    	        "firstname",
	    	        session.getAttribute("firstname")
	    	    );

	    	    mav.addObject(
	    	        "lastname",
	    	        session.getAttribute("lastname")
	    	    );

	    	    return mav;
	    	}
	    
	    @GetMapping("/farmer/requisitions")
	    public ModelAndView farmerRequisitionList(
	            @RequestParam(
	                    name = "registerId",
	                    required = false
	            ) Integer registerId,
	            @RequestParam(
	                    name = "status",
	                    required = false
	            ) String status,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        List<ItemRequisition> requisitions =
	                itemRequisitionService
	                        .findFarmerRequisitions(
	                                farmerId,
	                                registerId,
	                                status
	                        );

	        ModelAndView mav =
	                new ModelAndView(
	                        "farmer_requisition_list"
	                );

	        mav.addObject(
	                "requisitions",
	                requisitions
	        );

	        mav.addObject(
	                "approvedCycles",
	                itemRequisitionService.findApprovedProgressCycles(farmerId)
	        );

	        mav.addObject("selectedRegisterId", registerId);
	        mav.addObject("selectedStatus", status);
	        mav.addObject("total", requisitions.size());

	        mav.addObject(
	                "success",
	                session.getAttribute(
	                        "requisitionSuccess"
	                )
	        );

	        session.removeAttribute("requisitionSuccess");

	        return mav;
	    }

	    @GetMapping("/farmer/requisition/add")
	    public ModelAndView showAddRequisition(
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        ModelAndView mav =
	                new ModelAndView(
	                        "farmer_requisition_form"
	                );

	        mav.addObject(
	                "requisitionForm",
	                new RequisitionFormDTO()
	        );

	        mav.addObject(
	                "approvedCycles",
	                itemRequisitionService.findApprovedProgressCycles(farmerId)

	        );

	        mav.addObject(
	                "chemicalItems",
	                itemRequisitionService
	                        .findChemicalItems()
	        );

	        mav.addObject("editMode", false);

	        return mav;
	    }

	    @PostMapping("/farmer/requisition/save-draft")
	    public ModelAndView saveRequisitionDraft(
	            @ModelAttribute("requisitionForm")
	            RequisitionFormDTO form,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            ItemRequisition requisition =
	                    itemRequisitionService
	                            .createDraft(
	                                    form,
	                                    farmerId
	                            );

	            session.setAttribute(
	                    "requisitionSuccess",
	                    "บันทึกแบบร่างใบเบิกเรียบร้อยแล้ว"
	            );

	            return new ModelAndView(
	                    "redirect:/farmer/requisition/"
	                    + requisition.getRequisitionId()
	            );

	        } catch (IllegalArgumentException e) {

	            ModelAndView mav =
	                    new ModelAndView(
	                            "farmer_requisition_form"
	                    );

	            mav.addObject("requisitionForm", form);

	            mav.addObject(
	                    "approvedCycles",
		                itemRequisitionService.findApprovedProgressCycles(farmerId)

	            );

	            mav.addObject(
	                    "chemicalItems",
	                    itemRequisitionService
	                            .findChemicalItems()
	            );

	            mav.addObject("editMode", false);
	            mav.addObject("error", e.getMessage());

	            return mav;
	        }
	    }

	    @GetMapping("/farmer/requisition/{requisitionId}")
	    public ModelAndView requisitionDetail(
	            @PathVariable("requisitionId")
	            int requisitionId,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            ItemRequisition requisition =
	                    itemRequisitionService
	                            .findOwnedRequisition(
	                                    requisitionId,
	                                    farmerId
	                            );

	            ModelAndView mav =
	                    new ModelAndView(
	                            "farmer_requisition_detail"
	                    );

	            mav.addObject(
	                    "requisition",
	                    requisition
	            );

	            mav.addObject(
	                    "totalPrice",
	                    itemRequisitionService
	                            .calculateTotal(requisition)
	            );

	            mav.addObject(
	                    "success",
	                    session.getAttribute(
	                            "requisitionSuccess"
	                    )
	            );

	            session.removeAttribute(
	                    "requisitionSuccess"
	            );

	            return mav;

	        } catch (IllegalArgumentException e) {

	            return new ModelAndView(
	                    "redirect:/farmer/requisitions"
	            );
	        }
	    }

	    @GetMapping(
	        "/farmer/requisition/edit/{requisitionId}"
	    )
	    public ModelAndView showEditRequisition(
	            @PathVariable("requisitionId")
	            int requisitionId,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            ItemRequisition requisition =
	                    itemRequisitionService
	                            .findOwnedRequisition(
	                                    requisitionId,
	                                    farmerId
	                            );

	            if (!"DRAFT".equalsIgnoreCase(
	                    requisition.getStatus())) {

	                return new ModelAndView(
	                        "redirect:/farmer/requisition/"
	                        + requisitionId
	                );
	            }

	            ModelAndView mav =
	                    new ModelAndView(
	                            "farmer_requisition_form"
	                    );

	            mav.addObject(
	                    "requisitionForm",
	                    itemRequisitionService
	                            .createEditForm(requisition)
	            );

	            mav.addObject(
	                    "approvedCycles",
		                itemRequisitionService.findApprovedProgressCycles(farmerId)

	            );

	            mav.addObject(
	                    "chemicalItems",
	                    itemRequisitionService
	                            .findChemicalItems()
	            );

	            mav.addObject("editMode", true);

	            return mav;

	        } catch (IllegalArgumentException e) {

	            return new ModelAndView(
	                    "redirect:/farmer/requisitions"
	            );
	        }
	    }

	    @PostMapping(
	        "/farmer/requisition/update-draft"
	    )
	    public ModelAndView updateRequisitionDraft(
	            @ModelAttribute("requisitionForm")
	            RequisitionFormDTO form,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            ItemRequisition requisition =
	                    itemRequisitionService
	                            .updateDraft(
	                                    form.getRequisitionId(),
	                                    form,
	                                    farmerId
	                            );

	            session.setAttribute(
	                    "requisitionSuccess",
	                    "แก้ไขแบบร่างเรียบร้อยแล้ว"
	            );

	            return new ModelAndView(
	                    "redirect:/farmer/requisition/"
	                    + requisition.getRequisitionId()
	            );

	        } catch (IllegalArgumentException e) {

	            ModelAndView mav =
	                    new ModelAndView(
	                            "farmer_requisition_form"
	                    );

	            mav.addObject("requisitionForm", form);

	            mav.addObject(
	                    "approvedCycles",
		                itemRequisitionService.findApprovedProgressCycles(farmerId)

	            );

	            mav.addObject(
	                    "chemicalItems",
	                    itemRequisitionService
	                            .findChemicalItems()
	            );

	            mav.addObject("editMode", true);
	            mav.addObject("error", e.getMessage());

	            return mav;
	        }
	    }

	    @PostMapping(
	        "/farmer/requisition/delete/{requisitionId}"
	    )
	    public ModelAndView deleteRequisitionDraft(
	            @PathVariable("requisitionId")
	            int requisitionId,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            itemRequisitionService.deleteDraft(
	                    requisitionId,
	                    farmerId
	            );

	            session.setAttribute(
	                    "requisitionSuccess",
	                    "ลบแบบร่างใบเบิกเรียบร้อยแล้ว"
	            );

	        } catch (IllegalArgumentException e) {

	            session.setAttribute(
	                    "requisitionSuccess",
	                    e.getMessage()
	            );
	        }

	        return new ModelAndView(
	                "redirect:/farmer/requisitions"
	        );
	    }

	    @PostMapping(
	        "/farmer/requisition/submit/{requisitionId}"
	    )
	    public ModelAndView submitRequisition(
	            @PathVariable("requisitionId")
	            int requisitionId,
	            HttpSession session) {

	        Integer farmerId =
	                (Integer) session.getAttribute("farmerId");

	        if (farmerId == null) {
	            return new ModelAndView("redirect:/");
	        }

	        try {

	            itemRequisitionService.submit(
	                    requisitionId,
	                    farmerId
	            );

	            session.setAttribute(
	                    "requisitionSuccess",
	                    "ส่งใบเบิกให้โบรกเกอร์เรียบร้อยแล้ว"
	            );

	        } catch (IllegalArgumentException e) {

	            session.setAttribute(
	                    "requisitionSuccess",
	                    e.getMessage()
	            );
	        }

	        return new ModelAndView(
	                "redirect:/farmer/requisition/"
	                + requisitionId
	        );
	    }
	    
	    @GetMapping("/broker/requisitions")
	    public ModelAndView brokerRequisitionList(
	            @RequestParam(
	                    name = "cycleId",
	                    required = false
	            ) Integer cycleId,
	            @RequestParam(
	                    name = "status",
	                    required = false
	            ) String status,
	            @RequestParam(
	                    name = "success",
	                    required = false
	            ) String success,
	            HttpSession session) {

	        if (session.getAttribute("brokerId") == null) {

	            return new ModelAndView(
	                    "redirect:/broker/login"
	            );
	        }

	        List<BrokerRequisitionListDTO> requisitions =
	                brokerRequisitionService
	                        .findRequisitions(
	                                cycleId,
	                                status
	                        );

	        ModelAndView mav =
	                new ModelAndView(
	                        "broker_requisition_list"
	                );

	        mav.addObject(
	                "requisitions",
	                requisitions
	        );

	        mav.addObject(
	                "cycles",
	                cropCycleService.findAll()
	        );

	        mav.addObject(
	                "selectedCycleId",
	                cycleId
	        );

	        mav.addObject(
	                "selectedStatus",
	                status
	        );

	        mav.addObject(
	                "total",
	                requisitions.size()
	        );

	        mav.addObject(
	                "success",
	                success
	        );

	        return mav;
	    }

	    @GetMapping("/broker/requisition/{requisitionId}")
	    public ModelAndView brokerRequisitionDetail(
	            @PathVariable("requisitionId")
	            int requisitionId,
	            @RequestParam(
	                    name = "success",
	                    required = false
	            ) String success,
	            HttpSession session) {

	        if (session.getAttribute("brokerId") == null) {

	            return new ModelAndView(
	                    "redirect:/broker/login"
	            );
	        }

	        try {

	            ItemRequisition requisition =
	                    brokerRequisitionService
	                            .findDetail(
	                                    requisitionId
	                            );

	            Farmer farmer =
	                    brokerRequisitionService
	                            .findFarmer(
	                                    requisition
	                            );

	            ModelAndView mav =
	                    new ModelAndView(
	                            "broker_requisition_detail"
	                    );

	            mav.addObject(
	                    "requisition",
	                    requisition
	            );

	            mav.addObject(
	                    "farmer",
	                    farmer
	            );

	            mav.addObject(
	                    "register",
	                    requisition.getCycle()
	            );

	            mav.addObject(
	                    "cycle",
	                    requisition.getCycle()
	                            .getCycle()
	            );

	            mav.addObject(
	                    "totalPrice",
	                    brokerRequisitionService
	                            .calculateTotal(
	                                    requisition
	                            )
	            );

	            mav.addObject(
	                    "success",
	                    success
	            );

	            return mav;

	        } catch (IllegalArgumentException e) {

	            return new ModelAndView(
	                    "redirect:/broker/requisitions"
	            );
	        }
	    }

	    @PostMapping("/broker/requisition/review")
	    public ModelAndView reviewRequisition(
	            @RequestParam("requisitionId")
	            int requisitionId,
	            @RequestParam("decision")
	            String decision,
	            HttpSession session) {

	        if (session.getAttribute("brokerId") == null) {

	            return new ModelAndView(
	                    "redirect:/broker/login"
	            );
	        }

	        try {

	            brokerRequisitionService.review(
	                    requisitionId,
	                    decision
	            );

	            String success;

	            if ("APPROVED".equalsIgnoreCase(
	                    decision)) {

	                success = "approved";

	            } else {

	                success = "rejected";
	            }

	            return new ModelAndView(
	                    "redirect:/broker/requisition/"
	                    + requisitionId
	                    + "?success="
	                    + success
	            );

	        } catch (IllegalArgumentException e) {

	            return new ModelAndView(
	                    "redirect:/broker/requisition/"
	                    + requisitionId
	                    + "?success=error"
	            );
	        }
	    }
}