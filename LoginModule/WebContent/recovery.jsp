<%@page import="java.sql.*,com.kskdevelopers.mail.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	String submit = request.getParameter("submit");
	String pageMessage = "";
	String email = "";

	String subject = "Password Recovery";
	String fromAddress = "no-reply@rev-creations.com";
	String messageText = "";
	String recoveryURL = "";
	
	
	if (submit != null) {
		Random rand = new Random();
		String token = "";
		
		int  ranNum = rand.nextInt(1000000000) ;
		java.util.Date date = new java.util.Date();
		java.util.Date expiration = date;
		String expirationString;
		
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		expiration.setDate(expiration.getDate()+1);
		expirationString = sdf.format(expiration);
		
		
		long time = date.getTime();	
				
		token = time + "" + ranNum;
		
		System.out.println(date);
		System.out.println("time " + time);
		System.out.println("ranNum " + ranNum);
		System.out.println("token " + token);
		
		email = request.getParameter("email");

		try {
			String connectionURL = "jdbc:mysql://localhost/kskdevelopers";
			Connection connection = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "kskdevelopers", "mfsiablt");
			Statement stmt = connection.createStatement();
			String sql = "SELECT username, email FROM users WHERE email = '" + email + "'";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			String[] emailList = { email };

			if (rs.next()) {
				String username = rs.getString(1);
				
				sql = "INSERT INTO password_recovery (username, token, expiration) VALUES( '"
						+ username + "', '" + token + "', '" + expirationString + "' ) ";
				
				stmt.close();
				stmt = connection.createStatement();
				stmt.executeUpdate(sql);
				
				recoveryURL = "http://localhost:8080/LoginModule/edit.jsp?token=" + token;
				SendMailSMTP MailObject = new SendMailSMTP();
				try {
					
					messageText = "Hello "+ username +"!<br>"+
								  "To access your KSKDevelopers account, you can change your password through the link below: <br>"+
								  recoveryURL+"<br>"+
								  " Your password will not be changed until you access the link above and create a new one.<br>"+
								  "If you didn't request for this, please ignore this email.<br>"+
								  "With love, Your friends at KSKDevelopers";
										  
					MailObject.SendMail(messageText, subject, fromAddress, emailList);


					System.out.print("success");

				} catch (Exception ex) {

					// pageMessage="Your message could not be sent. Please try again. ";

					ex.printStackTrace();

				}
			}

			pageMessage = "If a matching user is registed,"
					+ " you will receive a email to change your password";

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
	<font color="green"><%=pageMessage%></font>
	<form method="post">
		Email:<br> <input type="text" name="email"><br> <input
			type="submit" name="submit">
	</form>

</body>
</html>