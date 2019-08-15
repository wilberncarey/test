<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.util.Properties" %>
<%@ page import="java.util.Set" %>
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


<div class="ui-btn-right" style="position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">
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

				
				out.println("<li data-icon=\"home\"><a href=\"test.jsp\">HOME</a></li>");
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
				
				out.println("<li data-icon=\"home\"><a href=\"test.jsp\">HOME</a></li>");
			
				
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
  <h3 style="text-align: center">System Properties Viewer</h3>

  

   <%




out.print("</h><div class=\"inner\"><p>Filter by Property Name: &nbsp; <div style=\"width: 50%;\" ><input data-type=\"search\" type=\"text\" id=\"myInput\" onkeyup=\"myFunction()\" placeholder=\"Search for Property..\" title=\"Type in a name\"></div>");
out.print("<br/>");
out.print("<table id=\"myTable\" class=\"alt\"><thead><tr><th style=\"font-size: 2rem;\">Name</th><th style=\"font-size: 2rem;\">Value</th></tr></thead><tbody>");


Properties p = System.getProperties();

Set<String> keys = p.stringPropertyNames();
for (String key : keys)

	

out.println("<tr class=\"Properties-\"><td class=\"Properties-name\"><label for=\"" + key + "\">"  + key + "</label></td><td class=\"Properties-value\"><label for=\"" + key +  "\" name=\"\">" + p.getProperty(key) + "");
		



out.print("</tbody></table><br><br></div>");
out.print("<script>function myFunction() {var input, filter, table, tr, td, i;input = document.getElementById(\"myInput\");filter = input.value.toUpperCase();table = document.getElementById(\"myTable\");tr = table.getElementsByTagName(\"tr\");for (i = 0; i < tr.length; i++) {td = tr[i].getElementsByTagName(\"td\")[0];if (td) {if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {tr[i].style.display = \"\";} else {tr[i].style.display = \"none\";}}       }}</script>");






	

%>
   

  


</div>

 
 
</body>
</html>