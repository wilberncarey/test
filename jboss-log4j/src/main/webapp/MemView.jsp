<%@ page pageEncoding="UTF-8"  language="java" contentType="text/html;charset=UTF-8"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.util.List"%>
<%@page import="java.lang.management.MemoryPoolMXBean"%>
<%@page import="java.lang.management.MemoryUsage"%>
<%@page import="java.lang.management.MemoryMXBean"%>
<%@page import="java.io.*"%>
<%@ page import="java.util.*,java.io.*"%>



<!DOCTYPE html>
<html>
<head>
    
   
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
	 
	    <%
int dataSize = 1024 * 1024;

String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
long pid = Long.valueOf(jvmName.split("@")[0]);

%>

 
<script type="text/javascript">
[c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20] = [<%Process pCHARc = null;
 String[] arrayCHARc = {"/bin/bash", "-c", "jmap -histo "+pid+"|head -23|tail -20 |awk -v qu=\"'\" 'BEGIN {ORS=\",\"}; {print qu $4 qu}'"};
 ProcessBuilder pbCHARc= new ProcessBuilder(arrayCHARc);
 pCHARc = pbCHARc.start();
 OutputStream osCHARc = pCHARc.getOutputStream();
 InputStream inCHARc = pCHARc.getInputStream();
 BufferedReader disCHARc = new BufferedReader(new InputStreamReader(inCHARc));
 String disrCHARc = disCHARc.readLine();
 while ( disrCHARc != null ) {out.println(disrCHARc+"];");disrCHARc=disCHARc.readLine();}%>
 
[d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20] = [<%Process pCHARd = null;
	  String[] arrayCHARd = {"/bin/bash", "-c", "jmap -histo "+pid+"|head -23|tail -20 |awk 'BEGIN {ORS=\",\"}; {print $3}'"};
	  ProcessBuilder pbCHARd= new ProcessBuilder(arrayCHARd);
	  pCHARd = pbCHARd.start();
	  OutputStream osCHARd = pCHARd.getOutputStream();
	  InputStream inCHARd = pCHARd.getInputStream();
	  BufferedReader disCHARd = new BufferedReader(new InputStreamReader(inCHARd));
	  String disrCHARd = disCHARd.readLine();
	  while ( disrCHARd != null ) {out.println(disrCHARd+"];");disrCHARd=disCHARd.readLine();}%>



      function drawChart() {
    	  var data = google.visualization.arrayToDataTable([
          ['Classes', 'Bytes'],
          [c1, d1],
          [c2, d2],
          [c3, d3],
          [c4, d4],
          [c5, d5],
          [c6, d6],
          [c7, d7],
          [c8, d8],
          [c9, d9],
          [c10, d10],
          [c11, d11],
          [c12, d12],
          [c13, d13],
          [c14, d14],
          [c15, d15],
          [c16, d16],
          [c17, d17],
          [c18, d18],
          [c19, d19],
          [c20, d20],
         
        ]);

    	  var options = {titleTextStyle: {fontSize: '20',}, 
    			  title: 'Class Usage',
    	    	  backgroundColor: { fill:'transparent'},
    	    	  legend: 'none',
    	    	  
    	  
                  chart: { 
                          title: 'Class Usage',
                          subtitle: 'Space used by class',
                          titleTextStyle: {color: 'Blue'},
                          
                  },
                   chartArea: {
                	 title: 'Class Name',
                     //top: 28,
                     //height: '300' 
                     width: '90%',
                	          },
                	          vAxis: { gridlines: { count: '4' }, 
              	        	  	textStyle: {color: 'Blue', size: '10'},
              	        	  	},
                  hAxis: {
        	           
        	          slantedText: true,
        	           textStyle: {color: 'Blue', size: '10'},
        	  
      
  }
                	        
  
//I tried with slantedText: true here but while my graph was rendering, labels were not rotated!
                  };              
var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
chart.draw(data, options); 
          }

      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
	  
  </script>
  
  
  <script type="text/javascript">
[b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20] = [<%Process pCHARb = null;
 String[] arrayCHARb = {"/bin/bash", "-c", "jmap -histo:live "+pid+"|head -23|tail -20 |awk -v qu=\"'\" 'BEGIN {ORS=\",\"}; {print qu $4 qu}'"};
 ProcessBuilder pbCHARb= new ProcessBuilder(arrayCHARb);
 pCHARb = pbCHARb.start();
 OutputStream osCHARb = pCHARb.getOutputStream();
 InputStream inCHARb = pCHARb.getInputStream();
 BufferedReader disCHARb = new BufferedReader(new InputStreamReader(inCHARb));
 String disrCHARb = disCHARb.readLine();
 while ( disrCHARb != null ) {out.println(disrCHARb+"];");disrCHARb=disCHARb.readLine();}%>
 
[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20] = [<%Process pCHARa = null;
	  String[] arrayCHARa = {"/bin/bash", "-c", "jmap -histo:live "+pid+"|head -23|tail -20 |awk 'BEGIN {ORS=\",\"}; {print $3}'"};
	  ProcessBuilder pbCHARa= new ProcessBuilder(arrayCHARa);
	  pCHARa = pbCHARa.start();
	  OutputStream osCHARa = pCHARa.getOutputStream();
	  InputStream inCHARa = pCHARa.getInputStream();
	  BufferedReader disCHARa = new BufferedReader(new InputStreamReader(inCHARa));
	  String disrCHARa = disCHARa.readLine();
	  while ( disrCHARa != null ) {out.println(disrCHARa+"];");disrCHARa=disCHARa.readLine();}%>



      function drawChart() {
    	  var data = google.visualization.arrayToDataTable([
          ['Classes', 'Bytes'],
          [b1, a1],
          [b2, a2],
          [b3, a3],
          [b4, a4],
          [b5, a5],
          [b6, a6],
          [b7, a7],
          [b8, a8],
          [b9, a9],
          [b10, a10],
          [b11, a11],
          [b12, a12],
          [b13, a13],
          [b14, a14],
          [b15, a15],
          [b16, a16],
          [b17, a17],
          [b18, a18],
          [b19, a19],
          [b20, a20],
         
        ]);

    	  var options = {titleTextStyle: {fontSize: '20',}, 
    			  title: 'Class Usage Live',
    	    	  backgroundColor: { fill:'transparent'},
    	    	  legend: 'none',
    	    	  
    	  
                  chart: { 
                          title: 'Class Usage',
                          subtitle: 'Space used by class',
                          titleTextStyle: {color: 'Blue'},
                          
                  },
                   chartArea: {
                	 title: 'Class Name',
                     //top: 28,
                     //height: '80%',
                   width: '90%',
                	          },
                	          vAxis: { gridlines: { count: '4' }, 
              	        	  	textStyle: {color: 'Blue', size: '10'},
              	        	  	},
                  hAxis: {
        	           
        	          slantedText: true,
        	           textStyle: {color: 'Blue', size: '10'},
        	  
      
  }
                	        
  
//I tried with slantedText: true here but while my graph was rendering, labels were not rotated!
                  };              
var chart = new google.visualization.ColumnChart(document.getElementById('chart_div_live'));
chart.draw(data, options); 
          }

      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
	  
  </script>

<meta charset="UTF-8">
<title>Java Tools</title>

 <style>
  .panel-content {
    padding: 1em;
  }
 iframe {

    margin: 0px;
    padding: 0px;
    background: black;
    border: 0px;
    display: block;

}
 

#toptab {
 padding-left: 12px;
  border-collapse: collapse;
  border: none!important;
  width: 90%;
   background-color: transparent;
  color: lightgrey;
}
#toptab td, #toptab th {
  border: none;
  padding: 2px;
   background-color: transparent;
  color: black;
  font-size: 12px;
}

  </style>
<script>
// Preventing whiteflash in loading iframes.     
(function () {
    var div = document.createElement('div'),
        ref = document.getElementsByTagName('base')[0] || 
              document.getElementsByTagName('script')[0];
    div.innerHTML = '&shy;<style> iframe { visibility: hidden; } </style>';
    ref.parentNode.insertBefore(div, ref);
    window.onload = function() {
        div.parentNode.removeChild(div);
    }
})();
</script>
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
             color: 'blue'
         },
         legend: {
             textStyle: {
                 color: 'blue'
             }
         }
         
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>


<body >


 
<div data-role="page" id="page1">
   
<div data-role="header">
 <h1 style="font-size: 48px">Java Tools</h1>
 


<div id="show" class="ui-btn-left" style="z-index: 9999;position:fixed" data-role="controlgroup" id="buttons-sys" data-type="horizontal">

</div>

<div class="ui-btn-right" style="z-index: 9998;position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">

    <a href="#defaultpanel" data-role="button" data-position="right" data-position-fixed="true" data-icon="bars">Menu</a>
    <a href="Logout.jsp"  data-role="button" data-position="right" data-position-fixed="true" data-icon="delete">Log Out</a>
    <a href="#popupLogA" data-role="button" data-rel="popup" data-position-to="window"  data-icon="heart">System Health</a>
    <a href="#popupLogB" data-role="button" data-rel="popup" data-position-to="window"  data-icon="heart">JVM Health</a>
    <a href="#" data-role="button"   data-position="right" data-position-fixed="true"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
</div>


<div data-history="false" data-role="popup" id="popupLogA" data-arrow="true" data-theme="b"  data-overlay-theme="b">
<a href="#"  data-rel="back" data-role="button" data-theme="a" class="ui-btn ui-btn-b ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<iframe id="sysframe" src="sysinf.jsp"  width="800" height="450"></iframe></div>

<div data-history="false" data-role="popup" id="popupLogB" data-arrow="true" data-theme="b"  data-overlay-theme="b">
<a href="#"  data-rel="back" data-role="button" data-theme="a" class="ui-btn ui-btn-b ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<iframe id="JVMframe" src="JVMinf.jsp"  width="600" height="450"></iframe>
</div>




<div  role="main" class="ui-content">

  

</div>






</div>



  
  
  
<div style="font-size: 18px!important;z-index: 9999;" data-role="panel" id="defaultpanel" data-theme="b" data-position="right" data-position-fixed="true" data-display="overlay">
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
				out.println("<li><a href=\"ThreadView.jsp\">JVM Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">JVM Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
				out.println("<li><a href=\"SysView.jsp\">System Resources</a></li>");
				
				out.println("<li><a href=\"DumpGen.jsp\">Dump Generator</a></li>");
			
		
				
			}
			else
			{
				
				out.println("<li data-icon=\"home\"><a href=\"Home.jsp\">HOME</a></li>");
			
				
				out.println("<li><a href=\"LogView.jsp\">Log Viewer</a></li>");
				out.println("<li><a href=\"LogAdmin.jsp\">Log level Configurator</a></li>");
				out.println("<li><a href=\"PropsView.jsp\">Properties Viewer</a></li>");
				out.println("<li><a href=\"CommTest.jsp\">Communication Tester</a></li>");
				out.println("<li><a href=\"ThreadView.jsp\">JVM Thread Dump</a></li>");
				out.println("<li><a href=\"MemView.jsp\">JVM Memory Usage</a></li>");
				out.println("<li><a href=\"JDBCView.jsp\">JDBC Tester</a></li>");
				out.println("<li><a href=\"SysView.jsp\">System Resources</a></li>");
				
				out.println("<li><a href=\"DumpGen.jsp\">Dump Generator</a></li>");
			}
	
%>

 	  

	  </ul>
	<br/>
	<br/>
     
    </div>
   <!-- /content wrapper for padding -->

   
  </div>

  <br/>
  <br/>
  <h3 style="text-align: center">JVM Memory Usage</h3>

  <div style="padding-left: 20px;" class="content">     
      



<fieldset id="toptab" style="width: 100%;border: none;" class="ui-grid-a">
<table>
<tr>
<td style="width: 70%;">
<div  id="piechart_3d" ></div>
</td>
<td>
<div class="ui-block-d">

<%

   
Process pjheap = null;
String[] arrayjheap = { "/bin/bash", "-c", "sudo jmap -heap "+pid+"|head -21|tail -13|awk '{print $1\" \"$2\" \"$3\" \"$4\" \"$5\" \"$6\" \"$7}'"};

ProcessBuilder pbjheap= new ProcessBuilder(arrayjheap);
pbjheap.directory(new File(System.getProperty("BatchDir")));
pjheap = pbjheap.start();

OutputStream osjheap = pjheap.getOutputStream();
InputStream injheap = pjheap.getInputStream();
BufferedReader disjheap = new BufferedReader(new InputStreamReader(injheap));
String disrjheap = disjheap.readLine();

out.println("<table style=\"word-wrap:break-word;\" id=\"toptab\" >");



while ( disrjheap != null ) {
	out.println("<tr>");


	 out.println("<td>");
	
	disrjheap = disrjheap.replaceAll("\\s+","</td><td>");
	
	

        out.println(disrjheap); 
    	out.println("</td>");
    	
    	
   	 out.println("</tr>");
   	 
   	disrjheap = disjheap.readLine();  
   

}
out.println("</table>");


%>
</div>
</td>
</tr>
</table>
</fieldset>

<fieldset style="width: 100%;" class="ui-grid-b">
<%!
int dataSize = 1024 * 1024;


    public String dumpUsage (MemoryUsage usage) {
        StringBuffer buf = new StringBuffer();
        buf.append ("<table style=\"font-size: 12px;\">");
        buf.append ("<tr>");
        buf.append ("<td>Committed</td>");
        buf.append ("<td>" + usage.getCommitted()/dataSize + " MB</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Init</td>");
        buf.append ("<td>" + usage.getInit()/dataSize + " MB</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Max</td>");
        buf.append ("<td>" + usage.getMax()/dataSize + " MB</td>");
        buf.append ("</tr>");
        buf.append ("<tr>");
        buf.append ("<td>Used</td>");
        buf.append ("<td>" + usage.getUsed()/dataSize + " MB</td>");
        buf.append ("</tr>");
        buf.append ("</table>");
        return buf.toString();
    }
%>
<%
    MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
    //out.println ("<center><b><u>JVM MEMORY DETAILS</u></b></center><hr>");
    out.println ("<br/><center>[<b>Heap usage</b>]</center><br>");
    out.println (dumpUsage (memBean.getHeapMemoryUsage()));
    out.println ("<center>[<b>Non Heap usage</b>]</center><br>");
    out.println (dumpUsage (memBean.getNonHeapMemoryUsage()));
    out.println ("Objects pending finalization:" + memBean.getObjectPendingFinalizationCount());
   
    
    List<MemoryPoolMXBean> beans = ManagementFactory.getMemoryPoolMXBeans();
%>
<hr>
<fieldset id="toptab" style="width: 100%;border: none;" class="ui-grid-b">
<table>
<tr style="background: rgba(255, 255, 255, 0.075)">
<td>
<br/>
<h3 ><b>JVM Histogram All</b></h3>
</td>
</tr>
<tr>
<td>
<div id="chart_div" style="float: center;width: 700px; height: 350px"></div>
</td>
<td>
<div  class="ui-block-c">


<%

   
Process pjfin = null;
String[] arrayjfin = { "/bin/bash", "-c", "jmap -histo "+pid+"|head -13|tail -12|awk '!(NR==2) {print $1\" \"$2\" \"$3\" \"$4}'"};

ProcessBuilder pbjfin= new ProcessBuilder(arrayjfin);
pbjfin.directory(new File(System.getProperty("BatchDir")));
pjfin = pbjfin.start();

OutputStream osjfin = pjfin.getOutputStream();
InputStream injfin = pjfin.getInputStream();
BufferedReader disjfin = new BufferedReader(new InputStreamReader(injfin));
String disrjfin = disjfin.readLine();

out.println("<table style=\"float: right;word-wrap:break-word;\" id=\"toptab\" >");



while ( disrjfin != null ) {
	out.println("<tr>");


	 out.println("<td>");
	
	disrjfin = disrjfin.replaceAll("\\s+","</td><td>");
	
	

        out.println(disrjfin); 
    	out.println("</td>");
    	
    	
   	 out.println("</tr>");
   	 
   	disrjfin = disjfin.readLine();  
   

}
out.println("</table>");


%>


</div>


</td>
</tr>
</table>
</fieldset>

<hr style="padding-left: -10px!important;">

<fieldset id="toptab" style="width: 100%;border: none;" class="ui-grid-c">
<table>
<tr style="background: rgba(255, 255, 255, 0.075)">

<td >

<br/>
<br/>
<h3 ><b>JVM Histogram Live</b></h3>
</td>
</tr>
<tr>
<td>

<div  id="chart_div_live" style="float: center;width: 700px; height: 350px"></div>
</td>
<td>
<div  class="ui-block-c">



<%

   
Process pJHISL = null;
String[] arrayJHISL = { "/bin/bash", "-c", "jmap -histo:live "+pid+"|head -13|tail -12|awk '!(NR==2) {print $1\" \"$2\" \"$3\" \"$4}'"};

ProcessBuilder pbJHISL= new ProcessBuilder(arrayJHISL);
pbJHISL.directory(new File(System.getProperty("BatchDir")));
pJHISL = pbJHISL.start();

OutputStream osJHISL = pJHISL.getOutputStream();
InputStream inJHISL = pJHISL.getInputStream();
BufferedReader disJHISL = new BufferedReader(new InputStreamReader(inJHISL));
String disrJHISL = disJHISL.readLine();

out.println("<table style=\"float: right;word-wrap:break-word;\" id=\"toptab\" >");



while ( disrJHISL != null ) {
	out.println("<tr>");


	 out.println("<td>");
	
	disrJHISL = disrJHISL.replaceAll("\\s+","</td><td>");
	
	

        out.println(disrJHISL); 
    	out.println("</td>");
    	
    	
   	 out.println("</tr>");
   	 
   	disrJHISL = disJHISL.readLine();  
   

}
out.println("</table>");


%>


</div>
</td>
</tr>
</table>
</fieldset>



<hr>
<% 
out.println ("<br><br>[<b>POOLS</b>]<br/><br/>");
    for (MemoryPoolMXBean memPoolBean:beans) {
        out.println ("<br><center>[<b>" + memPoolBean.getName() + "</b>]</center><br>");
        out.println (memPoolBean.getType() + "<br>");
        //out.println ("CollectionUsageThreshold:" + memPoolBean.getCollectionUsageThreshold() + "<br>");
        //out.println ("CollectionUsageThresholdCount:" + memPoolBean.getCollectionUsageThresholdCount() + "<br>");
        //out.println ("UsageThreshold:" + memPoolBean.getUsageThreshold() + "<br>");
        //out.println ("UsageThresholdCount:" + memPoolBean.getUsageThresholdCount() + "<br>");
        MemoryUsage usage = memPoolBean.getPeakUsage();
        out.println ("Peak Usage<br>");
        out.println (dumpUsage (usage));
        usage = memPoolBean.getUsage();
        out.println ("Current Usage<br>");
        out.println (dumpUsage (usage));
    }
%>
<br><br>

  </fieldset>
  
  </div>

</div>
	

	</body>
</html>