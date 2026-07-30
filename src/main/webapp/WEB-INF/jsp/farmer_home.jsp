<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Farmer Home</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/farmer_home.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<nav class="navbar">

    <div class="logo-section">
        <i class="fa-solid fa-seedling"></i>
        <span>Potato Farmer</span>
    </div>

    <ul class="menu">
        <li>
            <a href="${pageContext.request.contextPath}/farmer/home" class="active">
                <i class="fa-solid fa-house"></i>
                หน้าแรก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/farmer/cycles">
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
            <a href="${pageContext.request.contextPath}/farmer/requisitions">
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

<section class="hero-section">

    <div class="hero-carousel">

        <div class="hero-slide active"
             style="background-image:
             url('${pageContext.request.contextPath}/images/hero/farm-1.jpg');">
        </div>

        <div class="hero-slide"
             style="background-image:
             url('${pageContext.request.contextPath}/images/hero/farm-2.jpg');">
        </div>

        <div class="hero-slide"
             style="background-image:
             url('${pageContext.request.contextPath}/images/hero/farm-3.jpg');">
        </div>
        
        <div class="hero-slide"
             style="background-image:
             url('${pageContext.request.contextPath}/images/hero/farm-4.jpg');">
        </div>

    </div>

    <div class="hero-overlay"></div>

    <div class="hero-content">

        <div class="welcome-badge">
            <i class="fa-solid fa-leaf"></i>
            ระบบสำหรับเกษตรกร
        </div>

        <h1>
            ยินดีต้อนรับ<br>
            <span>${firstname}</span>
        </h1>

        <p>
            สมัครรอบเพาะปลูก ลงทะเบียนพื้นที่ ตรวจสอบสถานะอนุมัติ
            และติดตามกำหนดการปลูก/เก็บเกี่ยวได้ในที่เดียว
        </p>

        <div class="hero-actions">

            <a href="${pageContext.request.contextPath}/farmer/cycles"
               class="primary-btn">
                ลงทะเบียนรอบเพาะปลูก
                <i class="fa-solid fa-arrow-right"></i>
            </a>

            <a href="${pageContext.request.contextPath}/farmer/registered-cycles"
               class="secondary-btn">
                ดูรอบที่ลงทะเบียน
            </a>

        </div>

    </div>

    <div class="hero-card">

        <div class="hero-card-icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <h3>เริ่มต้นใช้งาน</h3>

        <div class="step-item">
            <span>1</span>
            เลือกรอบเพาะปลูก
        </div>

        <div class="step-item">
            <span>2</span>
            ลงทะเบียนพื้นที่
        </div>

        <div class="step-item">
            <span>3</span>
            รอการอนุมัติ
        </div>

    </div>

    <div class="carousel-dots">

        <button type="button"
                class="carousel-dot active"
                onclick="showHeroSlide(0)">
        </button>

        <button type="button"
                class="carousel-dot"
                onclick="showHeroSlide(1)">
        </button>

        <button type="button"
                class="carousel-dot"
                onclick="showHeroSlide(2)">
        </button>
        
          <button type="button"
                class="carousel-dot"
                onclick="showHeroSlide(3)">
        </button>

    </div>

</section>

<main class="main-content">

    <div class="section-header">
        <div>
            <h2>เมนูหลัก</h2>
            <p>เลือกเมนูที่ต้องการใช้งาน</p>
        </div>
    </div>

    <div class="dashboard-grid">

        <div class="dashboard-card">

            <div class="card-top">
                <div class="card-icon green">
                    <i class="fa-solid fa-circle-info"></i>
                </div>
            </div>

            <h3>แนะนำการใช้งาน</h3>

            <p>
                เรียนรู้ขั้นตอนการลงทะเบียนรอบเพาะปลูกและการใช้งานระบบเบื้องต้น
            </p>

            <a href="${pageContext.request.contextPath}/farmer/onboarding">
                ดูคำแนะนำ
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>

        <div class="dashboard-card">

            <div class="card-top">
                <div class="card-icon blue">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
            </div>

            <h3>รอบการเพาะปลูก</h3>

            <p>
                ดูรอบที่เปิดรับสมัคร รายละเอียดวันปลูก วันเก็บเกี่ยว และราคารับซื้อ
            </p>

            <a href="${pageContext.request.contextPath}/farmer/cycles">
                ดูรายการรอบ
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>

        <div class="dashboard-card">

            <div class="card-top">
                <div class="card-icon purple">
                    <i class="fa-solid fa-clipboard-check"></i>
                </div>
            </div>

            <h3>รอบที่ลงทะเบียน</h3>

            <p>
                ตรวจสอบสถานะการสมัคร พื้นที่ที่ลงทะเบียน และกำหนดการของคุณ
            </p>

            <a href="${pageContext.request.contextPath}/farmer/registered-cycles">
                ดูรอบที่ลงทะเบียน
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>

    </div>

</main>

<footer class="footer">

    <div class="footer-content">

        <div>
            <h3>
                <i class="fa-solid fa-seedling"></i>
                Potato Management System
            </h3>

            <p>
                ระบบจัดการรอบเพาะปลูกมันฝรั่งสำหรับเกษตรกรและโบรกเกอร์
            </p>
        </div>

        <div class="footer-links">
            <a href="${pageContext.request.contextPath}/farmer/home">หน้าแรก</a>
            <a href="${pageContext.request.contextPath}/farmer/cycles">รอบเพาะปลูก</a>
            <a href="${pageContext.request.contextPath}/farmer/registered-cycles">รอบที่ลงทะเบียน</a>
        </div>

    </div>

    <div class="footer-bottom">
        © 2026 Potato Management System
    </div>

</footer>

</body>
<script>
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
</html>