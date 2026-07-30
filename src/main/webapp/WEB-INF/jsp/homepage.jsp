<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Potato Management System</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">
</head>

<body>

<nav class="navbar">
    <div class="logo">
        <i class="fa-solid fa-seedling"></i>
        <span>Potato Management</span>
    </div>

    <div class="nav-links">
        <a href="#features">ฟีเจอร์</a>
        <a href="#roles">ผู้ใช้งาน</a>
        <a href="${pageContext.request.contextPath}/farmer/login">เกษตรกรเข้าสู่ระบบ</a>
        <a href="${pageContext.request.contextPath}/broker/login" class="broker-btn">โบรกเกอร์</a>
    </div>
</nav>

<section class="hero">
    <div class="overlay"></div>

    <div class="hero-content">
        <div class="hero-icon">
            <i class="fa-solid fa-seedling"></i>
        </div>

        <h1>ระบบจัดการมันฝรั่ง</h1>

        <p>
            เชื่อมต่อเกษตรกรและโบรกเกอร์ จัดการรอบเพาะปลูก การลงทะเบียนพื้นที่
            และติดตามผลผลิตได้อย่างเป็นระบบ
        </p>

        <div class="hero-actions">
            <a href="${pageContext.request.contextPath}/farmer/login" class="primary-btn">
                เริ่มต้นใช้งาน
                <i class="fa-solid fa-arrow-right"></i>
            </a>

            <a href="${pageContext.request.contextPath}/register" class="secondary-btn">
                สมัครเกษตรกร
            </a>
        </div>
    </div>
</section>

<section class="stats">
    <div class="stat-card">
        <i class="fa-solid fa-users"></i>
        <h3>1,200+</h3>
        <p>เกษตรกรในระบบ</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-calendar-days"></i>
        <h3>120+</h3>
        <p>รอบเพาะปลูก</p>
    </div>

    <div class="stat-card">
        <i class="fa-solid fa-chart-line"></i>
        <h3>8,500+</h3>
        <p>ผลผลิตรวมต่อปี</p>
    </div>
</section>

<section id="features" class="features">
    <div class="section-title">
        <h2>ฟีเจอร์หลักของระบบ</h2>
        <p>เครื่องมือครบสำหรับการจัดการรอบเพาะปลูกมันฝรั่ง</p>
    </div>

    <div class="feature-grid">
        <div class="feature-card">
            <div class="feature-icon green">
                <i class="fa-solid fa-calendar-check"></i>
            </div>
            <h3>จัดการรอบเพาะปลูก</h3>
            <p>สร้างรอบ เปิดรับสมัคร กำหนดวันปลูกและวันเก็บเกี่ยวได้อย่างชัดเจน</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon blue">
                <i class="fa-solid fa-map-location-dot"></i>
            </div>
            <h3>ลงทะเบียนพื้นที่</h3>
            <p>เกษตรกรสามารถลงทะเบียนพื้นที่หลายแปลง พร้อมแนบรูปโฉนดได้</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon purple">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <h3>อนุมัติการลงทะเบียน</h3>
            <p>โบรกเกอร์ตรวจสอบข้อมูลพื้นที่และอนุมัติผู้เข้าร่วมรอบเพาะปลูก</p>
        </div>

        <div class="feature-card">
            <div class="feature-icon orange">
                <i class="fa-solid fa-seedling"></i>
            </div>
            <h3>จัดตารางปลูก/เก็บเกี่ยว</h3>
            <p>ระบบช่วยจัดวันปลูกและวันเก็บเกี่ยวให้เกษตรกรตามเงื่อนไขของรอบ</p>
        </div>
    </div>
</section>

<section id="roles" class="roles">
    <div class="role-card farmer">
        <h2>สำหรับเกษตรกร</h2>
        <p>สมัครรอบเพาะปลูก ลงทะเบียนพื้นที่ ตรวจสอบสถานะ และดูกำหนดการของตนเอง</p>
        <a href="${pageContext.request.contextPath}/farmer/login">
            เข้าสู่ระบบเกษตรกร
        </a>
    </div>

    <div class="role-card broker">
        <h2>สำหรับโบรกเกอร์</h2>
        <p>สร้างรอบ ตรวจสอบเกษตรกร อนุมัติการลงทะเบียน และติดตามจำนวนผู้เข้าร่วม</p>
        <a href="${pageContext.request.contextPath}/broker/login">
            เข้าสู่ระบบโบรกเกอร์
        </a>
    </div>
</section>

<footer>
    <div>
        <h3><i class="fa-solid fa-seedling"></i> Potato Management System</h3>
        <p>ระบบบริหารจัดการการเพาะปลูกมันฝรั่งสำหรับเกษตรกรและโบรกเกอร์</p>
    </div>

    <span>© 2026 Potato Management System</span>
</footer>

</body>
</html>