<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดเกษตรกรที่อนุมัติแล้ว</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_approved_farmer_detail.css">
</head>

<body>


	<nav class="navbar navbar-expand-lg navbar-dark top-navbar">

		<div class="container-fluid">

			<a class="navbar-brand fw-bold" href="#"> 
			    <i class="fa-solid fa-seedling"></i>
			    ระบบจัดการมันฝรั่ง - โบรกเกอร์ </a>

			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarContent">

				<span class="navbar-toggler-icon"></span>

			</button>

			<div class="collapse navbar-collapse" id="navbarContent">

				<ul class="navbar-nav ms-auto">

					<li class="nav-item"><a class="nav-link active" href="/broker/home">
							<i class="fa-solid fa-house"></i> หน้าแรก
					</a></li>

					<li class="nav-item">

					    <a class="nav-link"
					       href="${pageContext.request.contextPath}/broker/cycles">
					        <i class="fa-solid fa-seedling"></i>
					        รอบเพาะปลูก
					
					    </a>
					
					</li>

					<li class="nav-item"><a class="nav-link text-warning"
						href="${pageContext.request.contextPath}/logout"> <i
							class="fa-solid fa-right-from-bracket"></i> ออกจากระบบ
					</a></li>

				</ul>

			</div>

		</div>

	</nav>


<div class="page">

    <div class="header">

        <a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/approved-farmers"
           class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="main-icon">
            <i class="fa-solid fa-circle-check"></i>
        </div>

        <div>
            <h2>รายละเอียดเกษตรกรที่อนุมัติแล้ว</h2>
            <p>${farmer.firstname} ${farmer.lastname}</p>
        </div>

    </div>

    <div class="status-card">
        <span class="status approved">
            <i class="fa-solid fa-circle-check"></i>
            อนุมัติแล้ว
        </span>

        <p>
            เกษตรกรรายนี้ได้รับการอนุมัติและมีการกำหนดวันปลูก/วันเก็บเกี่ยวเรียบร้อยแล้ว
        </p>
    </div>

    <div class="grid">

        <div class="card-box">

            <div class="profile-top">

                <c:choose>
                    <c:when test="${not empty farmer.profileImagePath && farmer.profileImagePath ne 'default-profile.png'}">
                        <img class="profile-img"
                             src="${pageContext.request.contextPath}/uploads/profile/${farmer.profileImagePath}">
                    </c:when>

                    <c:otherwise>
                        <img class="profile-img"
                             src="${pageContext.request.contextPath}/images/default-profile.png">
                    </c:otherwise>
                </c:choose>

                <div>
                    <h3>${farmer.firstname} ${farmer.lastname}</h3>
                    <p>${farmer.userName}</p>
                </div>

            </div>

            <div class="card-title">
                <i class="fa-solid fa-id-card"></i>
                <h4>ข้อมูลเกษตรกร</h4>
            </div>

            <div class="info-list">

                <div>
                    <span>ชื่อผู้ใช้</span>
                    <b>${farmer.userName}</b>
                </div>

                <div>
                    <span>ชื่อ-นามสกุล</span>
                    <b>${farmer.firstname} ${farmer.lastname}</b>
                </div>

                <div>
                    <span>เบอร์โทรศัพท์</span>
                    <b>${farmer.phoneNumber}</b>
                </div>

                <div>
                    <span>ที่อยู่</span>
                    <b>${farmer.address}</b>
                </div>

            </div>

        </div>

        <div class="card-box">

            <div class="card-title">
                <i class="fa-solid fa-calendar-check"></i>
                <h4>กำหนดการของเกษตรกร</h4>
            </div>

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

            <div class="info-list mt-3">

                <div>
                    <span>สถานะ</span>
                    <b class="approved-text">${register.regStatus}</b>
                </div>

                <div>
                    <span>วันที่อนุมัติ</span>
                    <b>${register.approvedDate}</b>
                </div>

                <div>
                    <span>จำนวนพื้นที่</span>
                    <b>${landCount} แปลง</b>
                </div>

            </div>

        </div>

    </div>
	


    <section class="allocation-card">

        <div class="allocation-header">

            <div class="allocation-title-group">

                <div class="allocation-title-icon">
                    <i class="fa-solid fa-box-open"></i>
                </div>

                <div>
                    <h3>หัวพันธุ์และปุ๋ยที่จัดสรร</h3>
                    <p>
                        รายการที่ระบบจัดสรรให้เกษตรกร
                        หลังจากอนุมัติการลงทะเบียน
                    </p>
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
                        <b>
                            ${initialAllocation.details.size()}
                            รายการ
                        </b>
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

                                    <h4>
                                        ${detail.item.itemName}
                                    </h4>

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

                                <span>จำนวนที่จัดสรร</span>

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
                        <p>
                            ไม่พบใบจัดสรรหัวพันธุ์และปุ๋ย
                            ของเกษตรกรรายนี้
                        </p>
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

                                <h5>แปลงที่ ${st.count}</h5>

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
                    ไม่พบข้อมูลพื้นที่ของเกษตรกรรายนี้
                </div>
            </c:otherwise>

        </c:choose>

    </div>

</div>

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