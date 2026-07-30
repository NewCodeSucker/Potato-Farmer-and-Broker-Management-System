<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>เริ่มต้นใช้งานระบบ</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/farmer_onboarding.css">

<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
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
<div class="onboarding-page">

    <div class="onboarding-card">

        <div class="top-icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <h1>
            ยินดีต้อนรับ ${firstname}
        </h1>

        <p class="subtitle">
            เริ่มต้นใช้งานระบบจัดการรอบเพาะปลูกมันฝรั่งสำหรับเกษตรกร
        </p>

        <div class="step-grid">

            <div class="step-card">

                <div class="step-number">
                    1
                </div>

                <i class="fa-solid fa-calendar-days"></i>

                <h3>
                    เลือกรอบเพาะปลูก
                </h3>

                <p>
                    ดูรอบเพาะปลูกที่โบรกเกอร์เปิดรับสมัคร พร้อมรายละเอียดวันปลูก วันเก็บเกี่ยว และราคาซื้อ
                </p>

            </div>

            <div class="step-card">

                <div class="step-number">
                    2
                </div>

                <i class="fa-solid fa-map-location-dot"></i>

                <h3>
                    ลงทะเบียนพื้นที่
                </h3>

                <p>
                    กรอกข้อมูลแปลงเพาะปลูก เช่น เลขโฉนด ที่ตั้งพื้นที่ ขนาดพื้นที่ และแนบรูปเอกสารสิทธิ์
                </p>

            </div>

            <div class="step-card">

                <div class="step-number">
                    3
                </div>

                <i class="fa-solid fa-circle-check"></i>

                <h3>
                    รอการอนุมัติ
                </h3>

                <p>
                    หลังลงทะเบียน โบรกเกอร์จะตรวจสอบข้อมูล เมื่ออนุมัติแล้ว ระบบจะแสดงกำหนดวันปลูกและวันเก็บเกี่ยวของคุณ
                </p>

            </div>

        </div>

        <div class="info-box">

            <i class="fa-solid fa-lightbulb"></i>

            <div>
                <h4>
                    คำแนะนำ
                </h4>

                <p>
                    เตรียมข้อมูลพื้นที่และรูปเอกสารสิทธิ์ให้พร้อมก่อนเริ่มลงทะเบียน เพื่อให้การสมัครรอบเพาะปลูกสมบูรณ์
                </p>
            </div>

        </div>

        <form action="${pageContext.request.contextPath}/farmer/onboarding/complete"
              method="post">

            <button type="submit"
                    class="start-btn">

                เริ่มลงทะเบียนรอบเพาะปลูก

                <i class="fa-solid fa-arrow-right"></i>

            </button>

        </form>

        <a href="${pageContext.request.contextPath}/farmer/home"
           class="skip-link">
            ข้ามไปหน้าแรก
        </a>

    </div>

</div>

</body>
</html>