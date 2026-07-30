<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>แก้ไขรอบการเพาะปลูก</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/broker_edit_cycle.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <a href="${pageContext.request.contextPath}/broker/cycle/detail/${cycle.cyleId}" class="back">←</a>

        <div class="icon">🌱</div>

        <div>
            <h2>แก้ไขรอบการเพาะปลูก</h2>
            <p>แก้ไขข้อมูลรอบการเพาะปลูก CC${cycle.cyleId}</p>
        </div>
    </div>

    <form:form action="${pageContext.request.contextPath}/broker/cycle/update"
               method="post"
               modelAttribute="cycle">

        <form:hidden path="cyleId"/>

        <div class="card-box">

            <h4>ⓘ สถานะรอบการเพาะปลูก</h4>

            <div class="status-grid">

                <label class="status-option">
                    <form:radiobutton path="status" value="OPEN"/>
                    <span>✓</span>
                    <b>เปิดรับลงทะเบียน</b>
                </label>

                <label class="status-option">
                    <form:radiobutton path="status" value="PROGRESS"/>
                    <span>◷</span>
                    <b>กำลังดำเนินการ</b>
                </label>

                <label class="status-option">
                    <form:radiobutton path="status" value="CLOSE"/>
                    <span>✓</span>
                    <b>เสร็จสิ้น</b>
                </label>

                <label class="status-option">
                    <form:radiobutton path="status" value="CANCEL"/>
                    <span>×</span>
                    <b>ยกเลิก</b>
                </label>

            </div>

        </div>

        <div class="card-box">

            <h4>🌱 ข้อมูลพื้นฐาน</h4>

            <div class="form-grid">

                <div>
                    <label>รหัสรอบ</label>
                    <input type="text"
                           class="form-control"
                           value="CC${cycle.cyleId}"
                           readonly>
                </div>

                <div>
                    <label>ชื่อรอบการเพาะปลูก *</label>
                    <form:input path="cycleName" cssClass="form-control"/>
                </div>

                <div>
                    <label>ชนิดหัวพันธุ์มันฝรั่ง *</label>
                    <form:select path="potatoType" cssClass="form-control">
                        <form:option value="แอตแลนติก">แอตแลนติก</form:option>
                        <form:option value="สปันต้า">สปันต้า</form:option>
                        <form:option value="แกรนโอลา">แกรนโอลา</form:option>
                    </form:select>
                </div>

                <div>
                    <label>จำนวนเกษตรกรที่รับ *</label>
                    <form:input path="maxpeople" type="number" cssClass="form-control"/>
                </div>

                <div>
                    <label>ราคาขายต่อหน่วย บาท/กก.</label>
                    <form:input path="purchasePrice" type="number" step="0.01" cssClass="form-control"/>
                </div>

            </div>

        </div>

        <div class="card-box">

            <h4>📅 กำหนดเวลา</h4>

            <div class="form-grid">

                 <div>
                    <label>วันเปิดรับลงทะเบียน *</label>
                    <input type="date" name="openRegDate"value="${cycle.openRegDate}"class="form-control" required>
                </div>

                <div>
                    <label>วันปิดรับลงทะเบียน *</label>
                    <input type="date" name="endRegDate"value="${cycle.endRegDate}"class="form-control" required>
                </div>

                <div>
                    <label>วันเริ่มปลูก *</label>
                   <input type="date" name="plantDate"value="${cycle.plantDate}"class="form-control" required>	
                </div>

                <div>
                    <label>วันเริ่มเก็บเกี่ยว *</label>
                     <input type="date" name="harvestDate"value="${cycle.harvestDate}"class="form-control" required>	
                </div>
                </div>

                <div>
                    <label>วันสิ้นสุดเก็บเกี่ยว *</label>
                    <form:input path="endHarvestDate" type="date" cssClass="form-control"/>
                </div>

            </div>

     

        <div class="button-box">

		    <a href="${pageContext.request.contextPath}/broker/cycle/detail/${cycle.cyleId}"
		       class="btn-cancel">
		        × ยกเลิก
		    </a>
		
		    <button type="submit" class="btn-save">
		        💾 บันทึกการแก้ไข
		    </button>
		
		</div>

    </form:form>

</div>

</body>
</html>