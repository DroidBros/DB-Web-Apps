<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"
	%>

<%
	String passwordmessage = "";
	String submit = request.getParameter("submit");

	String username = "";
	String password = "";
	String retypepassword = "";
	String firstname = "";
	String lastname = "";
	String email = "";
	String birthdate = "";
	String usertype = "";
	
	Boolean usernameMatches = false;
	Boolean emailMatches = false;
	//List<String> usernameList = new ArrayList<String>();

	if (submit != null) {
		username = request.getParameter("username");
		password = request.getParameter("password");
		retypepassword = request.getParameter("retypepassword");
		firstname = request.getParameter("firstname");
		lastname = request.getParameter("lastname");
		email = request.getParameter("email");
		birthdate = request.getParameter("birthdate");

		try {
			String connectionURL = "jdbc:mysql://localhost/kskdevelopers";
			Connection connection = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "kskdevelopers","mfsiablt");
			if(!connection.isClosed()){
				System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
			}else{
				System.out.println("Could not connect to " + "MySQL server using TCP/IP...");
			}
			Statement stmt = connection.createStatement();
			
			ResultSet rs = stmt.executeQuery("Select * from users");
			
			int resultNum = 0;
			
			while(rs.next()){
				resultNum++;
				System.out.println(rs.getString(1) + " is username " + resultNum);
				if(username.equals(rs.getString(1))){
					usernameMatches = true;
					System.out.println("boolean is true now");
				}
				System.out.println(rs.getString(3) + " is email " + resultNum);
				if(email.equals(rs.getString(3))){
					emailMatches = true;
					System.out.println("email boolean is true now");
				}
			}
			
			connection.close();
		}
		catch(SQLException e) {
			System.out.println("SQLException caught: " +e.getMessage());
		}
		
		if(usernameMatches!= true){
		
			System.out.println("boolean is false");
			
		if (password.equals(retypepassword)) {

			passwordmessage = "";
			
			if(!password.equals("")){
				
				passwordmessage = "";
				
				if(!email.equals("")){
					
					passwordmessage = "";
				
				if(emailMatches!=true){
					
					passwordmessage = "";

			if (!birthdate.equals("")) {
				
				passwordmessage = "";
				
				try {
					String connectionURL = "jdbc:mysql://localhost/kskdevelopers";
					Connection connection = null;
					Class.forName("com.mysql.jdbc.Driver").newInstance();
					connection = DriverManager.getConnection(connectionURL, "kskdevelopers", "mfsiablt");
					if(!connection.isClosed()){
						System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
					}else{
						System.out.println("Could not connect to " + "MySQL server using TCP/IP...");
					}
					Statement stmt = connection.createStatement();
					String sql = "INSERT INTO users (username, password, first_name, last_name, email, birth_date, user_type) VALUES( '"
							+ username + "', '" + password + "', '" + firstname + "', '" + lastname + "', '"
							+ email + "', '" + birthdate + "', '" + usertype + "' ) ";
					stmt.executeUpdate(sql);

					connection.close();
				} catch (SQLException e) {
					System.out.println("SQLException caught: " + e.getMessage());
				}

			} else {
				
				passwordmessage = "Date is empty!";
				
			}
				} else{
					passwordmessage = "somebody is already using that email";
				}
				
				}else{
					passwordmessage = "email is blank";
				}
			
			} else{
				passwordmessage = "Password is blank";
			}

		} else {
			passwordmessage = "Password did not match!";
		}
		}else{
			passwordmessage = "Username is not original";
			System.out.println("Boolean is true");
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

	<form action="registration.jsp" method="post">
		<table>
			<tr>
				<th>Field</th>
				<th>Your Data</th>
			</tr>
			<tr>
				<td><br></td>
				<td></td>
			</tr>
			<tr>
				<td><font color="red"><%=passwordmessage%></font></td>
				<td></td>
			</tr>
			<tr>
				<td><br></td>
				<td></td>
			</tr>
			<tr>
				<td>Username</td>
				<td><input type="text" name="username" value="<%=username%>">
				</td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>Re Enter Password</td>
				<td><input type="password" name="retypepassword"></td>
			</tr>
			<tr>
				<td>First Name</td>
				<td><input type="text" name="firstname" value="<%=firstname%>">
				</td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="lastname" value="<%=lastname%>">
				</td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value="<%=email%>">
				</td>
			</tr>
			<tr>
				<td>Birth Date</td>
				<td><input type="date" name="birthdate"></td>
			</tr>
			<tr>
				<td><br></td>
				<td><br></td>
			</tr>
			<tr>
				<td><input type="submit" name="submit"></td>
			</tr>
			<tr>
				<td><br></td>
				<td></td>
			</tr>
			<tr>
				<td><input type="reset"></td>
				<td></td>
			</tr>
		</table>

	</form>
</body>
</html>