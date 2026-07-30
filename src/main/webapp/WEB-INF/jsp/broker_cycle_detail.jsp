<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายละเอียดรอบการเพาะปลูก</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_cycle_detail.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">



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

    <div class="top-bar">

        <a href="${pageContext.request.contextPath}/broker/cycles"
           class="back-btn">
            ←
        </a>

        <div class="cycle-icon">
         <i class="fa-solid fa-seedling"></i>
        </div>

        <div class="title-section">
            <div class="title-line">
                <h2>${cycle.cycleName}</h2>
            </div>

            <p>รายละเอียดรอบการเพาะปลูก</p>
        </div>

        <div class="action-buttons">
			
           <a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/farmers"
			   class="btn-farmers">
			    <i class="fa-solid fa-users"></i>
			     เกษตรกรที่ลงทะเบียน
			</a>
			<a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/approved-farmers"
			   class="btn-farmers">
			    <i class="fa-solid fa-check"></i>
			     เกษตรกรที่อนุมัติแล้ว
			</a>
            <a href="${pageContext.request.contextPath}/broker/cycle/edit/${cycle.cyleId}"
               class="btn-edit">
                ✎ แก้ไขรอบ
            </a>

        </div>

    </div>

    <hr>

    <div class="status-box">

        <div>
            <h4>สถานะรอบการเพาะปลูก</h4>

            <c:choose>
                <c:when test="${cycle.status eq 'open' || cycle.status eq 'OPEN'}">
                    <p>เปิดรับลงทะเบียน</p>
                </c:when>

                <c:when test="${cycle.status eq 'progress' || cycle.status eq 'PROGRESS'}">
                    <p>กำลังดำเนินการ</p>
                </c:when>

                <c:otherwise>
                    <p>เสร็จสิ้น</p>
                </c:otherwise>
            </c:choose>
        </div>

        <c:choose>
            <c:when test="${cycle.status eq 'open' || cycle.status eq 'OPEN'}">
                <span class="status-badge open">
                    เปิดรับลงทะเบียน
                </span>
            </c:when>

            <c:when test="${cycle.status eq 'progress' || cycle.status eq 'PROGRESS'}">
                <span class="status-badge progress">
                    กำลังดำเนินการ
                </span>
            </c:when>

            <c:otherwise>
                <span class="status-badge close">
                    เสร็จสิ้น
                </span>
            </c:otherwise>
        </c:choose>

    </div>

    <div class="detail-grid">

        <div class="card-box">

            <h4>
              <i class="fa-regular fa-calendar"></i> กำหนดการ
            </h4>

            <div class="date-item pink">
                <span>เปิดรับลงทะเบียน</span>
                <b>${cycle.openRegDate}</b>
            </div>

            <div class="date-item red">
                <span>ปิดรับลงทะเบียน</span>
                <b>${cycle.endRegDate}</b>
            </div>

            <div class="date-item blue">
                <span>วันเริ่มปลูก</span>
                <b>${cycle.plantDate}</b>
            </div>

            <div class="date-item green">
                <span>วันเก็บเกี่ยว</span>
                <b>${cycle.harvestDate}</b>
            </div>

        </div>

        <div class="card-box">

            <h4>
              <i class="fa-solid fa-seedling"></i> ข้อมูลการเพาะปลูก
            </h4>

            <div class="info-item green">
                <span>ชนิดหัวพันธุ์</span>
                <b>${cycle.potatoType}</b>
            </div>

            <div class="info-item blue">
                <span>ราคาขายต่อหน่วย</span>
                <b>฿${cycle.purchasePrice}/กก.</b>
            </div>

            <div class="info-item orange">
                <span>จำนวนเกษตรกร</span>
                <b>${registered}/${cycle.maxpeople} ท่าน</b>

                <div class="progress-line">
                    <div class="progress-fill"
                         style="width:${percent}%">
                    </div>
                </div>

                <small>
                    คงเหลือ ${remaining} ที่
                </small>
            </div>

        </div>

    </div>

</div>

</body>
</html>