<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดรอบที่ลงทะเบียน</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/farmer_registered_cycle_detail.css">
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
            <a href="${pageContext.request.contextPath}/farmer/cycles" >
                <i class="fa-solid fa-calendar-days"></i>
                รอบเพาะปลูก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/farmer/registered-cycles" class = "active">
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
        <div class="user-avatar">
             <a href="${pageContext.request.contextPath}/farmer/profile">            
               <i class="fa-solid fa-user"></i>
             </a>
        </div>

        <div class="user-info">
            <span>${firstname} ${lastname}</span>
            <a href="${pageContext.request.contextPath}/logout">ออกจากระบบ</a>
        </div>
    </div>
</nav>
<div class="page">

    <div class="header">

        <a href="${pageContext.request.contextPath}/farmer/registered-cycles"
           class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="main-icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <div>
            <h2>รายละเอียดรอบที่ลงทะเบียน</h2>
            <p>${cycle.cycleName}</p>
        </div>

    </div>

    <div class="status-card">

        <c:choose>

            <c:when test="${register.regStatus eq 'PENDING'}">
                <span class="status pending">
                    <i class="fa-solid fa-clock"></i>
                    รออนุมัติ
                </span>

                <p>
                    ระบบจะแสดงกำหนดวันปลูกและวันเก็บเกี่ยวหลังจากโบรกเกอร์อนุมัติ
                </p>
            </c:when>

            <c:when test="${register.regStatus eq 'APPROVED'}">
                <span class="status approved">
                    <i class="fa-solid fa-circle-check"></i>
                    อนุมัติแล้ว
                </span>

                <p>
                    ระบบได้จัดตารางวันปลูกและวันเก็บเกี่ยวให้แล้ว
                </p>
            </c:when>

            <c:otherwise>
                <span class="status rejected">
                    <i class="fa-solid fa-circle-xmark"></i>
                    ไม่อนุมัติ
                </span>

                <p>
                    การลงทะเบียนรอบนี้ไม่ผ่านการอนุมัติ
                </p>
            </c:otherwise>

        </c:choose>

    </div>

    <div class="grid">

        <div class="card-box">

            <div class="card-title">
                <i class="fa-solid fa-seedling"></i>
                <h4>ข้อมูลรอบการเพาะปลูก</h4>
            </div>

            <div class="info-list">

                <div>
                    <span>ชื่อรอบ</span>
                    <b>${cycle.cycleName}</b>
                </div>

                <div>
                    <span>พันธุ์มันฝรั่ง</span>
                    <b>${cycle.potatoType}</b>
                </div>

                <div>
                    <span>ราคารับซื้อ</span>
                    <b>${cycle.purchasePrice} บาท/กก.</b>
                </div>

                <div>
                    <span>วันเริ่มปลูกของรอบ</span>
                    <b>${cycle.plantDate}</b>
                </div>

                <div>
                    <span>วันเริ่มเก็บเกี่ยวของรอบ</span>
                    <b>${cycle.harvestDate}</b>
                </div>

            </div>

        </div>

        <div class="card-box">

            <div class="card-title">
                <i class="fa-solid fa-calendar-check"></i>
                <h4>กำหนดการของคุณ</h4>
            </div>

            <c:choose>

                <c:when test="${register.regStatus eq 'APPROVED'}">

                    <div class="schedule green">
                        <i class="fa-solid fa-seedling"></i>

                        <div>
                            <span>วันปลูกที่กำหนด</span>
                            <b>${register.scheduledPlantDate}</b>
                        </div>
                    </div>

                    <div class="schedule blue">
                        <i class="fa-solid fa-box"></i>

                        <div>
                            <span>วันเก็บเกี่ยวที่กำหนด</span>
                            <b>${register.scheduledHarvestDate}</b>
                        </div>
                    </div>

                </c:when>

                <c:otherwise>

                    <div class="waiting-box">
                        <i class="fa-solid fa-hourglass-half"></i>
                        <b>ยังไม่มีกำหนดการ</b>
                        <span>กรุณารอโบรกเกอร์อนุมัติ</span>
                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>
	
    <!-- หัวพันธุ์และปุ๋ยที่ได้รับ -->
    <section class="allocation-card">

        <div class="allocation-header">

            <div class="allocation-title-group">

                <div class="allocation-title-icon">
                    <i class="fa-solid fa-box-open"></i>
                </div>

                <div>
                    <h3>หัวพันธุ์และปุ๋ยที่ได้รับ</h3>
                    <p>รายการที่ระบบจัดสรรให้อัตโนมัติหลังได้รับการอนุมัติ</p>
                </div>

            </div>

            <c:if test="${not empty initialAllocation}">
                <span class="allocation-status">
                    <i class="fa-solid fa-circle-check"></i>
                    จัดสรรแล้ว
                </span>
            </c:if>

        </div>

        <c:choose>

            <c:when test="${not empty initialAllocation}">

                <div class="allocation-summary">

                    <div>
                        <span>เลขที่ใบจัดสรร</span>
                        <b>REQ${initialAllocation.requisitionId}</b>
                    </div>

                    <div>
                        <span>วันที่จัดสรร</span>
                        <b>${initialAllocation.submitDate}</b>
                    </div>

                    <div>
                        <span>จำนวนรายการ</span>
                        <b>${initialAllocation.details.size()} รายการ</b>
                    </div>

                </div>

                <div class="allocation-list">

                    <c:forEach
                        items="${initialAllocation.details}"
                        var="detail">

                        <article class="allocation-item">

                            <div class="allocation-icon
                                ${detail.item.itemType eq 'SEED'
                                    ? 'seed'
                                    : 'fertilizer'}">

                                <c:choose>

                                    <c:when test="${detail.item.itemType eq 'SEED'}">
                                        <i class="fa-solid fa-seedling"></i>
                                    </c:when>

                                    <c:otherwise>
                                        <i class="fa-solid fa-flask"></i>
                                    </c:otherwise>

                                </c:choose>

                            </div>

                            <div class="allocation-info">

                                <div class="allocation-item-title">

                                    <h4>${detail.item.itemName}</h4>

                                    <span class="item-type">
                                        <c:choose>
                                            <c:when test="${detail.item.itemType eq 'SEED'}">
                                                หัวพันธุ์
                                            </c:when>
                                            <c:otherwise>
                                                ปุ๋ย
                                            </c:otherwise>
                                        </c:choose>
                                    </span>

                                </div>

                                <p>
                                    <c:choose>
                                        <c:when test="${not empty detail.cause}">
                                            ${detail.cause}
                                        </c:when>
                                        <c:otherwise>
                                            จัดสรรตามพื้นที่เพาะปลูกที่ได้รับอนุมัติ
                                        </c:otherwise>
                                    </c:choose>
                                </p>

                            </div>

                            <div class="allocation-quantity">

                                <span>จำนวนที่ได้รับ</span>

                                <div>
                                    <b>${detail.qty}</b>
                                    <small>${detail.item.unit}</small>
                                </div>

                            </div>

                        </article>

                    </c:forEach>

                </div>

            </c:when>

            <c:otherwise>

                <div class="allocation-empty">

                    <div class="allocation-empty-icon">
                        <i class="fa-solid fa-box-open"></i>
                    </div>

                    <div>
                        <b>ยังไม่มีข้อมูลการจัดสรร</b>

                        <c:choose>
                            <c:when test="${register.regStatus eq 'PENDING'}">
                                <p>
                                    ระบบจะจัดสรรหัวพันธุ์และปุ๋ย
                                    หลังจากโบรกเกอร์อนุมัติการลงทะเบียน
                                </p>
                            </c:when>

                            <c:when test="${register.regStatus eq 'REJECTED'}">
                                <p>
                                    การลงทะเบียนไม่ได้รับอนุมัติ
                                    จึงไม่มีรายการจัดสรร
                                </p>
                            </c:when>

                            <c:otherwise>
                                <p>
                                    ยังไม่พบใบจัดสรรหัวพันธุ์และปุ๋ยของรอบนี้
                                </p>
                            </c:otherwise>
                        </c:choose>

                    </div>

                </div>

            </c:otherwise>

        </c:choose>

    </section>

  

      
    <div class="card-box mt-4">

        <div class="card-title">
            <i class="fa-solid fa-map-location-dot"></i>
            <h4>พื้นที่ที่ลงทะเบียน</h4>
        </div>

        <c:choose>

            <c:when test="${not empty lands}">

                <c:forEach items="${lands}" var="land" varStatus="st">

                    <div class="land-item">

                        <div class="land-no">
                            ${st.count}
                        </div>

                        <div class="land-info">

                            <div class="land-head">

                                <h5>
                                    แปลงที่ ${st.count}
                                </h5>

                                <span>
                                    ${land.rai} ไร่
                                    ${land.ngan} งาน
                                    ${land.squreWah} ตร.ว.
                                </span>

                            </div>

                            <div class="land-detail">

                                <p>
                                    <i class="fa-solid fa-file-lines"></i>
                                    <b>เลขโฉนด:</b>
                                    ${land.titleDeedNo}
                                </p>

                                <p>
                                    <i class="fa-solid fa-location-dot"></i>
                                    <b>ที่ตั้ง:</b>
                                    ${land.location}
                                </p>

                            </div>

                            <div class="image-list">

                                <button type="button"
                                        class="image-btn"
                                        onclick="openLandGallery(
                                            '${pageContext.request.contextPath}/uploads/titledeed/${land.titleDeedImagePath}',
                                            '${pageContext.request.contextPath}/uploads/titledeed/${land.titleDeedBackImagePath}'
                                        )">
                                    <i class="fa-solid fa-images"></i>
                                    ดูรูปโฉนด
                                </button>

                            </div>

                        </div>

                    </div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="empty-box">
                    ยังไม่มีข้อมูลพื้นที่
                </div>

            </c:otherwise>

        </c:choose>

    </div>

</div>

<!-- IMAGE VIEWER -->
<div id="imageViewer" class="image-viewer">

    <button type="button"
            class="viewer-close"
            onclick="closeGallery()">
        <i class="fa-solid fa-xmark"></i>
    </button>

    <button type="button"
            class="viewer-arrow left"
            onclick="prevImage()">
        <i class="fa-solid fa-chevron-left"></i>
    </button>

    <div class="viewer-content">

        <img id="viewerImage" src="">

        <div id="imageCounter" class="image-counter">
            1 / 1
        </div>

    </div>

    <button type="button"
            class="viewer-arrow right"
            onclick="nextImage()">
        <i class="fa-solid fa-chevron-right"></i>
    </button>

</div>

<script>

let galleryImages = [];
let currentIndex = 0;

function openLandGallery(frontImage, backImage){

    galleryImages = [];

    if(frontImage &&
       !frontImage.includes("null") &&
       !frontImage.includes("undefined") &&
       !frontImage.endsWith("/")){

        galleryImages.push(frontImage);
    }

    if(backImage &&
       !backImage.includes("null") &&
       !backImage.includes("undefined") &&
       !backImage.endsWith("/")){

        galleryImages.push(backImage);
    }

    if(galleryImages.length === 0){
        alert("ไม่พบรูปโฉนด");
        return;
    }

    currentIndex = 0;

    showCurrentImage();

    document.getElementById("imageViewer").style.display = "flex";
}

function showCurrentImage(){

    document.getElementById("viewerImage").src =
        galleryImages[currentIndex];

    document.getElementById("imageCounter").innerText =
        (currentIndex + 1) + " / " + galleryImages.length;
}

function closeGallery(){

    document.getElementById("imageViewer").style.display = "none";

    document.getElementById("viewerImage").src = "";
}

function nextImage(){

    if(galleryImages.length === 0){
        return;
    }

    currentIndex =
        (currentIndex + 1) % galleryImages.length;

    showCurrentImage();
}

function prevImage(){

    if(galleryImages.length === 0){
        return;
    }

    currentIndex =
        (currentIndex - 1 + galleryImages.length) % galleryImages.length;

    showCurrentImage();
}

document.addEventListener("keydown", function(e){

    const viewer =
        document.getElementById("imageViewer");

    if(viewer.style.display === "flex"){

        if(e.key === "Escape"){
            closeGallery();
        }

        if(e.key === "ArrowRight"){
            nextImage();
        }

        if(e.key === "ArrowLeft"){
            prevImage();
        }
    }
});

</script>

</body>
</html>