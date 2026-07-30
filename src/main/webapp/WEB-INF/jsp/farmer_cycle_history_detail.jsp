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

<title>รายละเอียดประวัติรอบเพาะปลูก</title>

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
      href="${pageContext.request.contextPath}/css/farmer_cycle_history_detail.css">
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

        <a href="${pageContext.request.contextPath}/farmer/registered-cycles?tab=history"
           class="back-button">

            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="page-icon">
            <i class="fa-solid fa-file-invoice-dollar"></i>
        </div>

        <div class="header-text">
            <h1>รายละเอียดประวัติรอบเพาะปลูก</h1>

            <p>
                Statement การขายผลผลิตและใบสรุปต้นทุน
            </p>
        </div>

        <span class="complete-badge">
            <i class="fa-solid fa-circle-check"></i>
            เสร็จสิ้น
        </span>

    </header>

    <section class="cycle-banner">

        <div class="cycle-main">

            <div class="cycle-avatar">
                <i class="fa-solid fa-seedling"></i>
            </div>

            <div>
                <span class="label">
                    รอบการเพาะปลูก
                </span>

                <h2>${cycle.cycleName}</h2>

                <div class="cycle-tags">

                    <span>
                        <i class="fa-solid fa-leaf"></i>
                        ${cycle.potatoType}
                    </span>

                    <span>
                        <i class="fa-regular fa-calendar"></i>
                        ปลูก ${register.scheduledPlantDate}
                    </span>

                    <span>
                        <i class="fa-regular fa-calendar-check"></i>
                        เก็บเกี่ยว ${register.scheduledHarvestDate}
                    </span>

                </div>
            </div>

        </div>

        <div class="cycle-code">
            <small>รหัสรอบ</small>
            <b>CC${cycle.cyleId}</b>
        </div>

    </section>

    <section class="summary-grid">

        <article class="summary-card quantity">

            <div class="summary-icon">
                <i class="fa-solid fa-weight-hanging"></i>
            </div>

            <div>
                <span>ผลผลิตที่ขายรวม</span>

                <b>
                    <fmt:formatNumber
                        value="${history.totalQuantity}"
                        pattern="#,##0.00"/>
                    กก.
                </b>
            </div>

        </article>

        <article class="summary-card sale-count">

            <div class="summary-icon">
                <i class="fa-solid fa-list-ol"></i>
            </div>

            <div>
                <span>จำนวนครั้งที่ขาย</span>
                <b>${history.purchases.size()} ครั้ง</b>
            </div>

        </article>

        <article class="summary-card revenue">

            <div class="summary-icon">
                <i class="fa-solid fa-coins"></i>
            </div>

            <div>
                <span>รายรับรวม</span>

                <b>
                    ฿<fmt:formatNumber
                        value="${history.totalRevenue}"
                        pattern="#,##0.00"/>
                </b>
            </div>

        </article>

        <article class="summary-card cost">

            <div class="summary-icon">
                <i class="fa-solid fa-receipt"></i>
            </div>

            <div>
                <span>ต้นทุนรวม</span>

                <b>
                    ฿<fmt:formatNumber
                        value="${history.totalCost}"
                        pattern="#,##0.00"/>
                </b>
            </div>

        </article>

        <article class="summary-card profit">

            <div class="summary-icon">
                <i class="fa-solid fa-chart-line"></i>
            </div>

            <div>
                <span>รายได้สุทธิ</span>

                <b>
                    ฿<fmt:formatNumber
                        value="${history.netIncome}"
                        pattern="#,##0.00"/>
                </b>
            </div>

        </article>

    </section>

    <section class="content-card">

        <div class="section-header">

            <div class="section-title">

                <div class="title-icon blue">
                    <i class="fa-solid fa-money-bill-transfer"></i>
                </div>

                <div>
                    <h2>Statement การขายผลผลิต</h2>

                    <p>
                        รายการรับซื้อผลผลิตทั้งหมดของเกษตรกรในรอบนี้
                    </p>
                </div>

            </div>

            <span class="record-count">
                ${history.purchases.size()} รายการ
            </span>

        </div>

        <c:choose>

            <c:when test="${not empty history.purchases}">

                <div class="table-wrapper">

                    <table class="statement-table">

                        <thead>
                            <tr>
                                <th>ลำดับ</th>
                                <th>เลขที่รายการ</th>
                                <th>วันที่รับซื้อ</th>
                                <th>ปริมาณผลผลิต</th>
                                <th>ยอดขาย</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:forEach
                                items="${history.purchases}"
                                var="purchase"
                                varStatus="st">

                                <tr>
                                    <td>
                                        <span class="row-number">
                                            ${st.count}
                                        </span>
                                    </td>

                                    <td>
                                        PO${purchase.purchaseId}
                                    </td>

                                    <td>
                                        ${purchase.purchaseDate}
                                    </td>

                                    <td>
                                        <fmt:formatNumber
                                            value="${purchase.quantity}"
                                            pattern="#,##0.00"/>
                                        กก.
                                    </td>

                                    <td class="revenue-text">
                                        ฿<fmt:formatNumber
                                            value="${purchase.totalPrice}"
                                            pattern="#,##0.00"/>
                                    </td>
                                </tr>

                            </c:forEach>

                        </tbody>

                        <tfoot>
                            <tr>
                                <td colspan="3">
                                    รวมทั้งหมด
                                </td>

                                <td>
                                    <fmt:formatNumber
                                        value="${history.totalQuantity}"
                                        pattern="#,##0.00"/>
                                    กก.
                                </td>

                                <td class="revenue-text">
                                    ฿<fmt:formatNumber
                                        value="${history.totalRevenue}"
                                        pattern="#,##0.00"/>
                                </td>
                            </tr>
                        </tfoot>

                    </table>

                </div>

            </c:when>

            <c:otherwise>

                <div class="empty-box">

                    <i class="fa-solid fa-chart-line"></i>

                    <h3>ยังไม่มีข้อมูลการขายผลผลิต</h3>

                    <p>
                        โปรดรอโบรกเกอร์บันทึกข้อมูลการรับซื้อ
                    </p>

                </div>

            </c:otherwise>

        </c:choose>

    </section>

    <section class="content-card">

        <div class="section-header">

            <div class="section-title">

                <div class="title-icon orange">
                    <i class="fa-solid fa-file-invoice"></i>
                </div>

                <div>
                    <h2>ใบสรุปต้นทุนการเพาะปลูก</h2>

                    <p>
                        รายการหัวพันธุ์ ปุ๋ย ยา และวัสดุที่ได้รับจากโบรกเกอร์
                    </p>
                </div>

            </div>

            <strong class="cost-total">
                ต้นทุนรวม
                ฿<fmt:formatNumber
                    value="${history.totalCost}"
                    pattern="#,##0.00"/>
            </strong>

        </div>

        <c:choose>

            <c:when test="${not empty history.requisitions}">

                <c:forEach
                    items="${history.requisitions}"
                    var="requisition"
                    varStatus="reqStatus">

                    <article class="requisition-card">

                        <header class="requisition-header">

                            <div class="requisition-name">

                                <div class="requisition-icon">

                                    <c:choose>

                                        <c:when test="${reqStatus.first}">
                                            <i class="fa-solid fa-box-open"></i>
                                        </c:when>

                                        <c:otherwise>
                                            <i class="fa-solid fa-file-circle-plus"></i>
                                        </c:otherwise>

                                    </c:choose>

                                </div>

                                <div>

                                    <h3>

                                        <c:choose>

                                            <c:when test="${reqStatus.first}">
                                                การจัดสรรครั้งแรก
                                            </c:when>

                                            <c:otherwise>
                                                ใบเบิกเพิ่มเติม
                                            </c:otherwise>

                                        </c:choose>

                                    </h3>

                                    <p>
                                        ใบเบิกเลขที่
                                        REQ${requisition.requisitionId}
                                    </p>

                                </div>

                            </div>

                            <div class="requisition-meta">

                                <span class="approved-badge">
                                    <i class="fa-solid fa-check"></i>
                                    อนุมัติแล้ว
                                </span>

                                <span>
                                    <i class="fa-regular fa-calendar"></i>
                                    ${requisition.submitDate}
                                </span>

                            </div>

                        </header>

                        <div class="table-wrapper">

                            <table class="cost-table">

                                <thead>
                                    <tr>
                                        <th>รายการ</th>
                                        <th>เหตุผล/รายละเอียด</th>
                                        <th>จำนวน</th>
                                        <th>ราคาต่อหน่วย</th>
                                        <th>รวม</th>
                                    </tr>
                                </thead>

                                <tbody>

                                    <c:forEach
                                        items="${requisition.details}"
                                        var="detail">

                                        <tr>
                                            <td class="item-name">
                                                <i class="fa-solid fa-box"></i>

                                                ${detail.item.itemName}
                                            </td>

                                            <td>
                                                ${detail.cause}
                                            </td>

                                            <td>
                                                ${detail.qty}
                                            </td>

                                            <td>
                                                ฿<fmt:formatNumber
                                                    value="${detail.unitPrice}"
                                                    pattern="#,##0.00"/>
                                            </td>

                                            <td class="cost-text">
                                                ฿<fmt:formatNumber
                                                    value="${detail.totalPrice}"
                                                    pattern="#,##0.00"/>
                                            </td>
                                        </tr>

                                    </c:forEach>

                                </tbody>

                            </table>

                        </div>

                    </article>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <div class="empty-box">

                    <i class="fa-solid fa-file-circle-xmark"></i>

                    <h3>ไม่พบข้อมูลใบเบิก</h3>

                    <p>
                        รอบนี้ยังไม่มีรายการต้นทุนจากใบเบิก
                    </p>

                </div>

            </c:otherwise>

        </c:choose>

    </section>

    <section class="net-summary">

        <div>
            <span>รายรับรวม</span>

            <b class="net-revenue">
                ฿<fmt:formatNumber
                    value="${history.totalRevenue}"
                    pattern="#,##0.00"/>
            </b>
        </div>

        <i class="fa-solid fa-minus"></i>

        <div>
            <span>ต้นทุนรวม</span>

            <b class="net-cost">
                ฿<fmt:formatNumber
                    value="${history.totalCost}"
                    pattern="#,##0.00"/>
            </b>
        </div>

        <i class="fa-solid fa-equals"></i>

        <div class="net-result">
            <span>รายได้สุทธิ</span>

            <b>
                ฿<fmt:formatNumber
                    value="${history.netIncome}"
                    pattern="#,##0.00"/>
            </b>
        </div>

    </section>

</main>

</body>
</html>