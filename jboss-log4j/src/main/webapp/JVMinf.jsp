<%@ page pageEncoding="UTF-8"  language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.apache.logging.log4j.LogManager, org.apache.logging.log4j.Level,
org.apache.logging.log4j.core.LoggerContext   , org.apache.logging.log4j.core.config.LoggerConfig,
                 java.util.Map"%>
<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*"
%>

<!DOCTYPE html>
<html style="background-color: black;">
<head>
    
<meta http-equiv="refresh" content="15" />
  <meta http-equiv="cache-control" content="no-cache, must-revalidate, post-check=0, pre-check=0" />
  <meta http-equiv="cache-control" content="max-age=0" />
  <meta http-equiv="expires" content="0" />
  <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT" />
  <meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" href="css/main1.css" />
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
#customers {
 
  border-collapse: collapse;
  width: 100%;
   background-color: transparent;
  color: lightgrey;
}

#customers td, #customers th {
  border: none;
  padding: 2px;
   background-color: transparent;
  color: lightgrey;
  font-size: 12px;
}
#customers tr:nth-child(even){background-color: transparent;}
#customers tr:nth-child(odd){background-color: transparent;}


#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: transparent;
  color: lightgrey;
}
</style>
     
<%
int dataSize = 1024 * 1024;



String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
long pid = Long.valueOf(jvmName.split("@")[0]);
//String pid = jvmName.split("@")[0];




%>
    <script type="text/javascript">
 
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['MAX MEM:', '<%=Runtime.getRuntime().maxMemory()/dataSize %>'],
          ['FREE JVM MEM: <%=Runtime.getRuntime().freeMemory()/dataSize %>  MB',     <%=Runtime.getRuntime().freeMemory()/dataSize %> ],
          ['USED JVM MEM: <%=(Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/dataSize%>  MB',  <%=(Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/dataSize%>],
          ['MAX MEM : <%=Runtime.getRuntime().maxMemory()/dataSize %>', 0],
             
        ]);

        var options = {
          title: 'JVM Heap Allocation   (MAX:<%=Runtime.getRuntime().maxMemory()/dataSize %> MB)',
          is3D: true,
         backgroundColor: { fill:'transparent' },
         titleTextStyle: {
             color: 'white'
         },
         legend: {
             textStyle: {
                 color: 'white'
             }
         }
         
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>




    





<meta charset="UTF-8">

 
    <style>
        html {
            height: 100%;
            overflow: hidden;
        }
        body {
            margin: 0;
            padding: 0;
            height: 100%;
        }

    </style>

</head>
<body >
 
  

 
<div data-role="page" id="page1" data-theme="b">
   







<div role="main" class="ui-content" data-theme="b">
<h2>JVM MEMORY</h2>
<div id="piechart_3d" style="width: 100%; height: 200px;"></div>





	

	




<br/>
<br/>




</div>

</div>


  


	</body>
</html>