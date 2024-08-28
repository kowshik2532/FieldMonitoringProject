<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <% 
	if(session.getAttribute("name")==null){
		response.sendRedirect("adminPage.jsp");
	}
%>
<%@page errorPage="error_page.jsp"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Access</title>


<style type="text/css">


		*{
		  font-family: Verdana;
		}

		.container{
		display:flex;
		justify-content:cneter;
		align-item:cneter;
		padding:20px;
		border-radius:5px;
		box-shadow: 2px 2px 8px 2px #C0C0C0;
		
		
		
		}
		
		#link1{
		color:white;
		background-color:purple;
		diplay:incline-box;
		padding:10px 40px;
		text-decoration:none;
		margin:10px;
		border-radius:5px;
		
		}
		
		#link2{
		color:white;
		background-color:purple;
		diplay:incline-box;
		padding:10px 40px;
		text-decoration:none;
		margin:10px ;
		border-radius:5px;
		
		}
		
		
		#link1:hover{
		background-color:#1E6446;
		
		}
		
		#link2:hover{
		background-color:#1E6446;
		}
		
		
		.main-container{
		diplay:incline-box;
		width:43vh;
		margin-left:40%;
		}

		.topnav {
		  overflow: hidden;
		  background-color: #990099;
		   margin-bottom:50px;
		 
		}
		
		.topnav a {
		  float: right;
		  color: #f2f2f2;
		  text-align: center;
		  padding: 10px 16px;
		  text-decoration: none;
		  font-size: 20px;
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
		
		#rightNavBar{
			margin-right:3%;
		}


</style>


</head>

<body>

	<!-- Navigation-->
		<div class="topnav">
		  <a class="active" href="#home">ADMIN PORTAL</a>
		  <div id="rightNavBar">	  
		 <a  id ="user12" href="index.jsp" >Welcome,&nbsp;ADMIN!</a>	 
		 
		 <!-- <a href="index.jsp">Logout</a>-->
		  <a href="modulePage.jsp">Home</a>
		  </div>
		</div>
	
	
	
		<!-- Main Body-->
		<div class="main-container">
			<div class="container">
				<div id =btn>
				     <a id ="link1" href="createUser.jsp">  
				      	Create User
				     </a>
				</div>		
				<div id =btn>
				     <a id="link2" href="userLog.jsp">  
				      	User Log
				     </a>
				</div>
			</div>
		</div>


</body>
</html>