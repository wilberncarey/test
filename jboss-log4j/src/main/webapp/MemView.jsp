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
    
  
<meta http-equiv=“Pragma” content=”no-cache”>
<meta http-equiv=“Expires” content=”-1″>
<meta http-equiv=“CACHE-CONTROL” content=”NO-CACHE”>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js?v=1.1"></script>
	
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css?v=1.1" />
	<link rel="stylesheet" href="css/main1.css?v=1.1" />
	<script src="http://code.jquery.com/jquery-2.1.3.min.js?v=1.1"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js?v=1.1"></script>
	<meta charset="UTF-8">

<title><%=request.getServerName()%> Java Tools</title>

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
  color: black;
}
#toptab td, #toptab th {
  border: none;
  padding: 2px;
   background-color: transparent;
  color: black;
  font-size: 12px;
}

  </style>


</head>
<body> 
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
	 
	    <%
int dataSize = 1024 * 1024;

String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
long pid = Long.valueOf(jvmName.split("@")[0]);

%>







 
<div data-role="page" id="page1">
   
<div data-role="header">
 <h1 style="font-size: 48px">Java Tools</h1>
 


<div id="show" class="ui-btn-left" style="z-index: 9999;position:fixed" data-role="controlgroup" id="buttons-sys" data-type="horizontal">

</div>

<div class="ui-btn-right" style="z-index: 9998;position:fixed" data-role="controlgroup" id="buttons-1" data-type="horizontal">

    <a href="#defaultpanel" data-role="button" data-position="right" data-position-fixed="true" data-icon="bars">Menu</a>
    <a href="Logout.jsp"  data-role="button" data-position="right" data-position-fixed="true" data-icon="delete">Log Out</a>
    <a href="sysinf.jsp" target="_blank" data-role="button"  data-position-to="window"  data-icon="heart">System Health</a>
    <a href="JVMinf.jsp" target="_blank" data-role="button"  data-position-to="window"  data-icon="heart">JVM Health</a>
    <a href="#" data-role="button"   data-position="right" data-position-fixed="true"><%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
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