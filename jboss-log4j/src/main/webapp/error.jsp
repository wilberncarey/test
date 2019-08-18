<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="https://its.ny.gov/sites/default/files/favicon.ico" type="image/vnd.microsoft.icon" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>ITS Middleware</title>
		
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<meta name="description" content="" />
		<meta name="keywords" content="" />
		<link rel="stylesheet" href="css/main1.css" />
		
			<script src="js/jquery.min.js"></script>
			<script src="js/browser.min.js"></script>
			<script src="js/breakpoints.min.js"></script>
			<script src="js/util.js"></script>
	
		
		<meta http-equiv="Refresh" content="2;url=Home.jsp">
	</head>
		
	<body class="is-preload">
		<!-- Header -->
			<header id="header">
			<img src="img/nygov-logo.png" height="39">
			<a class="logo" >ITS Java Support Pages - <%=request.getServerName()%> - (<%=request.getLocalName()%>) </a>
			

			
				
<span style="font-size:16px;cursor:pointer;padding-right:10px;" onclick="openNav()">&#9776; Menu</span>	
	<%
			//Output message
			if (System.getProperty("Batch") != null) {

				
				out.println("<div id=\"mySidenav\" class=\"sidenav\">");
				out.println("<a href=\"javascript:void(0)\" class=\"closebtn\" onclick=\"closeNav()\">&times;</a>");
				out.println("<a href=\"Home.jsp\">HOME</a>");
				out.println("<a href=\"LogView.jsp\">Log Viewer</a>");
				out.println("<a href=\"LogAdmin.jsp\">Log level Configurator</a>");
				out.println("<a href=\"PropsView.jsp\">Properties Viewer</a>");
				out.println("<a href=\"BatchAdmin.jsp\">Batch Administration</a>");
				out.println("<a href=\"CommTest.jsp\">Communication Tester</a>");
				out.println("<a href=\"ThreadView.jsp\">View Thread Dump</a>");
				out.println("</div>");
		
				
			}
			else
			{
				
				out.println("<div id=\"mySidenav\" class=\"sidenav\">");
				out.println("<a href=\"javascript:void(0)\" class=\"closebtn\" onclick=\"closeNav()\">&times;</a>");
				out.println("<a href=\"Home.jsp\">HOME</a>");
				out.println("<a href=\"LogView.jsp\">Log Viewer</a>");
				out.println("<a href=\"LogAdmin.jsp\">Log level Configurator</a>");
				out.println("<a href=\"PropsView.jsp\">Properties Viewer</a>");
				//out.println("<a href=\"BatchAdmin.jsp\">Batch Administration</a>");
				out.println("<a href=\"CommTest.jsp\">Communication Tester</a>");
				out.println("<a href=\"ThreadView.jsp\">View Thread Dump</a>");
				out.println("</div>");}
	
%>
		
<script type="text/javascript">
            function refreshPage () {
                var page_y = document.getElementsByTagName("body")[0].scrollTop;
                window.location.href = window.location.href.split('?')[0] + '?page_y=' + page_y;
            }      
        </script>



<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>
				
				
				
				
			</header>
			
		<!-- Banner -->
		<section id="banner">
						
	<h1 style="z-index: 8;  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);">New York State</h1>

			</section>

		<!-- Highlights -->
			<section class="wrapper">
				<div class="inner">
					
					</div>
					</section>
						<section id="main">
						<div class="content">
 
 
 
 
 <h2>An Error has occured,Please try again later...</h2> 
 <br>
 <br>
 <br>
 
</div>
</section>
			<section id="cta" class="wrapper">
				<div class="inner">
					<h2>New York State</h2>
					<p>ITS COO Middleware</p>
					</div>
			</section>
	
			<!-- Testi -->
			<section class="wrapper">
				<div class="inner">
					<header class="special">
						<h2></h2>
						<p></p>
					</header>
					<div class="testimonials">
						
					</div>
				</div>
			</section>

		<!-- Footer -->
			<footer id="footer">
				<div class="inner">
					<div class="content">
						<section>
							<h3></h3>
							<p></p>
						</section>
						<section>
							<h4></h4>
						
						</section>
						<section>
							<h4>Contact Us</h4>
							<ul class="plain">
								<li><a href="#"><i class="icon fa-twitter">&nbsp;</i>Twitter</a></li>
								<li><a href="#"><i class="icon fa-facebook">&nbsp;</i>Facebook</a></li>
								<li><a href="#"><i class="icon fa-instagram">&nbsp;</i>Instagram</a></li>
								<li><a href="#"><i class="icon fa-github">&nbsp;</i>Github</a></li>
							</ul>
						</section>
					</div>
					<br>
					<div class="copyright">
						
					</div>
				</div>
				
			</footer>

	

	</body>
</html>