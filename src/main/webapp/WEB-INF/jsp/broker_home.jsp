<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Broker Home</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_home.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

</head>
<body>

	<!-- NAVBAR -->

	<nav class="navbar">

    <div class="logo-section">

        <div class="logo-icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <div>
            <b>Potato Broker</b>
            <small>ระบบจัดการมันฝรั่ง</small>
        </div>

    </div>

    <ul class="menu">

        <li>
            <a href="${pageContext.request.contextPath}/broker/home" class="active">
                <i class="fa-solid fa-house"></i>
                หน้าแรก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/broker/cycles">
                <i class="fa-solid fa-calendar-days"></i>
                รอบเพาะปลูก
            </a>
        </li>

        <li>
            <a 
               href="${pageContext.request.contextPath}/broker/requisitions">

                <i class="fa-solid fa-file-lines"></i>
                ใบเบิก
            </a>
        </li>

    </ul>

    <div class="broker-section">

        <div class="broker-avatar">
            <i class="fa-solid fa-user-tie"></i>
        </div>

        <div>
            <b>${firstname} ${lastname}</b>

            <a href="${pageContext.request.contextPath}/logout">
                ออกจากระบบ
            </a>
        </div>

    </div>

</nav>
	<!-- CONTENT -->

	<div class="container mt-5">

		<div class="welcome-section">

			<div class="logo-circle">

				<i class="fa-solid fa-seedling"></i>

			</div>

			<h1>
				ยินดีต้อนรับ
				${firstname}
			</h1>

			<p>ระบบจัดการรอบการเพาะปลูกมันฝรั่ง</p>

		</div>

		<div class="row mt-5">

			<div class="col-lg-4 mb-4">

				<div class="menu-card">

					<div class="card-icon">
						<i class="fa-solid fa-list-check"></i>
					</div>

					<h3>รอบการเพาะปลูก</h3>

					<p>ดูและจัดการรอบการเพาะปลูกทั้งหมด</p>

					<a href="${pageContext.request.contextPath}/broker/cycles">

						เข้าสู่หน้า → </a>

				</div>

			</div>

			<div class="col-lg-4 mb-4">

				<div class="menu-card">

					<div class="card-icon green">
						<i class="fa-solid fa-plus"></i>
					</div>

					<h3>เพิ่มรอบเพาะปลูก</h3>

					<p>สร้างรอบเพาะปลูกใหม่</p>

					<a href="${pageContext.request.contextPath}/broker/cycle/add">

						เข้าสู่หน้า → </a>

				</div>

			</div>

		</div>

	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>