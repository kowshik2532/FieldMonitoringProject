<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  

    
<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("index.jsp");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
        response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
        response.setDateHeader("Expires", 0);
		
	}
%>

<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FR_SR Management Portal</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body {
            font-family: Verdana;
            margin: 0;
            padding: 0;       
            align-items: center;
            height: 100vh;
            background: linear-gradient(to bottom, white,#D8BFD8);
        }

        .boxbar {
            width: 100%;
            max-width: 800px;
            text-align: center;
              position: absolute;
			  top: 50%;
			  left: 50%;
			  transform: translate(-50%, -50%);
            
           <%--  background: linear-gradient(to bottom, white, #721a71);--%>
            background-color: rgba(255, 255, 255, 0.8);
            padding: 40px;
            border-radius: 50px;
        }

        .dashboard-button {
            background-color: #990099;
      
            color: #fff;
            border: none;
            padding: 28px 28px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 20px;
            cursor: pointer;
            border-radius: 7px;
            transition: background-color 0.3s ease-in-out;
            width: 100%;
            max-width: 300px;
            margin-top: 20px;
        }

        .dashboard-button:hover {
            background-color: #0056b3;
        }

        .action-button:hover {
            background-color: #171718;
        }
        
                
		.topnav {
		  overflow: hidden;
		  background-color: #990099;
		 
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
	  <a class="active" href="#home">FR SR MANAGEMENT PORTAL</a>
	  <div id="rightNavBar">
	  <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>	  
	  </div>
	</div>


    <div class="boxbar">

 	
        <h1>FR SR MANAGEMENT PORTAL</h1>
        
    <!--    <div class="current-time">
            <p id="date"></p>
            <h2 id="time"></h2>
        </div>-->
        
        <div class="buttons">
            <button class="dashboard-button" onclick="goToPage('projectSelect.jsp')">Hourly Report</button>
            <br>            
            <button class="dashboard-button" onclick="goToPage('samplingSelectProject.jsp')">Sampling</button>
            <br> 
            <button class="dashboard-button" onclick="goToPage('casteProjectSelect.jsp')">Caste Sampling</button>
            <br>                       
            <button class="dashboard-button" onclick="goToPage('latLongProjectSelect.jsp')">Lat/Long</button>
            <br> 
            <button class="dashboard-button" onclick="goToPage('qualityLandingPage.jsp')">Quality Report</button>
            <br>
            
            <button class="dashboard-button" onclick="goToPage('adminPage.jsp')">Admin Portal</button>
            <br>
    
            

            

             <!--<button class="dashboard-button" onclick="goToPage('login.jsp')">Quality</button>-->       
          
        </div>
    </div>
    <script>
    
        function goToPage(pageName) {
            window.location.href = pageName;
        }

        function updateDateTime() {
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const dateString = now.toLocaleDateString('en-US', options);
            const timeString = now.toLocaleTimeString('en-US');
            document.getElementById("date").textContent = dateString;
            document.getElementById("time").textContent = timeString;
        }

        // Update the date and time every second
        setInterval(updateDateTime, 1000);

        // Initial update
        updateDateTime();
    </script>
</body>
</html>
   