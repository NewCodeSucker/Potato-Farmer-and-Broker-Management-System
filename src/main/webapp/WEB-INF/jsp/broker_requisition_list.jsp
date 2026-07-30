<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt"
           uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>รายการใบเบิกของเกษตรกร</title>

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
      href="${pageContext.request.contextPath}/css/broker_requisition.css">
</head>

<body>

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
            <a href="${pageContext.request.contextPath}/broker/home" >
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
            <a class="active"
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

<main class="page">

    <header class="page-header">

        <div class="header-left">

            <div class="page-icon">
                <i class="fa-solid fa-file-signature"></i>
            </div>

            <div>
                <h1>รายการใบเบิกของเกษตรกร</h1>

                <p>
                    ตรวจสอบและพิจารณาใบเบิกยาและสารเคมี
                </p>
            </div>

        </div>

    </header>

    <c:if test="${success eq 'approved'}">

        <div class="alert success-alert">
            <i class="fa-solid fa-circle-check"></i>
            อนุมัติใบเบิกเรียบร้อยแล้ว
        </div>

    </c:if>

    <c:if test="${success eq 'rejected'}">

        <div class="alert reject-alert">
            <i class="fa-solid fa-circle-xmark"></i>
            ปฏิเสธใบเบิกเรียบร้อยแล้ว
        </div>

    </c:if>

    <section class="filter-card">

        <div class="filter-heading">

            <i class="fa-solid fa-filter"></i>

            <div>
                <h2>ค้นหาและกรองข้อมูล</h2>
                <p>เลือกแสดงใบเบิกตามรอบและสถานะ</p>
            </div>

        </div>

        <form method="get"
              action="${pageContext.request.contextPath}/broker/requisitions"
              class="filter-form">

            <div class="form-field">

                <label for="cycleId">
                    รอบเพาะปลูก
                </label>

                <select id="cycleId"
                        name="cycleId">

                    <option value="">
                        ทุกรอบเพาะปลูก
                    </option>

                    <c:forEach items="${cycles}"
                               var="cycle">

                        <option value="${cycle.cyleId}"
                            <c:if test="${selectedCycleId eq cycle.cyleId}">
                                selected
                            </c:if>>

                            ${cycle.cycleName}
                        </option>

                    </c:forEach>

                </select>

            </div>

            <div class="form-field">

                <label for="status">
                    สถานะใบเบิก
                </label>

                <select id="status"
                        name="status">

                    <option value="">
                        ทุกสถานะ
                    </option>

                    <option value="SUBMITTED"
                        <c:if test="${selectedStatus eq 'SUBMITTED'}">
                            selected
                        </c:if>>

                        รอพิจารณา
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

                <i class="fa-solid fa-magnifying-glass"></i>
                แสดงผล
            </button>

            <a href="${pageContext.request.contextPath}/broker/requisitions"
               class="clear-button">

                ล้างตัวกรอง
            </a>

        </form>

    </section>

    <div class="result-header">

        <span>
            พบทั้งหมด
            <b>${total}</b>
            รายการ
        </span>

    </div>

    <section class="table-card">

        <div class="table-wrapper">

            <table class="requisition-table">

                <thead>
                    <tr>
                        <th>เลขที่ใบเบิก</th>
                        <th>เกษตรกร</th>
                        <th>รอบเพาะปลูก</th>
                        <th>วันที่ส่ง</th>
                        <th>จำนวนรายการ</th>
                        <th>ยอดรวม</th>
                        <th>สถานะ</th>
                        <th class="text-right">จัดการ</th>
                    </tr>
                </thead>

                <tbody>

                    <c:choose>

                        <c:when test="${not empty requisitions}">

                            <c:forEach items="${requisitions}"
                                       var="req">

                                <tr>

                                    <td>

                                        <div class="requisition-code">

                                            <div class="table-icon">
                                                <i class="fa-solid fa-file-lines"></i>
                                            </div>

                                            <b>
                                                REQ${req.requisitionId}
                                            </b>

                                        </div>

                                    </td>

                                    <td>

                                        <b>${req.farmerName}</b>

                                        <small>
                                            ${req.phoneNumber}
                                        </small>

                                    </td>

                                    <td>
                                        ${req.cycleName}
                                    </td>

                                    <td>
                                        ${req.submitDate}
                                    </td>

                                    <td>
                                        ${req.detailCount} รายการ
                                    </td>

                                    <td class="money-text">

                                        ฿<fmt:formatNumber
                                            value="${req.totalPrice}"
                                            pattern="#,##0.00"/>

                                    </td>

                                    <td>

                                        <c:choose>

                                            <c:when test="${req.status eq 'SUBMITTED'}">

                                                <span class="status submitted">
                                                    รอพิจารณา
                                                </span>

                                            </c:when>

                                            <c:when test="${req.status eq 'APPROVED'}">

                                                <span class="status approved">
                                                    อนุมัติแล้ว
                                                </span>

                                            </c:when>

                                            <c:when test="${req.status eq 'REJECTED'}">

                                                <span class="status rejected">
                                                    ไม่อนุมัติ
                                                </span>

                                            </c:when>

                                            <c:otherwise>

                                                <span class="status draft">
                                                    ${req.status}
                                                </span>

                                            </c:otherwise>

                                        </c:choose>

                                    </td>

                                    <td class="text-right">

                                        <a href="${pageContext.request.contextPath}/broker/requisition/${req.requisitionId}"
                                           class="detail-button">

                                            <i class="fa-regular fa-eye"></i>
                                            ดูรายละเอียด
                                        </a>

                                    </td>

                                </tr>

                            </c:forEach>

                        </c:when>

                        <c:otherwise>

                            <tr>
                                <td colspan="8"
                                    class="empty-table">

                                    <div class="empty-icon">
                                        <i class="fa-solid fa-file-circle-xmark"></i>
                                    </div>

                                    <h3>ไม่พบข้อมูลใบเบิก</h3>

                                    <p>
                                        ยังไม่มีใบเบิกที่ตรงกับเงื่อนไขที่เลือก
                                    </p>

                                </td>
                            </tr>

                        </c:otherwise>

                    </c:choose>

                </tbody>

            </table>

        </div>

    </section>

</main>

</body>
</html>