<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*, java.net.*" %>
<%@ page import="javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList" %>



<%@page errorPage="error_page.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Log Detail</title>


<style type="text/css">
	
	*{
  font-family: Verdana;
}
	table {
	    border-collapse: collapse;
	     
	     width: 100%;
	
	
	}
	
	th, td {
		border: 1px solid black;
		text-align: center;
		padding: 8px;
		width: 150px;
	}
	
	th {
		background-color: purple;
		color: white;
		
	}
	
	tr:hover {
		background-color: #f5f5f5;
	}
	
	#mainTab {
		padding: 20px;
	}
	
	#second {
		font-size: 12px;
	}
	

	
	#header {
		display: flex;
		justify-content: center;
		font-size: 30px;
		color:purple;
		
	}


</style>



</head>
<body>
	
			<!-- for fetching less than and greater than data from server  -->
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
		
		
		
	
			<h2 id="header">User Log Details</h2>

			<%@ page import="java.sql.*"%>
			
				<div class="hr-table">

					<%
					response.setContentType("text/html");
					out.println("<table id='main' border='1'>");
					

					Connection con = null;
					PreparedStatement ps = null;
					ResultSet rs = null;
					

					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						con =DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false",username, password);
						String query = "select * from sm_login_logs Order by sr Desc";

						ps = con.prepareStatement(query);
						
						rs = ps.executeQuery();

						//System.out.println(String.valueOf(k));

						out.println("<tr><th>Sr no</th><th>Date</th><th>Name</th><th>Dept Id</th><th>Web Page</th><th>Log In Time </th><th>Log Out Time</th><th>Duration</th></tr>");
						int ind=0;
						while (rs.next()) {
							ind++;
							String sr = rs.getString("sr");
							String date = rs.getString("date");
							String name = rs.getString("name");
							String dept = rs.getString("dept");
							String webpage = rs.getString("webPage");
							String logInTime = rs.getString("logInTime");
							String logOutTime = rs.getString("logOutTime");
							String duration = rs.getString("duration");


							//System.out.println(name + " " + sd1 + " " + sd2 + " " + sd3 + " " + sd4 + " " + sd5 + " " + sd6 + " " + sd7
							//+ " " + sd8 + " " + sd9 + " " + sd10 + " " + sd11 + " " + GD);
							
							out.println("<tr><td  >" + ind + "</td><td>" + date + "</td><td>" + name + "</td><td>" + dept + "</td><td>" + webpage+ "</td><td>" + logInTime
							+ "</td><td>" + logOutTime + "</td><td>" + duration + "</td></tr>");

						}
						
						out.println("</table>");
						rs.close();
						ps.close();
						con.close();

					} catch (Exception e) {
						e.printStackTrace();
					}
					%>
					</div>
		

</body>
</html>