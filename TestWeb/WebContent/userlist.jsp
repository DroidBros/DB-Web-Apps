<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head >

<title>
User List
</title>

</head>

<body>
<%

try {
	String connectionURL = "jdbc:mysql://localhost/baconbase";
	Connection connection = null;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "droidbros","bacon");
	if(!connection.isClosed()){
		System.out.println("Successfully conneced to " + "MySQL server using TCP/IP...");
	}
	Statement stmt = connection.createStatement();
	
	ResultSet rs = stmt.executeQuery("Select * from users");
	
	%><table border = "!">
	<tr>
		<th>Username</th>
		<th>Password</th>
		<th>First Name</th>
		<th>Last Name</th>
		<th>Email</th>
		<th>User Type</th>
		<th>Edit Info</th>
	</tr>
	<%
	
	while(rs.next()){
		%><tr>
		
		<td><%=rs.getString(1)%></td>
		<td><%=rs.getString(2)%></td>
		<td><%=rs.getString(3)%></td>
		<td><%=rs.getString(4)%></td>
		<td><%=rs.getString(5)%></td>
		<td><%=rs.getString(6)%></td>
		<td><a href="/TestWeb/update_user.jsp?username1=<%=rs.getString(1)%>">edit</a></td>
		</tr><%
	}
	
	%>
	</table><%
	connection.close();
}
catch(SQLException e) {
	System.out.println("SQLException caught: " +e.getMessage());
}

%>

</body>
</html>