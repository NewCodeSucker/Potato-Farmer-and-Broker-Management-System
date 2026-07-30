<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="th">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Broker Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/css/broker_login.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

</head>
<body>

<div class="container-fluid login-container">

    <div class="row h-100">

        <!-- LEFT -->

        <div class="col-lg-6 left-panel">

            <div class="login-box">

                <h1 class="text-center mb-2">
                    เข้าสู่ระบบ
                </h1>

                <p class="text-center mb-5">
                    ระบบจัดการบริหารโบรกเกอร์และเกษตรกรมันฝรั่ง
                </p>

                <form action="${pageContext.request.contextPath}/broker/doLogin"
                      method="post">

                    <div class="mb-3">

                        <label class="form-label">
                            ชื่อผู้ใช้
                        </label>

                        <input type="text"
                               name="userName"
                               class="form-control"
                               placeholder="กรอกชื่อผู้ใช้"
                               required>

                    </div>

                    <div class="mb-3">

                        <label class="form-label">
                            รหัสผ่าน
                        </label>

                        <div class="input-group">

                            <input type="password"
                                   id="password"
                                   name="password"
                                   class="form-control"
                                   placeholder="กรอกรหัสผ่าน"
                                   required>

                            <button class="btn btn-outline-secondary"
                                    type="button"
                                    onclick="togglePassword()">

                                👁

                            </button>

                        </div>

                    </div>
                    <c:if test="${not empty error}">
					    <div class="alert alert-danger">
					        ${error}
					    </div>
					</c:if>

                    <button type="submit"
                            class="btn btn-login text-white w-100">

                        เข้าสู่ระบบ

                    </button>

                </form>

            

                <hr class="my-4">

                <div class="text-center">

                    <a href="${pageContext.request.contextPath}/farmer/login"
                       class="text-success text-decoration-none">

                        ← เข้าสู่ระบบสำหรับเกษตรกร

                    </a>

                </div>

            </div>

        </div>

        <!-- RIGHT -->

        <div class="col-lg-6 d-none d-lg-flex justify-content-center align-items-center right-panel">

            <div class="right-content">

                <div class="icon-circle mb-4">
                    🤝
                </div>

                <h1 class="fw-bold mb-4">
                    ระบบจัดการบริหาร<br>
                    โบรกเกอร์และเกษตรกรมันฝรั่ง
                </h1>

                <p class="fs-5">
                    เชื่อมโยงโบรกเกอร์และเกษตรกร
                    เพื่อการบริหารจัดการที่มีประสิทธิภาพ
                </p>

                <div class="row mt-5">

                    <div class="col-4 stat">
                        <h2>350+</h2>
                        <p>โบรกเกอร์</p>
                    </div>

                    <div class="col-4 stat">
                        <h2>1,200+</h2>
                        <p>เกษตรกร</p>
                    </div>

                    <div class="col-4 stat">
                        <h2>5,000+</h2>
                        <p>ตัน/ปี</p>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

<script>

function togglePassword(){

    const password =
        document.getElementById("password");

    if(password.type === "password"){
        password.type = "text";
    }
    else{
        password.type = "password";
    }
}

</script>

</body>
</html>