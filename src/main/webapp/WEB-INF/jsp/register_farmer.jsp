<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>สมัครสมาชิกเกษตรกร</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/register_farmer.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>

<body>

<div class="register-page">

    <div class="register-card">

        <div class="header-box">

            <div class="icon-circle">
                <i class="fa-solid fa-seedling"></i>
            </div>

            <h1>สมัครสมาชิกเกษตรกร</h1>

            <p>
                กรุณากรอกข้อมูลให้ครบถ้วนเพื่อเข้าสู่ระบบจัดการมันฝรั่ง
            </p>

        </div>

        <form action="${pageContext.request.contextPath}/doRegister" method="post" enctype="multipart/form-data" class="register-form">

            <div class="form-group">
            	<div class="profile-upload-box">
				    <div class="preview-circle">
				        <img id="profilePreview"
				             src="${pageContext.request.contextPath}/images/default-profile.png">
				    </div>
				
				    <label class="upload-label">
				        รูปโปรไฟล์
				    </label>
				
				    <input type="file"
				           name="profileImage"
				           id="profileImage"
				           class="form-control"
				           accept="image/*"
				           onchange="previewProfileImage(this)">
				    <small>
				        เลือกรูปโปรไฟล์ของคุณ 
				    </small>
				
				</div>
                <label>
                    ชื่อผู้ใช้ <span>*</span>
                </label>

                <input type="text"
                       name="userName"
                       class="form-control"
                       placeholder="เช่น somchai_01"
                       required>

                <small>
                    ใช้สำหรับเข้าสู่ระบบ เช่น somchai01 หรือ farmer_001 ใช้ได้เฉพาะตัวอักษรอังกฤษ ตัวเลข และ _
                </small>
            </div>

            <div class="row">

                <div class="col-md-6 form-group">
                    <label>
                        ชื่อ <span>*</span>
                    </label>

                    <input type="text"
                           name="firstname"
                           class="form-control"
                           placeholder="เช่น สมชาย"
                           required>

                    <small>
                        กรอกชื่อจริงของเกษตรกร
                    </small>
                </div>

                <div class="col-md-6 form-group">
                    <label>
                        นามสกุล <span>*</span>
                    </label>

                    <input type="text"
                           name="lastname"
                           class="form-control"
                           placeholder="เช่น ใจดี"
                           required>

                    <small>
                        กรอกนามสกุลจริงของเกษตรกร
                    </small>
                </div>

            </div>

            <div class="form-group">
                <label>
                    ที่อยู่ <span>*</span>
                </label>

                <textarea name="address"
                          class="form-control address-box"
                          rows="3"
                          placeholder="เช่น 123 หมู่ 5 ต.บ้านเก่า อ.เมือง จ.เชียงราย"
                          required></textarea>

                <small>
                    กรอกที่อยู่ที่สามารถติดต่อได้จริง
                </small>
            </div>

            <div class="form-group">
                <label>
                    เบอร์โทรศัพท์ <span>*</span>
                </label>

                <input type="text"
                       maxlength="10"
                       name="phoneNumber"
                       class="form-control"
                       placeholder="เช่น 0812345678"
                       required>

                <small>
                    กรอกตัวเลข 10 หลัก ไม่ต้องใส่ขีด
                </small>
            </div>

            <div class="row">

                <div class="col-md-6 form-group">
                    <label>
                        รหัสผ่าน <span>*</span>
                    </label>

                    <div class="password-group">
                        <input type="password"
                               id="password"
                               name="password"
                               class="form-control"
                               placeholder="เช่น farmer1234"
                               required>

                        <button type="button"
                                class="show-btn"
                                onclick="togglePassword('password')">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>

                    <small>
                        ใช้สำหรับเข้าสู่ระบบ ควรมีอย่างน้อย 6 ตัวอักษร
                    </small>
                </div>

                <div class="col-md-6 form-group">
                    <label>
                        ยืนยันรหัสผ่าน <span>*</span>
                    </label>

                    <div class="password-group">
                        <input type="password"
                               id="confirmPassword"
                               name="confirmPassword"
                               class="form-control"
                               placeholder="กรอกรหัสผ่านซ้ำอีกครั้ง"
                               required>

                        <button type="button"
                                class="show-btn"
                                onclick="togglePassword('confirmPassword')">
                            <i class="fa-regular fa-eye"></i>
                        </button>
                    </div>

                    <small>
                        ต้องตรงกับรหัสผ่านด้านบน
                    </small>
                </div>

            </div>

            <c:if test="${not empty error}">
                <div class="alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    ${error}
                </div>
            </c:if>

            <button type="submit"
                    class="btn-register">
                สมัครสมาชิก
                <i class="fa-solid fa-arrow-right"></i>
            </button>

        </form>

        <div class="login-link">
            มีบัญชีอยู่แล้ว?
            <a href="${pageContext.request.contextPath}/farmer/login">
                เข้าสู่ระบบ
            </a>
        </div>

    </div>

</div>

<script>
function togglePassword(id){
    const input = document.getElementById(id);

    if(input.type === "password"){
        input.type = "text";
    }else{
        input.type = "password";
    }
}
function previewProfileImage(input){
    const file = input.files[0];

    if(!file){
        return;
    }

    const preview = document.getElementById("profilePreview");
    preview.src = URL.createObjectURL(file);
}
</script>

</body>
</html>