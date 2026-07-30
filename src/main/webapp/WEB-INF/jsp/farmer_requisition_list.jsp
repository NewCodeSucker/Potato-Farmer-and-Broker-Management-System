<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>รายการใบเบิก</title>

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
      href="${pageContext.request.contextPath}/css/farmer_requisition.css">
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
            <a href="${pageContext.request.contextPath}/farmer/cycles">
                <i class="fa-solid fa-calendar-days"></i>
                รอบเพาะปลูก
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/farmer/registered-cycles">
                <i class="fa-solid fa-clipboard-check"></i>
                รอบที่ลงทะเบียน
            </a>
        </li>
        
        <li>
	    <a href="${pageContext.request.contextPath}/farmer/requisitions" class="active">
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

    <header class="page-header">

        <div class="header-title">

            <div class="page-icon">
                <i class="fa-solid fa-file-circle-plus"></i>
            </div>

            <div>
                <h1>รายการใบเบิก</h1>
                <p>จัดการแบบร่างและติดตามสถานะใบเบิกยาและสารเคมี</p>
            </div>

        </div>

        <a href="${pageContext.request.contextPath}/farmer/requisition/add"
           class="primary-button">

            <i class="fa-solid fa-plus"></i>
            เพิ่มใบเบิก
        </a>

    </header>

    <c:if test="${not empty success}">
        <div class="alert success-alert">
            <i class="fa-solid fa-circle-check"></i>
            ${success}
        </div>
    </c:if>

    <section class="filter-card">

        <form method="get"
              action="${pageContext.request.contextPath}/farmer/requisitions"
              class="filter-form">

            <div class="filter-field">

                <label for="registerId">
                    รอบเพาะปลูก
                </label>

                <select id="registerId"
                        name="registerId">

                    <option value="">
                        ทุกรอบ
                    </option>

                    <c:forEach items="${approvedCycles}"
                               var="reg">

                        <option value="${reg.registerId}"
                            <c:if test="${selectedRegisterId eq reg.registerId}">
                                selected
                            </c:if>>

                            ${reg.cycle.cycleName}
                        </option>

                    </c:forEach>

                </select>

            </div>

            <div class="filter-field">

                <label for="status">
                    สถานะ
                </label>

                <select id="status"
                        name="status">

                    <option value="">
                        ทุกสถานะ
                    </option>

                    <option value="DRAFT"
                        <c:if test="${selectedStatus eq 'DRAFT'}">
                            selected
                        </c:if>>
                        แบบร่าง
                    </option>

                    <option value="SUBMITTED"
                        <c:if test="${selectedStatus eq 'SUBMITTED'}">
                            selected
                        </c:if>>
                        ส่งแล้ว
                    </option>

                    <option value="APPROVED"
                        <c:if test="${selectedStatus eq 'APPROVED'}">
                            selected
                        </c:if>>
                        อนุมัติแล้ว
                    </option>

                    <option value="REJECTED"
                        <c:if test="${selectedStatus eq 'REJECTED'}">
                            selected
                        </c:if>>
                        ไม่อนุมัติ
                    </option>

                </select>

            </div>

            <button type="submit"
                    class="filter-button">

                <i class="fa-solid fa-filter"></i>
                กรองข้อมูล
            </button>

            <a href="${pageContext.request.contextPath}/farmer/requisitions"
               class="clear-button">
                ล้างตัวกรอง
            </a>

        </form>

    </section>

    <section class="list-header">
        <span>พบ ${total} รายการ</span>
    </section>

    <section class="requisition-list">

        <c:choose>

            <c:when test="${not empty requisitions}">

                <c:forEach items="${requisitions}"
                           var="req">

                    <article class="requisition-card">

                        <div class="requisition-left">

                            <div class="requisition-icon">
                                <i class="fa-solid fa-file-lines"></i>
                            </div>

                            <div class="requisition-info">

                                <h2>
                                    REQ${req.requisitionId}
                                </h2>

                                <div class="requisition-meta">

                                    <span>
                                        <i class="fa-solid fa-seedling"></i>
                                        ${req.cycle.cycle.cycleName}
                                    </span>

                                    <span>
                                        <i class="fa-regular fa-calendar"></i>
                                        ${req.submitDate}
                                    </span>

                                    <span>
                                        <i class="fa-solid fa-box"></i>
                                        ${req.details.size()} รายการ
                                    </span>

                                </div>

                            </div>

                        </div>

                        <div class="requisition-actions">

                            <c:choose>

                                <c:when test="${req.status eq 'DRAFT'}">

                                    <span class="status draft">
                                        แบบร่าง
                                    </span>

                                    <a href="${pageContext.request.contextPath}/farmer/requisition/${req.requisitionId}"
                                       class="detail-button">
                                        ดูรายละเอียด
                                    </a>

                                    <a href="${pageContext.request.contextPath}/farmer/requisition/edit/${req.requisitionId}"
                                       class="edit-button">
                                        แก้ไข
                                    </a>

                                    <form method="post"
                                          action="${pageContext.request.contextPath}/farmer/requisition/delete/${req.requisitionId}"
                                          onsubmit="return confirm('ยืนยันการลบแบบร่างใบเบิกนี้หรือไม่?');">

                                        <button type="submit"
                                                class="delete-button">
                                            ลบ
                                        </button>
                                    </form>

                                </c:when>

                                <c:when test="${req.status eq 'SUBMITTED'}">

                                    <span class="status submitted">
                                        ส่งแล้ว
                                    </span>

                                    <a href="${pageContext.request.contextPath}/farmer/requisition/${req.requisitionId}"
                                       class="detail-button">
                                        ดูรายละเอียด
                                    </a>

                                </c:when>

                                <c:when test="${req.status eq 'APPROVED'}">

                                    <span class="status approved">
                                        อนุมัติแล้ว
                                    </span>

                                    <a href="${pageContext.request.contextPath}/farmer/requisition/${req.requisitionId}"
                                       class="detail-button">
                                        ดูรายละเอียด
                                    </a>

                                </c:when>

                                <c:otherwise>

                                    <span class="status rejected">
                                        ไม่อนุมัติ
                                    </span>

                                    <a href="${pageContext.request.contextPath}/farmer/requisition/${req.requisitionId}"
                                       class="detail-button">
                                        ดูรายละเอียด
                                    </a>

                                </c:otherwise>

                            </c:choose>

                        </div>

                    </article>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="empty-state">

                    <div class="empty-icon">
                        <i class="fa-solid fa-file-circle-xmark"></i>
                    </div>

                    <h2>ยังไม่มีใบเบิก</h2>

                    <p>
                        สร้างแบบร่างใบเบิกยาและสารเคมีสำหรับรอบที่ได้รับอนุมัติ
                    </p>

                    <a href="${pageContext.request.contextPath}/farmer/requisition/add"
                       class="primary-button">

                        <i class="fa-solid fa-plus"></i>
                        เพิ่มใบเบิก
                    </a>

                </div>

            </c:otherwise>

        </c:choose>

    </section>

</main>

</body>
</html>