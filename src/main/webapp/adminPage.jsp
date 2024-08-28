<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<meta http-equiv="X-UA-Compatible" content="ie=edge">

<title>login</title>



<!-- Main css -->

<link rel="stylesheet" href="css/style.css">



<style type="text/css">

.container{
height:25vh;
width:35%;
}

.signin-form{
	width:70%;

}



</style>
</head>
<body>

	<div class="main"> 

		<!-- Sing in  Form -->

			<div class="container">
					<div class="signin-form">
						<h2 class="form-title">Admin Login</h2>
						<form class="register-form"
							id="login-form">



							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password"
									placeholder="Password" />

							</div>

							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Log in" onClick="auth(event)" />
							</div>						

						</form>						
						</div>	
				</div>
				
				   </script>

	<!-- JS -->

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>  
<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.min.css'></link>  


   <script>

    function auth(event) {

    event.preventDefault();
    var password=document.getElementById("password").value;

    if(password==="admin$2023"){
    	
    <%session.setAttribute("name", "Admin");%>
    
    window.location.replace("adminAccessPage.jsp")	

    }else{
    	
    	swal('Oops! Wrong password');
    	//swal("Oops!","Wrong password","error");
    	return;

    }
    }
    </script>


</body>



</html>