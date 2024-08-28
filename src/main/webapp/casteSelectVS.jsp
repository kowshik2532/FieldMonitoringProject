<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>   
    
    
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>
    
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
<title>Select VishanSabha</title>




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
            background-size: 25%;
            height: 100vh;
            width: 100%;
            position: fixed;
            z-index: 100;
            opacity: 1;           
        }
        
        
		    .header {		   
		   
		    display: flex;
		    justify-content: center;
		    align-items: center;
		    margin-left: 27%;
		    color: #990099;
		    padding: 10px;
		    padding-bottom:5px;
		    width : 90vh;
		   
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
		
		#msg{
			margin-top:-2%;
			margin-left:44.5%;			
		
		}
		
		#desc{
			padding-left:70px;
			font-wieght:bold;
			color:green;
		}
		
		#demo{

			font-weight: bold;
			color:green;
    
        }

    </style>






</head>
<body>

	<div id="preloader"></div>
	
	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">Caste Sampling</a>
	  <div id="rightNavBar">
	   <a href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
	  <a href="logout">Logout</a>
	  <a href="modulePage.jsp">Home</a>
	  </div>
	</div>


			<% 
			String frName = request.getParameter("frName");
			String projectName = request.getParameter("projectName");
			String min_value=request.getParameter("min_value");	
						
			%>
			
			
			
			
	<!-- for fetching VidhanSabha name from server  -->	   
     <%
 	Connection con_sg=null;
 	PreparedStatement ps_sg=null;
 	ResultSet rs_sg=null;
 	Connection con_capi=null;
 	PreparedStatement ps_capi=null;
 	ResultSet rs_capi=null;	
 	String id1="(";
 	String vidhansabhaId="";
 	ArrayList<String> arr=new ArrayList<>();
     
     
     try {    	 
    
    	Connection con=null;		
    		
         ArrayList<String> task=new ArrayList<>();
         ArrayList<String> checkList=new ArrayList<>();
         HashSet<String> ProjectName=new HashSet<>();
        // System.out.println("DON TILL 1");
         
    
         	Class.forName("com.mysql.cj.jdbc.Driver");
    			 con=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");			 
    		//	System.out.println("succesfully connected");
    			 
    				//data base connection to fetch surveyor id 
    				//System.out.println(projectName);
    				PreparedStatement ps1 =con.prepareStatement("SELECT *  FROM `CHECKLIST_MASTER` WHERE `CHECKLIST_NAME` LIKE ? LIMIT 1");
    				ps1.setString(1, projectName);
    				ResultSet rs1=ps1.executeQuery();			
    				  
    			//	while(rs1.next()) {
    			//		String taskId  =rs1.getString("SUBSTRING(TASK_ID, 1, 6)");
    			//		task.add(taskId);					
    			//	}
    			
    			
    			String chkListId="";
    			while(rs1.next()) {
    					 chkListId  =rs1.getString("CHECKLIST_ID");
    					 
    				}
    			//System.out.println(chkListId);
    				
    			rs1.close();
    			ps1.close();
    			con.close();
    		
    			
    			
    			
    			//Class.forName("com.mysql.cj.jdbc.Driver");
    			con_sg=DriverManager.getConnection("jdbc:mysql://192.168.1.32:3306/surveygeniusdb?useSSL=false","root","axis@123");	
    			//System.out.println("connected");
    			ps_sg =con_sg.prepareStatement("SELECT *  FROM `mainapp_project` WHERE `capi_checklist_id` LIKE ?");
    			ps_sg.setString(1,chkListId);			
    			rs_sg=ps_sg.executeQuery();
    			
    			
    			String newId="";
    			while(rs_sg.next()) {
    				newId=rs_sg.getString("id");
					 
				}
    			//System.out.println(newId);
    			
    		
        rs_sg.close();
        ps_sg.close();
    	 
    	 
    	 
    	 
    	 
		//	Class.forName("com.mysql.cj.jdbc.Driver");
			//con_sg=DriverManager.getConnection("jdbc:mysql://192.168.1.32:3306/surveygeniusdb?useSSL=false","root","axis@123");	
			//System.out.println("connected");
			ps_sg =con_sg.prepareStatement("SELECT checkpointid FROM `mainapp_vidhansabhacheckpoint` where project_id LIKE ?");
			ps_sg.setString(1,newId);			
			rs_sg=ps_sg.executeQuery();
			
			while(rs_sg.next()) {
				vidhansabhaId=rs_sg.getString("checkpointid");		
			}
			
			rs_sg.close();
			ps_sg.close();
			con_sg.close();
			
			
	     	Class.forName("com.mysql.cj.jdbc.Driver");
			con_capi=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");	
    	 
    	//System.out.println(vidhansabhaId);
    	 
  	   String date = java.time.LocalDate.now().toString();						
  			String editDate =date+" 00:00:00";
  		        
  		        //fetchig id from capi
  		        ps_capi=con_capi.prepareStatement("SELECT * FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` LIKE ? AND `VALUE` LIKE ? AND `DATETIME` > ? ORDER BY `DATETIME`");
  		        ps_capi.setString(1,min_value);
  		        ps_capi.setString(2,frName);
  		        ps_capi.setString(3,editDate);
  			    rs_capi=ps_capi.executeQuery();
  		         
  				while(rs_capi.next()) {
  						id1+=rs_capi.getString("id1")+",";		
  				}
  				
  				id1=id1.substring(0,id1.length()-1)+")";
  				//System.out.println(id1);
  	   			//System.out.println(id1);
  		        rs_capi.close();
  		        ps_capi.close();
  		        
  		    
  			
  			 //fetching distinct value from capi
  		       ps_capi=con_capi.prepareStatement("SELECT DISTINCT(VALUE) FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` LIKE ? AND `id1` IN "+id1);
  		       ps_capi.setString(1,vidhansabhaId);  			       
  	           rs_capi=ps_capi.executeQuery();  	           
  				while(rs_capi.next()) {
  					String v1=rs_capi.getString("VALUE");
  					arr.add(v1);
  				}
  				
  				//arr.add("man"); 
  				
  			//	System.out.println(arr);
  			rs_capi.close();
  			ps_capi.close();
	    
	        	
		} catch (Exception e) {
			e.printStackTrace();
		}
    %>
    
    
    
    
    
          <!--to show name of project -->	
	  <div class="header">
   		 <label for="Project"><%=projectName%></label>
  	 </div>
  	 
  <!--to show FR of project -->	
	  <div class="header">
   		 <label for="Project"> FR : <%=frName%></label>
  	 </div>
  	 
   
    
    
    <!--to show vs name list -->    
   <div class="container">	
        <form action="casteVidhansabha.jsp" method="post">
            <label for="vsName">Select a VS Name:</label>
            <select id="vsName" name="vsName">
            
			<%
			    for (String vsValue:arr) {
			%>
			        <option value="<%=vsValue%>"><%=vsValue%></option>
			        
			<%
			    }
			%>			
			
           </select>  
           
           <input type="hidden" id="valueId" name="min_value" value="<%=min_value%>">   
           <input type="hidden" id="valueProject" name="projectName" value="<%=projectName%>" >   
             <input type="hidden" id="valueProject" name="frName" value="<%=frName%>" > 
             <input type="hidden" id="valueProject" name="vidhansabhaId" value="<%=vidhansabhaId%>" >        
     
           <br>
           <br>
            <button type="submit" onclick="myFunction()">Submit</button>
            </form>
    </div>
    
    
           <div id ="msg">
            <p id="desc"></p>
            <p id="demo"></p>
          </div>
    
    
    
    
 
    
			
	<script>
		function myFunction() {
		  var descc=document.getElementById("desc").innerHTML = "Processing...";
		 
		  var demo1=document.getElementById("demo").innerHTML = "Please wait for a few sec.... ";
		
		  	
		   var loader=document.getElementById("preloader");	
		  
			loader.style.display="block"
			
		  
		}
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