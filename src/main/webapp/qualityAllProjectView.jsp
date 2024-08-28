<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>
<%
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
    <title>Select project</title>

    <style>
           body {

           font-family: Verdana;
            margin: 0;
            padding: 0;
            height: 100vh; /* Increased height */
        }

         .form{
             padding: 50px;
             height: 3vh;        

         }
        .container {
            max-width: 600px;
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
            background-color: #990099;
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
		
		
		th, td {
			border: 1px solid black;
			text-align: center;
			padding: 8px;
			
		}
		
		th {
			background-color: purple;
			color: white;
			
		}
		
		tr:hover {
			background-color: #f5f5f5;
		}
		
		#main, {
			border-collapse: collapse;
		}
		

		
		#main {
			margin-top: 50px;
		}
		
		table {
	    border-collapse: collapse;	     
	     width: 90%;	
		}

	  

    </style>

</head> 

<body>


	
	
	
	
	
	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">QUALITY REPORT</a>
	  <div id="rightNavBar">
	  <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	  		<%
		
		String depid=(String)session.getAttribute("dept");
	
		if(depid.contains("sm_04")==true){
		
		%>
	   <a href="dataInsert.jsp">Data-Insert</a>
	           <%	
		}
		
		%>
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
     
     
     
     
     
     
      <%
	 Connection con=null;
    
     String prjName=request.getParameter("project");
     ArrayList<String> projectList=new ArrayList<>();
     ArrayList<String> prjDate=new ArrayList<>();
     
     
     
     try {
    		 
        Class.forName("com.mysql.cj.jdbc.Driver");
        //System.out.println(username+" "+password);
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false", username, password);
        //PreparedStatement ps=con.prepareStatement("select * from quality where Project_Name Like ?ORDER BY Inputdate DESC");
       PreparedStatement ps=con.prepareStatement("SELECT DISTINCT Inputdate, Project_Name  FROM quality where Project_Name LIKE ? ORDER BY Inputdate DESC;");
      
        ps.setString(1,prjName);
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
        	String ans1=rs.getString("Inputdate");
        	
        	String pname=rs.getString("Project_Name");
        	String pdate=rs.getString("Inputdate");
        	projectList.add(pname);
        	prjDate.add(pdate);
        	
        }
      //  System.out.println(projectList);
				
	 			rs.close();
	 			ps.close();
	            con.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
     %>
     
     
     
     
      <center>
     <input type="hidden" value="<%=prjName%> name="project">
   <div class="tables">
    <%
					response.setContentType("text/html");
					out.println("<table id='main'>");
					int index=0;
					int srNo=0;
					 					
					out.println("<tr ><th>Sr.No</th><th>Project Name </th><th>Date</th><th>Action</th></tr>");
					
				while(index<projectList.size()){
					srNo++;
					String p1=projectList.get(index);
					String p2=prjDate.get(index);
					String editedDate=p2.substring(8,10)+"-"+p2.substring(5,7)+"-"+p2.substring(0,4);
					
					
				   out.println("<tr><td >" + srNo + "</td><td>" + p1 + "</td><td>" + editedDate + "</td><td><a href='qualityReportView.jsp?inputDate="+p2+"&project="+p1+"'>View</a></td></tr>");
                   index++;
				}
				
                 
%>
      
     </div>
     </div>
    </center>
     
     
     
     
     
     
     
     
     
     
     




</body>

 

</html>