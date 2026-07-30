<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>โปรไฟล์</title>
	<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/farmer_profile.css">
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@100..900&display=swap" rel="stylesheet">
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
	<div class="profile-container">
		<h2>
		<i class="fa-solid fa-user"></i>		
	    	ข้อมูลส่วนตัว		
		</h2>
	<form action="${pageContext.request.contextPath}/farmer/profile/update"
		method="post"
		enctype="multipart/form-data">
	<div class="profile-top">
	    <div class="avatar-box">
	
	        <c:choose>
	            <c:when test="${not empty farmer.profileImagePath 
	                           && farmer.profileImagePath ne 'default-profile.png'}">
	
	                <img id="profilePreview"
	                     src="${pageContext.request.contextPath}/uploads/profile/${farmer.profileImagePath}"
	                     class="avatar">
	
	            </c:when>
	
	            <c:otherwise>
	
	                <img id="profilePreview"
	                     src="${pageContext.request.contextPath}/images/default-profile.png"
	                     class="avatar">
	
	            </c:otherwise>
	        </c:choose>
	
	    </div>
	
	    <label class="upload-btn">
	        เปลี่ยนรูป
	        <input type="file"
	               name="image"
	               accept="image/*"
	               hidden
	               onchange="previewProfile(this)">
	    </label>
	
	</div>
		
		<div class="row">
		
		<div class="group">
		
		<label>ชื่อผู้ใช้</label>
		
		<input
		type="text"
		value="${farmer.userName}"
		readonly>
		
		</div>
		
		<div class="group">
		
		<label>ชื่อ</label>
		
		<input
		type="text"
		name="firstname"
		value="${farmer.firstname}">
		
		</div>
		
		<div class="group">
		
		<label>นามสกุล</label>
		
		<input
		type="text"
		name="lastname"
		value="${farmer.lastname}">
		
		</div>
		
		<div class="group">
		
		<label>เบอร์โทร</label>
		
		<input
		type="text"
		name="phoneNumber"
		value="${farmer.phoneNumber}">
		
		</div>
		
		<div class="group full">
		
		<label>ที่อยู่</label>
		
		<textarea
		name="address">${farmer.address}</textarea>
		
		</div>
		
		</div>
		
		<div class="button-group">
		
		<button
		type="submit"
		class="save">
		
		<i class="fa-solid fa-floppy-disk"></i>
		
		บันทึกข้อมูล
		
		</button>
		
		<a
		href="${pageContext.request.contextPath}/farmer/home"
		class="cancel">
		
		ยกเลิก
		
		</a>
	
	</div>
	
	</form>
	
	</div>

</body>
<script>
function previewProfile(input){
    const file = input.files[0];

    if(file){
        document.getElementById("profilePreview").src =
            URL.createObjectURL(file);
    }
}
</script>
</html>