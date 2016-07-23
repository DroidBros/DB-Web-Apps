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
	System.out.println();
	System.out.println("Posted Values");
	System.out.println();
	username = request.getParameter("username");
	System.out.println(username);
	password = request.getParameter("password");
	System.out.println(password);
	retypepassword = request.getParameter("retypepassword");
	System.out.println(password);
	firstname = request.getParameter("firstname");
	System.out.println(firstname);
	lastname = request.getParameter("lastname");
	System.out.println(lastname);
	email = request.getParameter("email");
	System.out.println(email);
	usertype = request.getParameter("usertype");
	System.out.println(usertype);
	
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
			String sql = "INSERT INTO users (username, password, first_name, last_name, email, user_type) VALUES( '" + username + "', '" + password + "', '" + 
			firstname + "', '" + lastname + "', '" + email + "', '" + usertype + "' ) ";
			stmt.executeUpdate(sql);
			
			
			/*ResultSet rs = stmt.executeQuery("Select * from users");
			System.out.println();
			System.out.println("Table entries");
			System.out.println();
			while(rs.next()){
				System.out.println("<br>");
				System.out.println(rs.getString(1)+",");
				System.out.println(rs.getString(2)+",");
				System.out.println(rs.getString(3)+",");
				System.out.println(rs.getString(4)+",");
				System.out.println(rs.getString(5)+",");
				System.out.println(rs.getString(6)+",");
			}*/
			
			connection.close();
			/*
			String nextJSP = "/userlist.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
			dispatcher.forward(request,response);*/
			
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
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


<head>

<title>
Create User
</title>

</head>

<body>

	<form action="create_user.jsp" method="post">

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