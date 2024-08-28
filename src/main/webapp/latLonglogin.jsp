<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Lat/Long Login</title>
<!-- Main css -->
<link rel="stylesheet" href="css/style.css"> 

<style type="text/css">


*{
	font-family: Verdana;

}
           #preloader{           
            background-image: url('pl1.gif');
            background-repeat: no-repeat;
            background-position: center center;
            background-size: 30%;
            height: 100vh;
            width: 100%;
            position: fixed;
            z-index: 100;
            opacity: 0.8;           
        }
        
        
        #titleOfPage{
        	display: flex;
			justify-content: center;
			color:#990099;
        }
        
        .topnav {
		  overflow: hidden;
		  background-color: #990099;
		 
		 
		}
		
		.topnav a.active {
		  float: left;
		  font-weight:bold;  
		  color: white;
		  text-decoration: none;
		  margin-left:5%;
		  font-size: 20px;
		   padding: 2px 15px;
		  
		}
		 .topnav a:hover {
		  background-color: #1E6446 ;
		  color: white;
		}
		
		.topnav a.active {
		  float: left;
		  font-weight:bold;  
		  color: white;
		  margin-left:5%;
		  
		}
		
		.topnav a.active:hover{
			color: white;
		}
		
		.creatAnAccount{
		 display:incline-box;
		 color:white;
		 background-color: #990099 ;
		 text-decoration: none;
		 padding :5px 10px;
		 border-radius:5px;
		 margin-left:80px;
		 
		
		}
		.creatAnAccount:hover{
		  background-color: #1E6446 ;
		  color: white;
		}
		
		

    </style>



</style>

</head>
<body>




	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="index.jsp">Home</a>
	  </div>
	</div>



<h1 id="titleOfPage">LOGIN FOR LAT/LONG REPORT</h1>

<input type="hidden" id ="status" value="<%=request.getAttribute("status") %>">

	<div class="main">

		<!-- Sing in  Form -->
		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="images/signin-image123.jpg" alt="sing up image">
						</figure>
						<a href="adminPage.jsp" class="creatAnAccount">Create an
							account</a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">Login</h2>
						<form method="post" action="latLongLonginServlet" class="register-form"
							id="login-form">
							<div class="form-group">
								<label for="username"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="username" id="username"
									placeholder="userame" />
							</div>
							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password"
									placeholder="Password" />
							</div>
	
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Login" />
							</div>
						</form>

					</div>
				</div>
			</div>
		</section>

	</div>

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