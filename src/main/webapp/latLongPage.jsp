<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.IOException" %>
<%@ page import="java.net.URI" %>
<%@ page import="java.net.http.HttpClient" %>
<%@ page import="java.net.http.HttpRequest" %>
<%@ page import="java.net.http.HttpResponse" %>
<%@ page import="java.util.Arrays" %>

<%
	if(session.getAttribute("name")==null){
		response.sendRedirect("index.jsp");
	}
%>
<%@page errorPage="error_page.jsp"%>

    
    
  
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Lat/Long Report page </title>


 <!-- script for search bar -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js">
	</script>

    <style>
    
    
	   *{
	    margin:3px;
	    padding: 0;
	    font-family: Verdana;	
		}
	    
	    table,
	    th,
	    td {
	    border: 1px solid black;
	    border-collapse: collapse;
	    }
	 
	    th,
	    td {
	        padding: 20px;
	    }
	    
	    th{
	    background-color: #eee1ff;
	     color: #990099;
	    
	    }   

		body{
		    height: 75vh;    
		    place-items: center;
		    width: 100%;		
		}
		
		
		table{
		    box-shadow: -1px 12px 12px -6px rgba(0, 0, 0, 0.5);
		    width: 100%;	
			justify-content: center;
			text-align: center;			
		
		}
	
		table, td, th{
		    padding: 15px;
		    border: 1px solid lightgray;
		    border-collapse: collapse;
		    text-align: center;
		
		}
		
		
		#upperRow{
		color:white;
		 background-color: #990099;
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
		
		#user{
		 font-weight:bold; 
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
		    font-weight:bold;
		    font-size: 20px;
		    margin-bottom:20px;
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
        
        #searchBar{
			  /* To center the element horizontally */
			  margin: 0 auto;
			  /* To center the element vertically */
			  display: flex;
			  align-items: center;
			  justify-content: center;
			  /* To make the element large */
			  width: 300px;
			  height: 18px;
			  padding:8px;
			  /* To make the element have a circular border */
			  border-radius: 25px;
			   border: 2px solid #eee1ff;
			   outline: none;			
			  margin-bottom:-20px;
        }

    </style>
    
    
    
</head>
<body>



	<div id="preloader"></div>


	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">Lat/Long REPORT</a>
	  <div id="rightNavBar">	  
	  <a  id ="user12" href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	  <a href="modulePage.jsp">Home</a>
	  </div>
	</div>


<% 

		String ddd=request.getParameter("inputDate");
		String project=request.getParameter("project");
		String prjjj=project;
		project=project.replace(" ", "%20");
		//System.out.println(ddd+"  "+project);
		


			//String dd="2023-09-18";
			String prjName=project+"/"+ddd;
			var url ="http://192.168.1.198:8090/"+prjName+"/?format=json";
			//URL urlObj=new URL("https://18bc-103-226-1-242.ngrok-free.app/J&K%20LOKSABHA%20IMPACT%20ASSESSMENT%20SURVEY%20P1/2023-09-14/");
			
			var req=HttpRequest.newBuilder().GET().uri(URI.create(url)).build();
			var client =HttpClient.newBuilder().build();
			var resp=client.send(req, HttpResponse.BodyHandlers.ofString());
			//System.out.println(resp.statusCode());
			//System.out.println(response.body());
			StringBuilder sb=new StringBuilder();
			sb.append(resp.body());		
			//System.out.println(sb);
			
			String temp[]=null;
			temp=sb.toString().replace("[", "]").split("]");
			//System.out.println();
			
			
			String []date=null;
			String []FrName=null;
			String []surveyor1=null;
			String []surveyor2=null;
			String []count=null;
			
			
			date=temp[1].replace("\"", "").split(",");
			FrName=temp[3].replace("\"", "").split(",");
			surveyor1=temp[5].replace("\"", "").split(",");
			surveyor2=temp[7].replace("\"", "").split(",");
			count=temp[9].replace("\"", "").split(",");
			
			
			
			//System.out.println(Arrays.toString(date));
			//System.out.println(Arrays.toString(FrName));
			//System.out.println(Arrays.toString(surveyor1));
			//System.out.println(Arrays.toString(surveyor2));
			//System.out.println(Arrays.toString(count));
			
			

%>


		<!--to show name of project -->	
	  <div class="header">
   		 <label for="Project"><%=prjjj%></label>
  	 </div>



		<input id="searchBar" type="text"
				placeholder=" Search here..." >
		
		<br>
		<br>
    <center id="latTable" >
				<div class="latLongTable" >

					<%
					response.setContentType("text/html");
					out.println("<table id='main'>");

					out.println("<th colspan='18' id='upperRow'>Lat/Long Report</th>");
					int index=0;
					out.println("<tr><th>SR.NO</th><th>Date</th><th>FR Name</th><th>Surveyor 1</th><th>Surveyor 2</th><th>Nearest Interview Count(less than 15 mtr.)</th></tr>");
					out.println("<tbody id='latlatData'>");
						while (index<FrName.length) {
							int srNo=index+1;
							String date1 = date[index];
							String frName1 = FrName[index];
							String sur1 = surveyor1[index];
							String sur2 = surveyor2[index];
							String count1 = count[index];							
							out.println("<tr><td  >" + srNo + "</td><td id='dateFetch'>" + date1 + "</td><td>" + frName1 + "</td><td>" + sur1 + "</td><td>" + sur2 + "</td><td>" + count1
							+ "</td></tr>");							
							index++;
						}
					out.println("</tbody>");
					out.println("</table>");
					 
					%>
			</div>
			
</center>





 <center id="noDataFound" >
			
			<h1 id="msg"></h1>
			<br>
			<h2 id="or"></h2>
			<br>
			<h1 id="msg1"></h1>
</center>






	
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">





	<script type="text/javascript">
		function showingMsg(){
			var msg=document.getElementById("msg");		
			var msg1=document.getElementById("msg1");
			var or=document.getElementById("or");
			
			var lateTable=document.getElementById("latTable");
			
			if(<%=date[0].length()%><3){				
				//alert("No data found");
				latTable.style.display="none";

				msg.textContent="No interview was conducted at a distance of less than 15 meters !!";
				msg.style.color="green";
				
				or.textContent="or";
				or.style.color="green";
				
				
				msg1.textContent="Project is not Live for the selected date!!";
				msg1.style.color="green";
		
			}
		}	
		showingMsg();
	
	</script>	






    
  
    
     <!-- searching Filter for FR wise  -->
    		<script>
			$(document).ready(function() {
				$("#searchBar").on("keyup", function() {
					var value = $(this).val().toLowerCase();
					$("#latlatData tr").filter(function() {
						$(this).toggle($(this).text()
						.toLowerCase().indexOf(value) > -1)
					});
				});
			});
		</script>
		
    
      <!-- preloader image buffering  -->
     <script>
        var loader=document.getElementById("preloader");
        window.addEventListener('load',()=>{
                loader.style.display="none"
        })
    </script>  
    
   

</body>
</html>