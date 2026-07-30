<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดรอบเพาะปลูก</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/farmer_cycle.css">
<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
<nav class="navbar">
    <div class="logo-section">
        <i class="fa-solid fa-seedling"></i>
        <span>ระบบจัดการมันฝรั่ง - เกษตรกร</span>
    </div>
    <ul class="menu">
        <li>
            <a href="${pageContext.request.contextPath}/farmer/home">
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
        	<i class="fa-solid fa-calendar-days"></i>
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
        <span>${firstname} ${lastname}</span>
        <a href="${pageContext.request.contextPath}/logout">ออกจากระบบ</a>
    </div>
</nav>

<div class="page">

    <div class="title-box">
        <div class="icon">
        	<i class="fa-solid fa-seedling"></i>
        </div>
        <div>
            <h2>ลงทะเบียนรอบการเพาะปลูก</h2>
            <p>${cycle.cycleName}</p>
        </div>
    </div>

    <div class="detail-layout">

        <div class="info-card">
            <h4>ข้อมูลรอบการเพาะปลูก</h4>

            <p><b>วันเปิดรับสมัคร:</b> ${cycle.openRegDate}</p>
            <p><b>วันปิดรับสมัคร:</b> ${cycle.endRegDate}</p>
            <p><b>วันเริ่มปลูก:</b> ${cycle.plantDate}</p>
            <p><b>วันเก็บเกี่ยว:</b> ${cycle.harvestDate}</p>

            <hr>

            <div class="green-box">
                <b>ชนิดหัวพันธุ์</b><br>
                ${cycle.potatoType}
            </div>

            <div class="blue-box">
                 <b>จำนวนที่รับ</b><br>
    			 ${registered} / ${cycle.maxpeople} คน
            </div>
        </div>

        <div class="info-card">
            <h4>ข้อมูลผู้สมัคร</h4>

            <div class="profile-box">
                <p><b>ชื่อ-นามสกุล</b><br>
                    ${farmer.firstname} ${farmer.lastname}
                </p>

                <p><b>เบอร์โทรศัพท์</b><br>
                    ${farmer.phoneNumber}
                </p>

                <p><b>ที่อยู่</b><br>
                    ${farmer.address}
                </p>
            </div>

            <div class="action-area">

                <a href="${pageContext.request.contextPath}/farmer/cycles"
                   class="btn btn-outline-secondary">
                    ยกเลิก
                </a>

                <c:choose>
                    <c:when test="${alreadyRegistered}">
                        <button class="btn btn-secondary" disabled>
                            ลงทะเบียนแล้ว
                        </button>
                    </c:when>

                    <c:otherwise>
                        <button type="button"
                                class="btn btn-success"
                                onclick="openRegisterModal(${cycle.cyleId})">
                            ลงทะเบียน
                        </button>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

    </div>

</div>

<!-- MODAL -->
<div class="modal fade" id="registerLandModal" tabindex="-1">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <form id="registerLandForm">

                <input type="hidden" id="registerCycleId">

                <div class="modal-header">
                    <h4>🏡 ลงทะเบียนพื้นที่เพาะปลูก</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <div id="landContainer"></div>

                    <button type="button"
                            class="btn btn-success mt-3"
                            onclick="addLand()">
                        + เพิ่มพื้นที่
                    </button>
                </div>

                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal">
                        ยกเลิก
                    </button>

                    <button type="button"
                            class="btn btn-success"
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

function openRegisterModal(cycleId){
    document.getElementById("registerCycleId").value = cycleId;
    document.getElementById("landContainer").innerHTML = "";

    index = 0;
    addLand();

    new bootstrap.Modal(
        document.getElementById("registerLandModal")
    ).show();
}

function addLand(){
    let currentIndex = index;

    let html = '';
    html += '<div class="card p-3 mb-3 land-card">';
    html += '<div class="d-flex justify-content-between">';
    html += '<h5>พื้นที่ #' + (currentIndex + 1) + '</h5>';
    html += '<button type="button" class="btn btn-danger btn-sm" onclick="removeLand(this)">ลบ</button>';
    html += '</div>';

    html += '<div class="row mt-3">';
    html += '<div class="col-md-4"><label>ไร่</label><input type="number" step="0.01" class="form-control rai" required></div>';
    html += '<div class="col-md-4"><label>งาน</label><input type="number" step="0.01" class="form-control ngan" required></div>';
    html += '<div class="col-md-4"><label>ตารางวา</label><input type="number" step="0.01" class="form-control squreWah" required></div>';
    html += '</div>';

    html += '<div class="mt-3"><label>เลขโฉนด</label><input type="text" class="form-control titleDeedNo" required></div>';
    html += '<div class="mt-3"><label>ที่ตั้งพื้นที่</label><input type="text" class="form-control location" required></div>';
    html += '<div class="mt-3"><label>รูปโฉนด</label><input type="file" class="form-control image" accept="image/*" required></div>';
    html += '</div>';

    document.getElementById("landContainer").insertAdjacentHTML("beforeend", html);
    index++;
}

function removeLand(btn){
    btn.closest(".land-card").remove();
}

async function submitAllLands(){

    const cycleId = document.getElementById("registerCycleId").value;
    const cards = document.querySelectorAll(".land-card");

    for(let i = 0; i < cards.length; i++){

        const card = cards[i];
        const formData = new FormData();

        formData.append("cycleId", cycleId);
        formData.append("rai", card.querySelector(".rai").value);
        formData.append("ngan", card.querySelector(".ngan").value);
        formData.append("squreWah", card.querySelector(".squreWah").value);
        formData.append("titleDeedNo", card.querySelector(".titleDeedNo").value);
        formData.append("location", card.querySelector(".location").value);
        formData.append("image", card.querySelector(".image").files[0]);

        const res = await fetch("${pageContext.request.contextPath}/farmer/register-cycle-land", {
            method: "POST",
            body: formData
        });

        const text = await res.text();

        if(text.trim() !== "success"){
            alert("บันทึกพื้นที่ที่ " + (i + 1) + " ไม่สำเร็จ");
            return;
        }
    }

    alert("ลงทะเบียนสำเร็จ");
    window.location.href =
        "${pageContext.request.contextPath}/farmer/cycle/detail/" + cycleId;
}
</script>

</body>
</html>