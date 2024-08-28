package com.dev.logDetails;

import java.io.IOException;


import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
import jakarta.servlet.http.HttpSession;



/**
 * Servlet implementation class LogoutServlet
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
	  

	 
	private static final long serialVersionUID = 1L;
	
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		

		HttpSession session =request.getSession();	
		
		RequestDispatcher rq=null;
		Connection con=null;	
		
		
		response.setContentType("text/html");
		String username="";
		String password="";
		String logInTime=(String)session.getAttribute("logInTime");
		String logOutTime =java.time.LocalTime.now().toString();
		String difference="";		
		
		try {
        String time1 =logInTime.substring(0,8);
        String time2 =logOutTime.substring(0,8);

        SimpleDateFormat simpleDateFormat= new SimpleDateFormat("HH:mm:ss");

		  
		    Date date1 = simpleDateFormat.parse(time1);
		    Date date2 = simpleDateFormat.parse(time2);		
		  
		    long differenceInMilliSeconds= Math.abs(date2.getTime() - date1.getTime());		
		    long differenceInHours = (differenceInMilliSeconds / (60 * 60 * 1000)) % 24;
		    long differenceInMinutes= (differenceInMilliSeconds / (60 * 1000)) % 60;
		    long differenceInSeconds = (differenceInMilliSeconds / 1000) % 60;
		
		   difference= differenceInHours + "h " + differenceInMinutes + "m "+ differenceInSeconds + "s ";
		
		}catch(Exception e) {
			e.printStackTrace();
		}	
		
		
		
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
	                     username = nameElement.getTextContent();
	                     password = passElement.getTextContent();
	                     //System.out.print(username+" "+password);
	                }
	            }            
	                  
			
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false",username, password);			
		
			PreparedStatement ps=con.prepareStatement("update sm_login_logs set logOutTime =?, duration=? where logInTime=?");	
			
			ps.setString(1, logOutTime);
			ps.setString(2, difference);
			ps.setString(3, logInTime);			
			int cnt=ps.executeUpdate();		
			
			
			ps.close();
			con.close();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		
			response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
			response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
	        response.setDateHeader("Expires", 0);
	        response.setDateHeader("Expires", -1);
		session.invalidate();
		response.sendRedirect("index.jsp");
	}


}
