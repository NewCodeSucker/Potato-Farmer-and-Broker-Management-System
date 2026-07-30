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

            <a href="${pageContext.request.contextPath}/farmer/requisitions"
               class="back-button">

                <i class="fa-solid fa-arrow-left"></i>
            </a>

            <div class="page-icon">
                <i class="fa-solid fa-file-lines"></i>
            </div>

            <div>
                <h1>รายละเอียดใบเบิก</h1>
                <p>REQ${requisition.requisitionId}</p>
            </div>

        </div>

        <c:choose>

            <c:when test="${requisition.status eq 'DRAFT'}">
                <span class="status draft">แบบร่าง</span>
            </c:when>

            <c:when test="${requisition.status eq 'SUBMITTED'}">
                <span class="status submitted">ส่งแล้ว</span>
            </c:when>

            <c:when test="${requisition.status eq 'APPROVED'}">
                <span class="status approved">อนุมัติแล้ว</span>
            </c:when>

            <c:otherwise>
                <span class="status rejected">ไม่อนุมัติ</span>
            </c:otherwise>

        </c:choose>

    </header>

    <c:if test="${not empty success}">
        <div class="alert success-alert">
            <i class="fa-solid fa-circle-check"></i>
            ${success}
        </div>
    </c:if>

    <section class="detail-summary">

        <div class="summary-item">
            <span>เลขที่ใบเบิก</span>
            <b>REQ${requisition.requisitionId}</b>
        </div>

        <div class="summary-item">
            <span>รอบเพาะปลูก</span>
            <b>${requisition.cycle.cycle.cycleName}</b>
        </div>

        <div class="summary-item">
            <span>วันที่บันทึก/ส่ง</span>
            <b>${requisition.submitDate}</b>
        </div>

        <div class="summary-item">
            <span>จำนวนรายการ</span>
            <b>${requisition.details.size()} รายการ</b>
        </div>

    </section>

    <section class="detail-card">

        <div class="section-title">

            <i class="fa-solid fa-flask"></i>

            <div>
                <h2>รายการยาและสารเคมี</h2>
                <p>รายละเอียดรายการที่ขอเบิก</p>
            </div>

        </div>

        <div class="table-wrapper">

            <table class="detail-table">

                <thead>
                    <tr>
                        <th>ลำดับ</th>
                        <th>รายการ</th>
                        <th>เหตุผลการเบิก</th>
                        <th>จำนวน</th>
                        <th>หน่วย</th>
                        <th>ราคาต่อหน่วย</th>
                        <th>รวม</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach items="${requisition.details}"
                               var="detail"
                               varStatus="st">

                        <tr>
                            <td>${st.count}</td>

                            <td>
                                ${detail.item.itemName}
                            </td>

                            <td>
                                ${detail.cause}
                            </td>

                            <td>
                                ${detail.qty}
                            </td>

                            <td>
                                ${detail.item.unit}
                            </td>

                            <td>
                                ฿<fmt:formatNumber
                                    value="${detail.unitPrice}"
                                    pattern="#,##0.00"/>
                            </td>

                            <td class="total-cell">
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
                            รวมทั้งหมด
                        </td>

                        <td class="total-cell">
                            ฿<fmt:formatNumber
                                value="${totalPrice}"
                                pattern="#,##0.00"/>
                        </td>
                    </tr>
                </tfoot>

            </table>

        </div>

    </section>

    <section class="detail-actions">

        <a href="${pageContext.request.contextPath}/farmer/requisitions"
           class="cancel-button">
            กลับหน้ารายการ
        </a>

        <c:if test="${requisition.status eq 'DRAFT'}">

            <a href="${pageContext.request.contextPath}/farmer/requisition/edit/${requisition.requisitionId}"
               class="edit-main-button">

                <i class="fa-solid fa-pen"></i>
                แก้ไข
            </a>

            <form method="post"
                  action="${pageContext.request.contextPath}/farmer/requisition/delete/${requisition.requisitionId}"
                  onsubmit="return confirm('ยืนยันการลบแบบร่างใบเบิกนี้หรือไม่?');">

                <button type="submit"
                        class="delete-main-button">

                    <i class="fa-solid fa-trash"></i>
                    ลบ
                </button>

            </form>

            <form method="post"
                  action="${pageContext.request.contextPath}/farmer/requisition/submit/${requisition.requisitionId}"
                  onsubmit="return confirm('ยืนยันส่งใบเบิกให้โบรกเกอร์หรือไม่? หลังส่งแล้วจะไม่สามารถแก้ไขหรือลบได้');">

                <button type="submit"
                        class="submit-button">

                    <i class="fa-solid fa-paper-plane"></i>
                    ยืนยันส่งโบรกเกอร์
                </button>

            </form>

        </c:if>

    </section>

</main>

</body>
</html>