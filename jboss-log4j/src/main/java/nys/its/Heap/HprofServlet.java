package nys.its.Heap;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/JTools/hprofservlet/*")
public class HprofServlet extends HttpServlet {
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
	long pid = Long.valueOf(jvmName.split("@")[0]);
	Process pUSR = null;
	  String[] arrayUSR = {"/bin/bash", "-c", "jcmd "+pid+" GC.heap_dump /apps/dumps/heap.$(date +%Y.%m.%d-%H.%M.%S).hprof"};
	  
	  ProcessBuilder pbUSR= new ProcessBuilder(arrayUSR);

	  pUSR = pbUSR.start();

	  //OutputStream osUSR = pUSR.getOutputStream();
	  InputStream inUSR = pUSR.getInputStream();
	  BufferedReader disUSR = new BufferedReader(new InputStreamReader(inUSR));
	  String disrUSR = disUSR.readLine();
	  
	  while ( disrUSR != null ) {
		 	
	
    response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
    response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
    response.getWriter().write(disrUSR);  
    
    disrUSR = disUSR.readLine();
}
}
}