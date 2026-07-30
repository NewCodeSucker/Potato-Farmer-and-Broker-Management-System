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

<title>รายละเอียดใบเบิก</title>

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap"
      rel="stylesheet">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet">

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/broker_requisition_detail.css">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>
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
            <a 
               href="${pageContext.request.contextPath}/broker/requisitions" class="active">
 
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
	
    <!-- HEADER -->

    <header class="page-header">

        <div class="header-left">

            <a href="${pageContext.request.contextPath}/broker/requisitions"
               class="back-button">

                <i class="fa-solid fa-arrow-left"></i>
            </a>

            <div class="header-icon">
                <i class="fa-solid fa-file-signature"></i>
            </div>

            <div>
                <h1>รายละเอียดใบเบิก</h1>

                <p>
                    ใบเบิกเลขที่
                    <b>REQ${requisition.requisitionId}</b>
                </p>
            </div>

        </div>

        <div class="header-actions">

            <c:choose>

                <c:when test="${requisition.status eq 'SUBMITTED'}">

                    <span class="status-badge submitted">
                        <i class="fa-solid fa-clock"></i>
                        รอพิจารณา
                    </span>

                    <button type="button"
                            class="review-button"
                            data-bs-toggle="modal"
                            data-bs-target="#reviewModal">

                        <i class="fa-solid fa-clipboard-check"></i>
                        พิจารณาใบเบิก
                    </button>

                </c:when>

                <c:when test="${requisition.status eq 'APPROVED'}">

                    <span class="status-badge approved">
                        <i class="fa-solid fa-check"></i>
                        อนุมัติแล้ว
                    </span>

                </c:when>

                <c:when test="${requisition.status eq 'REJECTED'}">

                    <span class="status-badge rejected">
                        <i class="fa-solid fa-xmark"></i>
                        ไม่อนุมัติ
                    </span>

                </c:when>

                <c:otherwise>

                    <span class="status-badge draft">
                        ${requisition.status}
                    </span>

                </c:otherwise>

            </c:choose>

        </div>

    </header>


    <!-- ALERT -->

    <c:if test="${success eq 'approved'}">

        <div class="alert-message success">

            <i class="fa-solid fa-circle-check"></i>

            <div>
                <b>อนุมัติใบเบิกสำเร็จ</b>
                <p>ระบบส่งการแจ้งเตือนไปยังเกษตรกรแล้ว</p>
            </div>

        </div>

    </c:if>

    <c:if test="${success eq 'rejected'}">

        <div class="alert-message rejected-alert">

            <i class="fa-solid fa-circle-xmark"></i>

            <div>
                <b>ปฏิเสธใบเบิกสำเร็จ</b>
                <p>ระบบส่งการแจ้งเตือนไปยังเกษตรกรแล้ว</p>
            </div>

        </div>

    </c:if>

    <c:if test="${success eq 'error'}">

        <div class="alert-message error">

            <i class="fa-solid fa-triangle-exclamation"></i>

            <div>
                <b>ไม่สามารถพิจารณาใบเบิกได้</b>
                <p>ใบเบิกอาจถูกพิจารณาไปแล้ว</p>
            </div>

        </div>

    </c:if>


    <!-- DOCUMENT SUMMARY -->

    <section class="document-summary">

        <div class="summary-main">

            <div class="document-code">

                <span>เลขที่ใบเบิก</span>

                <strong>
                    REQ${requisition.requisitionId}
                </strong>

            </div>

            <div class="summary-divider"></div>

            <div class="summary-info">

                <div>
                    <span>
                        <i class="fa-regular fa-calendar"></i>
                        วันที่ส่ง
                    </span>

                    <b>${requisition.submitDate}</b>
                </div>

                <div>
                    <span>
                        <i class="fa-solid fa-seedling"></i>
                        รอบเพาะปลูก
                    </span>

                    <b>${cycle.cycleName}</b>
                </div>

                <div>
                    <span>
                        <i class="fa-solid fa-boxes-stacked"></i>
                        จำนวนรายการ
                    </span>

                    <b>
                        ${requisition.details.size()} รายการ
                    </b>
                </div>

            </div>

        </div>

        <div class="summary-total">

            <span>ยอดรวมใบเบิก</span>

            <strong>
                ฿<fmt:formatNumber
                    value="${totalPrice}"
                    pattern="#,##0.00"/>
            </strong>

        </div>

    </section>


    <!-- FARMER AND CYCLE -->

    <section class="information-grid">

        <article class="information-card">

            <div class="card-title">

                <div class="title-icon farmer">
                    <i class="fa-solid fa-user"></i>
                </div>

                <div>
                    <h2>ข้อมูลเกษตรกร</h2>
                    <p>ผู้ยื่นใบเบิกรายการนี้</p>
                </div>

            </div>

            <div class="farmer-profile">

                <div class="farmer-avatar">

                    <c:choose>

                        <c:when test="${not empty farmer.profileImagePath}">

                            <img src="${pageContext.request.contextPath}/uploads/profile/${farmer.profileImagePath}"
                                 alt="รูปโปรไฟล์">

                        </c:when>

                        <c:otherwise>

                            <i class="fa-solid fa-user"></i>

                        </c:otherwise>

                    </c:choose>

                </div>

                <div class="farmer-name">

                    <h3>
                        ${farmer.firstname}
                        ${farmer.lastname}
                    </h3>

                    <span>
                        @${farmer.userName}
                    </span>

                </div>

            </div>

            <div class="info-list">

                <div class="info-row">

                    <div class="info-icon">
                        <i class="fa-solid fa-phone"></i>
                    </div>

                    <div>
                        <span>เบอร์โทรศัพท์</span>
                        <b>${farmer.phoneNumber}</b>
                    </div>

                </div>

                <div class="info-row">

                    <div class="info-icon">
                        <i class="fa-solid fa-location-dot"></i>
                    </div>

                    <div>
                        <span>ที่อยู่</span>
                        <b>${farmer.address}</b>
                    </div>

                </div>

            </div>

        </article>


        <article class="information-card">

            <div class="card-title">

                <div class="title-icon cycle">
                    <i class="fa-solid fa-seedling"></i>
                </div>

                <div>
                    <h2>ข้อมูลรอบเพาะปลูก</h2>
                    <p>รอบที่ใช้ยื่นใบเบิก</p>
                </div>

            </div>

            <div class="cycle-highlight">

                <span>ชื่อรอบเพาะปลูก</span>

                <h3>${cycle.cycleName}</h3>

                <small>
                    รหัสรอบ CC${cycle.cyleId}
                </small>

            </div>

            <div class="cycle-detail-grid">

                <div>

                    <span>
                        <i class="fa-solid fa-leaf"></i>
                        ชนิดหัวพันธุ์
                    </span>

                    <b>${cycle.potatoType}</b>

                </div>

                <div>

                    <span>
                        <i class="fa-solid fa-chart-line"></i>
                        สถานะรอบ
                    </span>

                    <b class="cycle-status">
                        ${cycle.status}
                    </b>

                </div>

                <div>

                    <span>
                        <i class="fa-regular fa-calendar-check"></i>
                        วันเริ่มปลูก
                    </span>

                    <b>${cycle.plantDate}</b>

                </div>

                <div>

                    <span>
                        <i class="fa-solid fa-box"></i>
                        วันเริ่มเก็บเกี่ยว
                    </span>

                    <b>${cycle.harvestDate}</b>

                </div>

            </div>

        </article>

    </section>


    <!-- REQUISITION ITEMS -->

    <section class="items-card">

        <div class="items-header">

            <div class="card-title">

                <div class="title-icon chemical">
                    <i class="fa-solid fa-flask"></i>
                </div>

                <div>
                    <h2>รายการยาและสารเคมี</h2>
                    <p>รายละเอียดรายการที่เกษตรกรขอเบิก</p>
                </div>

            </div>

            <span class="item-count">
                ${requisition.details.size()} รายการ
            </span>

        </div>

        <div class="table-wrapper">

            <table class="items-table">

                <thead>
                    <tr>
                        <th>ลำดับ</th>
                        <th>รายการ</th>
                        <th>ประเภท</th>
                        <th>เหตุผลการเบิก</th>
                        <th>จำนวน</th>
                        <th>ราคาต่อหน่วย</th>
                        <th>รวม</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach items="${requisition.details}"
                               var="detail"
                               varStatus="st">

                        <tr>

                            <td>

                                <span class="row-number">
                                    ${st.count}
                                </span>

                            </td>

                            <td>

                                <div class="item-name">

                                    <div class="item-icon">
                                        <i class="fa-solid fa-vial"></i>
                                    </div>

                                    <div>
                                        <b>${detail.item.itemName}</b>

                                        <span>
                                            หน่วย ${detail.item.unit}
                                        </span>
                                    </div>

                                </div>

                            </td>

                            <td>

                                <span class="type-badge">
                                    ${detail.item.itemType}
                                </span>

                            </td>

                            <td class="cause-cell">
                                ${detail.cause}
                            </td>

                            <td>

                                <b>
                                    ${detail.qty}
                                    ${detail.item.unit}
                                </b>

                            </td>

                            <td>

                                ฿<fmt:formatNumber
                                    value="${detail.unitPrice}"
                                    pattern="#,##0.00"/>

                            </td>

                            <td class="money-cell">

                                ฿<fmt:formatNumber
                                    value="${detail.totalPrice}"
                                    pattern="#,##0.00"/>

                            </td>

                        </tr>

                    </c:forEach>

                </tbody>

                <tfoot>

                    <tr>

                        <td colspan="6">
                            รวมมูลค่าใบเบิกทั้งหมด
                        </td>

                        <td class="grand-total">

                            ฿<fmt:formatNumber
                                value="${totalPrice}"
                                pattern="#,##0.00"/>

                        </td>

                    </tr>

                </tfoot>

            </table>

        </div>

    </section>

</main>


<!-- REVIEW MODAL -->

<c:if test="${requisition.status eq 'SUBMITTED'}">

    <div class="modal fade"
         id="reviewModal"
         tabindex="-1"
         aria-hidden="true">

        <div class="modal-dialog modal-lg modal-dialog-centered">

            <div class="modal-content review-modal">

                <div class="modal-header review-header">

                    <div>

                        <h2>
                            <i class="fa-solid fa-clipboard-check"></i>
                            พิจารณาใบเบิก
                        </h2>

                        <p>
                            REQ${requisition.requisitionId}
                            · ${farmer.firstname}
                            ${farmer.lastname}
                        </p>

                    </div>

                    <button type="button"
                            class="btn-close btn-close-white"
                            data-bs-dismiss="modal">
                    </button>

                </div>

                <form method="post"
                      action="${pageContext.request.contextPath}/broker/requisition/review"
                      id="reviewForm">

                    <input type="hidden"
                           name="requisitionId"
                           value="${requisition.requisitionId}">

                    <div class="modal-body">

                        <div class="modal-summary">

                            <div>
                                <span>เกษตรกร</span>

                                <b>
                                    ${farmer.firstname}
                                    ${farmer.lastname}
                                </b>
                            </div>

                            <div>
                                <span>รอบเพาะปลูก</span>
                                <b>${cycle.cycleName}</b>
                            </div>

                            <div>
                                <span>จำนวนรายการ</span>

                                <b>
                                    ${requisition.details.size()}
                                    รายการ
                                </b>
                            </div>

                            <div>
                                <span>ยอดรวม</span>

                                <b class="modal-total">

                                    ฿<fmt:formatNumber
                                        value="${totalPrice}"
                                        pattern="#,##0.00"/>

                                </b>
                            </div>

                        </div>

                        <label class="decision-title">
                            ผลการพิจารณา
                            <span>*</span>
                        </label>

                        <div class="decision-grid">

                            <label class="decision-card approve">

                                <input type="radio"
                                       name="decision"
                                       value="APPROVED"
                                       required>

                                <div class="decision-icon">
                                    <i class="fa-solid fa-circle-check"></i>
                                </div>

                                <div>
                                    <b>อนุมัติ</b>

                                    <p>
                                        อนุมัติรายการเบิกยาและสารเคมีนี้
                                    </p>
                                </div>

                            </label>

                            <label class="decision-card reject">

                                <input type="radio"
                                       name="decision"
                                       value="REJECTED"
                                       required>

                                <div class="decision-icon">
                                    <i class="fa-solid fa-circle-xmark"></i>
                                </div>

                                <div>
                                    <b>ไม่อนุมัติ</b>

                                    <p>
                                        ปฏิเสธรายการเบิกยาและสารเคมีนี้
                                    </p>
                                </div>

                            </label>

                        </div>

                        <div class="review-warning">

                            <i class="fa-solid fa-circle-info"></i>

                            หลังจากยืนยันแล้วจะไม่สามารถเปลี่ยนผลการพิจารณาได้

                        </div>

                    </div>

                    <div class="modal-footer">

                        <button type="button"
                                class="modal-cancel"
                                data-bs-dismiss="modal">

                            ยกเลิก
                        </button>

                        <button type="submit"
                                class="modal-confirm"
                                id="confirmReviewButton"
                                disabled>

                            <i class="fa-solid fa-check"></i>
                            ยืนยันการพิจารณา
                        </button>

                    </div>

                </form>

            </div>

        </div>

    </div>

</c:if>


<script>
document.addEventListener("DOMContentLoaded", function(){

    const decisionRadios =
        document.querySelectorAll(
            "input[name='decision']"
        );

    const confirmButton =
        document.getElementById(
            "confirmReviewButton"
        );

    if(confirmButton){

        decisionRadios.forEach(function(radio){

            radio.addEventListener("change", function(){

                confirmButton.disabled = false;

                if(this.value === "APPROVED"){

                    confirmButton.classList.remove(
                        "reject-mode"
                    );

                    confirmButton.innerHTML =
                        '<i class="fa-solid fa-check"></i> '
                        + 'ยืนยันการอนุมัติ';

                }else{

                    confirmButton.classList.add(
                        "reject-mode"
                    );

                    confirmButton.innerHTML =
                        '<i class="fa-solid fa-xmark"></i> '
                        + 'ยืนยันการปฏิเสธ';
                }
            });
        });
    }

    const reviewForm =
        document.getElementById("reviewForm");

    if(reviewForm){

        reviewForm.addEventListener(
            "submit",
            function(event){

                const selected =
                    document.querySelector(
                        "input[name='decision']:checked"
                    );

                if(!selected){

                    event.preventDefault();

                    alert(
                        "กรุณาเลือกผลการพิจารณา"
                    );

                    return;
                }

                const message =
                    selected.value === "APPROVED"
                    ? "ยืนยันการอนุมัติใบเบิกนี้หรือไม่?"
                    : "ยืนยันการปฏิเสธใบเบิกนี้หรือไม่?";

                if(!confirm(message)){
                    event.preventDefault();
                }
            }
        );
    }
});
</script>

</body>
</html>