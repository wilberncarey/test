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
  <h3 style="text-align: center">Log Level Configuration</h3>
      
<br><br>

	
<%

    String[] logLevels = { "debug", "info", "warn", "error", "fatal", "off" };

    String targetOperation   = (String)request.getParameter("operation");
    String targetLogger      = (String)request.getParameter("logger");
    String targetLogLevel    = (String)request.getParameter("newLogLevel");

    LoggerContext logContext = (LoggerContext) LogManager.getContext(false);
    Map<String, LoggerConfig> map = logContext.getConfiguration()
            .getLoggers();

    if ("root".equals(targetLogger)) { targetLogger=""; }

    for (LoggerConfig logger : map.values()) {
        if("changeLogLevel".equals(targetOperation) && targetLogger.equals(logger.getName()))
        {
            logger.setLevel(Level.getLevel(targetLogLevel.toUpperCase()));
            logContext.updateLoggers();
        }
    }

%>
<div class="content">
   
    <table>
        <tr>
            <th width="25%">Logger</th>
            <th width="15%">Parent Logger</th>
            <th width="10%">Effective Level</th>
            <th width="50%">Change Log Level To</th>
        </tr>


        <% for(String k : map.keySet()) {%>
        <%
            String loggerName = k;
            LoggerConfig logger = map.get(k);
            if (k.length()==0) { loggerName="root"; }
        %>
        <tr>
            <td><%= loggerName %></td>
            <td><%= map.get(k).getParent() %></td>
            <td><%= map.get(k).getLevel() %></td>
            <td>
                <%
                    for(int cnt=0; cnt<logLevels.length; cnt++)
                    {
                        StringBuffer args = new StringBuffer();
                        args.append("operation=changeLogLevel&logger=" + loggerName);
                        args.append("&newLogLevel=" + logLevels[cnt]);
                        args.append("&template=templates/blanktemplate.jsp");

                        if(logger.getLevel() == Level.getLevel(logLevels[cnt].toUpperCase()) )
                        {
                %><a class="ui-btn ui-mini ui-btn-inline 
            ui-corner-all ui-btn-active">
                <%=logLevels[cnt].toUpperCase()%></a>
               
                <%
                }                  else                  {
                %>

                <a class="ui-btn ui-mini ui-btn-inline 
            ui-corner-all ui-btn-a"  href='LogAdmin.jsp?<%=args.toString()%>'><%=logLevels[cnt]%></a>
                <%
                        }
                    }
                %>
            </td>


        </tr>
        <%}%>


    </table>
    </div>
    <br/>
    <br/>
  <script type="text/javascript">
        $(document).on('pageinit', function () {
            $('#pop1').on('click', function () {
                $('#popupOffline').popup({ tolerance: 70, transition: 'pop' }).popup('open');
                return false;
            });
        });
    </script>
    
     <script type="text/javascript">
 function updateDiv()
 { 
     $( "#popupOffline2" ).load(window.location.href + " #popupOffline2" );
 }
 </script>
 
  <script type="text/javascript">
 function updateDiv()
 { 
     $( "#pop2" ).load(window.location.href + " #pop2" );
 }
 </script>

</div>
	

	</body>
</html>