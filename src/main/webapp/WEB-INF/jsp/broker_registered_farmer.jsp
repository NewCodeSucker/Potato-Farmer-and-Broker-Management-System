<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>เกษตรกรที่ลงทะเบียน</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/broker_registered_farmer.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
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

        <div class="main-icon">
            <i class="fa-solid fa-user-group"></i>
        </div>

        <div>
            <h2>เกษตรกรที่ลงทะเบียน</h2>
            <p>${cycle.cycleName}</p>
        </div>
    </div>

    <hr>

    <div class="filter-box">

        <h4><i class="fa-solid fa-magnifying-glass"></i> ค้นหาและกรองข้อมูล</h4>

        <label>ค้นหา</label>

        <input type="text"
               id="searchInput"
               class="search-input"
               placeholder="ค้นหาด้วยชื่อ หรือเบอร์โทรศัพท์..."
               onkeyup="searchFarmer()">

        <p class="result-text">
            พบ <b>${total}</b> ราย จากทั้งหมด <b>${total}</b> ราย
        </p>

    </div>

    <div class="table-card">

        <table class="farmer-table">

            <thead>
                <tr>
                    <th>ชื่อ-นามสกุล</th>
                    <th>เบอร์โทรศัพท์</th>
                    <th>ที่อยู่</th>
                    <th class="text-end">จัดการ</th>
                </tr>
            </thead>

            <tbody id="farmerTableBody">

                <c:choose>

                    <c:when test="${not empty farmers}">

                        <c:forEach items="${farmers}" var="farmer">

                            <tr class="farmer-row">

                                <td class="farmer-name">
                                    ${farmer.firstname} ${farmer.lastname}
                                </td>

                                <td class="farmer-phone">
                                    ${farmer.phoneNumber}
                                </td>

                                <td>
                                    ${farmer.address}
                                </td>

                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/broker/cycle/${cycle.cyleId}/farmer/${farmer.farmerId}"
									   class="detail-btn">
									    <i class="fa-regular fa-eye"></i> ดูรายละเอียด
									</a>
                                </td>
                            </tr>
                        </c:forEach>

                    </c:when>

                    <c:otherwise>

                        <tr>
                            <td colspan="4" class="empty">
                                ยังไม่มีเกษตรกรลงทะเบียนในรอบนี้
                            </td>
                        </tr>

                    </c:otherwise>

                </c:choose>

            </tbody>

        </table>

<script>
function searchFarmer(){

    const keyword =
        document.getElementById("searchInput")
                .value
                .toLowerCase();

    const rows =
        document.querySelectorAll(".farmer-row");

    rows.forEach(row => {

        const name =
            row.querySelector(".farmer-name")
               .innerText
               .toLowerCase();

        const phone =
            row.querySelector(".farmer-phone")
               .innerText
               .toLowerCase();

        if(name.includes(keyword) || phone.includes(keyword)){
            row.style.display = "";
        }else{
            row.style.display = "none";
        }

    });
}
</script>

</body>
</html>