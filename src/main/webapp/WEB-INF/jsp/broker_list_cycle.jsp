<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รอบการเพาะปลูกทั้งหมด</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_list_cycle.css">
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
        <div class="header-left">
            <div class="main-icon">
             <i class="fa-solid fa-seedling"></i>
            </div>
            <div>
                <h2>รอบการเพาะปลูกทั้งหมด</h2>
                <p>จัดการและติดตามรอบการเพาะปลูก</p>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/broker/cycle/add"
           class="add-btn">
            + เพิ่มรอบใหม่
        </a>
    </div>

    <hr>

    <div class="summary-grid">

        <div class="summary-card blue">
            <p>รอบทั้งหมด</p>
            <h3>${totalCycle}</h3>
        </div>

        <div class="summary-card green">
            <p>เปิดรับลงทะเบียน</p>
            <h3>${openCount}</h3>
        </div>

        <div class="summary-card blue">
            <p>กำลังดำเนินการ</p>
            <h3>${progressCount}</h3>
        </div>

        <div class="summary-card gray">
            <p>เสร็จสิ้น</p>
            <h3>${closeCount}</h3>
        </div>

    </div>

    <div class="sort-box">
        <span>↕ เรียงตาม:</span>

        <a href="${pageContext.request.contextPath}/broker/cycles?sort=name"
           class="sort-btn ${sort == 'name' ? 'active' : ''}">
            ชื่อรอบ
        </a>

        <a href="${pageContext.request.contextPath}/broker/cycles?sort=status"
           class="sort-btn ${sort == 'status' ? 'active' : ''}">
            สถานะ
        </a>

        <a href="${pageContext.request.contextPath}/broker/cycles?sort=date"
           class="sort-btn ${sort == 'date' ? 'active' : ''}">
            วันที่
        </a>
    </div>

    <div class="table-card">

        <table class="cycle-table">

            <thead>
                <tr>
                    <th>รหัส/ชื่อรอบ</th>
                    <th>สถานะ</th>
                    <th>จำนวนเกษตรกร</th>
                    <th class="text-end">จัดการ</th>
                </tr>
            </thead>

            <tbody>

            <c:forEach items="${cycles}" var="cycle">

                <tr>

                    <td>
                        <div class="cycle-name-box">
                            <div class="small-icon">
                            <i class="fa-solid fa-seedling"></i>
                            </div>
                            <div>
                                <b>${cycle.cycleName}</b>
                                <p>CC${cycle.cyleId}</p>
                            </div>
                        </div>
                    </td>

                    <td>
                       <c:choose>
					    <c:when test="${cycle.status eq 'open' || cycle.status eq 'OPEN'}">
					        <span class="badge-status open">เปิดรับลงทะเบียน</span>
					    </c:when>
					
					    <c:when test="${cycle.status eq 'progress' || cycle.status eq 'PROGRESS'}">
					        <span class="badge-status progress">กำลังดำเนินการ</span>
					    </c:when>
					
					    <c:when test="${cycle.status eq 'close' || cycle.status eq 'CLOSE'}">
					        <span class="badge-status close">เสร็จสิ้น</span>
					    </c:when>
					
					    <c:otherwise>
					        <span class="badge-status close">${cycle.status}</span>
					    </c:otherwise>
					</c:choose>
                    </td>

                    <td>
                        <div class="people-box">
                           
                            <b>
                                ${registeredCount[cycle.cyleId]}/${cycle.maxpeople}
                            </b>

                            <div class="progress-line">
                                <div class="progress-fill"
                                     style="width:${percentMap[cycle.cyleId]}%">
                                </div>
                            </div>
                        </div>
                    </td>

                    <td class="text-end">
                        <a href="${pageContext.request.contextPath}/broker/cycle/detail/${cycle.cyleId}"
                           class="detail-btn">
                            👁 ดูรายละเอียด
                        </a>
                    </td>

                </tr>

            </c:forEach>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>