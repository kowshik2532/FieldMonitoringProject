<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>





<% 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
	response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
	if(session.getAttribute("name")==null){
		response.sendRedirect("index.jsp");
	}
%>

<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>

<html lang="en">

 

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Condition Update</title>

    <style>

           body {

            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh; /* Increased height */
        }

         .form{
             padding: 50px;
             height: 3vh;        

         }

        .container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
            width: 80%; /* Increased width */

        }

 

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
        }

 

        select, button ,input{

            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;

        }
        
        input{
         width: 95%;
        }
        
        
        
          #hiddenButton{
        	width:200px;
        	display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-left: 45%;
		    
        }


        button {

            background-color: purple;
            color: #fff;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;

        }

 

        button:hover {
            background-color: #2680c2;
        }
        
        #hiddenButton{
        	width:200px;
        	display: flex;
		    justify-content: center;
		    align-items: center;
		    
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
		
		#user{
		 font-weight:bold; 
		}

    </style>
    
    


</head>

 

<body>




		<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">SAMPLING REPORT</a>
	  <div id="rightNavBar">
	  <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	  <a href="index.jsp">Home</a>
	  </div>
	</div>


<input type="hidden" id ="status" value="<%=request.getAttribute("status") %>">



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




	   <!-- for fetching project name from server  -->
     <%
        String project ="0";
		ArrayList<String> pjName=new ArrayList<>();
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/new?useSSL=false", username, password);
            
            PreparedStatement ps2 = con2.prepareStatement("select * from conditionTable");
            ResultSet rs2 = ps2.executeQuery();          
            
            while (rs2.next()) {
                 project = rs2.getString("project_name"); 
                 pjName.add(project);
                
            }
            
            con2.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
     %>




    <div class="container">
        <form action="condition" method="post">
            <label for="project">Select a Project:</label>
            <select id="project" name="project">
            
			<%
			    for (int i = 0; i < pjName.size(); i++) {
			%>
			        <option value="<%= pjName.get(i) %>"><%= pjName.get(i) %></option>
			<%
			    }
			%>			
			
           </select>           
           <label>Condition less than </label> <input type="number" name ="a" placeholder=0>
           <label>Condition greater than </label> <input type="number" name ="b"  placeholder=0>
           <br>
           <br>
            <button type="submit">Submit</button>

        </form>

    </div>
    
    
    
  
    
    <!-- JS -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="js/main.js"></script>
	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	
	<script type="text/javascript">
		var status=document.getElementById("status").value;
		if(status== "success"){
			swal("Done","Updated Successfully","success");
			
		}
	
	</script>
	
	
	
	
	<button id="hiddenButton" type="button" style="display: none;" value="<%=request.getAttribute("show") %>"> Log out </button>
	
	<script>
        var hd = document.getElementById("hiddenButton");
        var show=document.getElementById("hiddenButton").value;       
        if(show=="visible"){
            // hiddenButton.style.display = "block";
            hd.style.display="block";

        }

        hd.addEventListener("click",()=>{
            window.location.href = "logout"; 
        });
        
       

    </script>
    
    
  

 


</body>

 

</html>