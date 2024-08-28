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
 * Servlet implementation class Condition
 */
@WebServlet("/condition")
public class Condition extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String pn=req.getParameter("project");
		String a=req.getParameter("a");
		String b=req.getParameter("b");
		RequestDispatcher rq=null;
		res.setContentType("text/html");
		String username="";
		String password="";
		
		
	       try {
	           String fileName = "/config/config.xml";
	            InputStream ins = getServletContext().getResourceAsStream(fileName);
	            if (ins == null) {
	                res.setStatus(HttpServletResponse.SC_NOT_FOUND);
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

	                }
	            }
	        } catch (Exception e) {
	        	 e.printStackTrace();
	        }
		
		
		
		try {
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306/new?useSSL=false",username, password);
			
			//System.out.println("connected succesfully ");
			PreparedStatement ps= con.prepareStatement("update conditionTable set lessThan =?, greaterThan=? where project_name=?");
			ps.setString(1, a);
			ps.setString(2, b);
			ps.setString(3, pn);
			int count=ps.executeUpdate();
			
			if(count>0 ) {
				//System.out.println("update successfully");
				req.setAttribute("status", "success");
				req.setAttribute("show", "visible");
				rq=req.getRequestDispatcher("condi.jsp");
			}
			else {
				//System.out.println("updataion failed");
				req.setAttribute("status", "Failed");
				req.setAttribute("show", "hidden");
				rq=req.getRequestDispatcher("condi.jsp");
			}
			rq.forward(req, res);
			
			
			
			ps.close();
			con.close();
			
			
			
		} catch (ClassNotFoundException | SQLException e) {			
			e.printStackTrace();
		}		
		
	}

}

