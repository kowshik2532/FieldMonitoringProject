package com.dev.logDetails;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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


@WebServlet("/qualityDataAdd")
public class QualityDataAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;       

	
	 

		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			PrintWriter out=response.getWriter();

		    String Gender_sampling=request.getParameter("Gender_sampling");
		    String Caste_sampling=request.getParameter("Caste_sampling");
		    String Detailing_issue=request.getParameter("Detailing_issue");
		    String FrName=request.getParameter("frName");
		    String Inputdate=request.getParameter("inputDate");
		    String Project_Name=request.getParameter("project");
		    //System.out.println("reached");
		    RequestDispatcher rd=null;
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
		   
		         
		            //text.replace("\n", "");
		            
		       //  Gender_sampling=Gender_sampling.replace("\n", "");
			
				Class.forName("com.mysql.cj.jdbc.Driver");
				con=DriverManager.getConnection("jdbc:mysql://localhost:3306/survey_monitor?useSSL=false",username, password);
		        PreparedStatement ps=con.prepareStatement("insert into quality(Inputdate,Project_Name,FrName,Gender_sampling,Caste_sampling,Detailing_issue) values(?,?,?,?,?,?)");
		        ps.setString(1,Inputdate);
		        ps.setString(2,Project_Name);
		        ps.setString(3,FrName);
		        ps.setString(4,Gender_sampling);
		    	ps.setString(5,Caste_sampling);
		    	ps.setString(6,Detailing_issue);



		    	int i=ps.executeUpdate();
		    	rd=request.getRequestDispatcher("qualityFrSelect.jsp");		    	
		    	if(i>0){
		    		request.setAttribute("status", "success");
		    		request.setAttribute("dataAdded", "success");
		    		
		    	   
		    	   
		    	}
		    	else{
		    		request.setAttribute("status", "failed");
		    		request.setAttribute("dataAdded", "failed");
		    		
		    	}
		    	rd.forward(request, response);

		    } catch(Exception e){
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
