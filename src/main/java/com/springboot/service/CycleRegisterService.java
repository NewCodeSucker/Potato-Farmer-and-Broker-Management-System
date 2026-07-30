package com.springboot.service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.springboot.model.CropCycle;
import com.springboot.model.CycleRegister;
import com.springboot.model.Farmer;
import com.springboot.model.Farmland;
import com.springboot.repository.CycleRegisterRepository;
import com.springboot.repository.FarmlandRepository;

@Service
public class CycleRegisterService {

    @Autowired
    private CycleRegisterRepository cycleRegisterRepository;

    @Autowired
    private FarmlandRepository farmlandRepository;

    @Autowired
    private InitialAllocationService initialAllocationService;

    @Autowired
    private FarmerNotificationService farmerNotificationService;


    public List<CycleRegister> findAll() {
        return cycleRegisterRepository.findAll();
    }

    public Optional<CycleRegister> findById(Integer id) {
        return cycleRegisterRepository.findById(id);
    }

    public CycleRegister save(CycleRegister register) {
        return cycleRegisterRepository.save(register);
    }

    public void delete(Integer id) {
        cycleRegisterRepository.deleteById(id);
    }

    public List<CycleRegister> findByFarmerId(int farmerId) {
        return cycleRegisterRepository.findByFarmerId(farmerId);
    }

    public boolean alreadyRegistered(
            int cycleId,
            int farmerId) {

        return cycleRegisterRepository
                .existsByCycleIdAndFarmerId(
                        cycleId,
                        farmerId
                );
    }

    public long countFarmersByCycleId(int cycleId) {
        return cycleRegisterRepository
                .countFarmersByCycleId(cycleId);
    }

    public List<Farmer> findFarmersByCycleId(int cycleId) {
        return cycleRegisterRepository
                .findFarmersByCycleId(cycleId);
    }

    public List<CycleRegister> findByCycleIdAndFarmerId(
            int cycleId,
            int farmerId) {

        return cycleRegisterRepository
                .findByCycleIdAndFarmerId(
                        cycleId,
                        farmerId
                );
    }

    public List<CycleRegister>
    findByCycleIdAndFarmerIdAndStatus(
            int cycleId,
            int farmerId,
            String status) {

        return cycleRegisterRepository
                .findByCycleIdAndFarmerIdAndStatus(
                        cycleId,
                        farmerId,
                        status
                );
    }


    @Transactional
    public CycleRegister findOrCreateRegister(
            CropCycle cycle,
            Farmer farmer) {

        List<CycleRegister> registers =
                cycleRegisterRepository
                        .findByCycleIdAndFarmerId(
                                cycle.getCyleId(),
                                farmer.getFarmerId()
                        );

        if (!registers.isEmpty()) {
            return registers.get(0);
        }

        CycleRegister register = new CycleRegister();

        register.setCycle(cycle);
        register.setRegisterDate(LocalDate.now());
        register.setRegStatus("PENDING");

        return cycleRegisterRepository.save(register);
    }


    public List<Farmer> findFarmersByCycleIdAndStatus(
            int cycleId,
            String status) {

        return cycleRegisterRepository
                .findFarmersByCycleIdAndStatus(
                        cycleId,
                        status
                );
    }


    public CycleRegister findMainRegisterByCycleAndFarmer(
            int cycleId,
            int farmerId) {

        List<CycleRegister> registers =
                cycleRegisterRepository
                        .findByCycleIdAndFarmerId(
                                cycleId,
                                farmerId
                        );

        if (registers.isEmpty()) {
            throw new IllegalArgumentException(
                    "ไม่พบข้อมูลการลงทะเบียน"
            );
        }

        return registers.get(0);
    }

    @Transactional
    public CycleRegister reviewRegistration(
            int registerId,
            String status) {

        if ("APPROVED".equalsIgnoreCase(status)) {
            return approveRegister(registerId);
        }

        if ("REJECTED".equalsIgnoreCase(status)) {
            return rejectRegister(registerId);
        }

        throw new IllegalArgumentException(
                "สถานะการพิจารณาไม่ถูกต้อง"
        );
    }


    @Transactional
    public CycleRegister approveRegister(int registerId) {

        CycleRegister register =
                cycleRegisterRepository
                        .findById(registerId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "ไม่พบข้อมูลการลงทะเบียน"
                                )
                        );

        if ("APPROVED".equalsIgnoreCase(
                register.getRegStatus())) {

            throw new IllegalArgumentException(
                    "การลงทะเบียนนี้ได้รับอนุมัติแล้ว"
            );
        }

        if ("REJECTED".equalsIgnoreCase(
                register.getRegStatus())) {

            throw new IllegalArgumentException(
                    "การลงทะเบียนนี้ถูกปฏิเสธแล้ว"
            );
        }

        CropCycle cycle = register.getCycle();

        if (cycle == null) {
            throw new IllegalArgumentException(
                    "ไม่พบข้อมูลรอบการเพาะปลูก"
            );
        }

        if (cycle.getPlantDate() == null
                || cycle.getHarvestDate() == null) {

            throw new IllegalArgumentException(
                    "รอบเพาะปลูกยังไม่ได้กำหนดวันปลูกหรือวันเก็บเกี่ยว"
            );
        }

        List<Farmland> lands =
                farmlandRepository
                        .findByCycleRegistersRegisterId(
                                registerId
                        );

        if (lands == null || lands.isEmpty()) {
            throw new IllegalArgumentException(
                    "ไม่พบพื้นที่ที่ลงทะเบียน"
            );
        }

        Farmer farmer =
                lands.get(0).getFarmer();

        if (farmer == null) {
            throw new IllegalArgumentException(
                    "ไม่พบข้อมูลเกษตรกร"
            );
        }

 
        LocalDate scheduledPlantDate =
                findAvailablePlantDate(cycle);

        long growingDays =
                ChronoUnit.DAYS.between(
                        cycle.getPlantDate(),
                        cycle.getHarvestDate()
                );

        LocalDate scheduledHarvestDate =
                scheduledPlantDate.plusDays(growingDays);

        register.setRegStatus("APPROVED");
        register.setApprovedDate(LocalDate.now());
        register.setScheduledPlantDate(
                scheduledPlantDate
        );
        register.setScheduledHarvestDate(
                scheduledHarvestDate
        );

        CycleRegister savedRegister =
                cycleRegisterRepository.save(register);

        initialAllocationService
                .createInitialAllocation(
                        savedRegister,
                        lands
                );
        farmerNotificationService.create(
                farmer,
                "อนุมัติการลงทะเบียนแล้ว",
                "การลงทะเบียนรอบ "
                        + cycle.getCycleName()
                        + " ได้รับอนุมัติแล้ว "
                        + "ระบบได้กำหนดวันปลูก วันเก็บเกี่ยว "
                        + "และจัดสรรหัวพันธุ์กับปุ๋ยให้เรียบร้อยแล้ว",
                "REGISTRATION_APPROVED",
                "/farmer/registered-cycle/detail/"
                        + cycle.getCyleId()
        );

        return savedRegister;
    }


    @Transactional
    public CycleRegister rejectRegister(int registerId) {

        CycleRegister register =
                cycleRegisterRepository
                        .findById(registerId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "ไม่พบข้อมูลการลงทะเบียน"
                                )
                        );

        if ("APPROVED".equalsIgnoreCase(
                register.getRegStatus())) {

            throw new IllegalArgumentException(
                    "ไม่สามารถปฏิเสธรายการที่อนุมัติแล้วได้"
            );
        }

        if ("REJECTED".equalsIgnoreCase(
                register.getRegStatus())) {

            throw new IllegalArgumentException(
                    "การลงทะเบียนนี้ถูกปฏิเสธแล้ว"
            );
        }

        List<Farmland> lands =
                farmlandRepository
                        .findByCycleRegistersRegisterId(
                                registerId
                        );

        if (lands == null || lands.isEmpty()) {
            throw new IllegalArgumentException(
                    "ไม่พบพื้นที่ที่ลงทะเบียน"
            );
        }

        Farmer farmer =
                lands.get(0).getFarmer();

        if (farmer == null) {
            throw new IllegalArgumentException(
                    "ไม่พบข้อมูลเกษตรกร"
            );
        }

        register.setRegStatus("REJECTED");
        register.setApprovedDate(null);
        register.setScheduledPlantDate(null);
        register.setScheduledHarvestDate(null);

        CycleRegister savedRegister =
                cycleRegisterRepository.save(register);

        farmerNotificationService.create(
                farmer,
                "ไม่อนุมัติการลงทะเบียน",
                "การลงทะเบียนรอบ "
                        + register.getCycle().getCycleName()
                        + " ไม่ผ่านการอนุมัติ",
                "REGISTRATION_REJECTED",
                "/farmer/registered-cycles"
        );

        return savedRegister;
    }

    private LocalDate findAvailablePlantDate(
            CropCycle cycle) {

        LocalDate plantDate =
                cycle.getPlantDate();

        while (
            cycleRegisterRepository
                    .countApprovedByPlantDate(
                            cycle.getCyleId(),
                            plantDate
                    ) >= 4
        ) {

            plantDate = plantDate.plusDays(1);
        }

        return plantDate;
    }


    @Transactional
    public CycleRegister updateStatus(
            int registerId,
            String status) {

        CycleRegister register =
                cycleRegisterRepository
                        .findById(registerId)
                        .orElseThrow(() ->
                                new IllegalArgumentException(
                                        "ไม่พบข้อมูลการลงทะเบียน"
                                )
                        );

        register.setRegStatus(status);

        return cycleRegisterRepository.save(register);
    }


    public List<CycleRegister> findCurrentByFarmerId(
            int farmerId) {

        return cycleRegisterRepository
                .findCurrentByFarmerId(farmerId);
    }

    public List<CycleRegister> findHistoryByFarmerId(
            int farmerId) {

        return cycleRegisterRepository
                .findHistoryByFarmerId(farmerId);
    }

    public Optional<CycleRegister>
    findHistoryRegisterForFarmer(
            int registerId,
            int farmerId) {

        return cycleRegisterRepository
                .findHistoryRegisterForFarmer(
                        registerId,
                        farmerId
                );
    }
}