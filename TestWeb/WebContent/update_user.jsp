<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
     
<%

String passwordmessage = "";
String submit = request.getParameter("submit");

String username ="";
String password="";
String retypepassword="";
String firstname="";
String lastname="";
String email="";
String usertype="";



if(submit!=null){
	username = request.getParameter("username");
	password = request.getParameter("password");
	retypepassword = request.getParameter("retypepassword");
	firstname = request.getParameter("firstname");
	lastname = request.getParameter("lastname");
	email = request.getParameter("email");
	usertype = request.getParameter("usertype");
	
	if(password.equals(retypepassword)){
		
		passwordmessage = "";
		
		try {
			String connectionURL = "jdbc:mysql://localhost/baconbase";
			Connection connection = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection = DriverManager.getConnection(connectionURL, "droidbros","bacon");
			if(!connection.isClosed()){
				System.out.println("Successfully conneced to " + "MySQL server using TCP/IP...");
			}
			Statement stmt = connection.createStatement();
			String sql = "UPDATE users SET username = '"+username+"', password = '"+password+
					"',first_name = '"+firstname+"', last_name = '"+lastname+"', email = '"+email+"', user_type = '"+usertype+
					"' WHERE username = '"+request.getParameter("username1")+"'";
			stmt.executeUpdate(sql);
			
			connection.close();
			
			String redirectURL = "/TestWeb/userlist.jsp";
			response.sendRedirect(redirectURL);
		}
		catch(SQLException e) {
			System.out.println("SQLException caught: " +e.getMessage());
		}
			
	}else{
		passwordmessage = "Password did not match!"; 
	}
}



try {
	String connectionURL = "jdbc:mysql://localhost/baconbase";
	Connection connection = null;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "droidbros","bacon");
	if(!connection.isClosed()){
		System.out.println("Successfully conneced to " + "MySQL server using TCP/IP...");
	}
	Statement stmt = connection.createStatement();
	
	ResultSet rs = stmt.executeQuery("Select * from users where username ='"+request.getParameter("username1")+"'");
	
	rs.next();
		
		username = rs.getString(1);
		password = rs.getString(2);
		firstname = rs.getString(3);
		lastname = rs.getString(4);
		email = rs.getString(5);
		usertype = rs.getString(6);
	
	connection.close();
}
catch(SQLException e) {
	System.out.println("SQLException caught: " +e.getMessage());
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update User</title>
</head>
<body>
<form action="update_user.jsp" method="post">

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
			<td><font color="red"><%=passwordmessage %></font></td>
			<td></td>
		</tr>
		<tr>
		<td><br></td>
		<td></td>
		</tr>
		<tr>
			<td>Username</td>
			<td>
				<input type="text" name="username" value="<%=username%>">
				<input type="hidden" name="username1" value="<%=username%>">
			</td>
		</tr>
		<tr>
			<td>Password</td>
			<td>
				<input type="password" name="password">
			</td>
		</tr>
		<tr>
			<td>Re Enter Password</td>
			<td>
				<input type="password" name="retypepassword">
			</td>
		</tr>
		<tr>
			<td>First Name</td>
			<td>
				<input type="text" name="firstname" value="<%=firstname%>">
			</td>
		</tr>	
		<tr>
			<td>Last Name</td>
			<td>
				<input type="text" name="lastname" value="<%=lastname%>">
			</td>
		</tr>	
		<tr>
			<td>Email</td>
			<td>
				<input type="text" name="email" value="<%=email%>">
			</td>
		</tr>	
		<tr>
			<td>User Type</td>
			<td>
				<select name="usertype">
					<option value="customer">Customer</option>
					<option value="admin">Administrator</option>
				</select>
			</td>
		</tr>	
		<tr>
			<td><br></td>
			<td><br></td>
		</tr>
		<tr>
			<td>
			<input type="submit" name="submit">
			</td>
		</tr>		
		<tr>
		<td><br></td>
		<td></td>
		</tr>
		<tr>
			<td>
			<input type="reset">
			</td>
			<td></td>
		</tr>		
	</table>

	</form>
</body>
</html>