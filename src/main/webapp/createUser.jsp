<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>

<% 
	if(session.getAttribute("name")==null){
		response.sendRedirect("adminPage.jsp");
	}
%>
<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up Form </title>


<!-- Main css -->
<link rel="stylesheet" href="css/style.css">

<style type="text/css">

		*{
		  font-family: Verdana;
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
		img {
		margin-top:80px;
		  max-width: 210%; /* Adjust this value to control the image size */
		  height: auto; /* Maintain aspect ratio */
		}
</style>



</head>
<body>


<style>
select.form-control {
  height: 30px; /* adjust this value as you like */
  width: 300px; /* adjust this value as you like */
}
</style>




	<!-- Navigation-->
		<div class="topnav">
		  <a class="active" href="#home">ADMIN PORTAL</a>
		  <div id="rightNavBar">	  
		 <a  id ="user12" href="index.jsp" >Welcome,&nbsp;ADMIN!</a>	 
		 
		 <!-- <a href="index.jsp">Logout</a>-->
		  <a href="modulePage.jsp">Home</a>
		  </div>
		</div>
		
		
		
		
		
		
		
		
		
					<%
		String fileName = "/config/config.xml";
		InputStream ins = application.getResourceAsStream(fileName);
		 String username="";
		 String password="";
		try {
		    if (ins == null) {
		        response.setStatus(response.SC_NOT_FOUND);
		    } else {
		        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		        DocumentBuilder builder = factory.newDocumentBuilder();
		        Document document = builder.parse(ins);
		
		        NodeList itemList = document.getElementsByTagName("userDetail");
		        for (int i = 0; i < itemList.getLength(); i++) {
		            Element item = (Element) itemList.item(i);
		            Element nameElement = (Element) item.getElementsByTagName("name").item(0);
		            Element passElement = (Element) item.getElementsByTagName("pass").item(0);	
		            username = nameElement.getTextContent();
		            password=passElement.getTextContent();
		          
		            
		        }	        
		    
		        
		    }
		} catch (Exception e) {
		    e.printStackTrace();
		}
		%>






	<div class="main">

		<!-- Sign up form -->
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Create User</h2>
					
						<form method="post" action="register" class="register-form"
							id="register-form" >
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="emp_name" id="employee-name" placeholder="Employee Name" required />
							</div>
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="email" name="email" id="email" placeholder="Email id"  required />
							</div>
							<div class="form-group">
								<label for="name"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="username" id="name" placeholder="Username(eg. da_01,....)" required />
							</div>
						
							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="pass" id="password" placeholder="Password" minlength="2" required />
							</div>

        
				<div class="dropdown">
				        <label for="type"></label>        
				
				            <select class="form-control" name="user_type" required>
				            <option value=""> Select Department</option>
				
				               <%
				                try{
				                	Class.forName("com.mysql.cj.jdbc.Driver");
				                	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false",username,password);
				                	String Query="select * from sm_dept";
				                	Statement st=con.createStatement();
				                	ResultSet rs=st.executeQuery(Query);
				                	while(rs.next()){
				                		%>
				                		<option value="<%=rs.getString("dept_id")%>"><%=rs.getString("dept_name")%></option>
				                		<%            		
				                	}
				 	
				                }catch(Exception e){
				                	e.printStackTrace();
				                	out.println("error "+e.getMessage());
				                }			               
				               %>
				            </select>     
				  </div>

			<div class="form-group form-button">
				<input type="submit" name="signup" id="signup"
				class="form-submit" value="Register" />
			</div> 
	</form>
	
	
		</div>
			<div class="signup-image">
						<figure>
							<img src="AxisLogo.jpg" alt="AxisMyIndia_logo">
						</figure>
			
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
	var status= document.getElementById("status").value;
	if(status=="success"){
		swal("congrats!","User Created Successfully","success");
	}
	
	
	</script>


</body>

</html>