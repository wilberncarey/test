/*
 * JBoss, Home of Professional Open Source
 * Copyright 2015, Red Hat, Inc. and/or its affiliates, and individual
 * contributors by the @authors tag. See the copyright.txt in the
 * distribution for a full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.as.quickstarts.log4jdemo;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.StringJoiner;

import javax.enterprise.context.SessionScoped;
import javax.inject.Named;


/**
 * <p>
 * Simplistic class to initialize logger and push value passed by user.
 * </p>
 * <p>
 * The {@link #text} variable is populated with content which is logged in {@link #log()} method.
 * </p>
 *
 * @author baranowb
 *
 */
@SessionScoped
@Named
public class Log4jDemo implements Serializable {

    /** Default value included to remove warning. **/
    private static final long serialVersionUID = 1L;

   

    private String text;

    public String getText() {
        return text;
    }

    public String setText(String text) {
        this.text = text;
   


        
    ProcessBuilder pb = new ProcessBuilder("bash", "-c", "echo hello");
	

	
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
