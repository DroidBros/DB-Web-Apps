<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	String submit = request.getParameter("submit");

	String username = "";
	String password = "";

	if (submit != null) {
		username = request.getParameter("username");
		password = request.getParameter("password");

		try {
			String connectionURL = "jdbc:mysql://localhost/kskdevelopers";
			Connection connection = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "kskdevelopers", "mfsiablt");
			/*if(!connection.isClosed()){
				System.out.println("Successfully conneced to " + "MySQL server using TCP/IP...");
			}*/
			Statement stmt = connection.createStatement();
			String sql = "SELECT username, password FROM users WHERE username = '"
					+ username + "' AND password = '" + password + "'";
			ResultSet rs = stmt.executeQuery(sql);
			
			if(rs.next()){
				session.setAttribute("username",username);
				String redirectURL = "/LoginModule/welcome.jsp";
				response.sendRedirect(redirectURL);
			}else{
				out.print("Invalid username/password combination");
			}
			

			connection.close();
		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		}

	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%if(session.getAttribute("username")!=null){
	out.print(session.getAttribute("username"));
	} %>
	<form method="post">
		Username:<br> <input type="text" name="username"><br>
		Password:<br> <input type="password" name="password"> 
		<input type="submit" name="submit">
	</form>
	<h2><a href="/LoginModule/registration.jsp">Don't have an account? Sign up.</a></h2>
	<h2><a href="/LoginModule/recovery.jsp">Forgot Password</a></h2>
</body>
</html>