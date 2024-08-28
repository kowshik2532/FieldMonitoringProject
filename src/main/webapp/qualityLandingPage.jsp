<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>
  
    
    <% 

	if(session.getAttribute("name")==null){
		response.sendRedirect("index.jsp");
	}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Quality Page</title>


<style type="text/css">


		*{
		  font-family: Verdana;
		}
		
		
	

		.container{
		display:flex;
		justify-content:cneter;
		align-item:cneter;
		padding:22px;
		border-radius:5px;
		box-shadow: 2px 2px 8px 2px #C0C0C0;
		
		}
		
		
	
		
		
		
		
        .boxbar {
            width: 100%;
            max-width: 800px;
            text-align: center;
              position: absolute;
			  top: 20%;
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
            margin-left: 10px;
        }

        .dashboard-button:hover {
            background-color: #0056b3;
        }

        .action-button:hover {
            background-color: #171718;
        }
		
		
		#link1{
		color:white;
		background-color:purple;
		diplay:incline-box;
		padding:5px 25px;
		text-decoration:none;
		margin:10px;
		border-radius:5px;
		
		}
		
		#link2{
		color:white;
		background-color:purple;
		diplay:incline-box;
		padding:5px 25px;
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
		width:40vh;
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
	  <a class="active" href="#home">Quality Report</a>
	  <div id="rightNavBar">
	  <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	  <a href="modulePage.jsp">Home</a>
	  </div>
	</div>
	
	
	
	     
      <!-- to fetch user name and password from xml-->
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
	
	
	
	
	     <!-- to track user log -->
     <%    
     try { 	
    	 Connection con=null;	
    	 	String date=(String)session.getAttribute("date");
    	 	String name=(String)session.getAttribute("name");
    	 	String dept=(String)session.getAttribute("dept");
    	 	String logInTime=(String)session.getAttribute("logInTime");
    	 	String webPage="QualityReport";
    	 	
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false", username, password); 
				//data base connection to fetch surveyor id 
				PreparedStatement ps1 =con2.prepareStatement("insert into sm_login_logs(date,name,dept,webPage,logInTime,logOutTime,duration) values (?,?,?,?,?,'-','-')");
				ps1.setString(1,date);
				ps1.setString(2,name);
				ps1.setString(3,dept);
				ps1.setString(4,webPage);
				ps1.setString(5,logInTime);		
				int rs1=ps1.executeUpdate();
				
				if(rs1>0){
					//System.out.println("Succesfully Working");
				}else {
					System.out.println("Not Working");
				}
				
				
	 			ps1.close();				
	            con2.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
     %>
	
	
	
		<!-- Main Body
		<div class="main-container">
			<div class="container">
				<div id =btn>
				     <a id ="link1" href="dataInsert.jsp">  
				      	Data Insert
				     </a>
				</div>		
				<div id =btn>
				     <a id="link2" href="dataView.jsp">  
				      	Data View
				     </a>
				</div>
			</div>
		</div>-->
		
		
		
		
		
		
		

		
    <div class="boxbar">
        
        <div class="buttons">
        
        		
		<%
		
		String depid=(String)session.getAttribute("dept");
	
		if(depid.contains("sm_04")==true){
		
		%>
        
        <a class="dashboard-button"href="dataInsert.jsp">DATA INSERT</a>                      
                      
         <%	
		}
		
		%> 
          <a class="dashboard-button" href="dataView.jsp"/>DATA VIEW </a>             
    
          
        </div>
    </div>


</body>
</html>