package com.dev.logDetails;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Registration
 */
@WebServlet("/register")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name=request.getParameter("emp_name");
	    String email=request.getParameter("email");
	    String username=request.getParameter("username");
	    String password=request.getParameter("pass");		
	    String dept_id=request.getParameter("user_type");

	    RequestDispatcher rd=null;
	    Connection con=null;
	    
	    
		RequestDispatcher rq=null;
		response.setContentType("text/html");
	    
		String username1="";
		String password1="";
		
		
	       try {
	           String fileName = "/config/config.xml";
	            InputStream ins = getServletContext().getResourceAsStream(fileName);
	            if (ins == null) {
	            	response.setStatus(HttpServletResponse.SC_NOT_FOUND);
	            } else {
	                DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
	                DocumentBuilder builder = factory.newDocumentBuilder();
	                Document document = builder.parse(ins);

	                NodeList itemList = document.getElementsByTagName("userDetail");	        		
	                for (int i = 0; i < itemList.getLength(); i++) {
	                    Element item = (Element) itemList.item(i);
	                    Element nameElement = (Element) item.getElementsByTagName("name").item(0);
	                    Element passElement = (Element) item.getElementsByTagName("pass").item(0);
	                     username1 = nameElement.getTextContent();
	                     password1 = passElement.getTextContent();	                   

	                }
	            }
	        } catch (Exception e) {
	        	 e.printStackTrace();
	        }
	       
	
	    
	    
	    
//	    ResultSet rs=null;
//	    PreparedStatement ps=null;
//	    String query="insert into register1 values(?,?,?,?)";		    
	    try{
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	        con=DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor",username1,password1);
	        PreparedStatement ps=con.prepareStatement("insert into sm_auth(name,email,username,password,dept_id) values(?,?,?,?,?)");
	    	ps.setString(1,name);
	    	ps.setString(2,email);
	    	ps.setString(3,username);
	    	ps.setString(4,password);
	    	ps.setString(5,dept_id);

	    	int i=ps.executeUpdate();
	    	rd=request.getRequestDispatcher("createUser.jsp");
	    	if(i>0){
	    		request.setAttribute("status", "success");		    		
	    	}
	    	else{
	    		request.setAttribute("status", "failed");		    			    	
	    	}
	    	rd.forward(request, response);
	    }catch(Exception e){
	    e.printStackTrace();		    	
	    }
	    finally {
	    	try {
	    	con.close();
	    	} catch(SQLException e){
	    		e.printStackTrace();
	    	}
	    }
	
		
		
		
	}

}
