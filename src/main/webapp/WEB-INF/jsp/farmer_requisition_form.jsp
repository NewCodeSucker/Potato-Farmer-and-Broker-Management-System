<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>
    <c:choose>
        <c:when test="${editMode}">
            แก้ไขแบบร่างใบเบิก
        </c:when>
        <c:otherwise>
            เพิ่มใบเบิก
        </c:otherwise>
    </c:choose>
</title>

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
            <a href="${pageContext.request.contextPath}/farmer/requisitions" class="back-button">
                <i class="fa-solid fa-arrow-left"></i>
            </a>
            <div class="page-icon">
                <i class="fa-solid fa-file-circle-plus"></i>
            </div>
            <div>
                <c:choose>
                    <c:when test="${editMode}">
                        <h1>แก้ไขแบบร่างใบเบิก</h1>
                        <p>แก้ไขรายการยาและสารเคมีก่อนส่งให้โบรกเกอร์</p>
                    </c:when>
                    <c:otherwise>
                        <h1>เพิ่มใบเบิก</h1>
                        <p>สร้างแบบร่างใบเบิกยาและสารเคมี</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <c:if test="${not empty error}">
        <div class="alert error-alert">
            <i class="fa-solid fa-circle-exclamation"></i>
            ${error}
        </div>
    </c:if>

    <form method="post"
          id="requisitionForm"
          <c:choose>
              <c:when test="${editMode}">
                  action="${pageContext.request.contextPath}/farmer/requisition/update-draft"
              </c:when>
              <c:otherwise>
                  action="${pageContext.request.contextPath}/farmer/requisition/save-draft"
              </c:otherwise>
          </c:choose>>

        <c:if test="${editMode}">
            <input type="hidden" name="requisitionId" value="${requisitionForm.requisitionId}">
        </c:if>

        <section class="form-card">
            <div class="section-title">
                <i class="fa-solid fa-seedling"></i>
                <div>
                    <h2>รอบเพาะปลูก</h2>
                    <p>เลือกได้เฉพาะรอบที่ได้รับอนุมัติ และกำลังดำเนินการอยู่</p>
                </div>
            </div>

            <div class="form-field">
                <label for="registerId">
                    รอบเพาะปลูก <span>*</span>
                </label>

                <!-- ปิด Select เมื่อไม่มีรอบเพาะปลูก -->
                <select id="registerId" name="registerId" required <c:if test="${empty approvedCycles}">disabled</c:if>>
                    <option value="">เลือกรอบที่กำลังดำเนินการ</option>
                    <c:forEach items="${approvedCycles}" var="reg">
                        <option value="${reg.registerId}"
                            <c:if test="${requisitionForm.registerId eq reg.registerId}">selected</c:if>>
                            ${reg.cycle.cycleName}
                        </option>
                    </c:forEach>
                </select>

                <!-- แสดงข้อความเตือนเฉพาะเมื่อไม่มีรอบเพาะปลูก (ย้ายไว้นอก select) -->
                <c:if test="${empty approvedCycles}">
                    <div class="no-cycle-message">
                        <i class="fa-solid fa-circle-info"></i>
                        ขณะนี้ไม่มีรอบที่ได้รับอนุมัติและกำลังดำเนินการ จึงยังไม่สามารถสร้างใบเบิกได้
                    </div>
                </c:if>
            </div>
        </section>

        <section class="form-card">
            <div class="section-heading-row">
                <div class="section-title">
                    <i class="fa-solid fa-flask"></i>
                    <div>
                        <h2>รายการยาและสารเคมี</h2>
                        <p>เพิ่มได้มากกว่า 1 รายการ</p>
                    </div>
                </div>

                <button type="button" class="add-row-button" onclick="addDetailRow()">
                    <i class="fa-solid fa-plus"></i>
                    เพิ่มรายการ
                </button>
            </div>

            <div id="detailContainer">
                <c:forEach items="${requisitionForm.details}" var="row" varStatus="st">
                    <div class="detail-row">
                        <div class="row-number">
                            ${st.count}
                        </div>

                        <div class="detail-grid">
                            <div class="form-field">
                                <label>ยา/สารเคมี <span>*</span></label>
                                <select name="details[${st.index}].itemId"
                                        class="item-select"
                                        onchange="updateItemInfo(this)"
                                        required>
                                    <option value="">เลือกรายการ</option>
                                    <c:forEach items="${chemicalItems}" var="item">
                                        <option value="${item.itemId}"
                                                data-unit="${item.unit}"
                                                data-price="${item.unitPrice}"
                                            <c:if test="${row.itemId eq item.itemId}">selected</c:if>>
                                            ${item.itemName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-field">
                                <label>จำนวน <span>*</span></label>
                                <input type="number"
                                       name="details[${st.index}].qty"
                                       value="${row.qty}"
                                       min="1"
                                       required>
                            </div>

                            <div class="form-field item-summary">
                                <label>ข้อมูลสินค้า</label>
                                <div class="item-summary-box">
                                    <span class="item-unit">-</span>
                                    <span class="item-price">฿0.00</span>
                                </div>
                            </div>

                            <div class="form-field cause-field">
                                <label>เหตุผลการเบิก <span>*</span></label>
                                <textarea name="details[${st.index}].cause" rows="2" required>${row.cause}</textarea>
                            </div>
                        </div>

                        <button type="button" class="remove-row-button" onclick="removeDetailRow(this)">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="form-actions">
            <a href="${pageContext.request.contextPath}/farmer/requisitions" class="cancel-button">
                ยกเลิก
            </a>

            <!-- ปุ่มเปิดใช้งานปกติหากมีรอบการเพาะปลูก (approvedCycles ไม่ empty) -->
            <button type="submit"
                    class="save-button"
                    <c:if test="${empty approvedCycles}">disabled</c:if>>
                <i class="fa-solid fa-floppy-disk"></i>
                บันทึกแบบร่าง
            </button>
        </section>
    </form>
</main>

<script>

let rowIndex = document.querySelectorAll(".detail-row").length;

function createItemOptions(){
    return `<option value="">เลือกรายการ</option>` +
        `<c:forEach items="${chemicalItems}" var="item">` +
            `<option value="${item.itemId}" data-unit="${item.unit}" data-price="${item.unitPrice}">${item.itemName}</option>` +
        `</c:forEach>`;
}

function addDetailRow(){

    const container = document.getElementById("detailContainer");
    const row = document.createElement("div");

    row.className = "detail-row";

    row.innerHTML = `
        <div class="row-number">
            \${rowIndex + 1}
        </div>

        <div class="detail-grid">

            <div class="form-field">

                <label>
                    ยา/สารเคมี
                    <span>*</span>
                </label>

                <select name="details[\${rowIndex}].itemId"
                        class="item-select"
                        onchange="updateItemInfo(this)"
                        required>

                    \${createItemOptions()}
                </select>

            </div>

            <div class="form-field">

                <label>
                    จำนวน
                    <span>*</span>
                </label>

                <input type="number"
                       name="details[\${rowIndex}].qty"
                       min="1"
                       required>

            </div>

            <div class="form-field item-summary">

                <label>ข้อมูลสินค้า</label>

                <div class="item-summary-box">
                    <span class="item-unit">-</span>
                    <span class="item-price">฿0.00</span>
                </div>

            </div>

            <div class="form-field cause-field">

                <label>
                    เหตุผลการเบิก
                    <span>*</span>
                </label>

                <textarea
                    name="details[\${rowIndex}].cause"
                    rows="2"
                    required></textarea>

            </div>

        </div>

        <button type="button"
                class="remove-row-button"
                onclick="removeDetailRow(this)">

            <i class="fa-solid fa-trash"></i>
        </button>
    `;

    container.appendChild(row);

    rowIndex++;
    renumberRows();
}

function removeDetailRow(button){

    const rows = document.querySelectorAll(".detail-row");

    if(rows.length <= 1){
        alert("ใบเบิกต้องมีอย่างน้อย 1 รายการ");
        return;
    }

    button.closest(".detail-row").remove();

    renumberRows();
}

function renumberRows(){

    const rows = document.querySelectorAll(".detail-row");

    rows.forEach(function(row, index){

        row.querySelector(".row-number").innerText = index + 1;
        row.querySelector(".item-select").name = `details[\${index}].itemId`;
        row.querySelector("input[type='number']").name = `details[\${index}].qty`;
        row.querySelector("textarea").name = `details[\${index}].cause`;
    });

    rowIndex = rows.length;
}

function updateItemInfo(select){

    const selected = select.options[select.selectedIndex];
    const row = select.closest(".detail-row");

    const unit = selected.dataset.unit || "-";
    const price = selected.dataset.price || "0.00";

    row.querySelector(".item-unit").innerText = "หน่วย: " + unit;
    row.querySelector(".item-price").innerText = "ราคา: ฿" + Number(price).toFixed(2);
}

document.addEventListener("DOMContentLoaded", function(){

    if(document.querySelectorAll(".detail-row").length === 0){
        addDetailRow();
    }

    document.querySelectorAll(".item-select").forEach(function(select){
        updateItemInfo(select);
    });
});

</script>

</body>
</html>