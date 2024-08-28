<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Error page</title>
  <style>

    /*======================
    404 page
=======================*/


.page_404{ 
  
  padding:40px 0; background:#fff; font-family: 'Arvo', serif;
 
}

.page_404  img{ width:100%;}

.four_zero_four_bg{
 
 background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
    
    height: 400px;
    
  background-position: center;
    background-repeat: no-repeat;
 }
 
 
 .four_zero_four_bg h1{
 font-size:80px;
 background-position: center;
 display: flex;
 justify-content: center;
 }
 
  .four_zero_four_bg h3{
			 font-size:80px;

       margin-left: 45%;
			 }
			 
.link_404{			 
	color: #fff!important;
    padding: 10px 20px;
    background-position: center;
    background: #39ac31;    
    display: inline-block;
    margin-left: 48%;
  
  }
    


#textContent{
  display: flex;
  justify-content: center;
  align-items: center;
}

  </style>



</head>
<body>

  <section class="page_404">
    <div class="container">
      <div class="row">	
      <div class="col-sm-12 ">
      <div class="col-sm-10 col-sm-offset-1  text-center">
      <div class="four_zero_four_bg">
      <h1 class="text-center ">Error </h1>
      
      
      </div>
      
      <div class="contant_box_404">
       <div id="textContent">
          <h3 >
       		   Look like you're lost.......
          </h3>      
          <p >the page you are looking for is not found!</p>
    </div>
      
      <a href="index.jsp" class="link_404">Go to Home</a>
    </div>
      </div>
      </div>
      </div>
    </div>
  </section>
  
</body>
</html>
