<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>เกษตรกรที่อนุมัติแล้ว</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_approved_farmer.css">
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
        <a href="${pageContext.request.contextPath}/broker/cycle/detail/${cycle.cyleId}"
           class="back-btn">
            ←
        </a>

        <div class="main-icon">✓</div>

        <div>
            <h2>เกษตรกรที่อนุมัติแล้ว</h2>
            <p>${cycle.cycleName}</p>
        </div>
    </div>

    <hr>

    <div class="summary-grid">

        <div class="summary-card">
            <p>เกษตรกรที่อนุมัติ</p>
            <h3>${total}</h3>
            <span>ราย</span>
        </div>

        <div class="summary-card">
            <p>รอบการเพาะปลูก</p>
            <h3>${cycle.cycleName}</h3>
        </div>

    </div>

    <div class="search-box">
        <label>ค้นหา</label>

        <input type="text"
               id="searchInput"
               placeholder="ค้นหาด้วยรหัสเกษตรกร, ชื่อ, ชื่อผู้ใช้ หรือเบอร์โทร..."
               onkeyup="searchFarmer()">
    </div>

    <div class="table-card">

        <table class="farmer-table">
            <thead>
                <tr>
                    <th>รหัสเกษตรกร</th>
                    <th>ชื่อผู้ใช้</th>
                    <th>ชื่อ-นามสกุล</th>
                    <th class="text-end">จัดการ</th>
                </tr>
            </thead>

            <tbody>

            <c:choose>

                <c:when test="${not empty farmers}">

                    <c:forEach items="${farmers}" var="farmer">

                        <tr class="farmer-row">

                            <td class="farmer-code">
                                <span class="code-badge">
                                    F00${farmer.farmerId}
                                </span>
                            </td>

                            <td class="farmer-card">
                                ${farmer.userName}
                            </td>

                            <td class="farmer-name">
                                ${farmer.firstname} ${farmer.lastname}
                            </td>

                            <td class="text-end">
	                            <a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/approved-farmer/${farmer.farmerId}"
								   class="detail-btn">
								    👁 ดูรายละเอียด
								</a>
                            </td>

                        </tr>

                    </c:forEach>

                </c:when>

                <c:otherwise>
                    <tr>
                        <td colspan="4" class="empty">
                            ยังไม่มีเกษตรกรที่อนุมัติ
                        </td>
                    </tr>
                </c:otherwise>

            </c:choose>

            </tbody>
        </table>

    </div>

</div>

<script>
function searchFarmer(){

    const keyword =
        document.getElementById("searchInput")
                .value
                .toLowerCase();

    const rows =
        document.querySelectorAll(".farmer-row");

    rows.forEach(row => {

        const text =
            row.innerText.toLowerCase();

        row.style.display =
            text.includes(keyword) ? "" : "none";
    });
}
</script>

</body>
</html>