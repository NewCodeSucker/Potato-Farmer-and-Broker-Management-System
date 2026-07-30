<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดเกษตรกรที่ลงทะเบียน</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_registered_farmer_detail.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

<div class="page">

    <div class="header">

        <a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/farmers"
           class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="main-icon">
            <i class="fa-solid fa-user"></i>
        </div>

        <div class="header-text">
            <h2>รายละเอียดเกษตรกรที่ลงทะเบียน</h2>
            <p>${cycle.cycleName}</p>
        </div>

        <button type="button"
                class="review-btn"
                data-bs-toggle="modal"
                data-bs-target="#reviewModal">
            <i class="fa-solid fa-circle-check"></i>
            พิจารณาการลงทะเบียน
        </button>

    </div>

    <div class="status-card">

        <span class="status pending">
            <i class="fa-solid fa-clock"></i>
            รอพิจารณา
        </span>

        <p>
            ตรวจสอบข้อมูลเกษตรกรและพื้นที่ที่ลงทะเบียน ก่อนอนุมัติหรือปฏิเสธการเข้าร่วมรอบเพาะปลูก
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
                <i class="fa-solid fa-seedling"></i>
                <h4>ข้อมูลรอบการเพาะปลูก</h4>
            </div>

            <div class="info-list">

                <div>
                    <span>รหัสรอบ</span>
                    <b>CC${cycle.cyleId}</b>
                </div>

                <div>
                    <span>ชื่อรอบ</span>
                    <b>${cycle.cycleName}</b>
                </div>

                <div>
                    <span>ชนิดหัวพันธุ์</span>
                    <b>${cycle.potatoType}</b>
                </div>

                <div>
                    <span>จำนวนพื้นที่ที่ลงทะเบียน</span>
                    <b>${landCount} แปลง</b>
                </div>

                <div>
                    <span>สถานะการลงทะเบียน</span>
                    <b>${register.regStatus}</b>
                </div>

            </div>

        </div>

    </div>

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

<div class="modal fade" id="reviewModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content review-modal">

            <div class="modal-header review-header">
                <div>
                    <h4>
                        <i class="fa-solid fa-circle-check"></i>
                        พิจารณาการลงทะเบียนรอบเพาะปลูก
                    </h4>

                    <p>${cycle.cycleName}</p>
                </div>

                <button type="button"
                        class="btn-close btn-close-white"
                        data-bs-dismiss="modal">
                </button>
            </div>

            <form action="${pageContext.request.contextPath}/broker/register/update-status"
                  method="post">

                <input type="hidden" name="registerId" value="${register.registerId}">
                <input type="hidden" name="cycleId" value="${cycle.cyleId}">
                <input type="hidden" name="farmerId" value="${farmer.farmerId}">

                <div class="modal-body">

                    <div class="review-summary">

                        <div>
                            <small>ชื่อเกษตรกร</small>
                            <b>${farmer.firstname} ${farmer.lastname}</b>
                        </div>

                        <div>
                            <small>รอบการเพาะปลูก</small>
                            <b>${cycle.cycleName}</b>
                        </div>

                        <div>
                            <small>พื้นที่รวม</small>
                            <b>${landCount} แปลง</b>
                        </div>

                        <div>
                            <small>สถานะปัจจุบัน</small>
                            <b>${register.regStatus}</b>
                        </div>

                    </div>

                    <label class="review-label">
                        การพิจารณา
                    </label>

                    <div class="review-choice">

                        <label class="choice-card approve">

                            <input type="radio"
                                   name="status"
                                   value="APPROVED"
                                   checked>

                            <div>
                                <b>อนุมัติ</b>
                                <p>ยืนยันการลงทะเบียนเข้าร่วมรอบ</p>
                            </div>

                        </label>

                        <label class="choice-card reject">

                            <input type="radio"
                                   name="status"
                                   value="REJECTED">

                            <div>
                                <b>ไม่อนุมัติ</b>
                                <p>ปฏิเสธการลงทะเบียน</p>
                            </div>

                        </label>

                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn-cancel"
                            data-bs-dismiss="modal">
                        ยกเลิก
                    </button>

                    <button type="submit"
                            class="btn-confirm">
                        ยืนยันการพิจารณา
                    </button>
                </div>

            </form>

        </div>
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

<c:if test="${success eq 'approved'}">
    <script>
        alert("อนุมัติการลงทะเบียนสำเร็จ");
        window.location.href =
            "${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/farmers";
    </script>
</c:if>

<c:if test="${success eq 'rejected'}">
    <script>
        alert("ปฏิเสธการลงทะเบียนสำเร็จ");
        window.location.href =
            "${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/farmers";
    </script>
</c:if>

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