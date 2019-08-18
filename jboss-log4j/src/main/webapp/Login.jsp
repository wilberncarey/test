
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" href="css/main1.css" />
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

<meta charset="UTF-8">
<title>Java Tools</title>

 <style>
  .panel-content {
    padding: 1em;
  }
  </style>
</head>
<body>


 
<div data-role="page" id="page1">
   
<div data-role="header">
 <h1 style="font-size: 48px">Java Tools</h1>
 <a class="logo" style="z-index: 9999;position:fixed"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>


<div class="ui-btn-right" style="z-index: 9999;position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">
    <a href="#defaultpanel" data-role="button" data-position="right" data-position-fixed="true" data-icon="bars">Menu</a>
    <a href="Logout.jsp"  data-role="button" data-position="right" data-position-fixed="true" data-icon="delete">Log Out</a>
    <a href="#popup-1" data-transition="fade" data-position-to="window" data-rel="popup" data-role="button" data-position="right" data-position-fixed="true" data-icon="info">Help</a> 
</div>

<div role="main" class="ui-content">

  
<div data-role="popup" id="popup-1" data-arrow="true" data-theme="b" class="ui-content" data-overlay-theme="b">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
	<p>This is a popup</p>
</div>

</div>

</div>
  
<div data-role="panel" id="defaultpanel" data-theme="b" data-position="right" data-position-fixed="true" data-display="overlay">
<div class="panel-content">
 	  <ul data-role="listview" id="listview-1">
 	  
<%
			//Output message
			if (System.getProperty("BatchUser") != null) {

				
				out.println("<li data-icon=\"home\"><a href=\"Home.jsp\">HOME</a></li>");
				out.println("<li><a href=\"LogView.jsp\">Log Viewer</a></li>");
				out.println("<li><a href=\"LogAdmin.jsp\">Log level Configurator</a></li>");
				out.println("<li><a href=\"PropsView.jsp\">Properties Viewer</a></li>");
				out.println("<li><a href=\"BatchAdmin.jsp\">Batch Administration</a></li>");
				out.println("<li><a href=\"CommTest.jsp\">Communication Tester</a></li>");
				out.println("<li><a href=\"ThreadView.jsp\">View Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">View Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
			
		
				
			}
			else
			{
				
				out.println("<li data-icon=\"home\"><a href=\"Home.jsp\">HOME</a></li>");
			
				
				out.println("<li><a href=\"LogView.jsp\">Log Viewer</a></li>");
				out.println("<li><a href=\"LogAdmin.jsp\">Log level Configurator</a></li>");
				out.println("<li><a href=\"PropsView.jsp\">Properties Viewer</a></li>");
				out.println("<li><a href=\"CommTest.jsp\">Communication Tester</a></li>");
				out.println("<li><a href=\"ThreadView.jsp\">View Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">View Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
			}
	
%>

 	  

	  </ul>
	<br/>
	<br/>
     
    </div>
   <!-- /content wrapper for padding -->

   
  </div>

  <br/>
  <h3 style="text-align: center">Home</h3>
						<br><br>
      <form method = "POST" action ="j_security_check">
         <table class="logintab" style="border: none!important;background-color: #f9f9f9!important;" >
            <tr style="border: none!important;background-color: #f9f9f9!important;">
               <td style="border: none!important;background-color: #f9f9f9!important;">User Name:</td>
               <td style="border: none!important;background-color: #f9f9f9!important;"><input type = "text" name="j_username"></td>
            </tr>
            <tr style="border: none !important;background-color: none;">
               <td style="border: none!important;background-color: none;">Password:</td>
               <td style="border: none!important;background-color: none;"><input type = "password" name="j_password"></td>
            <td style="border: none!important;background-color: none;">
         
       
       
       
     
       
       
       
           <div class="ui-input-btn ui-btn ui-icon-forward ui-btn-icon-left ui-mini ui-btn-inline ui-corner-all">
	   Submit
	   <input data-enhanced="true" type="submit" value="Login!" id="button-1"/>
   </div>
   </td>
   </tr>
   </table>
      </form>
<br>
<br>
    </div>
    

	

	</body>
</html>