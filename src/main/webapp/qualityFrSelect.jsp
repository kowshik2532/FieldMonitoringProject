<%@page import="com.mysql.cj.protocol.x.SyncFlushDeflaterOutputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import ="java.util.stream.Collectors" %>
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

    <title>SelectFrName</title>

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
            max-width: 500px;
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
            margin-bottom: 4px;
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
         .header {
		   
		    background-color: #eee1ff;
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-left: 27%;
		    color: #990099;
		    padding: 10px;
		    padding-bottom:5px;
		    width : 90vh;
		    border-radius:10px;
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

<input type="hidden" id ="status" value="<%=request.getAttribute("dataAdded") %>">
	
	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">Quality Report</a>
	  <div id="rightNavBar">
	   <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	    <a href="dataView.jsp">Data-View</a>
	  <a href="modulePage.jsp">Home</a>
	  </div>
	</div>






	<% 
		String prjName=request.getParameter("project");	
	
	%>
	
	<br>

	  
	   
	<!-- for fetching FR name from server  -->	   
     <%
		Connection con=null;		
		String mValue="not selected"; 
		String str="not selected";
	     ArrayList<String> FRname=new ArrayList<>();
	     List<String> arr=new ArrayList<>();
	     int temp=0;
	     String CHECKPOINT_ID="";
     
     
     try {
     	Class.forName("com.mysql.cj.jdbc.Driver");
			 con=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");			 
				//System.out.println("succesfully connected");			 
				//data base connection to fetch surveyor id 
				PreparedStatement ps1 =con.prepareStatement("SELECT * FROM CHECKLIST_MASTER WHERE `CAT_ID` LIKE (SELECT MIN(CAT_ID) FROM `CHECKLIST_MASTER` WHERE `CHECKLIST_NAME` LIKE ?)");                                  
				ps1.setString(1, prjName);	
				ResultSet rs1=ps1.executeQuery();	
				while(rs1.next()) {
					CHECKPOINT_ID=rs1.getString("CHECKPOINT_ID");			
				}
				String str1[]=CHECKPOINT_ID.split(",");				
				int s1=Integer.parseInt(str1[0]);				
				temp=Integer.parseInt(str1[0]);
				request.setAttribute("min_value", temp);
				
				
				PreparedStatement ps2 =con.prepareStatement("SELECT VALUE FROM `CHECKPOINT` WHERE `CHECKPOINT_ID` = "+temp+" ORDER BY `CPID` DESC");
				ResultSet rs2=ps2.executeQuery();
				
				while(rs2.next()) {
					str=rs2.getString("VALUE");		
				}
					
		       arr=Arrays.stream(str.split(","))
		              .map(String::trim).collect(Collectors.toList());		        
		        
		       rs2.close();
		       ps2.close();        
	           con.close();
	    
	        	
		} catch (Exception e) {
			e.printStackTrace();
		}
    %>

	
	
	<!--to show name of project -->	
	  <div class="header">
   		 <label for="Project"><%=prjName%></label>
  	 </div>
  	 

    
    
    
    <!--to show FR name list -->    
   <div class="container">
	
        <form action="dataInsertFrWise.jsp" method="post">
            <label for="frName">Select a FR Name:</label>
            <select id="frName" name="frName">
            
			<%
			    for (String str1:arr) {
			%>
			        <option value="<%=str1%>"><%=str1%></option>
			        
			<%
			    }
			%>			
			
           </select>  
           
           <input type="hidden" id="valueId" name="min_value" value="<%=temp%>">   
            <input type="hidden" id="valueProject" name="projectName" value="<%=prjName%>" >        
     
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
		var status=document.getElementById("dataAdded").value;
		if(status== "success"){
			swal("successfully!","Data Added","success");
		}	
	</script>
    
    
    

    


</body>

 

</html>