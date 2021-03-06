<%@page import="java.util.*,
                java.net.*,
                java.text.*,
                java.util.zip.*,
                java.io.*"
%>
<%!
    
	private static final boolean READ_ONLY = false;
	private static final boolean ALLOW_UPLOAD = false;
	private static final boolean RESTRICT_BROWSING = true;
    private static final boolean RESTRICT_WHITELIST = true;
	private static final String RESTRICT_PATH = "/apps/dumps";
    
	private static final int EDITFIELD_COLS = 85;
	
	private static final int EDITFIELD_ROWS = 30;
	
	private static final boolean USE_POPUP = true;
	
	private static final boolean USE_DIR_PREVIEW = true;
	private static final int DIR_PREVIEW_NUMBER = 10;
	
	private static final String CSS_NAME = "main1.css";

	private static final int COMPRESSION_LEVEL = 1;

	private static final String[] FORBIDDEN_DRIVES = {"/"};

	private static final long MAX_PROCESS_RUNNING_TIME = 30 * 1000; //30 seconds

	private static final String SAVE_AS_ZIP = "Download selected files as (z)ip";
	
	private static final String DELETE_FILES = "(Del)ete selected files";

	
	
	
	
	
	private static String tempdir = "/tmp";
	private static String VERSION_NR = "1.3";
	private static DateFormat dateFormat = DateFormat.getDateTimeInstance();
	public class UplInfo {
		public long totalSize;
		public long currSize;
		public long starttime;
		public boolean aborted;
		public UplInfo() {
			totalSize = 0l;
			currSize = 0l;
			starttime = System.currentTimeMillis();
			aborted = false;
		}
		public UplInfo(int size) {
			totalSize = size;
			currSize = 0;
			starttime = System.currentTimeMillis();
			aborted = false;
		}
		public String getUprate() {
			long time = System.currentTimeMillis() - starttime;
			if (time != 0) {
				long uprate = currSize * 1000 / time;
				return convertFileSize(uprate) + "/s";
			}
			else return "n/a";
		}
		public int getPercent() {
			if (totalSize == 0) return 0;
			else return (int) (currSize * 100 / totalSize);
		}
		public String getTimeElapsed() {
			long time = (System.currentTimeMillis() - starttime) / 1000l;
			if (time - 60l >= 0){
				if (time % 60 >=10) return time / 60 + ":" + (time % 60) + "m";
				else return time / 60 + ":0" + (time % 60) + "m";
			}
			else return time<10 ? "0" + time + "s": time + "s";
		}
		public String getTimeEstimated() {
			if (currSize == 0) return "n/a";
			long time = System.currentTimeMillis() - starttime;
			time = totalSize * time / currSize;
			time /= 1000l;
			if (time - 60l >= 0){
				if (time % 60 >=10) return time / 60 + ":" + (time % 60) + "m";
				else return time / 60 + ":0" + (time % 60) + "m";
			}
			else return time<10 ? "0" + time + "s": time + "s";
		}
	}
	public class FileInfo {
		public String name = null, clientFileName = null, fileContentType = null;
		private byte[] fileContents = null;
		public File file = null;
		public StringBuffer sb = new StringBuffer(100);
		public void setFileContents(byte[] aByteArray) {
			fileContents = new byte[aByteArray.length];
			System.arraycopy(aByteArray, 0, fileContents, 0, aByteArray.length);
		}
	}
	public static class UploadMonitor {
		static Hashtable uploadTable = new Hashtable();
		static void set(String fName, UplInfo info) {
			uploadTable.put(fName, info);
		}
		static void remove(String fName) {
			uploadTable.remove(fName);
		}
		static UplInfo getInfo(String fName) {
			UplInfo info = (UplInfo) uploadTable.get(fName);
			return info;
		}
	}
	// A Class with methods used to process a ServletInputStream
	public class HttpMultiPartParser {
		//private final String lineSeparator = System.getProperty("line.separator", "\n");
		private final int ONE_MB = 1024 * 1;
		public Hashtable processData(ServletInputStream is, String boundary, String saveInDir,
				int clength) throws IllegalArgumentException, IOException {
			if (is == null) throw new IllegalArgumentException("InputStream");
			if (boundary == null || boundary.trim().length() < 1) throw new IllegalArgumentException(
					"\"" + boundary + "\" is an illegal boundary indicator");
			boundary = "--" + boundary;
			StringTokenizer stLine = null, stFields = null;
			FileInfo fileInfo = null;
			Hashtable dataTable = new Hashtable(5);
			String line = null, field = null, paramName = null;
			boolean saveFiles = (saveInDir != null && saveInDir.trim().length() > 0);
			boolean isFile = false;
			if (saveFiles) { // Create the required directory (including parent dirs)
				File f = new File(saveInDir);
				f.mkdirs();
			}
			line = getLine(is);
			if (line == null || !line.startsWith(boundary)) throw new IOException(
					"Boundary not found; boundary = " + boundary + ", line = " + line);
			while (line != null) {
				if (line == null || !line.startsWith(boundary)) return dataTable;
				line = getLine(is);
				if (line == null) return dataTable;
				stLine = new StringTokenizer(line, ";\r\n");
				if (stLine.countTokens() < 2) throw new IllegalArgumentException(
						"Bad data in second line");
				line = stLine.nextToken().toLowerCase();
				if (line.indexOf("form-data") < 0) throw new IllegalArgumentException(
						"Bad data in second line");
				stFields = new StringTokenizer(stLine.nextToken(), "=\"");
				if (stFields.countTokens() < 2) throw new IllegalArgumentException(
						"Bad data in second line");
				fileInfo = new FileInfo();
				stFields.nextToken();
				paramName = stFields.nextToken();
				isFile = false;
				if (stLine.hasMoreTokens()) {
					field = stLine.nextToken();
					stFields = new StringTokenizer(field, "=\"");
					if (stFields.countTokens() > 1) {
						if (stFields.nextToken().trim().equalsIgnoreCase("filename")) {
							fileInfo.name = paramName;
							String value = stFields.nextToken();
							if (value != null && value.trim().length() > 0) {
								fileInfo.clientFileName = value;
								isFile = true;
							}
							else {
								line = getLine(is); // Skip "Content-Type:" line
								line = getLine(is); // Skip blank line
								line = getLine(is); // Skip blank line
								line = getLine(is); // Position to boundary line
								continue;
							}
						}
					}
					else if (field.toLowerCase().indexOf("filename") >= 0) {
						line = getLine(is); // Skip "Content-Type:" line
						line = getLine(is); // Skip blank line
						line = getLine(is); // Skip blank line
						line = getLine(is); // Position to boundary line
						continue;
					}
				}
				boolean skipBlankLine = true;
				if (isFile) {
					line = getLine(is);
					if (line == null) return dataTable;
					if (line.trim().length() < 1) skipBlankLine = false;
					else {
						stLine = new StringTokenizer(line, ": ");
						if (stLine.countTokens() < 2) throw new IllegalArgumentException(
								"Bad data in third line");
						stLine.nextToken(); // Content-Type
						fileInfo.fileContentType = stLine.nextToken();
					}
				}
				if (skipBlankLine) {
					line = getLine(is);
					if (line == null) return dataTable;
				}
				if (!isFile) {
					line = getLine(is);
					if (line == null) return dataTable;
					dataTable.put(paramName, line);
					// If parameter is dir, change saveInDir to dir
					if (paramName.equals("dir")) saveInDir = line;
					line = getLine(is);
					continue;
				}
				try {
					UplInfo uplInfo = new UplInfo(clength);
					UploadMonitor.set(fileInfo.clientFileName, uplInfo);
					OutputStream os = null;
					String path = null;
					if (saveFiles) os = new FileOutputStream(path = getFileName(saveInDir,
							fileInfo.clientFileName));
					else os = new ByteArrayOutputStream(ONE_MB);
					boolean readingContent = true;
					byte previousLine[] = new byte[2 * ONE_MB];
					byte temp[] = null;
					byte currentLine[] = new byte[2 * ONE_MB];
					int read, read3;
					if ((read = is.readLine(previousLine, 0, previousLine.length)) == -1) {
						line = null;
						break;
					}
					while (readingContent) {
						if ((read3 = is.readLine(currentLine, 0, currentLine.length)) == -1) {
							line = null;
							uplInfo.aborted = true;
							break;
						}
						if (compareBoundary(boundary, currentLine)) {
							os.write(previousLine, 0, read - 2);
							line = new String(currentLine, 0, read3);
							break;
						}
						else {
							os.write(previousLine, 0, read);
							uplInfo.currSize += read;
							temp = currentLine;
							currentLine = previousLine;
							previousLine = temp;
							read = read3;
						}//end else
					}//end while
					os.flush();
					os.close();
					if (!saveFiles) {
						ByteArrayOutputStream baos = (ByteArrayOutputStream) os;
						fileInfo.setFileContents(baos.toByteArray());
					}
					else fileInfo.file = new File(path);
					dataTable.put(paramName, fileInfo);
					uplInfo.currSize = uplInfo.totalSize;
				}//end try
				catch (IOException e) {
					throw e;
				}
			}
			return dataTable;
		}
		/**
		 * Compares boundary string to byte array
		 */
		private boolean compareBoundary(String boundary, byte ba[]) {
			if (boundary == null || ba == null) return false;
			for (int i = 0; i < boundary.length(); i++)
				if ((byte) boundary.charAt(i) != ba[i]) return false;
			return true;
		}
		/** Convenience method to read HTTP header lines */
		private synchronized String getLine(ServletInputStream sis) throws IOException {
			byte b[] = new byte[1024];
			int read = sis.readLine(b, 0, b.length), index;
			String line = null;
			if (read != -1) {
				line = new String(b, 0, read);
				if ((index = line.indexOf('\n')) >= 0) line = line.substring(0, index - 1);
			}
			return line;
		}
		public String getFileName(String dir, String fileName) throws IllegalArgumentException {
			String path = null;
			if (dir == null || fileName == null) throw new IllegalArgumentException(
					"dir or fileName is null");
			int index = fileName.lastIndexOf('/');
			String name = null;
			if (index >= 0) name = fileName.substring(index + 1);
			else name = fileName;
			index = name.lastIndexOf('\\');
			if (index >= 0) fileName = name.substring(index + 1);
			path = dir + File.separator + fileName;
			if (File.separatorChar == '/') return path.replace('\\', File.separatorChar);
			else return path.replace('/', File.separatorChar);
		}
	} //End of class HttpMultiPartParser
	/**
	 * This class is a comparator to sort the filenames and dirs
	 */
	class FileComp implements Comparator {
		int mode;
		int sign;
		FileComp() {
			this.mode = 1;
			this.sign = 1;
		}
		/**
		 * @param mode sort by 1=Filename, 2=Size, 3=Date, 4=Type
		 * The default sorting method is by Name
		 * Negative mode means descending sort
		 */
		FileComp(int mode) {
			if (mode < 0) {
				this.mode = -mode;
				sign = -1;
			}
			else {
				this.mode = mode;
				this.sign = 1;
			}
		}
		public int compare(Object o1, Object o2) {
			File f1 = (File) o1;
			File f2 = (File) o2;
			if (f1.isDirectory()) {
				if (f2.isDirectory()) {
					switch (mode) {
					//Filename or Type
					case 1:
					case 4:
						return sign
								* f1.getAbsolutePath().toUpperCase().compareTo(
										f2.getAbsolutePath().toUpperCase());
					//Filesize
					case 2:
						return sign * (new Long(f1.length()).compareTo(new Long(f2.length())));
					//Date
					case 3:
						return sign
								* (new Long(f1.lastModified())
										.compareTo(new Long(f2.lastModified())));
					default:
						return 1;
					}
				}
				else return -1;
			}
			else if (f2.isDirectory()) return 1;
			else {
				switch (mode) {
				case 1:
					return sign
							* f1.getAbsolutePath().toUpperCase().compareTo(
									f2.getAbsolutePath().toUpperCase());
				case 2:
					return sign * (new Long(f1.length()).compareTo(new Long(f2.length())));
				case 3:
					return sign
							* (new Long(f1.lastModified()).compareTo(new Long(f2.lastModified())));
				case 4: { // Sort by extension
					int tempIndexf1 = f1.getAbsolutePath().lastIndexOf('.');
					int tempIndexf2 = f2.getAbsolutePath().lastIndexOf('.');
					if ((tempIndexf1 == -1) && (tempIndexf2 == -1)) { // Neither have an extension
						return sign
								* f1.getAbsolutePath().toUpperCase().compareTo(
										f2.getAbsolutePath().toUpperCase());
					}
					// f1 has no extension
					else if (tempIndexf1 == -1) return -sign;
					// f2 has no extension
					else if (tempIndexf2 == -1) return sign;
					// Both have an extension
					else {
						String tempEndf1 = f1.getAbsolutePath().toUpperCase()
								.substring(tempIndexf1);
						String tempEndf2 = f2.getAbsolutePath().toUpperCase()
								.substring(tempIndexf2);
						return sign * tempEndf1.compareTo(tempEndf2);
					}
				}
				default:
					return 1;
				}
			}
		}
	}
	/**
	 * Wrapperclass to wrap an OutputStream around a Writer
	 */
	class Writer2Stream extends OutputStream {
		Writer out;
		Writer2Stream(Writer w) {
			super();
			out = w;
		}
		public void write(int i) throws IOException {
			out.write(i);
		}
		public void write(byte[] b) throws IOException {
			for (int i = 0; i < b.length; i++) {
				int n = b[i];
				//Convert byte to ubyte
				n = ((n >>> 4) & 0xF) * 16 + (n & 0xF);
				out.write(n);
			}
		}
		public void write(byte[] b, int off, int len) throws IOException {
			for (int i = off; i < off + len; i++) {
				int n = b[i];
				n = ((n >>> 4) & 0xF) * 16 + (n & 0xF);
				out.write(n);
			}
		}
	} //End of class Writer2Stream
	static Vector expandFileList(String[] files, boolean inclDirs) {
		Vector v = new Vector();
		if (files == null) return v;
		for (int i = 0; i < files.length; i++)
			v.add(new File(URLDecoder.decode(files[i])));
		for (int i = 0; i < v.size(); i++) {
			File f = (File) v.get(i);
			if (f.isDirectory()) {
				File[] fs = f.listFiles();
				for (int n = 0; n < fs.length; n++)
					v.add(fs[n]);
				if (!inclDirs) {
					v.remove(i);
					i--;
				}
			}
		}
		return v;
	}
	/**
	 * Method to build an absolute path
	 * @param dir the root dir
	 * @param name the name of the new directory
	 * @return if name is an absolute directory, returns name, else returns dir+name
	 */
	static String getDir(String dir, String name) {
		if (!dir.endsWith(File.separator)) dir = dir + File.separator;
		File mv = new File(name);
		String new_dir = null;
		if (!mv.isAbsolute()) {
			new_dir = dir + name;
		}
		else new_dir = name;
		return new_dir;
	}
	/**
	 * This Method converts a byte size in a kbytes or Mbytes size, depending on the size
	 *     @param size The size in bytes
	 *     @return String with size and unit
	 */
	static String convertFileSize(long size) {
		int divisor = 1;
		String unit = "bytes";
		if (size >= 1024 * 1024) {
			divisor = 1024 * 1024;
			unit = "MB";
		}
		else if (size >= 1024) {
			divisor = 1024;
			unit = "KB";
		}
		if (divisor == 1) return size / divisor + " " + unit;
		String aftercomma = "" + 100 * (size % divisor) / divisor;
		if (aftercomma.length() == 1) aftercomma = "0" + aftercomma;
		return size / divisor + "." + aftercomma + " " + unit;
	}
	/**
	 * Copies all data from in to out
	 * 	@param in the input stream
	 *	@param out the output stream
	 *	@param buffer copy buffer
	 */
	static void copyStreams(InputStream in, OutputStream out, byte[] buffer) throws IOException {
		copyStreamsWithoutClose(in, out, buffer);
		in.close();
		out.close();
	}
	/**
	 * Copies all data from in to out
	 * 	@param in the input stream
	 *	@param out the output stream
	 *	@param buffer copy buffer
	 */
	static void copyStreamsWithoutClose(InputStream in, OutputStream out, byte[] buffer)
			throws IOException {
		int b;
		while ((b = in.read(buffer)) != -1)
			out.write(buffer, 0, b);
	}
	/**
	 * Returns the Mime Type of the file, depending on the extension of the filename
	 */
	static String getMimeType(String fName) {
		fName = fName.toLowerCase();
		if (fName.endsWith(".jpg") || fName.endsWith(".jpeg") || fName.endsWith(".jpe")) return "image/jpeg";
		else if (fName.endsWith(".gif")) return "image/gif";
		else if (fName.endsWith(".pdf")) return "application/pdf";
		else if (fName.endsWith(".htm") || fName.endsWith(".html") || fName.endsWith(".shtml")) return "text/html";
		else if (fName.endsWith(".avi")) return "video/x-msvideo";
		else if (fName.endsWith(".mov") || fName.endsWith(".qt")) return "video/quicktime";
		else if (fName.endsWith(".mpg") || fName.endsWith(".mpeg") || fName.endsWith(".mpe")) return "video/mpeg";
		else if (fName.endsWith(".zip")) return "application/zip";
		else if (fName.endsWith(".tiff") || fName.endsWith(".tif")) return "image/tiff";
		else if (fName.endsWith(".rtf")) return "application/rtf";
		else if (fName.endsWith(".mid") || fName.endsWith(".midi")) return "audio/x-midi";
		else if (fName.endsWith(".xl") || fName.endsWith(".xls") || fName.endsWith(".xlv")
				|| fName.endsWith(".xla") || fName.endsWith(".xlb") || fName.endsWith(".xlt")
				|| fName.endsWith(".xlm") || fName.endsWith(".xlk")) return "application/excel";
		else if (fName.endsWith(".doc") || fName.endsWith(".dot")) return "application/msword";
		else if (fName.endsWith(".png")) return "image/png";
		else if (fName.endsWith(".xml")) return "text/xml";
		else if (fName.endsWith(".svg")) return "image/svg+xml";
		else if (fName.endsWith(".mp3")) return "audio/mp3";
		else if (fName.endsWith(".ogg")) return "audio/ogg";
		else return "text/plain";
	}
	/**
	 * Converts some important chars (int) to the corresponding html string
	 */
	static String conv2Html(int i) {
		if (i == '&') return "&amp;";
		else if (i == '<') return "&lt;";
		else if (i == '>') return "&gt;";
		else if (i == '"') return "&quot;";
		else return "" + (char) i;
	}
	/**
	 * Converts a normal string to a html conform string
	 */
	static String conv2Html(String st) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < st.length(); i++) {
			buf.append(conv2Html(st.charAt(i)));
		}
		return buf.toString();
	}
	/**
	 * Starts a native process on the server
	 * 	@param command the command to start the process
	 *	@param dir the dir in which the process starts
	 */
	static String startProcess(String command, String dir) throws IOException {
		StringBuffer ret = new StringBuffer();
		String[] comm = new String[3];

		comm[2] = command;
		long start = System.currentTimeMillis();
		try {
			//Start process
			Process ls_proc = Runtime.getRuntime().exec(comm, null, new File(dir));
			//Get input and error streams
			BufferedInputStream ls_in = new BufferedInputStream(ls_proc.getInputStream());
			BufferedInputStream ls_err = new BufferedInputStream(ls_proc.getErrorStream());
			boolean end = false;
			while (!end) {
				int c = 0;
				while ((ls_err.available() > 0) && (++c <= 1000)) {
					ret.append(conv2Html(ls_err.read()));
				}
				c = 0;
				while ((ls_in.available() > 0) && (++c <= 1000)) {
					ret.append(conv2Html(ls_in.read()));
				}
				try {
					ls_proc.exitValue();
					//if the process has not finished, an exception is thrown
					//else
					while (ls_err.available() > 0)
						ret.append(conv2Html(ls_err.read()));
					while (ls_in.available() > 0)
						ret.append(conv2Html(ls_in.read()));
					end = true;
				}
				catch (IllegalThreadStateException ex) {
					//Process is running
				}
				//The process is not allowed to run longer than given time.
				if (System.currentTimeMillis() - start > MAX_PROCESS_RUNNING_TIME) {
					ls_proc.destroy();
					end = true;
					ret.append("!!!! Process has timed out, destroyed !!!!!");
				}
				try {
					Thread.sleep(50);
				}
				catch (InterruptedException ie) {}
			}
		}
		catch (IOException e) {
			ret.append("Error: " + e);
		}
		return ret.toString();
	}
	/**
	 * Converts a dir string to a linked dir string
	 * 	@param dir the directory string (e.g. /usr/local/httpd)
	 *	@param browserLink web-path to Browser.jsp
	 */
	static String dir2linkdir(String dir, String browserLink, int sortMode) {
		File f = new File(dir);
		StringBuffer buf = new StringBuffer();
		while (f.getParentFile() != null) {
			if (f.canRead()) {
				String encPath = URLEncoder.encode(f.getAbsolutePath());
				buf.insert(0, "<a href=\"" + browserLink + "?sort=" + sortMode + "&amp;dir="
						+ encPath + "\">" + conv2Html(f.getName()) + File.separator + "</a>");
			}
			else buf.insert(0, conv2Html(f.getName()) + File.separator);
			f = f.getParentFile();
		}
		if (f.canRead()) {
			String encPath = URLEncoder.encode(f.getAbsolutePath());
			buf.insert(0, "<a href=\"" + browserLink + "?sort=" + sortMode + "&amp;dir=" + encPath
					+ "\">" + conv2Html(f.getAbsolutePath()) + "</a>");
		}
		else buf.insert(0, f.getAbsolutePath());
		return buf.toString();
	}
	/**
	 *	Returns true if the given filename tends towards a packed file
	 */
	static boolean isPacked(String name, boolean gz) {
		return (name.toLowerCase().endsWith(".zip") || name.toLowerCase().endsWith(".jar")
				|| (gz && name.toLowerCase().endsWith(".gz")) || name.toLowerCase()
				.endsWith(".war"));
	}
	/**
	 *	If RESTRICT_BROWSING = true this method checks, whether the path is allowed or not
	 */
	static boolean isAllowed(File path, boolean write) throws IOException{
		if (READ_ONLY && write) return false;
		if (RESTRICT_BROWSING) {
            StringTokenizer stk = new StringTokenizer(RESTRICT_PATH, ";");
            while (stk.hasMoreTokens()){
			    if (path!=null && path.getCanonicalPath().startsWith(stk.nextToken()))
                    return RESTRICT_WHITELIST;
            }
            return !RESTRICT_WHITELIST;
		}
		else return true;
	}
	//---------------------------------------------------------------------------------------------------------------
	
	%>
<%
		//Get the current browsing directory
		request.setAttribute("dir", request.getParameter("dir"));
		// The browser_name variable is used to keep track of the URI
		// of the jsp file itself.  It is used in all link-backs.
		final String browser_name = request.getRequestURI();
		final String FOL_IMG = "";
		boolean nohtml = false;
		boolean dir_view = true;
		//Get Javascript
		if (request.getParameter("Javascript") != null) {
			dir_view = false;
			nohtml = true;
			//Tell the browser that it should cache the javascript
			response.setHeader("Cache-Control", "public");
			Date now = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss z", Locale.US);
			response.setHeader("Expires", sdf.format(new Date(now.getTime() + 1000 * 60 * 60 * 24*2)));
			response.setHeader("Content-Type", "text/javascript");
			%>
<%// This section contains the Javascript used for interface elements %>
			var check = false;
	<%// Disables the checkbox feature %>
			function dis(){check = true;}
			var DOM = 0, MS = 0, OP = 0, b = 0;
	<%// Determine the browser type %>
			function CheckBrowser(){
				if (b == 0){
					if (window.opera) OP = 1;
					// Moz or Netscape
					if(document.getElementById) DOM = 1;
					// Micro$oft
					if(document.all && !OP) MS = 1;
					b = 1;
				}
			}
	<%// Allows the whole row to be selected %>
			function selrow (element, i){
				var erst;
				CheckBrowser();
				if ((OP==1)||(MS==1)) erst = element.firstChild.firstChild;
				else if (DOM==1) erst = element.firstChild.nextSibling.firstChild;
				<%// MouseIn %>
				if (i==0){
					if (erst.checked == true) element.className='mousechecked';
					else element.className='mousein';
				}
				<%// MouseOut %>
				else if (i==1){
					if (erst.checked == true) element.className='checked';
					else element.className='mouseout';
				}
				<%    // MouseClick %>
				else if ((i==2)&&(!check)){
					if (erst.checked==true) element.className='mousein';
					else element.className='mousechecked';
					erst.click();
				}
				else check=false;
			}
			<%// Filter files and dirs in FileList%>
			function filter (begriff){
				var suche = begriff.value.toLowerCase();
				var table = document.getElementById("filetable");
				var ele;
				for (var r = 1; r < table.rows.length; r++){
					ele = table.rows[r].cells[1].innerHTML.replace(/<[^>]+>/g,"");
					if (ele.toLowerCase().indexOf(suche)>=0 )
						table.rows[r].style.display = '';
					else table.rows[r].style.display = 'none';
		      	}
			}
			<%//(De)select all checkboxes%>	
			function AllFiles(){
				for(var x=0;x < document.FileList.elements.length;x++){
					var y = document.FileList.elements[x];
					var ytr = y.parentNode.parentNode;
					var check = document.FileList.selall.checked;
					if(y.name == 'selfile' && ytr.style.display != 'none'){
						if (y.disabled != true){
							y.checked = check;
							if (y.checked == true) ytr.className = 'checked';
							else ytr.className = 'mouseout';
						}
					}
				}
			}
			
			function shortKeyHandler(_event){
				if (!_event) _event = window.event;
				if (_event.which) {
					keycode = _event.which;
				} else if (_event.keyCode) {
					keycode = _event.keyCode;
				}
				var t = document.getElementById("text_Dir");
				//z
				if (keycode == 122){
					document.getElementById("but_Zip").click();
				}
				//r, F2
				else if (keycode == 113 || keycode == 114){
					var path = prompt("Please enter new filename", "");
					if (path == null) return;
					t.value = path;
					document.getElementById("but_Ren").click();
				}
				//c
				else if (keycode == 99){
					var path = prompt("Please enter filename", "");
					if (path == null) return;
					t.value = path;
					document.getElementById("but_NFi").click();
				}
				//d
				else if (keycode == 100){
					var path = prompt("Please enter directory name", "");
					if (path == null) return;
					t.value = path;
					document.getElementById("but_NDi").click();
				}
				//m
				else if (keycode == 109){
					var path = prompt("Please enter move destination", "");
					if (path == null) return;
					t.value = path;
					document.getElementById("but_Mov").click();
				}
				//y
				else if (keycode == 121){
					var path = prompt("Please enter copy destination", "");
					if (path == null) return;
					t.value = path;
					document.getElementById("but_Cop").click();
				}
				//l
				else if (keycode == 108){
					document.getElementById("but_Lau").click();
				}
				//Del
				else if (keycode == 46){
					document.getElementById("but_Del").click();
				}
			}
			function popUp(URL){
				fname = document.getElementsByName("myFile")[0].value;
				if (fname != "")
					window.open(URL+"?first&uplMonitor="+encodeURIComponent(fname),"","width=400,height=150,resizable=yes,depend=yes")
			}
			
			document.onkeypress = shortKeyHandler;
<% 		}
		// View file
		else if (request.getParameter("file") != null) {
            File f = new File(request.getParameter("file"));
            if (!isAllowed(f, false)) {
                request.setAttribute("dir", f.getParent());
                request.setAttribute("error", "You are not allowed to access "+f.getAbsolutePath());
            }
            else if (f.exists() && f.canRead()) {
                if (isPacked(f.getName(), false)) {
                    //If zipFile, do nothing here
                }
                else{
                    String mimeType = getMimeType(f.getName());
                    response.setContentType(mimeType);
                    if (mimeType.equals("text/plain")) response.setHeader(
                            "Content-Disposition", "inline;filename=\"temp.txt\"");
                    else response.setHeader("Content-Disposition", "inline;filename=\""
                            + f.getName() + "\"");
                    BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
                    byte buffer[] = new byte[8 * 1024];
                    out.clearBuffer();
                    OutputStream out_s = new Writer2Stream(out);
                    copyStreamsWithoutClose(fileInput, out_s, buffer);
                    fileInput.close();
                    out_s.flush();
                    nohtml = true;
                    dir_view = false;
                }
            }
            else {
                request.setAttribute("dir", f.getParent());
                request.setAttribute("error", "File " + f.getAbsolutePath()
                        + " does not exist or is not readable on the server");
            }
		}
		// Download selected files as zip file
		else if ((request.getParameter("Submit") != null)
				&& (request.getParameter("Submit").equals(SAVE_AS_ZIP))) {
			Vector v = expandFileList(request.getParameterValues("selfile"), false);
			//Check if all files in vector are allowed
			String notAllowedFile = null;
			for (int i = 0;i < v.size(); i++){
				File f = (File) v.get(i);
				if (!isAllowed(f, false)){
					notAllowedFile = f.getAbsolutePath();
					break;
				}
			}
			if (notAllowedFile != null){
				request.setAttribute("error", "You are not allowed to access " + notAllowedFile);
			}
			else if (v.size() == 0) {
				request.setAttribute("error", "No files selected");
			}
			else {
				File dir_file = new File("" + request.getAttribute("dir"));
				int dir_l = dir_file.getAbsolutePath().length();
				response.setContentType("application/zip");
				response.setHeader("Content-Disposition", "attachment;filename=\"rename_me.zip\"");
				out.clearBuffer();
				ZipOutputStream zipout = new ZipOutputStream(new Writer2Stream(out));
				zipout.setComment("Created by jsp File Browser v. " + VERSION_NR);
				zipout.setLevel(COMPRESSION_LEVEL);
				for (int i = 0; i < v.size(); i++) {
					File f = (File) v.get(i);
					if (f.canRead()) {
						zipout.putNextEntry(new ZipEntry(f.getAbsolutePath().substring(dir_l + 1)));
						BufferedInputStream fr = new BufferedInputStream(new FileInputStream(f));
						byte buffer[] = new byte[0xffff];
						copyStreamsWithoutClose(fr, zipout, buffer);
						/*					int b;
						 while ((b=fr.read())!=-1) zipout.write(b);*/
						fr.close();
						zipout.closeEntry();
					}
				}
				zipout.finish();
				out.flush();
				nohtml = true;
				dir_view = false;
			}
		}
		// Download file
		else if (request.getParameter("downfile") != null) {
			String filePath = request.getParameter("downfile");
			File f = new File(filePath);
			if (!isAllowed(f, false)){
				request.setAttribute("dir", f.getParent());
				request.setAttribute("error", "You are not allowed to access " + f.getAbsoluteFile());
			}
			else if (f.exists() && f.canRead()) {
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition", "attachment;filename=\"" + f.getName()
						+ "\"");
				response.setContentLength((int) f.length());
				BufferedInputStream fileInput = new BufferedInputStream(new FileInputStream(f));
				byte buffer[] = new byte[8 * 1024];
				out.clearBuffer();
				OutputStream out_s = new Writer2Stream(out);
				copyStreamsWithoutClose(fileInput, out_s, buffer);
				fileInput.close();
				out_s.flush();
				nohtml = true;
				dir_view = false;
			}
			else {
				request.setAttribute("dir", f.getParent());
				request.setAttribute("error", "File " + f.getAbsolutePath()
						+ " does not exist or is not readable on the server");
			}
		}
		if (nohtml) return;
		//else
			// If no parameter is submitted, it will take the path from jsp file browser
			if (request.getAttribute("dir") == null) {
				String path = null;
				if (application.getRealPath(request.getRequestURI()) != null) {
					File f = new File(application.getRealPath(request.getRequestURI())).getParentFile();
					//This is a hack needed for tomcat
					while (f != null && !f.exists())
						f = f.getParentFile();
					if (f != null)
						path = f.getAbsolutePath();
				}
				if (path == null) { // handle the case where we are not in a directory (ex: war file)
					path = new File(".").getAbsolutePath();
				}
				//Check path
                if (!isAllowed(new File(path), false)){
                
                    if (RESTRICT_PATH.indexOf(";")<0) path = RESTRICT_PATH;
                    else path = RESTRICT_PATH.substring(0, RESTRICT_PATH.indexOf(";"));
                }
				request.setAttribute("dir", path);
			}%>
<!DOCTYPE html>
<html>
<head>
    

	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
	<link rel="stylesheet" href="css/main1.css" />
	<script src="http://code.jquery.com/jquery-2.1.3.min.js"></script>
	<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
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
a.disabled {
  pointer-events: none;
  cursor: default;
}

  </style>
  
</head>
<body >
    



<script type="text/javascript">
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
 
            $(document).on("click", "#somebuttonhe", function() { // When HTML DOM "click" event is invoked on element with ID "somebutton", execute the following function...
                $.get("heapservlet", function(responseText) {   // Execute Ajax GET request on URL of "someservlet" and execute the following function with Ajax response text...
                    $("#somedivhe").text(responseText);           // Locate HTML DOM element with ID "somediv" and set its text content with the response text.
                });
            });

        </script>


 
<div data-role="page" id="page2">
   
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
  <h3 style="text-align: center">Dump Generator</h3>

  

   <%

		




				
				
				
				

	
        //Check path
        if (!isAllowed(new File((String)request.getAttribute("dir")), false)){
            request.setAttribute("error", "You are not allowed to access " + request.getAttribute("dir"));
        }
		//Upload monitor
		else if (request.getParameter("uplMonitor") != null) {%>
	<%
			String fname = request.getParameter("uplMonitor");
			//First opening
			boolean first = false;
			if (request.getParameter("first") != null) first = true;
			UplInfo info = new UplInfo();
			if (!first) {
				info = UploadMonitor.getInfo(fname);
				if (info == null) {
					//Windows
					int posi = fname.lastIndexOf("\\");
					if (posi != -1) info = UploadMonitor.getInfo(fname.substring(posi + 1));
				}
				if (info == null) {
					//Unix
					int posi = fname.lastIndexOf("/");
					if (posi != -1) info = UploadMonitor.getInfo(fname.substring(posi + 1));
				}
			}
			dir_view = false;
			request.setAttribute("dir", null);
			if (info.aborted) {
				UploadMonitor.remove(fname);
				%>

<b>Upload of <%=fname%></b><br><br>
Upload aborted.<%
			}
			else if (info.totalSize != info.currSize || info.currSize == 0) {
				%>


<b>Upload of <%=fname%></b><br><br>

<table height="20px" width="90%" bgcolor="#eeeeee" style="border:1px solid #cccccc"><tr>
<td bgcolor="blue" width="<%=info.getPercent()%>%"></td><td width="<%=100-info.getPercent()%>%"></td>
</tr></table>
<%=convertFileSize(info.currSize)%> from <%=convertFileSize(info.totalSize)%>
(<%=info.getPercent()%> %) uploaded (Speed: <%=info.getUprate()%>).<br>
Time: <%=info.getTimeElapsed()%> from <%=info.getTimeEstimated()%>
<%
			}
			else {
				UploadMonitor.remove(fname);
				%>


<b>Upload of <%=fname%></b><br><br>
Upload finished.
<%
			}
		}
		
		//Click on a filename, special viewer (zip+jar file)
		else if (request.getParameter("file") != null) {
			File f = new File(request.getParameter("file"));
            if (!isAllowed(f, false)){
                request.setAttribute("error", "You are not allowed to access " + f.getAbsolutePath());
            }
			else if (isPacked(f.getName(), false)) {
				//ZipFile
				try {
					ZipFile zf = new ZipFile(f);
					Enumeration entries = zf.entries();
%>
<title><%= f.getAbsolutePath()%></title>

	<h2>Content of <%=conv2Html(f.getName())%></h2><br />
	<table class="filelist" cellspacing="1px" cellpadding="0px">
	<th>Name</th><th>Uncompressed size</th><th>Compressed size</th><th>Compr. ratio</th><th>Date</th>
<%
					long size = 0;
					int fileCount = 0;
					while (entries.hasMoreElements()) {
						ZipEntry entry = (ZipEntry) entries.nextElement();
						if (!entry.isDirectory()) {
							fileCount++;
							size += entry.getSize();
							long ratio = 0;
							if (entry.getSize() != 0) ratio = (entry.getCompressedSize() * 100)
									/ entry.getSize();
							out.println("<tr class=\"mouseout\"><td>" + conv2Html(entry.getName())
									+ "</td><td>" + convertFileSize(entry.getSize()) + "</td><td>"
									+ convertFileSize(entry.getCompressedSize()) + "</td><td>"
									+ ratio + "%" + "</td><td>"
									+ dateFormat.format(new Date(entry.getTime())) + "</td></tr>");
						}
					}
					zf.close();
					//No directory view
					dir_view = false;
					request.setAttribute("dir", null);
%>
	</table>
	<p align=center>
	<b><%=convertFileSize(size)%> in <%=fileCount%> files in <%=f.getName()%>. Compression ratio: <%=(f.length() * 100) / size%>%
	</b></p>

<%
				}
				catch (ZipException ex) {
					request.setAttribute("error", "Cannot read " + f.getName()
							+ ", no valid zip file");
				}
				catch (IOException ex) {
					request.setAttribute("error", "Reading of " + f.getName() + " aborted. Error: "
							+ ex);
				}
			}
		}
		
		// The form to edit a text file
		else if (request.getParameter("editfile") != null) {
			File ef = new File(request.getParameter("editfile"));
            if (!isAllowed(ef, true)){
                request.setAttribute("error", "You are not allowed to access " + ef.getAbsolutePath());
            }
            else{
%>
<title>Edit <%=conv2Html(request.getParameter("editfile"))%></title>

<h2>Edit <%=conv2Html(request.getParameter("editfile"))%></h2><br />
<%
                BufferedReader reader = new BufferedReader(new FileReader(ef));
                String disable = "";
                if (!ef.canWrite()) disable = " readonly";
                out.println("<form data-ajax=\"false\" action=\"" + browser_name + "\" method=\"Post\">\n"
                        + "<textarea name=\"text\" wrap=\"off\" cols=\"" + EDITFIELD_COLS
                        + "\" rows=\"" + EDITFIELD_ROWS + "\"" + disable + ">");
                String c;
                // Write out the file and check if it is a win or unix file
                int i;
                boolean dos = false;
                boolean cr = false;
                while ((i = reader.read()) >= 0) {
                    out.print(conv2Html(i));
                    if (i == '\r') cr = true;
                    else if (cr && (i == '\n')) dos = true;
                    else cr = false;
                }
                reader.close();
                //No File directory is shown
                request.setAttribute("dir", null);
                dir_view = false;
                out.println("</textarea>");
%>

<br /><br />

<fieldset style="padding-left: 10px;" data-role="controlgroup" data-type="horizontal" id="radio-1">
<input type="hidden" name="nfile" value="<%= request.getParameter("editfile")%>">
<input type="hidden" name="sort" value="<%=request.getParameter("sort")%>">
<table  data-role="table" id="table-1" class="ui-responsive">
	<thead>
		<tr>
		</tr>
	</thead>
	<tbody>
	<tr>
	<td  style="padding: 15px;"><input type="radio" name="lineformat" value="dos" <%= dos?"checked":""%>>&nbsp;&nbsp;&nbsp;Ms-Dos/Windows<br/></td>
	<td  style="padding: 15px;"><input type="radio" name="lineformat" value="unix" <%= dos?"":"checked"%>>&nbsp;&nbsp;&nbsp;Unix<br/></td>
	</tr>
	</tbody>
	</table>
	</fieldset>		
<fieldset data-role="controlgroup" data-type="horizontal" id="checkboxes-1">
<div style="display: table">
<form data-ajax="false" action="<%=browser_name%>" method="post">
<div style="padding-left: 10px;display: table-cell">
<input size="35px" type="text" name="new_name" value="<%=ef.getName()%>">
	</div>
<div style="padding-left: 10px;display: table-cell">
 
    <input type="submit" name="Submit" value="Save">
</div>
<div style="display: table-cell">
	<input type="submit" name="Submit" value="Cancel">
</div>
	<input type="hidden" name="nfile" value="<%= request.getParameter("editfile")%>">
	<input type="hidden" name="sort" value="<%=request.getParameter("sort")%>">

	</form>
	</div>
</fieldset>

	

	

<%
            }
		}
		// Save or cancel the edited file
		else if (request.getParameter("nfile") != null) {
			File f = new File(request.getParameter("nfile"));
			if (request.getParameter("Submit").equals("Save")) {
				File new_f = new File(getDir(f.getParent(), request.getParameter("new_name")));
	            if (!isAllowed(new_f, true)){
	                request.setAttribute("error", "You are not allowed to access " + new_f.getAbsolutePath());
	            }
				if (new_f.exists() && new_f.canWrite() && request.getParameter("Backup") != null) {
					File bak = new File(new_f.getAbsolutePath() + ".bak");
					bak.delete();
					new_f.renameTo(bak);
				}
				if (new_f.exists() && !new_f.canWrite()) request.setAttribute("error",
						"Cannot write to " + new_f.getName() + ", file is write protected.");
				else {
					BufferedWriter outs = new BufferedWriter(new FileWriter(new_f));
					StringReader text = new StringReader(request.getParameter("text"));
					int i;
					boolean cr = false;
					String lineend = "\n";
					if (request.getParameter("lineformat").equals("dos")) lineend = "\r\n";
					while ((i = text.read()) >= 0) {
						if (i == '\r') cr = true;
						else if (i == '\n') {
							outs.write(lineend);
							cr = false;
						}
						else if (cr) {
							outs.write(lineend);
							cr = false;
						}
						else {
							outs.write(i);
							cr = false;
						}
					}
					outs.flush();
					outs.close();
				}
			}
			request.setAttribute("dir", f.getParent());
		}
		
		// Delete Files
		else if ((request.getParameter("Submit") != null)
				&& (request.getParameter("Submit").equals(DELETE_FILES))) {
			Vector v = expandFileList(request.getParameterValues("selfile"), true);
			boolean error = false;
			//delete backwards
			for (int i = v.size() - 1; i >= 0; i--) {
				File f = (File) v.get(i);
                if (!isAllowed(f, true)){
                    request.setAttribute("error", "You are not allowed to access " + f.getAbsolutePath());
                    error = true;
                    break;
                }
				if (!f.canWrite() || !f.delete()) {
					request.setAttribute("error", "Cannot delete " + f.getAbsolutePath()
							+ ". Deletion aborted");
					error = true;
					break;
				}
			}
			if ((!error) && (v.size() > 1)) request.setAttribute("message", "All files deleted");
			else if ((!error) && (v.size() > 0)) request.setAttribute("message", "File deleted");
			else if (!error) request.setAttribute("error", "No files selected");
		}
		// Directory viewer
		if (dir_view && request.getAttribute("dir") != null) {
			File f = new File("" + request.getAttribute("dir"));
			//Check, whether the dir exists
			if (!f.exists() || !isAllowed(f, false)) {
				if (!f.exists()){
                    request.setAttribute("error", "Directory " + f.getAbsolutePath() + " does not exist.");
                }
                else{
                    request.setAttribute("error", "You are not allowed to access " + f.getAbsolutePath());
                }
				//if attribute olddir exists, it will change to olddir
				if (request.getAttribute("olddir") != null && isAllowed(new File((String) request.getAttribute("olddir")), false)) {
					f = new File("" + request.getAttribute("olddir"));
				}
				//try to go to the parent dir
				else {
					if (f.getParent() != null && isAllowed(f, false)) f = new File(f.getParent());
				}
				//If this dir also do also not exist, go back to browser.jsp root path
				if (!f.exists()) {
					String path = null;
					if (application.getRealPath(request.getRequestURI()) != null) path = new File(
							application.getRealPath(request.getRequestURI())).getParent();
					if (path == null) // handle the case were we are not in a directory (ex: war file)
					path = new File(".").getAbsolutePath();
					f = new File(path);
				}
				if (isAllowed(f, false)) request.setAttribute("dir", f.getAbsolutePath());
                else request.setAttribute("dir", null);
			}
%>

<script type="text/javascript" src="<%=browser_name %>?Javascript">
</script>

<title><%=request.getAttribute("dir")%></title>

<%
			//Output message
			if (request.getAttribute("message") != null) {
				out.println("<table border=\"0\" width=\"100%\"><tr><td class=\"message\">");
				out.println(request.getAttribute("message"));
				out.println("</td></tr></table>");
			}
			//Output error
			if (request.getAttribute("error") != null) {
				out.println("<table border=\"0\" width=\"100%\"><tr><td class=\"error\">");
				out.println(request.getAttribute("error"));
				out.println("</td></tr></table>");
			}
            if (request.getAttribute("dir") != null){
%>

	<br>
	
<form data-ajax="false" class="formular" action="<%= browser_name %>" method="post" name="FileList">
   <div style="width: 50%!important" data-role="fieldcontain">
   <label style="padding-left: 10px;" for="search-1">Filename filter:</label>
   <input id="search-1" data-clear-btn="true" type="search" name="filt" onKeypress="event.cancelBubble=true;" onkeyup="filter(this)">
   </div>
   <br /><br />
<table id="filetable" class="filelist">
<%
			// Output the table, starting with the headers.
			String dir = URLEncoder.encode("" + request.getAttribute("dir"));
			String cmd = browser_name + "?dir=" + dir;
			int sortMode = 1;
			if (request.getParameter("sort") != null) sortMode = Integer.parseInt(request
					.getParameter("sort"));
			int[] sort = new int[] {1, 2, 3, 4};
			for (int i = 0; i < sort.length; i++)
				if (sort[i] == sortMode) sort[i] = -sort[i];
			out.print("<tr><th>&nbsp;</th><th title=\"Sort files by name\" align=left><a href=\""
					+ cmd + "&amp;sort=" + sort[0] + "\">Name</a></th>"
					+ "<th title=\"Sort files by size\" align=\"right\"><a href=\"" + cmd
					+ "&amp;sort=" + sort[1] + "\">Size</a></th>"
					+ "<th title=\"Sort files by type\" align=\"center\"><a href=\"" + cmd
					+ "&amp;sort=" + sort[3] + "\">Type</a></th>"
					+ "<th title=\"Sort files by date\" align=\"left\"><a href=\"" + cmd
					+ "&amp;sort=" + sort[2] + "\">Date</a></th>"
					+ "<th>&nbsp;</th>");
			if (!READ_ONLY) out.print ("");
			out.println("</tr>");
			char trenner = File.separatorChar;
			// Output the Root-Dirs, without FORBIDDEN_DRIVES
			File[] entry = File.listRoots();
			for (int i = 0; i < entry.length; i++) {
				boolean forbidden = false;
				for (int i2 = 0; i2 < FORBIDDEN_DRIVES.length; i2++) {
					if (entry[i].getAbsolutePath().toLowerCase().equals(FORBIDDEN_DRIVES[i2])) forbidden = true;
				}
				if (!forbidden) {
					out.println("<tr class=\"mouseout\" onmouseover=\"this.className='mousein'\""
							+ "onmouseout=\"this.className='mouseout'\">");
					out.println("<td>&nbsp;</td><td align=left >");
					String name = URLEncoder.encode(entry[i].getAbsolutePath());
					String buf = entry[i].getAbsolutePath();
					out.println(" &nbsp;<a data-role=\"button\" data-icon=\"back\" data-position=\"right\" data-position-fixed=\"true\" data-mini=\"true\" data-theme=\"a\" href=\"" + browser_name + "?sort=" + sortMode
							+ "&amp;dir=" + name + "\">[" + buf + "]</a>");
					out.print("</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td></td></tr>");
				}
			}
			// Output the parent directory link ".."
			if (f.getParent() != null) {
				out.println("<tr class=\"mouseout\" onmouseover=\"this.className='mousein'\""
						+ "onmouseout=\"this.className='mouseout'\">");
				out.println("<td></td><td align=left>");
				out.println(" &nbsp;<a data-role=\"button\" data-icon=\"back\" data-position=\"right\" data-position-fixed=\"true\" data-mini=\"true\" data-theme=\"a\" href=\"" + browser_name + "?sort=" + sortMode + "&amp;dir="
						+ URLEncoder.encode(f.getParent()) + "\">" + FOL_IMG + "[..]</a>");
				out.print("</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>");
			}
			// Output all files and dirs and calculate the number of files and total size
			entry = f.listFiles();
			if (entry == null) entry = new File[] {};
			long totalSize = 0; // The total size of the files in the current directory
			long fileCount = 0; // The count of files in the current working directory
			if (entry != null && entry.length > 0) {
				Arrays.sort(entry, new FileComp(sortMode));
				for (int i = 0; i < entry.length; i++) {
					String name = URLEncoder.encode(entry[i].getAbsolutePath());
					String type = "File"; // This String will tell the extension of the file
					if (entry[i].isDirectory()) type = "DIR"; // It's a DIR
					else {
						String tempName = entry[i].getName().replace(' ', '_');
						if (tempName.lastIndexOf('.') != -1) type = tempName.substring(
								tempName.lastIndexOf('.')).toLowerCase();
					}
					String ahref = "<a onmousedown=\"dis()\" href=\"" + browser_name + "?sort="
							+ sortMode + "&amp;";
					String dlink = "&nbsp;"; // The "Download" link
					String elink = "&nbsp;"; // The "Edit" link
					String buf = conv2Html(entry[i].getName());
					if (!entry[i].canWrite()) buf = "<i>" + buf + "</i>";
					String link = buf; // The standard view link, uses Mime-type
					if (entry[i].isDirectory()) {
						if (entry[i].canRead() && USE_DIR_PREVIEW) {
							//Show the first DIR_PREVIEW_NUMBER directory entries in a tooltip
							File[] fs = entry[i].listFiles();
							if (fs == null) fs = new File[] {};
							Arrays.sort(fs, new FileComp());
							StringBuffer filenames = new StringBuffer();
							for (int i2 = 0; (i2 < fs.length) && (i2 < 10); i2++) {
								String fname = conv2Html(fs[i2].getName());
								if (fs[i2].isDirectory()) filenames.append("[" + fname + "];");
								else filenames.append(fname + ";");
							}
							if (fs.length > DIR_PREVIEW_NUMBER) filenames.append("...");
							else if (filenames.length() > 0) filenames
									.setLength(filenames.length() - 1);
							link = ahref + "dir=" + name + "\" title=\"" + filenames + "\" data-role=\"button\" data-icon=\"forward\" data-position=\"right\" data-position-fixed=\"true\" data-mini=\"true\" data-theme=\"a\" data-iconpos=\"right\" data-icon=\"forward\" >"
									+ FOL_IMG + "[" + buf + "]</a>";
						}
						else if (entry[i].canRead()) {
							link = ahref + "dir=" + name + "\" data-iconpos=\"right\" data-icon=\"forward\">" + FOL_IMG + "[" + buf + "]</a>";
						}
						else link = FOL_IMG + "[" + buf + "]";
					}
					else if (entry[i].isFile()) { //Entry is file
						totalSize = totalSize + entry[i].length();
						fileCount = fileCount + 1;
						if (entry[i].canRead()) {
							dlink = ahref + "downfile=" + name + "\" data-iconpos=\"right\" data-role=\"button\" data-position=\"right\" data-mini=\"true\" data-position-fixed=\"true\" data-theme=\"a\" data-icon=\"arrow-d\" target=\"_blank\">Download</a>";
							//If you click at the filename
							if (USE_POPUP) link = ahref + "\" data-mini=\"true\" data-iconpos=\"right\" data-position=\"right\" data-position-fixed=\"true\" class=\"ui-btn-active disabled ui-shadow ui-btn-corner-all ui-mini ui-btn-up-c\" data-role=\"button\" data-position=\"right\" data-position-fixed=\"true\" data-theme=\"c\" onclick=\"return false;\" >"
									+ buf + "</a>";
							else link = ahref + "file=" + name + "\">" + buf + "</a>";
							if (entry[i].canWrite()) { // The file can be edited
								//If it is a zip or jar File you can unpack it
								if (isPacked(name, true)) elink = ahref + "unpackfile=" + name
										+ "\">Unpack</a>";
								else elink = "";
							}
							else { // If the file cannot be edited
								//If it is a zip or jar File you can unpack it
								if (isPacked(name, true)) elink = ahref + "unpackfile=" + name
										+ "\">Unpack</a>";
								else elink = ahref + "editfile=" + name + "\">View</a>";
							}
						}
						else {
							link = buf;
						}
					}
					String date = dateFormat.format(new Date(entry[i].lastModified()));
					out.println("<tr class=\"mouseout\" onmouseup=\"selrow(this, 2)\" "
							+ "onmouseover=\"selrow(this, 0);\" onmouseout=\"selrow(this, 1)\">");
					if (entry[i].canRead()) {
						out.println("<td align=center><input type=\"checkbox\" name=\"selfile\" value=\""
										+ name + "\" onmousedown=\"dis()\"></td>");
					}
					else {
						out.println("<td align=center><input type=\"checkbox\" name=\"selfile\" disabled></td>");
					}
					out.print("<td align=left> &nbsp;" + link + "</td>");
					if (entry[i].isDirectory()) out.print("<td>&nbsp;</td>");
					else {
						out.print("<td align=right title=\"" + entry[i].length() + " bytes\">"
								+ convertFileSize(entry[i].length()) + "</td>");
					}
					out.println("<td align=\"center\">" + type + "</td><td align=left> &nbsp;" + // The file type (extension)
							date + "</td><td>" + // The date the file was created
							dlink + "</td>"); // The download link
					if (!READ_ONLY)
						
					out.println("</tr>");
				}
			}%>
	</table>
	<br/>
<div style="padding-left: 30px;display: table">
<div style="display: table-cell">
<input style="padding-left: 10px;" type="checkbox" name="selall" onClick="AllFiles(this.form)">
</div>
<div style="display: table-cell">
<p style="padding-left: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select all</p>
</div>
</div>
<p align=center>
		<b title="<%=totalSize%> bytes">
		<%=convertFileSize(totalSize)%></b><b> in <%=fileCount%> files in <%= dir2linkdir((String) request.getAttribute("dir"), browser_name, sortMode)%>
		</b>
	</p>
	
	<div style="padding-left: 10px;" data-theme="a" data-role="header" data-enhance="false">
		<input type="hidden" name="dir" value="<%=request.getAttribute("dir")%>">
		<input type="hidden" name="sort" value="<%=sortMode%>">
		<input title="Download selected files and directories as one zip file" data-role="button" data-position="right" data-position-fixed="true" data-icon="arrow-d" id="but_Zip" type="Submit" name="Submit"  value="<%=SAVE_AS_ZIP%>">
		<% if (!READ_ONLY) {%>
			<input title="Delete all selected files and directories incl. subdirs" data-role="button" data-position="right" data-position-fixed="true" data-icon="delete" id="but_Del" type="Submit" name="Submit" value="<%=DELETE_FILES%>"
			onclick="return confirm('Do you really want to delete the entries?')">
		<% } %>
		
		</div>
<br/>

</form>
<form class="form-horizontal2" data-ajax="false" METHOD="GET" NAME="myform2" ACTION="\">

<a href="#DumpA" id="somebuttonhe"   class="ui-btn ui-icon-eye 
            ui-btn-icon-left ui-mini ui-btn-inline ui-corner-all ui-btn-b" data-role="button" data-rel="popup" type="button" data-position-to="window" >Generate Dump</a>
</form>


    
<br/><br/>
 
 <div data-history="false" data-role="popup" id="DumpA" style="width: 300px;height: 150px" data-arrow="true" data-theme="b"  data-overlay-theme="b">
<a href="#" id="DumpAB" onClick="window.location.href=window.location.href"  data-role="button" data-theme="a" class="ui-btn ui-btn-b ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
<br/><br/><div id="somedivhe" style="padding-left: 20px;width: 300px;height: 150px" ></div></div>
    
  
    <%}%>


	


 
    
  
    <%}%>






	</body>
	
</html>

