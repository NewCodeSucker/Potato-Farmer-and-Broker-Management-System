<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>เพิ่มรอบการเพาะปลูก</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<link rel="stylesheet"href="${pageContext.request.contextPath}/css/broker_add_cycle.css">
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


<div class="page-header">

    <a href="${pageContext.request.contextPath}/broker/cycles"
       class="back-btn">
       ←
    </a>

    <div>
        <h1>เพิ่มรอบการเพาะปลูก</h1>
        <p>สร้างรอบการเพาะปลูกใหม่สำหรับเกษตรกร</p>
    </div>

</div>

<div class="form-container">

<form:form action="${pageContext.request.contextPath}/broker/cycle/save"
           method="post"
           modelAttribute="cycle">

    <div class="card">

        <h2>ข้อมูลพื้นฐาน</h2>

        <div class="form-group">
            <label>ชื่อรอบการเพาะปลูก *</label>

            <form:input path="cycleName"
                        cssClass="form-control"
                        placeholder="เช่น รอบการเพาะปลูก ปี 2568/1"/>
        </div>

        <div class="row">

            <div class="form-group">
                <label>ชนิดหัวพันธุ์มันฝรั่ง *</label>

                <form:select path="potatoType"
                             cssClass="form-control">

                    <form:option value="แอตแลนติก">
                        แอตแลนติก
                    </form:option>

                    <form:option value="สปันต้า">
                        สปันต้า
                    </form:option>

                    <form:option value="แกรนโอลา">
                        แกรนโอลา
                    </form:option>

                </form:select>
            </div>

            <div class="form-group">
                <label>จำนวนเกษตรกรที่รับ *</label>

                <form:input path="maxpeople"
                            type="number"
                            cssClass="form-control"/>
            </div>

        </div>

        <div class="form-group">
            <label>ราคาขายผลผลิตต่อกิโลกรัม *</label>

            <form:input path="purchasePrice"
                        type="number"
                        step="0.01"
                        cssClass="form-control"/>
        </div>

    </div>

    <div class="card">

        <h2>กำหนดเวลา</h2>

        <div class="row">

            <div class="form-group">
                <label>วันเปิดลงทะเบียน *</label>

                <input type="date"
                       id="openRegDate"
                       name="openRegDate"
                       class="form-control"
                       required>
            </div>

            <div class="form-group">
                <label>วันปิดลงทะเบียน *</label>

                <input type="date"
                       id="endRegDate"
                       name="endRegDate"
                       class="form-control"
                       required>
            </div>

        </div>

        <div class="row">

            <div class="form-group">
                <label>วันเริ่มปลูก *</label>

                <input type="date"
                       id="plantDate"
                       name="plantDate"
                       class="form-control"
                       required>
            </div>

            <div class="form-group">
                <label>วันเริ่มเก็บเกี่ยว *</label>

                <input type="date"
                       id="harvestDate"
                       name="harvestDate"
                       class="form-control"
                       required>
            </div>

        </div>

    </div>

    <button class="btn-save">
        บันทึกรอบการเพาะปลูก
    </button>

</form:form>

</div>

<script>

const openReg =
document.getElementById("openRegDate");

const endReg =
document.getElementById("endRegDate");

const plantDate =
document.getElementById("plantDate");

const harvestDate =
document.getElementById("harvestDate");


openReg.addEventListener("change", function(){

    let date = new Date(this.value);

    date.setDate(date.getDate() + 15);

    let yyyy = date.getFullYear();
    let mm = String(date.getMonth()+1).padStart(2,'0');
    let dd = String(date.getDate()).padStart(2,'0');

    endReg.value =
        yyyy + "-" + mm + "-" + dd;

    endReg.min =
        yyyy + "-" + mm + "-" + dd;
});


plantDate.addEventListener("change", function(){

    let date = new Date(this.value);

    date.setDate(date.getDate() + 100);

    let yyyy = date.getFullYear();
    let mm = String(date.getMonth()+1).padStart(2,'0');
    let dd = String(date.getDate()).padStart(2,'0');

    harvestDate.value =
        yyyy + "-" + mm + "-" + dd;

    harvestDate.min =
        yyyy + "-" + mm + "-" + dd;
});

</script>

</body>
</html>