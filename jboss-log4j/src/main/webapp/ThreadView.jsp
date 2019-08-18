<%@ page language="java" import="java.util.*,java.lang.Thread.*" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*"
%>
<%@page import="java.lang.management.ClassLoadingMXBean"%>
<%@page import="java.lang.management.RuntimeMXBean"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.lang.management.ThreadInfo"%>
<%@page import="java.lang.management.ManagementFactory"%>
<%@page import="java.lang.management.ThreadMXBean"%>
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
 
<%
int dataSize = 1024 * 1024;

%>


<div id="show" class="ui-btn-left" style="z-index: 9999;position:fixed" data-role="controlgroup" id="buttons-sys" data-type="horizontal">
<a href="#" data-role="button"  data-position="right" data-position-fixed="true" >
<%

Process p = null;
String[] array = {"/bin/bash", "-c", "top -b -n1 -w | grep 'KiB Mem'"};

ProcessBuilder pb= new ProcessBuilder(array);

p = pb.start();

OutputStream os = p.getOutputStream();
InputStream in = p.getInputStream();
BufferedReader dis = new BufferedReader(new InputStreamReader(in));
String disr = dis.readLine();



while ( disr != null ) {
	
        out.println("SYSTEM " + disr); 
        disr = dis.readLine(); 
}

%>
        
</a>

<br>
<a href="#" data-role="button"  data-position="right" data-position-fixed="true" >
<%

Process p1 = null;
String[] array1 = {"/bin/bash", "-c", "top -b -n1 -w | grep 'Cpu'"};

ProcessBuilder pb1= new ProcessBuilder(array1);

p1 = pb1.start();

OutputStream os1 = p1.getOutputStream();
InputStream in1 = p1.getInputStream();
BufferedReader dis1 = new BufferedReader(new InputStreamReader(in1));
String disr1 = dis1.readLine();



while ( disr1 != null ) {
	
        out.println("SYSTEM " +disr1); 
        disr1 = dis1.readLine(); 
}

%>
        
</a>

<br/>

<a href="#" data-role="button"  data-position="right" data-position-fixed="true" >FREE JVM MEM: <%=Runtime.getRuntime().freeMemory()/dataSize %>  MB </a>
<a href="#" data-role="button"   data-position="right" data-position-fixed="true" >MAX JVM MEM: <%=Runtime.getRuntime().maxMemory()/dataSize %>  MB </a>
<a href="#" data-role="button"   data-position="right" data-position-fixed="true" >USED JVM MEM: <%=(Runtime.getRuntime().totalMemory() - Runtime.getRuntime().freeMemory())/dataSize%>  MB </a>

<br/>

</div>

<div class="ui-btn-right" style="z-index: 9998;position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">

    <a href="#defaultpanel" data-role="button" data-position="right" data-position-fixed="true" data-icon="bars">Menu</a>
    <a href="Logout.jsp"  data-role="button" data-position="right" data-position-fixed="true" data-icon="delete">Log Out</a>
    <a href="#popup-1" data-transition="fade" data-position-to="window" data-rel="popup" data-role="button" data-position="right" data-position-fixed="true" data-icon="info">Help</a> 
<a href="#" data-role="button"   data-position="right" data-position-fixed="true"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
</div>







<div role="main" class="ui-content">

  
<div data-role="popup" id="popup-1" data-arrow="true" data-theme="b" class="ui-content" data-overlay-theme="b">
	<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-inline ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-left">Close</a>
	<p>This is a popup</p>
</div>

</div>

</div>



  
  
  
<div style="z-index: 9999;" data-role="panel" id="defaultpanel" data-theme="b" data-position="right" data-position-fixed="true" data-display="overlay">
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
  <br/>
  <h3 style="text-align: center">Thread Dump</h3>
      
      
<br><br>
<table>
<tr>
<td bgcolor="#E7E7EF" bordercolor="#000000" align="center" nowrap>
<font face="Verdana" size="+1">Thread Dumps&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font>
</td>
</tr>

<tr>
<td bgcolor="#E7E7EF" bordercolor="#000000">
<%


final String VERSION = "2.0";

ThreadMXBean txBean = ManagementFactory.getThreadMXBean();
RuntimeMXBean runBean = ManagementFactory.getRuntimeMXBean();
ClassLoadingMXBean classBean = ManagementFactory.getClassLoadingMXBean();
txBean.setThreadContentionMonitoringEnabled(true);
//out.print("<h1>JMX Thread Dump (v"+ VERSION + ")</h1><hr>");
out.print("<h2>JVM Summary</h2>");
out.print("&nbsp;&nbsp;&nbsp;<b>JVM bootclasspath: </b>" + runBean.getBootClassPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM classpath: </b>" + runBean.getClassPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM lib path: </b>" + runBean.getLibraryPath() + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM start time: </b>" + new java.util.Date(runBean.getStartTime()) + "<br>");
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM uptime: </b>" + (runBean.getUptime()/1000)/60 + " min<br>");
List<String> args = runBean.getInputArguments();
out.print("<br>&nbsp;&nbsp;&nbsp;<b>JVM arguments: </b><br>");
for (int i=0; i< args.size(); i++){
	out.print("<pre>      " + args.get(i) + "</pre>");
}



out.print("<hr><h2>Thread Summary</h2>&nbsp;&nbsp;&nbsp;<b>Peak Thread Count:</b>" + txBean.getPeakThreadCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Current Thread Count:</b>" + txBean.getThreadCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Deadlocked threads:</b> " + txBean.findDeadlockedThreads());
out.print("&nbsp;&nbsp;&nbsp;<b>Monitor deadlocked threads:</b> " + txBean.findMonitorDeadlockedThreads() + "<br>");

out.print("<hr><h2>Classloading Summary</h2>&nbsp;&nbsp;&nbsp;<b># of classes loaded now:</b>" + classBean.getLoadedClassCount());
out.print("&nbsp;&nbsp;&nbsp;<b>Total # of class loaded since start:</b>" + classBean.getTotalLoadedClassCount());
out.print("&nbsp;&nbsp;&nbsp;<b># of unloaded classes:</b> " + classBean.getUnloadedClassCount() + "<br><hr>");




out.print("<h2>Thread details</h2>");


%>
<%!
//private static ThreadMXBean thMxBean =
//ManagementFactory.getThreadMXBean();
//private static String getTaskName(long id, String name)
//{
  //  if (name == null) {
    //    return Long.toString(id);
   // }
   // return id + " (" + name + ")<br>";
//}
%>
<%
out.print("---------------------------START-----------------------------------------<br>");
out.print("Generating Thread-Dump At:" + (new java.util.Date()).toString() + "<BR>");
out.println("---------------------------------------------------------------------<br>");

//Map map = Thread.getAllStackTraces();

//Iterator itr = map.keySet().iterator();
//while (itr.hasNext()) {
//Thread t = (Thread)itr.next();
//StackTraceElement[] elem = (StackTraceElement[])map.get(t);
/////////////////////
Map<Thread, StackTraceElement[]> map = Thread.getAllStackTraces();

Iterator<Thread> itr = map.keySet().iterator();

while (itr.hasNext()) {
   Thread t = itr.next();
StackTraceElement[] elem = map.get(t);
out.print("\"" + t.getName() + "\"");
out.print(" Priority=" + t.getPriority());
out.print(" Thread Id=" + t.getId());
State s = t.getState();
String state = null;
String color = "000000";
String GREEN = "00FF00";
String RED = "FF0000";
String ORANGE = "FCA742";
switch(s) {
case NEW: state ="NEW"; color = GREEN; break;
case BLOCKED: state = "BLOCKED"; color = RED; break;
case RUNNABLE: state = "RUNNABLE"; color = GREEN; break;
case TERMINATED: state = "TERMINATED"; break;
case TIMED_WAITING: state = "TIME WAITING"; color = ORANGE; break;
case WAITING: state = "WAITING"; color = RED; break;
}
out.print("<font color=\"" + color + "\"> In State :</font>");
out.println(" " + state + "<BR>");
for (int i=0; i < elem.length; i++) {
out.println("  at ");
out.print(elem[i].toString());
out.println("<BR>");
}
out.println("--------------------------------------------------------------------------<br>");
}
out.print("----------------------------FINISH--------------------------------------<br>");
out.print("Generated Thread-Dump At:" + (new java.util.Date()).toString() + "<BR>");
out.println("---------------------------------------------------------------------<br>");
%>
</td>
</tr>
</table>
<br><br>

  </div>
	

	</body>
</html>