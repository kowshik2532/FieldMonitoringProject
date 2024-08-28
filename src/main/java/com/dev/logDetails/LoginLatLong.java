package com.dev.logDetails;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;


@WebServlet("/latLongLonginServlet")
public class LoginLatLong extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname=request.getParameter("username");
		String upwd=request.getParameter("password");		
		HttpSession session =request.getSession();
		RequestDispatcher rq=null;
		Connection con=null;
		
		
		
		response.setContentType("text/html");
		String username="";
		String password="";
		
		
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
		
			PreparedStatement ps=con.prepareStatement("select * from sm_auth where username=? and password=?");
			ps.setString(1, uname);
			ps.setString(2, upwd);	
			
		
			ResultSet rs=ps.executeQuery();	
			
			if(rs.next()) {	
				
				String date=java.time.LocalDate.now().toString();   
				String time =java.time.LocalTime.now().toString();
				
				session.setAttribute("date",date);
				session.setAttribute("logInTime",time);
				
				session.setAttribute("name", rs.getString("name"));	
				session.setAttribute("dept", rs.getString("dept_id"));
				rq=request.getRequestDispatcher("latLongProjectSelect.jsp");
			}
		
			else {
				request.setAttribute("status", "failed");
				rq=request.getRequestDispatcher("latLonglogin.jsp");
			}
			
			
			
			
			rq.forward(request, response);
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

	}

}
