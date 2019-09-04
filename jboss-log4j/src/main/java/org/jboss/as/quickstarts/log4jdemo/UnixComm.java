package org.jboss.as.quickstarts.log4jdemo;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import java.util.StringJoiner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UnixComm")
public class UnixComm extends HttpServlet {
private static final long serialVersionUID = 1L;

public UnixComm() {
  super();
}

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  doPost(request, response);
}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
  String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
  long pid = Long.valueOf(jvmName.split("@")[0]);
 
  
  Process prun = null;
  String[] arrayrun = { "/bin/bash", "-c", "jmap -histo "+pid+"|head -23|tail -20"};

  ProcessBuilder pbrun= new ProcessBuilder(arrayrun);
  pbrun.directory(new File(System.getProperty("BatchDir")));
  prun = pbrun.start();

  
  InputStream inrun = prun.getInputStream();
  BufferedReader disrun = new BufferedReader(new InputStreamReader(inrun));
  String disrrun = disrun.readLine();

  response.getWriter().print("<table id=\"customers\" >");
  response.getWriter().print("<tr>");
 response.getWriter().print("<th></th>");
 response.getWriter().print("<th>RANK</th>");
 response.getWriter().print("<th>INSTANCES</th>");
 response.getWriter().print("<th>BYTES</th>");
 response.getWriter().print("<th>CLASS NAME</th>");
 response.getWriter().print("</tr>");
  while ( disrrun != null ) {
	  response.getWriter().print("<tr>");


  	response.getWriter().print("<td >");
  	
  	disrrun = disrrun.replaceAll("\\s+","</td><td>");
  	
  	

         response.getWriter().print(disrrun); 
         response.getWriter().print("</tr>");
      	
      	
     	response.getWriter().print("</td>");
     	 
     	disrrun = disrun.readLine();  
     

  }
 response.getWriter().print("</table>");


 request.setAttribute("message", disrrun);
 request.getRequestDispatcher("/Home.jsp").forward(request, response);

 
}
}