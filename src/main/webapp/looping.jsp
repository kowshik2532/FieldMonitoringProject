<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ page import ="java.util.stream.Collectors" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>
<%@page errorPage="error_page.jsp"%>


	

<!DOCTYPE html>

<html>

<head>

<meta charset="ISO-8859-1">

<title>Looping</title>

<style>
*{
	width:auto;
	height:auto;


}
body{
 font-family: "Verdana", sans-serif;
 
}


#main, #second {
	border-collapse: collapse;
	
	
}

#main th, #main td {
	border: 1px solid #D3D3D3;
	padding: 6px;
	text-align: center;
}

#main, #second {
	margin-top: 15px;
}


table {
    
    width: 98%;
    margin:15px;
    display:flex;
	justify-content: center;
	text-align: center;
}


th, td {
	border: 1px solid black;
	text-align: center;
	padding: 6px;
	width: 150px;
}


th {

	background-color: #990099;
	color: white;	
}

#tempPrjName{
	font-size: 40px;
	color:#990099;
	font-weight:bold;
	display:flex;
	justify-content: center;
	text-align: center;
	margin-bottom:15px;
}
	
#tempFrName{
	color:#990099;
	display:flex;
	font-weight:bold;
	justify-content: center;
	text-align: center;
	font-size: 30px;
	
}


#status{
	display:flex;
	justify-content: center;
	text-align: center;
	font-size: 15px;	
	font-weight:bold;
	
}

#imagePro{
display:flex;
justify-content: center;
text-align: center;
margin-bottom:15px;


}

#imagePro img {
  max-width: 16%; /* Adjust this value to control the image size */
  height: auto; /* Maintain aspect ratio */
}

.topright {
  position: absolute;
  top: 25px;
  right: 20px;
  font-size: 20px;
  color:red;
  font-weight:bold;
}


#timeId{
	position: absolute;
  	top: 8px;
  	left: 16px; 

}

#currentTime{
	font-weight:bold;
}

#hourlyReport{
	color:#990099;
	display:flex;
	font-weight:bold;
	justify-content: center;
	text-align: center;
	font-size: 20px;

}



</style>

</head>

<body>




 <div id="timeId">Time :  <span id="currentTime">11:00 AM</span></div>
 <script>
    function updateCurrentTime() {
        const currentDate = new Date();
        const formattedTime = currentDate.toLocaleTimeString([], {
            hour: '2-digit',
            minute: '2-digit',
          //  second: '2-digit'
        }); // Format the time as "hh:mm AM/PM"
        const currentTimeElement = document.getElementById('currentTime');
        currentTimeElement.textContent = formattedTime;
    }

    updateCurrentTime();

    // Update the current time every second (1000 milliseconds)
    setInterval(updateCurrentTime, 1000);
</script>
 

   
    

    <%! static int count=0;%>
     <%! static int ind=0;%>
    
    <%
        Connection con = null;



        ArrayList<String> task=new ArrayList<>();
       ArrayList<String> checkList=new ArrayList<>();
       HashSet<String> ProjectName=new HashSet<>();
       ArrayList<String> nameOfProject=new ArrayList<>();
       ArrayList<String> FRname=new ArrayList<>();

       try {

           Class.forName("com.mysql.cj.jdbc.Driver");
           con=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");
          

           //data base connection to fetch surveyor id

           PreparedStatement ps1 =con.prepareStatement("SELECT DISTINCT SUBSTRING(TASK_ID, 1, 6) FROM `MOVEMENT` WHERE `DEVICE_DATETIME` >= CURDATE();");
           ResultSet rs1=ps1.executeQuery();
           while(rs1.next()) {
               String taskId  =rs1.getString("SUBSTRING(TASK_ID, 1, 6)");
               task.add(taskId);
           }
           rs1.close();
           

           for(int i=0;i<task.size();i++) {
               String a=task.get(i);
               PreparedStatement ps2 =con.prepareStatement("SELECT DISTINCT(CHECKLIST_ID) FROM `ASSIGNED_SURVEY` WHERE `TASK_ID`="+a);
               ResultSet rs2=ps2.executeQuery();
               while(rs2.next()) {
                   String checkId  =rs2.getString("CHECKLIST_ID");
                   checkList.add(checkId);
               }
               rs2.close();
               ps2.close();
           }
           

           for(int i=0;i<checkList.size();i++) {
               String a=checkList.get(i);
               PreparedStatement ps3 =con.prepareStatement("SELECT MAX(CHK_ID) AS CHK_ID, CHECKLIST_NAME FROM `CHECKLIST_MASTER` WHERE `CHECKLIST_ID` ="+a+" GROUP BY `CHECKLIST_NAME`");
               ResultSet rs3=ps3.executeQuery();
               while(rs3.next()) {
                   String pname  =rs3.getString("CHECKLIST_NAME");
                   if(pname.charAt(0)!='#')ProjectName.add(pname);
                }
			
               
               ps3.close();
           }
			
           
           ps1.close();
           con.close();

        } catch (Exception e) {
             e.printStackTrace();
        }    

       
       
       
        for (String str : ProjectName) {
             nameOfProject.add(str);
        }
        
        String tempProject= "";
        
        
       
        
       if(count< nameOfProject.size()){ 
    	   tempProject=nameOfProject.get(count);   
       }else{
    	   count=0;
    	   tempProject=nameOfProject.get(count);
       }
       
    
        
        
        String str="";
		con=null;		
		String mValue="not selected"; 
		
   		  ArrayList<String> FRname1=new ArrayList<>();
    		 List<String> arr=new ArrayList<>();
     		int temp=0;
     
     
     try {
     	Class.forName("com.mysql.cj.jdbc.Driver");
			 con=DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false","bhanu","axis@123");			 
			//System.out.println("succesfully connected");
			
			String prjName=tempProject;
			 
				//data base connection to fetch surveyor id 
				PreparedStatement ps1 =con.prepareStatement("SELECT MIN(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(cm.CHECKPOINT_ID, ',', numbers.n), ',', -1) AS SIGNED)) AS min_value FROM CHECKLIST_MASTER cm JOIN ( SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 ) numbers ON LENGTH(cm.CHECKPOINT_ID) - LENGTH(REPLACE(cm.CHECKPOINT_ID, ',', '')) >= numbers.n - 1 WHERE cm.CHECKLIST_NAME ="+"'"+prjName+"'");                                  
				ResultSet rs1=ps1.executeQuery();			
				  
				while(rs1.next()) {
					mValue  =rs1.getString("min_value");				
				}
				temp=Integer.parseInt(mValue);
				request.setAttribute("min_value", temp);
				PreparedStatement ps2 =con.prepareStatement("SELECT VALUE FROM `CHECKPOINT` WHERE `CHECKPOINT_ID` = "+temp+" ORDER BY `CPID` DESC");
				
				
				//String dateTemp = java.time.LocalDate.now().toString();						
				//PreparedStatement ps2 =con.prepareStatement("SELECT  DISTINCT(VALUE) FROM `SAVE_SURVEY` WHERE `CHECKPOINT_ID` = "+temp+" AND `DATETIME` >= ?");
			//	ps2.setString(1, dateTemp + " 00:00:00");
				
				ResultSet rs2=ps2.executeQuery();
				
				while(rs2.next()) {
					str=rs2.getString("VALUE");		
				}
					
		        arr=Arrays.stream(str.split(","))
		                .map(String::trim).collect(Collectors.toList());	
		        
		        request.setAttribute("myList",arr);		        
		        
		       // System.out.println(arr);
		        
		        rs1.close();
		        ps1.close();
	            con.close();	            
	            
	           // System.out.println(arr);
	        	
		} catch (Exception e) {
			e.printStackTrace();
		}
  
    %>    
     
     
       
      
     	<div id="imagePro">
		  	<img src="AxisLogo.jpg" alt="AxisMyIndia_logo">
		</div>
		
		 <div id="hourlyReport">Hourly Report</div>
		<div class="topright"> &bull; LIVE</div>     	
        <div id="tempPrjName"><%=nameOfProject.get(count)%></div>
        <hr>       
        
        
        <!--assigning ind =1 if it gets out of bound -->
        <%         
        if(ind>=arr.size()){ 
     	   ind=0;
        }       
        %>
        
        
        <div id="tempFrName">FR : <%=arr.get(ind)%></div>
       	<span id="status"></span> 
       
		<div class="hr-table" border=1>    
   
     
     <%				
				response.setContentType("text/html");
     %> 
     
				<table class="main-tab" id="main">

				
	<%		
				String min_value = request.getParameter("min_value");

				con = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				String GD = "$";

				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection("jdbc:mysql://192.168.1.251:3306/AXISMYINDIA?useSSL=false", "bhanu", "axis@123");
					String query = "SELECT a.EMP_ID, " + "b.EMP_NAME, "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '07:00:00' AND TIME(a.DATETIME) < '08:00:00' THEN 1 ELSE 0 END) AS '7-8', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '08:00:00' AND TIME(a.DATETIME) < '09:00:00' THEN 1 ELSE 0 END) AS '8-9', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '09:00:00' AND TIME(a.DATETIME) < '10:00:00' THEN 1 ELSE 0 END) AS '9-10', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '10:00:00' AND TIME(a.DATETIME) < '11:00:00' THEN 1 ELSE 0 END) AS '10-11', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '11:00:00' AND TIME(a.DATETIME) < '12:00:00' THEN 1 ELSE 0 END) AS '11-12', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '12:00:00' AND TIME(a.DATETIME) < '13:00:00' THEN 1 ELSE 0 END) AS '12-13', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '13:00:00' AND TIME(a.DATETIME) < '14:00:00' THEN 1 ELSE 0 END) AS '13-14', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '14:00:00' AND TIME(a.DATETIME) < '15:00:00' THEN 1 ELSE 0 END) AS '14-15', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '15:00:00' AND TIME(a.DATETIME) < '16:00:00' THEN 1 ELSE 0 END) AS '15-16', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '16:00:00' AND TIME(a.DATETIME) < '17:00:00' THEN 1 ELSE 0 END) AS '16-17', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '17:00:00' AND TIME(a.DATETIME) < '18:00:00' THEN 1 ELSE 0 END) AS '17-18', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '18:00:00' AND TIME(a.DATETIME) < '19:00:00' THEN 1 ELSE 0 END) AS '18-19', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '19:00:00' AND TIME(a.DATETIME) < '20:00:00' THEN 1 ELSE 0 END) AS '19-20', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '20:00:00' AND TIME(a.DATETIME) < '21:00:00' THEN 1 ELSE 0 END) AS '20-21', "
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '21:00:00' AND TIME(a.DATETIME) < '22:00:00' THEN 1 ELSE 0 END) AS '21-22',"
					+ "SUM(CASE WHEN TIME(a.DATETIME) >= '07:00:00' AND TIME(a.DATETIME) < '22:00:00' THEN 1 ELSE 0 END) AS '8-22' "
					+ "FROM `SAVE_SURVEY` a " + "JOIN EMP_MASTER b ON a.EMP_ID = b.EMP_ID "
					+ "WHERE a.`CHECKPOINT_ID` = ? AND a.`VALUE` = ? " + "AND a.DATETIME > ? AND a.DATETIME <= ? "
					+ "GROUP BY a.EMP_ID, b.EMP_NAME";

					ps = con.prepareStatement(query);
					String min=String.valueOf(temp);
					ps.setString(1, min);
					ps.setString(2, arr.get(ind));
					String date = java.time.LocalDate.now().toString();						
					ps.setString(3, date + " 00:00:00");
					ps.setString(4, date + " 22:00:00");
					rs = ps.executeQuery();

					//System.out.println(String.valueOf(k));					
					
					
					ArrayList<ArrayList<Integer>> countArr=new ArrayList<>();					
					
					

					out.println(
					"<tr><th>Name</th><th>7 to 8</th><th>8 to 9</th><th>9 to 10</th><th>10 to 11</th><th>11 to 12</th><th>12 to 1</th><th>1 to 2</th><th>2 to 3</th><th>3 to 4</th><th>4 to 5</th><th>5 to 6</th><th>6 to 7</th><th>7 to 8</th><th>8 to 9</th><th>9 to 10</th><th>Grand Total</th></tr>");
					while (rs.next()) {
						ArrayList<Integer> cnt=new ArrayList<>();
						String name = rs.getString("EMP_NAME");
						String sd0 = rs.getString("7-8");
						String sd1 = rs.getString("8-9");
						String sd2 = rs.getString("9-10");
						String sd3 = rs.getString("10-11");
						String sd4 = rs.getString("11-12");
						String sd5 = rs.getString("12-13");
						String sd6 = rs.getString("13-14");
						String sd7 = rs.getString("14-15");
						String sd8 = rs.getString("15-16");
						String sd9 = rs.getString("16-17");
						String sd10 = rs.getString("17-18");
						String sd11 = rs.getString("18-19");
						String sd12 = rs.getString("19-20");
						String sd13 = rs.getString("20-21");
						String sd14 = rs.getString("21-22");
						GD = rs.getString("8-22");
						
						
						cnt.add(Integer.parseInt(sd0));
						cnt.add(Integer.parseInt(sd1));
						cnt.add(Integer.parseInt(sd2));
						cnt.add(Integer.parseInt(sd3));
						cnt.add(Integer.parseInt(sd4));
						cnt.add(Integer.parseInt(sd5));
						cnt.add(Integer.parseInt(sd6));
						cnt.add(Integer.parseInt(sd7));
						cnt.add(Integer.parseInt(sd8));
						cnt.add(Integer.parseInt(sd9));
						cnt.add(Integer.parseInt(sd10));
						cnt.add(Integer.parseInt(sd11));
						cnt.add(Integer.parseInt(sd12));
						cnt.add(Integer.parseInt(sd13));
						cnt.add(Integer.parseInt(sd14));
						cnt.add(Integer.parseInt(GD));						
						countArr.add(cnt);						
						

						//System.out.println(name + " " + sd1 + " " + sd2 + " " + sd3 + " " + sd4 + " " + sd5 + " " + sd6 + " " + sd7
						//+ " " + sd8 + " " + sd9 + " " + sd10 + " " + sd11 + " " + GD);
						
						out.println("<tr><td  >" + name + "</td><td>" + sd0 + "</td><td>" + sd1 + "</td><td>" + sd2 + "</td><td>" + sd3 + "</td><td>" + sd4
						+ "</td><td>" + sd5 + "</td><td>" + sd6 + "</td><td>" + sd7 + "</td><td>" + sd8 + "</td><td>" + sd9
						+ "</td><td>" + sd10 + "</td><td>" + sd11 + "</td><td>" + sd12 + "</td><td>" + sd13 + "</td><td>" + sd14
						+ "</td><td>" + GD + "</td></tr>");

					}
										
					
					int t0=0,t1=0,t2=0,t3=0,t4=0,t5=0,t6=0,t7=0,t8=0,t9=0,t10=0,t11=0,t12=0,t13=0,t14=0,t15=0;
					
					for(int i=0;i<countArr.size();i++){
						t0+=countArr.get(i).get(0);
						t1+=countArr.get(i).get(1);
						t2+=countArr.get(i).get(2);
						t3+=countArr.get(i).get(3);
						t4+=countArr.get(i).get(4);
						t5+=countArr.get(i).get(5);
						t6+=countArr.get(i).get(6);
						t7+=countArr.get(i).get(7);
						t8+=countArr.get(i).get(8);
						t9+=countArr.get(i).get(9);
						t10+=countArr.get(i).get(10);
						t11+=countArr.get(i).get(11);
						t12+=countArr.get(i).get(12);
						t13+=countArr.get(i).get(13);
						t14+=countArr.get(i).get(14);
						t15+=countArr.get(i).get(15);
					}
					
					
					
					out.println(
					"<tr><td>Total Count</td><td>"+t0+"</td><td>"+t1+"</td><td>"+t2+"</td><td>"+t3+"</td><td>"+t4+"</td><td>"+t5+"</td><td>"+t6+"</td><td>"+t7+"</td><td>"+t8+"</td><td>"+t9+"</td><td>"+t10+"</td><td>"+t11+"</td><td>"+t12+"</td><td>"+t13+"</td><td>"+t14+"</td><td>"+t15+"</td></tr>");

					out.println("</table>");
					out.println("<br>");
					
					
					rs.close();
					ps.close();
					con.close();

				} catch (Exception e) {
					e.printStackTrace();
				}
				
				ind++;
				if(ind>=arr.size()){
					count++;
					ind=0;
				}
				
				if(count>=nameOfProject.size()){
					count=0;
					ind=0;
				}     
     
    %>
    
    

    
    
    
    <!--giving time to actice/inactive table -->
    	<script>
        function hideTheTable() {
            var table = document.getElementById("main");
            var rows = table.getElementsByTagName("tr");
            var prj=document.getElementById("tempPrjName");
            var fr=document.getElementById("tempFrName");
            var status=document.getElementById("status");
            
            var gdd = '<%=GD%>';
            
            if(gdd=='$'){
            	  
            	//table.style.display = "none";
            	//fr.style.display = "none";
            	//fr.textContent = fr.textContent + " ( INACTIVE )";
            	status.textContent="( INACTIVE )";
            	status.style.color='red';
            	
            	
    	        setTimeout(function () {
    		         location.reload();
    		        }, 3000); 
            	//console.log("hide working :"+gdd);
            }else {
            	status.textContent="( ACTIVE )";
            	status.style.color='green';
            	
            }
		}

        hideTheTable();
	</script>
    
    
    
    
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
		    System.out.println(e.getMessage());
		}
		%>
    
   
    
    
  <!-- for fetching less than and greater than data from server  -->
	<%
	String lessThan = "2";
	String greaterThan = "4";

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/new?useSSL=false", username, password);

		PreparedStatement ps2 = con2.prepareStatement("select * from conditionTable");
		ResultSet rs2 = ps2.executeQuery();

		while (rs2.next()) {
			lessThan = rs2.getString("lessThan");
			greaterThan = rs2.getString("greaterThan");

		}

		
		 rs2.close();
		 ps2.close();
		con2.close();
	} catch (Exception e) {
		e.printStackTrace();
	}
	%>
    
   
    
    
    
    
    <!-- to color the cell  -->
	<script>
        function highlightCells() {
            var table = document.getElementById("main");
            var rows = table.getElementsByTagName("tr");
            
            rows[rows.length - 1].cells[16].style.fontWeight = 'bold';
			rows[rows.length - 1].cells[0].style.fontWeight = 'bold';
           
        
            let lessthan='<%=lessThan%>';
      		let greaterthan='<%=greaterThan%>';
      		//console.log(greaterthan);
      		

			for (let r = 1; r < rows.length - 1; r++) {
				const now = new Date();
				const hour = now.getHours();
				let upto = hour - 8 + 2;
				//console.log(hour);
				for (let c = 1; c < upto && c < 16; c++) {
					
					if (rows[r].cells[c].textContent < lessthan) {
						//rows[r].cells[c].style.backgroundColor="Red";
						rows[r].cells[c].style.color = "Red";
						rows[r].cells[c].style.fontWeight = "bold";
					}
					
					if (rows[r].cells[c].textContent > greaterthan) {
						//rows[r].cells[c].style.backgroundColor="Red";
						rows[r].cells[c].style.color = "blue";
						rows[r].cells[c].style.fontWeight = "bold";
					}
	
				}
			}
		}

		highlightCells();
	</script>
    
    
   		<script type="text/javascript">
	        setTimeout(function () {
	         location.reload();
	        }, 18000);
	    </script>

    

</body>

</html>