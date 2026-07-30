<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รอบการเพาะปลูก</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/farmer_list_cycle.css">
</head>

<body>

<nav class="navbar">

    <div class="logo-section">
        <i class="fa-solid fa-seedling"></i>
        <span>Potato Farmer</span>
    </div>

    <ul class="menu">
        <li>
            <a href="${pageContext.request.contextPath}/farmer/home" >
                <i class="fa-solid fa-house"></i>
                หน้าแรก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/farmer/cycles" class="active">
                <i class="fa-solid fa-calendar-days"></i>
                รอบเพาะปลูก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/farmer/registered-cycles">
                <i class="fa-solid fa-clipboard-check"></i>
                รอบที่ลงทะเบียน
            </a>
        </li>
        
       <li>
        	<a href="${pageContext.request.contextPath}/farmer/requisitions" >
		        <i class="fa-solid fa-file-circle-plus"></i>
		        ใบเบิก
	    	</a>
        </li>
    </ul>

    <div class="user-section">
        
	 <div class="notification-wrapper">
	
	    <button type="button"
	            class="notification-button"
	            id="notificationButton"
	            aria-label="การแจ้งเตือน">
	
	        <i class="fa-solid fa-bell"></i>
	
	        <c:if test="${unreadNotificationCount gt 0}">
	            <span class="notification-count">
	                ${unreadNotificationCount}
	            </span>
	        </c:if>
	
	    </button>
	
	    <div class="notification-dropdown"
	         id="notificationDropdown">
	
	        <div class="notification-title">
	            <div>
	                <h3>การแจ้งเตือน</h3>
	                <p>
	                    <c:out value="${unreadNotificationCount}" default="0"/>
	                    รายการที่ยังไม่ได้อ่าน
	                </p>
	            </div>
	        </div>
	
	        <div class="notification-list">
	
	            <c:choose>
	
	                <c:when test="${not empty farmerNotifications}">
	
	                    <c:forEach items="${farmerNotifications}"
	                               var="notification">
	
	                        <a href="${pageContext.request.contextPath}/farmer/notification/${notification.notificationId}"
	                           class="notification-item ${not notification.readStatus ? 'unread' : ''}">
	
	                            <div class="notification-item-icon">
	
	                                <c:choose>
	
	                                    <c:when test="${notification.notificationType eq 'REGISTRATION_APPROVED'}">
	                                        <i class="fa-solid fa-circle-check"></i>
	                                    </c:when>
	
	                                    <c:when test="${notification.notificationType eq 'REGISTRATION_REJECTED'}">
	                                        <i class="fa-solid fa-circle-xmark"></i>
	                                    </c:when>
	
	                                    <c:otherwise>
	                                        <i class="fa-solid fa-bell"></i>
	                                    </c:otherwise>
	
	                                </c:choose>
	
	                            </div>
	
	                            <div class="notification-content">
	
	                                <strong>
	                                    <c:out value="${notification.title}"/>
	                                </strong>
	
	                                <p>
	                                    <c:out value="${notification.message}"/>
	                                </p>
	
	                                <small>
	                                    <c:out value="${notification.createdAt}"/>
	                                </small>
	
	                            </div>
	
	                            <c:if test="${not notification.readStatus}">
	                                <span class="unread-dot"></span>
	                            </c:if>
	
	                        </a>
	
	                    </c:forEach>
	
	                </c:when>
	
	                <c:otherwise>
	
	                    <div class="notification-empty">
	                        <i class="fa-regular fa-bell-slash"></i>
	                        <span>ยังไม่มีการแจ้งเตือน</span>
	                    </div>
	
	                </c:otherwise>
	
	            </c:choose>
	
	        </div>
	
	    </div>
	
	</div>

        <div class="user-avatar">
             <a href="${pageContext.request.contextPath}/farmer/profile">            
               <i class="fa-solid fa-user"></i>
             </a>
        </div>

        <div class="user-info">
            <span><c:out value="${firstname}"/> <c:out value="${lastname}"/></span>
            <a href="${pageContext.request.contextPath}/logout">ออกจากระบบ</a>
        </div>

    </div>

</nav>

<div class="page">

    <div class="title-box">
        <div class="icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <div>
            <h2>รอบการเพาะปลูก</h2>
            <p>เลือกและลงทะเบียนรอบการเพาะปลูกที่เปิดรับสมัคร</p>
        </div>
    </div>

    <form method="get" action="${pageContext.request.contextPath}/farmer/cycles">
        <input type="text"
               name="keyword"
               value="${keyword}"
               class="search-input"
               placeholder="ค้นหารอบการเพาะปลูก...">
    </form>

    <div class="cycle-list">

        <c:choose>

            <c:when test="${not empty cycles}">

                <c:forEach items="${cycles}" var="cycle">

                    <div class="cycle-row">

                        <div class="left-info">

                            <div class="mini-icon">
                                <i class="fa-solid fa-seedling"></i>
                            </div>

                            <div class="cycle-main">

                                <div class="cycle-title-line">
                                    <h4>${cycle.cycleName}</h4>

                                    <c:choose>
                                        <c:when test="${cycle.status eq 'OPEN'}">
                                            <span class="status-badge status-open">
                                                เปิดรับสมัคร
                                            </span>
                                        </c:when>

                                        <c:when test="${cycle.status eq 'PROGRESS'}">
                                            <span class="status-badge status-progress">
                                                กำลังดำเนินการ
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status-badge status-close">
                                                เสร็จสิ้น
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="cycle-detail-grid">

                                    <div class="detail-item">
                                        <i class="fa-solid fa-leaf"></i>
                                        <span>ชนิดหัวพันธุ์</span>
                                        <b>${cycle.potatoType}</b>
                                    </div>

                                    <div class="detail-item">
                                        <i class="fa-solid fa-calendar-day"></i>
                                        <span>วันเริ่มปลูก</span>
                                        <b>${cycle.plantDate}</b>
                                    </div>

                                    <div class="detail-item">
                                        <i class="fa-solid fa-box"></i>
                                        <span>วันเก็บเกี่ยว</span>
                                        <b>${cycle.harvestDate}</b>
                                    </div>

                                    <div class="detail-item">
                                        <i class="fa-solid fa-clock"></i>
                                        <span>ปิดรับสมัคร</span>
                                        <b>${cycle.endRegDate}</b>
                                    </div>

                                    <div class="detail-item">
                                        <i class="fa-solid fa-users"></i>
                                        <span>จำนวนเกษตรกร</span>
                                        <b>${registeredCount[cycle.cyleId]}/${cycle.maxpeople} คน</b>
                                    </div>

                                    <div class="detail-item">
                                        <i class="fa-solid fa-baht-sign"></i>
                                        <span>ราคารับซื้อ</span>
                                        <b>${cycle.purchasePrice} บาท/กก.</b>
                                    </div>

                                </div>

                            </div>

                        </div>

					<div class="right-info">
					    <c:choose>
					        <c:when test="${registeredCycleIds.contains(cycle.cyleId)}">
					            <button type="button"
					                    class="register-btn registered"
					                    disabled>
					                <i class="fa-solid fa-circle-check"></i>
					                ลงทะเบียนแล้ว
					            </button>
					        </c:when>
					        <c:when test="${cycle.status eq 'OPEN'
					                        && registeredCount[cycle.cyleId] lt cycle.maxpeople}">
					            <button type="button"
					                    class="register-btn"
					                    onclick="openRegisterModal(
					                        ${cycle.cyleId},
					                        '${cycle.cycleName}'
					                    )">
					                <i class="fa-solid fa-pen-to-square"></i>
					                ลงทะเบียน
					            </button>
					        </c:when>
					        <c:when test="${registeredCount[cycle.cyleId]
					                        ge cycle.maxpeople}">
					            <button type="button"
					                    class="register-btn disabled"
					                    disabled>
					                <i class="fa-solid fa-users-slash"></i>
					                จำนวนเต็มแล้ว
					            </button>
					        </c:when>
					        <c:otherwise>
					            <button type="button"
					                    class="register-btn disabled"
					                    disabled>
					                <i class="fa-solid fa-lock"></i>
					                ไม่เปิดรับสมัคร
					            </button>
					        </c:otherwise>
					    </c:choose>
					
					</div>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>
                <div class="empty-result">
                    <div class="empty-icon">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                    <h3>ไม่พบรอบการเพาะปลูก</h3>
                    <p>ไม่พบรอบการเพาะปลูกที่ท่านค้นหา</p>
                </div>
            </c:otherwise>

        </c:choose>

    </div>

</div>

<div class="modal fade" id="registerLandModal" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content register-modal">

            <form id="registerLandForm">

                <input type="hidden" id="registerCycleId">

                <div class="modal-header register-modal-header">
                    <div>
                        <h4>
                            <i class="fa-solid fa-map-location-dot"></i>
                            ลงทะเบียนพื้นที่เพาะปลูก
                        </h4>
                        <p id="modalCycleName"></p>
                    </div>

                    <button type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal">
                    </button>
                </div>

                <div class="modal-body">

                    <div class="notice-box">
                        <i class="fa-solid fa-circle-info"></i>
                        สามารถเพิ่มได้หลายแปลง และแต่ละแปลงต้องอัปโหลดรูปโฉนดด้านหน้าและด้านหลัง
                    </div>

                    <div id="landContainer"></div>

                    <button type="button"
                            class="add-land-btn"
                            onclick="addLand()">
                        <i class="fa-solid fa-plus"></i>
                        เพิ่มพื้นที่
                    </button>

                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn-cancel"
                            data-bs-dismiss="modal">
                        ยกเลิก
                    </button>

                    <button type="button"
                            class="btn-submit"
                            onclick="submitAllLands()">
                        ยืนยันการลงทะเบียน
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
let index = 0;

function openRegisterModal(cycleId, cycleName){

    document.getElementById("registerCycleId").value = cycleId;
    document.getElementById("modalCycleName").innerText = cycleName;
    document.getElementById("landContainer").innerHTML = "";

    index = 0;
    addLand();

    new bootstrap.Modal(
        document.getElementById("registerLandModal")
    ).show();
}

function addLand(){

    const currentIndex = index;

    let html = '';

    html += '<div class="land-card">';
    html += '<div class="land-card-header">';
    html += '<h5>พื้นที่ #' + (currentIndex + 1) + '</h5>';

    html += '<button type="button" class="remove-btn" onclick="removeLand(this)">';
    html += '<i class="fa-solid fa-trash"></i> ลบ';
    html += '</button>';
    html += '</div>';

    html += '<div class="form-grid">';

    html += '<div>';
    html += '<label>ไร่ *</label>';
    html += '<input type="number" step="0.01" class="form-control rai" required>';
    html += '</div>';

    html += '<div>';
    html += '<label>งาน *</label>';
    html += '<input type="number" step="0.01" class="form-control ngan" required>';
    html += '</div>';

    html += '<div>';
    html += '<label>ตารางวา *</label>';
    html += '<input type="number" step="0.01" class="form-control squreWah" required>';
    html += '</div>';

    html += '</div>';

    html += '<div class="mt-3">';
    html += '<label>เลขโฉนด *</label>';
    html += '<input type="text" class="form-control titleDeedNo" placeholder="เช่น น.ส.3ก/1234" required>';
    html += '</div>';

    html += '<div class="mt-3">';
    html += '<label>ที่ตั้งพื้นที่ *</label>';
    html += '<input type="text" class="form-control location" placeholder="เช่น บ้านเลขที่ หมู่ ตำบล อำเภอ จังหวัด" required>';
    html += '</div>';

    html += '<div class="upload-grid mt-3">';

    html += '<div>';
    html += '<label>รูปโฉนดด้านหน้า *</label>';
    html += '<input type="file" class="form-control frontImage" accept="image/*" onchange="previewImage(this)" required>';
    html += '<img class="preview-image mt-2">';
    html += '</div>';

    html += '<div>';
    html += '<label>รูปโฉนดด้านหลัง *</label>';
    html += '<input type="file" class="form-control backImage" accept="image/*" onchange="previewImage(this)" required>';
    html += '<img class="preview-image mt-2">';
    html += '</div>';

    html += '</div>';

    html += '</div>';

    document
        .getElementById("landContainer")
        .insertAdjacentHTML("beforeend", html);

    index++;
}

function removeLand(btn){

    const cards = document.querySelectorAll(".land-card");

    if(cards.length <= 1){
        alert("ต้องมีพื้นที่อย่างน้อย 1 รายการ");
        return;
    }

    btn.closest(".land-card").remove();
}

function previewImage(input){

    const file = input.files[0];

    if(!file){
        return;
    }

    const img =
        input.parentElement.querySelector(".preview-image");

    img.src = URL.createObjectURL(file);
    img.style.display = "block";
}

function validateCard(card, i){

    const requiredInputs =
        card.querySelectorAll("input");

    for(const input of requiredInputs){
        if(!input.value){
            alert("กรุณากรอกข้อมูลพื้นที่ #" + (i + 1) + " ให้ครบ");
            input.focus();
            return false;
        }
    }

    if(!card.querySelector(".frontImage").files[0]){
        alert("กรุณาอัปโหลดรูปโฉนดด้านหน้าของพื้นที่ #" + (i + 1));
        return false;
    }

    if(!card.querySelector(".backImage").files[0]){
        alert("กรุณาอัปโหลดรูปโฉนดด้านหลังของพื้นที่ #" + (i + 1));
        return false;
    }

    return true;
}

async function submitAllLands(){

    const cycleId =
        document.getElementById("registerCycleId").value;

    const cards =
        document.querySelectorAll(".land-card");

    if(cards.length === 0){
        alert("กรุณาเพิ่มพื้นที่อย่างน้อย 1 รายการ");
        return;
    }

    for(let i = 0; i < cards.length; i++){

        const card = cards[i];

        if(!validateCard(card, i)){
            return;
        }

        const formData = new FormData();

        formData.append("cycleId", cycleId);
        formData.append("rai", card.querySelector(".rai").value);
        formData.append("ngan", card.querySelector(".ngan").value);
        formData.append("squreWah", card.querySelector(".squreWah").value);
        formData.append("titleDeedNo", card.querySelector(".titleDeedNo").value);
        formData.append("location", card.querySelector(".location").value);
        formData.append("frontImage", card.querySelector(".frontImage").files[0]);
        formData.append("backImage", card.querySelector(".backImage").files[0]);

        const res =
            await fetch("${pageContext.request.contextPath}/farmer/register-cycle-land", {
                method: "POST",
                body: formData
            });

        const text =
            await res.text();

        if(text.trim() !== "success"){
            alert("บันทึกพื้นที่ที่ " + (i + 1) + " ไม่สำเร็จ");
            return;
        }
    }

    alert("ลงทะเบียนสำเร็จ");
    window.location.href =
        "${pageContext.request.contextPath}/farmer/registered-cycles";
}

let currentHeroSlide = 0;

const heroSlides =
    document.querySelectorAll(".hero-slide");

const heroDots =
    document.querySelectorAll(".carousel-dot");

let heroInterval;

function showHeroSlide(index){

    heroSlides.forEach(function(slide){
        slide.classList.remove("active");
    });

    heroDots.forEach(function(dot){
        dot.classList.remove("active");
    });

    currentHeroSlide = index;

    heroSlides[currentHeroSlide]
        .classList.add("active");

    heroDots[currentHeroSlide]
        .classList.add("active");
}

function nextHeroSlide(){

    let nextIndex =
        currentHeroSlide + 1;

    if(nextIndex >= heroSlides.length){
        nextIndex = 0;
    }

    showHeroSlide(nextIndex);
}

function startHeroCarousel(){

    heroInterval =
        setInterval(nextHeroSlide, 5000);
}

function resetHeroCarousel(){

    clearInterval(heroInterval);
    startHeroCarousel();
}

heroDots.forEach(function(dot, index){

    dot.addEventListener("click", function(){
        showHeroSlide(index);
        resetHeroCarousel();
    });

});

startHeroCarousel();

document.addEventListener("DOMContentLoaded", function(){

    const button =
        document.getElementById("notificationButton");

    const dropdown =
        document.getElementById("notificationDropdown");

    if(!button || !dropdown){
        return;
    }

    button.addEventListener("click", function(event){

        event.stopPropagation();

        dropdown.classList.toggle("show");
    });

    document.addEventListener("click", function(event){

        if(!dropdown.contains(event.target)){
            dropdown.classList.remove("show");
        }
    });
});
</script>

</body>
</html>