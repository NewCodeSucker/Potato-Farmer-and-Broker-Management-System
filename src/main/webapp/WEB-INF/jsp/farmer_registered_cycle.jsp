<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>รอบที่ลงทะเบียน</title>

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/farmer_registered_cycle.css">
</head>

<body>

    <nav class="navbar">
        <div class="logo-section">
            <i class="fa-solid fa-seedling"></i>
            <span>Potato Farmer</span>
        </div>

        <ul class="menu">
            <li>
                <a href="${pageContext.request.contextPath}/farmer/home">
                    <i class="fa-solid fa-house"></i> หน้าแรก
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/farmer/cycles">
                    <i class="fa-solid fa-calendar-days"></i> รอบเพาะปลูก
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/farmer/registered-cycles" class="active">
                    <i class="fa-solid fa-clipboard-check"></i> รอบที่ลงทะเบียน
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

<main class="page">

    <section class="page-header">

        <div class="page-icon">
            <i class="fa-solid fa-clipboard-list"></i>
        </div>

        <div>
            <h1>รอบที่ลงทะเบียน</h1>

            <p>
                ตรวจสอบรอบปัจจุบัน และดูประวัติผลผลิต รายรับ และต้นทุนที่ผ่านมา
            </p>
        </div>

    </section>

    <section class="tab-navigation">

        <a href="${pageContext.request.contextPath}/farmer/registered-cycles?tab=current"
           class="tab-link<c:if test="${tab eq 'current'}"> active</c:if>">

            <i class="fa-solid fa-seedling"></i>

            <span>รอบปัจจุบัน</span>

            <b>${currentTotal}</b>

        </a>

        <a href="${pageContext.request.contextPath}/farmer/registered-cycles?tab=history"
           class="tab-link<c:if test="${tab eq 'history'}"> active</c:if>">

            <i class="fa-solid fa-clock-rotate-left"></i>

            <span>ประวัติรอบเพาะปลูก</span>

            <b>${historyTotal}</b>

        </a>

    </section>

    <c:choose>

        <c:when test="${tab eq 'history'}">

            <section class="cycle-list">

                <c:choose>

                    <c:when test="${not empty histories}">

                        <c:forEach items="${histories}" var="history">

                            <article class="cycle-card">

                                <div class="cycle-left">

                                    <div class="cycle-icon">
                                        <i class="fa-solid fa-seedling"></i>
                                    </div>

                                    <div class="cycle-info">

                                        <h2>
                                            ${history.register.cycle.cycleName}
                                        </h2>

                                        <div class="cycle-meta">

                                            <span>
                                                <i class="fa-solid fa-leaf"></i>
                                                ${history.register.cycle.potatoType}
                                            </span>

                                            <span>
                                                <i class="fa-regular fa-calendar-check"></i>
                                                เก็บเกี่ยว
                                                ${history.register.scheduledHarvestDate}
                                            </span>

                                        </div>

                                    </div>

                                </div>

                                <div class="cycle-actions">

                                    <span class="status completed">
                                        <i class="fa-solid fa-check"></i>
                                        เสร็จสิ้น
                                    </span>

                                    <a href="${pageContext.request.contextPath}/farmer/registered-cycle/history/${history.register.registerId}"
                                       class="detail-button">

                                        ดูรายละเอียด

                                        <i class="fa-solid fa-arrow-right"></i>
                                    </a>

                                </div>

                            </article>

                        </c:forEach>

                    </c:when>

                    <c:otherwise>

                        <div class="empty-state">

                            <div class="empty-icon">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                            </div>

                            <h2>ยังไม่มีประวัติรอบเพาะปลูก</h2>

                            <p>
                                รอบที่ดำเนินการเสร็จสิ้นแล้วจะแสดงในหน้านี้
                            </p>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>

        </c:when>

        <c:otherwise>

            <section class="cycle-list">

                <c:choose>

                    <c:when test="${not empty currentRegisters}">

                        <c:forEach items="${currentRegisters}" var="reg">

                            <article class="cycle-card">

                                <div class="cycle-left">

                                    <div class="cycle-icon">
                                        <i class="fa-solid fa-seedling"></i>
                                    </div>

                                    <div class="cycle-info">

                                        <h2>
                                            ${reg.cycle.cycleName}
                                        </h2>

                                        <div class="cycle-meta">

                                            <span>
                                                <i class="fa-regular fa-calendar"></i>
                                                ลงทะเบียน
                                                ${reg.registerDate}
                                            </span>

                                            <span>
                                                <i class="fa-solid fa-leaf"></i>
                                                ${reg.cycle.potatoType}
                                            </span>

                                        </div>

                                    </div>

                                </div>

                                <div class="cycle-actions">

                                    <c:choose>

                                        <c:when test="${reg.regStatus eq 'PENDING'}">

                                            <span class="status pending">
                                                <i class="fa-solid fa-clock"></i>
                                                รออนุมัติ
                                            </span>

                                        </c:when>

                                        <c:when test="${reg.regStatus eq 'APPROVED'}">

                                            <span class="status approved">
                                                <i class="fa-solid fa-check"></i>
                                                อนุมัติแล้ว
                                            </span>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="status rejected">
                                                <i class="fa-solid fa-xmark"></i>
                                                ไม่อนุมัติ
                                            </span>

                                        </c:otherwise>

                                    </c:choose>

                                    <a href="${pageContext.request.contextPath}/farmer/registered-cycle/detail/${reg.cycle.cyleId}"
                                       class="detail-button">

                                        ดูรายละเอียด

                                        <i class="fa-solid fa-arrow-right"></i>
                                    </a>

                                </div>

                            </article>

                        </c:forEach>

                    </c:when>

                    <c:otherwise>

                        <div class="empty-state">

                            <div class="empty-icon">
                                <i class="fa-solid fa-seedling"></i>
                            </div>

                            <h2>ยังไม่มีรอบที่ลงทะเบียน</h2>

                            <p>
                                สามารถเลือกรอบที่เปิดรับสมัครและลงทะเบียนพื้นที่ได้
                            </p>

                            <a href="${pageContext.request.contextPath}/farmer/cycles"
                               class="empty-button">

                                ดูรอบเพาะปลูก

                                <i class="fa-solid fa-arrow-right"></i>
                            </a>

                        </div>

                    </c:otherwise>

                </c:choose>

            </section>

        </c:otherwise>

    </c:choose>

</main>

</body>
</html>