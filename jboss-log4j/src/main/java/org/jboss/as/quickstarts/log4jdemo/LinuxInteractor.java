package org.jboss.as.quickstarts.log4jdemo;
import java.io.BufferedReader;

import java.io.InputStreamReader;

import java.util.StringJoiner;

import javax.annotation.ManagedBean;
import javax.enterprise.context.RequestScoped;

import java.io.Serializable;

@ManagedBean  
@RequestScoped  

public class LinuxInteractor implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static String executeCommand(String command, boolean waitForResponse) {
		 
		
		 
		ProcessBuilder pb = new ProcessBuilder("bash", "-c", command);
	

	
		    Process p;
		    String result = "";
		    try {
		        p = pb.start();
		        final BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));

		        StringJoiner sj = new StringJoiner(System.getProperty("line.separator"));
		        reader.lines().iterator().forEachRemaining(sj::add);
		        result = sj.toString();

		        p.waitFor();
		        p.destroy();
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return result;
		}
	
		}


