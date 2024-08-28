<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>     
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="org.w3c.dom.Node" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>
<%@ page import="java.time.LocalDate" %>


<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.

	if(session.getAttribute("name")==null){
		response.sendRedirect("index.jsp");
	}
%>

   <%@page errorPage="error_page.jsp"%>  
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Select VidhanSabha</title>




<style>
           body {

           font-family: Verdana;
            margin: 0;
            padding: 0;
            height: 100vh; /* Increased height */
        }



        label {
            display: block;
            font-weight: bold;
            
        }

        select ,input{

            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-bottom: 15px;

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
		
		
		th, td {
			border: 1px solid black;
			text-align: center;
			padding: 13px;
			
		}
		
		th {
			background-color: purple;
			color: white;
			
		}
		
		tr:hover {
			background-color: #f5f5f5;
		}
		
		#main {
			border-collapse: collapse;
		}
		

		
		#main {
			margin-top: 40px;
		}
		
		table {
	    border-collapse: collapse;	     
	    
		}
		
		#headerProject{
		
			  font-size: 21px;
		}
		
		#headerfR{
			 margin-bottom:-24px;
		}
		
		.topright {
		  position: absolute;
		  top: 55px;
		  right: 100px;
		  font-size: 20px;
		  color:red;
		  font-weight:bold;
		}
		
		
		#details{
			margin-top:30px;
			margin-bottom:10px;
			
		}</style>
</head>
<body>




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
			String VALUE=request.getParameter("vsName");
			String vidhansabhaId=request.getParameter("vidhansabhaId");			
			%>
			
			

	<!--Fetching vishansabha name -->			
	<%
	String vidhanSabhaName="";
	Connection con_capi=null;
	PreparedStatement ps_capi=null;
	ResultSet rs_capi=null;	
	
	ArrayList<String>allCasteName=new ArrayList<>();
	ArrayList<String> allCasteTaken=new ArrayList<>();
	HashMap<String,Integer> map=new HashMap<>();
	HashMap<String,Integer> reqPercentage=new HashMap<>();
	HashMap<String, String> achievedPercentage=new HashMap<>();
	int totalInterview=0;
		
	String id1="(";
	
	
		try{			
			/* Class.forName("com.mysql.cj.jdbc.Driver");
			con_sg=DriverManager.getConnection("jdbc:mysql://192.168.1.32:3306/surveygeniusdb?useSSL=false","root","axis@123");	
			//System.out.println("connected");
			ps_sg =con_sg.prepareStatement("SELECT checkpointid FROM `mainapp_vidhansabhacheckpoint` where project_id IN ( SELECT id FROM mainapp_project WHERE name LIKE ?)");
			ps_sg.setString(1, projectName);			
			rs_sg=ps_sg.executeQuery();
			
			while(rs_sg.next()) {
				vidhansabhaId=rs_sg.getString("checkpointid");		
			}
			
			rs_sg.close();
			ps_sg.close();
			con_sg.close();		
			
	
			
	       //    ps_capi=con_capi.prepareStatement("SELECT * FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` LIKE ? AND `VALUE` LIKE ? ORDER BY `DATETIME` DESC LIMIT 1");
		    //    ps_capi.setString(1,min_value);
		     //   ps_capi.setString(2,frName);
	      //     rs_capi=ps_capi.executeQuery();
	         
			//	while(rs_capi.next()) {
			//		id1=rs_capi.getString("id1");		
				//}				
				//System.out.println("id1 "+id1);    		
		       // rs_capi.close();
		        //ps_capi.close();      
		        
		  //fetching vidhansabha from capi
		      //  ps_capi=con_capi.prepareStatement("SELECT * FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` LIKE ? AND `id1` = ?");
		       // ps_capi.setString(1,vidhansabhaId);
		       // ps_capi.setString(2,id1);
	           // rs_capi=ps_capi.executeQuery();	           
				//while(rs_capi.next()) {
				//	vidhanSabhaName=rs_capi.getString("value");		
				//}				
				
			//	System.out.println(vidhanSabhaName);			
				
			//	rs_capi.close();
			//	ps_capi.close();        
		        
		        
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
		        rs_capi.close();
		        ps_capi.close();	        
		    
			
			 //fetching distinct value from capi
		       ps_capi=con_capi.prepareStatement("SELECT DISTINCT(VALUE) FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` LIKE ? AND `id1` IN "+id1);
		       ps_capi.setString(1,vidhansabhaId);
			 //  ps_capi.setString(2,id1);		       
	           rs_capi=ps_capi.executeQuery();	           
				while(rs_capi.next()) {
					VALUE=rs_capi.getString("VALUE");		
				}				
				//System.out.println(VALUE);				
			rs_capi.close();
			ps_capi.close();			
			*/
			
	     	Class.forName("com.mysql.cj.jdbc.Driver");
			con_capi=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");
			
		String date = java.time.LocalDate.now().toString();						
		String editDate =date+" 00:00:00";
		//editDate = shi=ould be todaysdate - 3	
		String taskId="(";
		String oneTaskId="";
		 //fetching taskId from capi
		
		
		LocalDate todayDate = LocalDate.now();			
		 String finalDate=todayDate.minusDays(2).toString();
		 finalDate=finalDate+" 00:00:00";
		 
		// System.out.println(finalDate);
		// System.out.println(vidhansabhaId);
	       ps_capi=con_capi.prepareStatement("SELECT DISTINCT(TASK_ID) FROM SAVE_SURVEY WHERE CHECKPOINT_ID LIKE ? AND VALUE LIKE '"+VALUE+"' AND DATETIME > ?");
	      // ps_capi.setString(1, VALUE);
	      // SELECT DISTINCT(TASK_ID) FROM SAVE_SURVEY WHERE CHECKPOINT_ID LIKE '77556' AND VALUE LIKE "89-HUZURNAGAR" AND DATETIME > '2023-10-08 00:00:00'
		  ps_capi.setString(1,vidhansabhaId);
		 	//ps_capi.setString(1,VALUE);	     
	       ps_capi.setString(2,finalDate);
		 //  ps_capi.setString(2,id1);		       
           rs_capi=ps_capi.executeQuery();
           
			while(rs_capi.next()) {				
				taskId+=rs_capi.getString("TASK_ID")+",";
				oneTaskId=rs_capi.getString("TASK_ID");
				//System.out.println("one task id"+oneTaskId);
			}			
			taskId=taskId.substring(0,taskId.length()-1)+")";			
			//System.out.println(oneTaskId);			
			
		rs_capi.close();
		ps_capi.close();
		
		
		
		
		//fetvhing all caste name 
		String casteName="";
		 //fetching taskId from capi
	       ps_capi=con_capi.prepareStatement("SELECT DISTINCT (VALUE) FROM SAMPLING1 WHERE TASK_ID LIKE "+oneTaskId+" AND NAME1 LIKE ?");
	       ps_capi.setString(1,VALUE);
	      // ps_capi.setString(2,frName);
		 //  ps_capi.setString(2,id1);		       
          rs_capi=ps_capi.executeQuery();
          
			while(rs_capi.next()) {
				casteName=rs_capi.getString("VALUE");
				allCasteName.add(casteName);
			}			
			//System.out.println(allCasteName);			
			
		rs_capi.close();
		ps_capi.close();
		
		
		
		
		
		String casteTaken="";		
		 //fetching taskId from capi
	       ps_capi=con_capi.prepareStatement("SELECT VALUE, REMAINING_COUNT  FROM `SAMPLING1` WHERE `TASK_ID` IN "+taskId +"AND NAME1 LIKE ?");
	       ps_capi.setString(1,VALUE);
	      // ps_capi.setString(2,frName);
		 //  ps_capi.setString(2,id1);		       
         rs_capi=ps_capi.executeQuery();
         
			while(rs_capi.next()) {
				String v1=rs_capi.getString("VALUE");
				casteTaken=rs_capi.getString("REMAINING_COUNT");
				int castNumber=Integer.parseInt(casteTaken);
				totalInterview+=castNumber;
				
				if(map.containsKey(v1)){
					map.put(v1,map.get(v1)+castNumber);					
				}else {
					map.put(v1,castNumber);
				}						
				//System.out.println(v1+" "+casteTaken);				
				//allCasteTaken.add(v1+"-"+casteTaken);
			}			
			//System.out.println(map);	
		
			rs_capi.close();
			ps_capi.close();
			
			
			
			//String ="";
			 //fetching taskId from capi
		       ps_capi=con_capi.prepareStatement("SELECT VALUE, TOTAL_COUNT  FROM `SAMPLING1` WHERE `TASK_ID` LIKE "+oneTaskId+" AND `NAME1` LIKE ?");
		       ps_capi.setString(1,VALUE);
		      // ps_capi.setString(2,frName);
			 //  ps_capi.setString(2,id1);		       
	         rs_capi=ps_capi.executeQuery();
	         
				while(rs_capi.next()) {
					String v1=rs_capi.getString("VALUE");
					String TOTAL_COUNT=rs_capi.getString("TOTAL_COUNT");
				    int tc=Integer.parseInt(TOTAL_COUNT);	
					reqPercentage.put(v1,tc);				
							
					//allCasteTaken.add(v1+"-"+casteTaken);
				}			
								
				//System.out.println(reqPercentage);		
				rs_capi.close();
				ps_capi.close();
				
				//System.out.println(totalInterview);
				con_capi.close();	
				
				for(String k:map.keySet()){
					double perConv=((double)(map.get(k)*100))/(double)totalInterview;
					String ans=String.format("%.1f", perConv);
					achievedPercentage.put(k,ans);
				}				
				
				//System.out.println(achievedPercentage); 
			
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{			
			
			try{		
				rs_capi.close();
				ps_capi.close();
				con_capi.close();				
			}catch(Exception e){
				System.out.println(e);
			}	
		}
		
		
		//System.out.println(allCasteName);
		//System.out.println("**************");
		//System.out.println(map);
		//System.out.println("**************");
		//System.out.println(reqPercentage);		
		//System.out.println("done till now");
		
		//allCasteName (template)
		//map(how much interview have take wrt caste)
		//reqPercentage(required % of caste sample )
		//achievedPercentage(achieve percentage by )
		
	%>
	
	      
	
	
	 <!--to show name of project -->	
	  <div class="header">
   		 <label  id="headerProject" for="Project"><%=projectName%></label>
  	 </div>
  	 
  	 
  	<!--to show vishansabha of project -->	
	  <div class="header">
   		 <label id="vsName" for="vishansabha">VS : <%=VALUE%></label>
  	 </div>
  	 
  	<!--to show frname of project -->	
	  <div class="header">
   		 <label  id="headerfR"  for="frname">FR : <%=frName%></label>
  	 </div>
  	 
	
	<div class="topright"> &bull; LIVE</div>  
	
	<div>
	<div>
	<center>
     
   <div class="tables">
    <%
					response.setContentType("text/html");
					out.println("<table id='main'>");
					int index=0;
					String data[]=null;
					allCasteName.add(allCasteName.size()-1,allCasteName.size()+"-"+allCasteName.get(allCasteName.size()-1));				
					out.println("<tr ><th>Sr.No</th><th>Caste</th><th>Interview Count</th><th> % Required </th><th> % Achieved </th><th> % Variance</th></tr>");
					
					int slnum=0;

					
					//System.out.println("**************");
				while(index<allCasteName.size()-1){
					if(allCasteName.size()>2){
					String p1=allCasteName.get(index);
					data=p1.split("-");
					
					//System.out.println(Arrays.toString(data));
					//System.out.println("**************");
					//System.out.println(allCasteName);
					
					
					//System.out.println(frName);
					//System.out.println(VALUE);
					//System.out.println(p1);
					
					
					
					if(index==allCasteName.size()-2)p1=allCasteName.get(index+1);
					int count =map.get(p1);
					int d1=reqPercentage.get(p1);
					
					if(d1>3)slnum++;
					
					String d2=achievedPercentage.get(p1);
					
					double oc=Double.valueOf(d2);
					double diff=oc-(double)d1;
					String oc1=String.format("%.1f", diff);
					//System.out.println(oc1);
					//int diff=.parseInt(d2)-d1;
				 //  System.out.println(num+"$$$$$$$$$$$$$$$$$$$$$$$$$$$"+data[1]);
					
				   // num=num+10;
					out.println("<tr><td>"+slnum+"</td><td>" + data[1] + "</td><td>"+count+"</td><td>"+d1+"</td><td>"+d2+"</td><td>" + oc1 + "</td></tr>");
				//	System.out.println(slnum);
					//out.println("<tr><td>0</td></tr>");
                   index++;
				}
					
					else {
						slnum++;
						String p1=allCasteName.get(index);
						int count =map.get(p1);
						int d1=reqPercentage.get(p1);
						String d2=achievedPercentage.get(p1);
						
						double oc=Double.valueOf(d2);
						double diff=oc-(double)d1;
						String oc1=String.format("%.1f", diff);
						
						
						out.println("<tr><td >" + slnum + "</td><td>" + p1 + "</td><td>"+count+"</td><td>"+d1+"%</td><td>"+d2+"%</td><td>" + oc1 + "%</td></tr>");
		                   index++;
					}
				}
				out.println("<tr><td colspan='2' style='font-weight: bold;'>Total</td><td style='font-weight: bold;'>"+totalInterview+"</td><td style='font-weight: bold;' >100%</td><td style='font-weight: bold;'>100%</td><td style='font-weight: bold;' > 0.0%</td></tr>");
                 
%>
      		 
     </div>
     </div>    
    </center>
</div>

	
	
	
	
	<!-- exclude the caste which % req is less than = 3 -->
	<script>
        function highlightCells() {
            var table = document.getElementById("main");
            var rows = table.getElementsByTagName("tr");                    
			var allCasteLessThan5="";
			let countPerc=0;
			let interviewCount=0;
			let achievedPerc=0;

			for (let r = 1; r < rows.length - 2; r++) {	
				//console.log(rows[r].cells[5].textContent.charAt(0));
				var reqPer=Number(rows[r].cells[3].textContent);
				//if(rows[r].cells[3].textContent.length==2){
				//	reqPer=rows[r].cells[3].textContent.charAt(0);					
			//	}else if(rows[r].cells[3].textContent.length==3){
				//	reqPer=rows[r].cells[3].textContent.charAt(0)+rows[r].cells[3].textContent.charAt(1);
			//	}
				
				//console.log(reqPer);					
					if (reqPer <= 3) {						
						//rows[r].cells[5].style.background = "Red";
						allCasteLessThan5=allCasteLessThan5+""+rows[r].cells[1].textContent+",";
						countPerc+=Number(reqPer);
						interviewCount+=Number(rows[r].cells[2].textContent);
						achievedPerc+=Number(rows[r].cells[4].textContent);
						//rows[r].cells[3].style.color = "blue";
						if(r<rows.length-2)rows[r].style.display="none";
						//rows[r].cells[5].style.fontWeight = "bold";
						//rows[r].cells[1].style.fontWeight = "bold";
					}
					
					//console.log(allCasteLessThan5+ "-->"+countPerc);
					//console.log(achievedPerc);
			}			
			var casteName=rows[rows.length - 2].cells[1].textContent+"("+allCasteLessThan5.substring(0,allCasteLessThan5.length-1)+")";
			//rows[rows.length - 2].cells[1].textContent=casteName;
			
			let v2=rows[rows.length - 2].cells[4].textContent=Number(rows[rows.length - 2].cells[4].textContent)+ Number(achievedPerc);
			let v1=rows[rows.length - 2].cells[3].textContent=Number(rows[rows.length - 2].cells[3].textContent)+ Number(countPerc);
			rows[rows.length - 2].cells[0].textContent=Number(rows[rows.length - 3].cells[0].textContent)+1;
			
			var roundedV1 = Math.round(v1 * 10) / 10;
			rows[rows.length - 2].cells[3].textContent=roundedV1;
			
			var roundedV2 = Math.round(v2 * 10) / 10;
			rows[rows.length - 2].cells[4].textContent=roundedV2;
			
			
			rows[rows.length - 2].cells[2].textContent=Number(rows[rows.length - 2].cells[2].textContent)+ Number(interviewCount);
			let finalCount=v2-v1;
			//rows[rows.length - 2].cells[5].textContent=finalCount;
			
			//console.log(Math.round(finalCount));
			//console.log(finalCount);
			var rounded = Math.round(finalCount * 10) / 10;
			console.log(rounded);
			rows[rows.length - 2].cells[5].textContent=rounded;			
			
		}
		highlightCells();
	</script>
	
	
	
	
		<!-- to color the cell  -->
	<script>
        function highlightCells() {
            var table = document.getElementById("main");
            var rows = table.getElementsByTagName("tr");                    

			var num=1;
			for (let r = 1; r < rows.length - 1; r++) {	
				//console.log(rows[r].cells[5].textContent.charAt(0));

					if (Number(rows[r].cells[5].textContent)<-5 ) {
						
						//rows[r].cells[5].style.background = "Red";
						rows[r].cells[5].style.color = "Red";						
						rows[r].cells[5].style.fontWeight = "bold";
						rows[r].cells[1].style.fontWeight = "bold";
					}else if(Number(rows[r].cells[5].textContent)>5){
						rows[r].cells[5].style.color = "Green";
						rows[r].cells[5].style.fontWeight = "bold";
					}		
			}
		}

		highlightCells();
	</script>
	
	

		

	
	
</body>
</html>