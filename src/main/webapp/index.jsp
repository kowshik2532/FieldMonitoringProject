<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <% 
 response.setHeader("Cache-Control","no-cache");
 response.setHeader("Cache-Control","no-store");
 response.setHeader("Pragma","no-cache");
 response.setDateHeader ("Expires", 0);
%>

<%@page errorPage="error_page.jsp"%>  
    
<!doctype html>
<html lang="en">
<!-- codingflicks.com -->
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="css/stylee.css">

</head>
<body>

  <input type="hidden" id ="status" value="<%=request.getAttribute("status") %>">
  <div id="imagePro">
        <img src="AxisLogo.jpg" alt="AxisMyIndia_logo">
  </div>
  <form action="login" method="post">
    <div class="box">
        <h2>Login Form</h2>
        <p>Username: </p>
        <input type="text" name="username" placeholder=" Username">
        <p>Password: </p>
        <input type="password"  name="password" placeholder=" Password">      
        <input type="submit" class="btn"   value="Login"  style='border: none;'}/>
        <a href="adminPage.jsp" class="for-pass">Create an account</a>

    </div>
   </form>
   
   
   
   
   	<!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	
	
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var status=document.getElementById("status").value;
		if(status== "failed"){
			swal("Sorry!!","Wrong username or password","error");
		}
	
	</script>
   
   
   
   
   
</body>
</html>