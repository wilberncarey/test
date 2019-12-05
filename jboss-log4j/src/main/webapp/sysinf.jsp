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
    
    <%
int dataSize = 1024 * 1024;

String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
long pid = Long.valueOf(jvmName.split("@")[0]);

%>
    
 
  
   <script type="text/javascript">


   

   </script>  
    
    
    <style>

#toptab {
 padding-left: 12px;
  border-collapse: collapse;
  width: 90%;
   background-color: transparent;
  color: lightgrey;
}

#toptab td, #toptab th {
  border: none;
  padding: 2px;
   background-color: transparent;
  color: lightgrey;
  font-size: 12px;
}
#toptab tr:nth-child(even){background-color: transparent;}
#toptab tr:nth-child(odd){background-color: transparent;}


#toptab th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: transparent;
  color: lightgrey;
}
</style>
     

   

    <script type="text/javascript">
 
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['MAX CPU:', 'TOTAL'],
          ['USER CPU TIME', <%Process pUSR = null;
        	  String[] arrayUSR = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $2}'"};

        	  ProcessBuilder pbUSR= new ProcessBuilder(arrayUSR);

        	  pUSR = pbUSR.start();

        	  OutputStream osUSR = pUSR.getOutputStream();
        	  InputStream inUSR = pUSR.getInputStream();
        	  BufferedReader disUSR = new BufferedReader(new InputStreamReader(inUSR));
        	  String disrUSR = disUSR.readLine();

        	  while ( disrUSR != null ) {
        	  	
        	          out.println(disrUSR); 
        	          disrUSR = disUSR.readLine(); 
        	  }%>],

        	  ['SYSTEM CPU TIME', <%Process pSYS = null;
        	  String[] arraySYS = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $4}'"};

        	  ProcessBuilder pbSYS= new ProcessBuilder(arraySYS);

        	  pSYS = pbSYS.start();

        	  OutputStream osSYS = pSYS.getOutputStream();
        	  InputStream inSYS = pSYS.getInputStream();
        	  BufferedReader disSYS = new BufferedReader(new InputStreamReader(inSYS));
        	  String disrSYS = disSYS.readLine();

        	  while ( disrSYS != null ) {
        	  	
        	          out.println(disrSYS); 
        	          disrSYS = disSYS.readLine(); 
        	  }%>],

        	  ['USER NICE CPU TIME', <%Process pUNI = null;
        	  String[] arrayUNI = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $6}'"};

        	  ProcessBuilder pbUNI= new ProcessBuilder(arrayUNI);

        	  pUNI = pbUNI.start();

        	  OutputStream osUNI = pUNI.getOutputStream();
        	  InputStream inUNI = pUNI.getInputStream();
        	  BufferedReader disUNI = new BufferedReader(new InputStreamReader(inUNI));
        	  String disrUNI = disUNI.readLine();

        	  while ( disrUNI != null ) {
        	  	
        	          out.println(disrUNI); 
        	          disrUNI = disUNI.readLine(); 
        	  }%>],

        	  ['IDLE CPU TIME', <%Process pIDL = null;
        	  String[] arrayIDL = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $8}'"};

        	  ProcessBuilder pbIDL= new ProcessBuilder(arrayIDL);

        	  pIDL = pbIDL.start();

        	  OutputStream osIDL = pIDL.getOutputStream();
        	  InputStream inIDL = pIDL.getInputStream();
        	  BufferedReader disIDL = new BufferedReader(new InputStreamReader(inIDL));
        	  String disrIDL = disIDL.readLine();

        	  while ( disrIDL != null ) {
        	  	
        	          out.println(disrIDL); 
        	          disrIDL = disIDL.readLine(); 
        	  }%>],

        	  ['WAIT CPU TIME', <%Process pWAI = null;
        	  String[] arrayWAI = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $10}'"};

        	  ProcessBuilder pbWAI= new ProcessBuilder(arrayWAI);

        	  pWAI = pbWAI.start();

        	  OutputStream osWAI = pWAI.getOutputStream();
        	  InputStream inWAI = pWAI.getInputStream();
        	  BufferedReader disWAI = new BufferedReader(new InputStreamReader(inWAI));
        	  String disrWAI = disWAI.readLine();

        	  while ( disrWAI != null ) {
        	  	
        	          out.println(disrWAI); 
        	          disrWAI = disWAI.readLine(); 
        	  }%>],


        	  ['HARDWARE IRQ CPU TIME', <%Process pHIRQ = null;
        	  String[] arrayHIRQ = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $12}'"};

        	  ProcessBuilder pbHIRQ= new ProcessBuilder(arrayHIRQ);

        	  pHIRQ = pbHIRQ.start();

        	  OutputStream osHIRQ = pHIRQ.getOutputStream();
        	  InputStream inHIRQ = pHIRQ.getInputStream();
        	  BufferedReader disHIRQ = new BufferedReader(new InputStreamReader(inHIRQ));
        	  String disrHIRQ = disHIRQ.readLine();

        	  while ( disrHIRQ != null ) {
        	  	
        	          out.println(disrHIRQ); 
        	          disrHIRQ = disHIRQ.readLine(); 
        	  }%>],

        	  ['SOFTWARE IRQ CPU TIME', <%Process pSIRQ = null;
        	  String[] arraySIRQ = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $14}'"};

        	  ProcessBuilder pbSIRQ= new ProcessBuilder(arraySIRQ);

        	  pSIRQ = pbSIRQ.start();

        	  OutputStream osSIRQ = pSIRQ.getOutputStream();
        	  InputStream inSIRQ = pSIRQ.getInputStream();
        	  BufferedReader disSIRQ = new BufferedReader(new InputStreamReader(inSIRQ));
        	  String disrSIRQ = disSIRQ.readLine();

        	  while ( disrSIRQ != null ) {
        	  	
        	          out.println(disrSIRQ); 
        	          disrSIRQ = disSIRQ.readLine(); 
        	  }%>],
        	  ['STEAL TIME CPU %', <%Process pSTL = null;
        	  String[] arraySTL = {"/bin/bash", "-c", "top -b -n1 | grep 'Cpu'|head -2|tail -1|awk '{print $16}'"};

        	  ProcessBuilder pbSTL= new ProcessBuilder(arraySTL);

        	  pSTL = pbSTL.start();

        	  OutputStream osSTL = pSTL.getOutputStream();
        	  InputStream inSTL = pSTL.getInputStream();
        	  BufferedReader disSTL = new BufferedReader(new InputStreamReader(inSTL));
        	  String disrSTL = disSTL.readLine();

        	  while ( disrSTL != null ) {
        	  	
        	          out.println(disrSTL); 
        	          disrSTL = disSTL.readLine(); 
        	  }%>],

        	  
        	  
    	  
    	   ]);

        var options = {
          title: 'CPU USAGE %',
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

        var chart = new google.visualization.PieChart(document.getElementById('piechart_sys_cpu'));
        chart.draw(data, options);
      }
    </script>



<script id="memchar" type="text/javascript">
 
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['MAX MEM:', 'TOTAL'],
          

        	  ['FREE MEM', <%Process pFM = null;
        	  String[] arrayFM = {"/bin/bash", "-c", "top -b -n1 | grep 'KiB Mem'|head -2|tail -1|awk '{print $6}'"};

        	  ProcessBuilder pbFM= new ProcessBuilder(arrayFM);

        	  pFM = pbFM.start();

        	  OutputStream osFM = pFM.getOutputStream();
        	  InputStream inFM = pFM.getInputStream();
        	  BufferedReader disFM = new BufferedReader(new InputStreamReader(inFM));
        	  String disrFM = disFM.readLine();

        	  while ( disrFM != null ) {
        	  	
        	          out.println(disrFM); 
        	          disrFM = disFM.readLine(); 
        	  }%>],

        	  ['USED MEM', <%Process pUM = null;
        	  String[] arrayUM = {"/bin/bash", "-c", "top -b -n1 | grep 'KiB Mem'|head -2|tail -1|awk '{print $8}'"};

        	  ProcessBuilder pbUM= new ProcessBuilder(arrayUM);

        	  pUM = pbUM.start();

        	  OutputStream osUM = pUM.getOutputStream();
        	  InputStream inUM = pUM.getInputStream();
        	  BufferedReader disUM = new BufferedReader(new InputStreamReader(inUM));
        	  String disrUM = disUM.readLine();

        	  while ( disrUM != null ) {
        	  	
        	          out.println(disrUM); 
        	          disrUM = disUM.readLine(); 
        	  }%>],

        	  ['BUFF/CACHE MEM', <%Process pBC = null;
        	  String[] arrayBC = {"/bin/bash", "-c", "top -b -n1 | grep 'KiB Mem'|head -2|tail -1|awk '{print $10}'"};

        	  ProcessBuilder pbBC= new ProcessBuilder(arrayBC);

        	  pBC = pbBC.start();

        	  OutputStream osBC = pBC.getOutputStream();
        	  InputStream inBC = pBC.getInputStream();
        	  BufferedReader disBC = new BufferedReader(new InputStreamReader(inBC));
        	  String disrBC = disBC.readLine();

        	  while ( disrBC != null ) {
        	  	
        	          out.println(disrBC); 
        	          disrBC = disBC.readLine(); 
        	  }%>],

        	
        	 

        	  
        	  
    	  
    	   ]);

        var options = {
          title: 'MEM USAGE %',
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

        var chart = new google.visualization.PieChart(document.getElementById('piechart_sys_mem'));
        chart.draw(data, options);
      }
    </script>




<meta charset="UTF-8">

 
    <style>
        html {
            height: 100%;
           
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
<h2>SYSTEM RESOURCES</h2>

 

 
 
<div  id="piechart_sys_cpu">
</div>

<div id="piechart_sys_mem" >
</div>
<br/>


<%

   
Process prun = null;
String[] arrayrun = { "/bin/bash", "-c", "top -b -n1 |head -21|tail -15| awk -F \" \" '{print $1\" \"$2\" \"$3\" \"$4\" \"$5\" \"$6\" \"$7\" \"$8\" \"$9\" \"$10\" \"$11\" \"$12\" \"}'"};

ProcessBuilder pbrun= new ProcessBuilder(arrayrun);
pbrun.directory(new File(System.getProperty("BatchDir")));
prun = pbrun.start();

OutputStream osrun = prun.getOutputStream();
InputStream inrun = prun.getInputStream();
BufferedReader disrun = new BufferedReader(new InputStreamReader(inrun));
String disrrun = disrun.readLine();

out.println("<table style=\"width: 30%;word-wrap:break-word;\" id=\"toptab\" >");



while ( disrrun != null ) {
	out.println("<tr>");


	 out.println("<td>");
	
	disrrun = disrrun.replaceAll("\\s+","</td><td>");
	
	

        out.println(disrrun); 
    	out.println("</td>");
    	
    	
   	 out.println("</tr>");
   	 
   	disrrun = disrun.readLine();  
   

}
out.println("</table>");


%>




	</div>



</div>




  


	</body>
</html>