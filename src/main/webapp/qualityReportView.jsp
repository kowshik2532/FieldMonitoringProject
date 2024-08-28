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

<%@page errorPage="error_page.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Quality Report</title>
   <style>
     *{
    margin:0;
    padding: 0;
    font-family: Verdana;

}

body{
    height: 65vh;    
    place-items: center;
    width: 100%;

}

#container{
	margin: 0px 20px 30px;
	

}
#move{
      margin-buttom:20px;
 }
table{
  
    box-shadow: -1px 12px 12px -6px rgba(0, 0, 0, 0.5);
  
    margin-left: 2em;
}
table, td, th{
    padding: 20px;
    border: 1px solid lightgray;
    border-collapse: collapse;
    text-align: center;
   
}

tr:nth-child(1){
    background-color: #990099;
    color: white;
    font-size: 150%;
}
tr:nth-child(2){
    background-color:	#CBC3E3;
    font-size: 12px;
    
}
tr:nth-child(3){
    background-color:	#CBC3E3;
    font-size: 13px;
    
}
tr:nth-child(3) th:nth-child(16){
font-size-adjust: calc();
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
#imagePro{
display:flex;
justify-content: center;
margin-bottom:10px;
margin-top:20px

}

#imagePro img {
  max-width: 13%; /* Adjust this value to control the image size */
  height: auto; /* Maintain aspect ratio */
}
#title{
	display: flex;
	justify-content: center; 
	margin-bottom:20px;

}
    </style>
</head>
<body>

	<!-- Navigation-->
	<div class="topnav">
	  <a class="active" href="#home">SAMPLING REPORT</a>
	  <div id="rightNavBar">	  
	  <a  id ="user12" href="logout" >Welcome,&nbsp;<%=session.getAttribute("name")%>!</a>
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
	<div id="move">
      <div id="container">

 

<%
		String s = "Master";	
		String nameOfTheProject=null;
		//String prjName=request.getParameter("project");
		
		
		
		String prjName=request.getParameter("project");
        
        //System.out.println(prjName);
        
		String date=request.getParameter("inputDate");
        
      //  System.out.println(date);
        
        
		
		char[] myCheck = new char[4];
		boolean decision=false;
		
		for(int i=0; i<myCheck.length; i++) {
			myCheck[i]=s.charAt(i);
		}
		
		for(int i=0; i<myCheck.length; i++) {
			if(myCheck[i]==prjName.charAt(i)) {
				decision = true;
			
			}else {
				decision = false;
				
			}
		}
		

        if(decision){
        	String[] check= prjName.split("/", 2);    		
    		nameOfTheProject=check[1];
        }else{
        	nameOfTheProject=prjName;
        }
		
		
		//String date=request.getParameter("inputDate");
		
				
		String editedDate=date.substring(8,10)+"-"+date.substring(5,7)+"-"+date.substring(0,4);
		
%>





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


     <div id="imagePro">
		  <img src="AxisLogo.jpg" alt="AxisMyIndia_logo">
	 </div>

	<div id =title><h2><%=prjName%>(<%=editedDate%>)<h2></div>
	
	<%
	
	    Connection con= null;
	     PreparedStatement ps=null;
	    ResultSet rs=null;
	   // String GenderSampling="";
	    ArrayList<String> FrNameList=new ArrayList<>();
	    ArrayList<String> Gendersampling=new ArrayList<>(); 
	    ArrayList<String> Castesampling=new ArrayList<>(); 
	    ArrayList<String> Detailingissue=new ArrayList<>(); 
	    try{
		 	
            Class.forName("com.mysql.cj.jdbc.Driver");
            //System.out.println(username+" "+password);
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false", username, password);	
            //System.out.println("PRJ:"+nameOfTheProject);        
			ps=con.prepareStatement("select * from quality where Project_Name LIKE'%"+nameOfTheProject+"%' AND Inputdate='"+date+"'");	
	    
	         //ps=con.prepareStatement("select * from quality where Project_Name='Master?ji / Gyani Insan WB' AND Inputdate='2023-09-25'");
	        // ps.setString(1, prjName);
	        // ps.setString(2, date);
	         
	         rs = ps.executeQuery();
	       
	         while(rs.next()){
	        	 FrNameList.add(rs.getString("FrName"));
	        	 Gendersampling.add(rs.getString("Gender_sampling"));
	        	 Castesampling.add(rs.getString("Caste_sampling"));
	        	 Detailingissue.add(rs.getString("Detailing_issue"));
	        	
	       	 }
	
	    	rs.close();
		 ps.close();		
	    }catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				ps.close();
				con.close();
			} catch (SQLException e) {					
				e.printStackTrace();
			}
		}	 	 
%>
 <center>
   <div class="tables">
    <%
					response.setContentType("text/html");
					out.println("<table id='main'>");
					int index=0;
					int srNo=0;
					 
					boolean flag=false;
					out.println("<th colspan='6'>Quality Report</th>");
					out.println("<tr><th colspan='2'>Feedback Sampling Report</th><th colspan='3'>"+prjName+"</th><th  font size='10px'>"+editedDate+"</th></tr>");
					out.println("<tr><th>Sr.No</th><th>Date</th><th>FR Name</th><th>Gender Sampling</th><th>Caste Sampling</th><th>Detailing of issues/sampling and Other errors</th></tr>");
					
				while(index<FrNameList.size()){
					//System.out.println("Here");
					srNo=index+1;
					//String ge_sl=Gender_sampling.get(index);
					String frName1 = FrNameList.get(index);
					
					String gender_sampling=Gendersampling.get(index).replace("\n","<br>");
					String caste_sampling=Castesampling.get(index).replace("\n","<br>");
					String detailing_issue=Detailingissue.get(index).replace("\n","<br>");
					
					
					out.println("<tr><td >" + srNo + "</td><td>" + editedDate + "</td><td>" + frName1 + "</td><td>" +gender_sampling+"</td><td>" +caste_sampling+ "</td><td>" +detailing_issue+ "</td></tr>");
                   index++;
				}
		     
%>
      
     </div>
     </div>
    </center>
</body>
</html>
    