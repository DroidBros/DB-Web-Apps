<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% try {
	String connectionURL = "jdbc:mysql://localhost/baconbase";
	Connection connection = null;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root","sathira12");
	if(!connection.isClosed())
		out.println("Successfully conneced to " + "MySQL server using TCP/IP...");
	Statement stmt = connection.createStatement();
	ResultSet rs = stmt.executeQuery("Select * from users");
	while(rs.next()){
		out.println("<br>");
		out.println(rs.getString(1));
		out.println(", ");
		out.println(rs.getString(2));
		out.println(", ");
		out.println(rs.getString(3));
		out.println(", ");
		out.println(rs.getString(4));
		out.println(", ");
		out.println(rs.getString(5));
		out.println(", ");
		out.println(rs.getString(6));
		out.println(", ");
	}
	connection.close();
}
catch(SQLException e) {
	out.println("SQLException caught: " +e.getMessage());
}
	%>

</body>
</html>