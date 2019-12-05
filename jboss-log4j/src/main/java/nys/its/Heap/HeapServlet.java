package nys.its.Heap;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/heapservlet/*")
public class HeapServlet extends HttpServlet {
/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String jvmName = java.lang.management.ManagementFactory.getRuntimeMXBean().getName();
	long pid = Long.valueOf(jvmName.split("@")[0]);
	Process pHEAP = null;
	  String[] arrayHEAP = {"/bin/bash", "-c", "jcmd "+pid+" GC.heap_dump /apps/dumps/heap.$(date +%Y.%m.%d-%H.%M.%S).hprof"};
	  
	  ProcessBuilder pbHEAP= new ProcessBuilder(arrayHEAP);

	  pHEAP = pbHEAP.start();

	  //OutputStream osHEAP = pHEAP.getOutputStream();
	  InputStream inHEAP = pHEAP.getInputStream();
	  BufferedReader disHEAP = new BufferedReader(new InputStreamReader(inHEAP));
	  String disrHEAP = disHEAP.readLine();
	  
	  while ( disrHEAP != null ) {
		 	
	
    response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
    response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
    response.getWriter().write(disrHEAP);  
    
    disrHEAP = disHEAP.readLine();
}
}
}