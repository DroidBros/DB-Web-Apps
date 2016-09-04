<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% 
    String tempString = (String) session.getAttribute("username");
    System.out.println(tempString+" is username");
    String tempToken = request.getParameter("token");
    boolean passwordReset = false;
    boolean redirected = false;
    
	if(tempToken==null||tempToken.equals("")){
    	System.out.println("token is null");

		if(tempString==null ||tempString.equals("")){
	    	//String redirectURL = "/LoginModule/login.jsp";
	    	//response.sendRedirect(redirectURL);
	    	System.out.println("Redirected from beginning of code");
	    	RequestDispatcher requestDispatcher; 
			requestDispatcher = request.getRequestDispatcher("/login.jsp");
			requestDispatcher.forward(request, response);
			redirected = true;
	    	}
	}else{
		passwordReset=true;
	}
    
    %>
    
    <%
    String passwordmessage = "";
	String submit = request.getParameter("submit");
	String username = "";
	String dateOfExpiry = "";
	
	String password = "";
	String retypepassword = "";
	String firstname = "";
	String lastname = "";
	String email = "";
	String birthdate = "";
	String usertype = "";
	
	if(redirected!=true){
	if(passwordReset==true){
		String token = request.getParameter("token");
		try{
			
			String connectionURL1 = "jdbc:mysql://localhost/kskdevelopers";
			Connection connection1 = null;
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			connection1 = DriverManager.getConnection(connectionURL1, "kskdevelopers","mfsiablt");
			Statement stmt1 = connection1.createStatement();
			ResultSet rs1 = stmt1.executeQuery("Select * from password_recovery where token = " + token);
			
			if(rs1.next()){
				username = rs1.getString(2);
				dateOfExpiry = rs1.getString(3);
			}else{
				System.out.println("F*** it didn't work, and by f*** I meant fail...");
			}
			
			connection1.close();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			String currentDateTime = dateFormat.format(date);
			
			String[] dateHours = currentDateTime.split(" ");
			String dateHour = dateHours[0];
			String[] days = dateHour.split("-");
			String currentDay = days[2];
			String currentMonth = days[1];
			String currentYear = days[0];
			int currentDayInt = Integer.parseInt(currentDay);
			int currentMonthInt = Integer.parseInt(currentMonth);
			int currentYearInt = Integer.parseInt(currentYear);
			System.out.println(currentDayInt + " is currentdayint");
			
			String[] expiryDateHours = dateOfExpiry.split(" ");
			String expiryDateHour = expiryDateHours[0];
			String[] expiryDates = expiryDateHour.split("-");
			String expiryDay = expiryDates[2];
			String expiryMonth = expiryDates[1];
			String expiryYear = expiryDates[0];
			int expiryDayInt = Integer.parseInt(expiryDay);
			int expiryMonthInt = Integer.parseInt(expiryMonth);
			int expiryYearInt = Integer.parseInt(expiryYear);
			System.out.println(expiryDayInt + " is expirydayint");
			
			
			if(expiryYearInt==currentYearInt){
				if(expiryMonthInt==currentMonthInt){
			
					if(expiryDayInt<=currentDayInt){
						System.out.println("Redirected because of expiry");
						RequestDispatcher requestDispatcher1;
						requestDispatcher1 = request.getRequestDispatcher("/login.jsp");
						requestDispatcher1.forward(request, response);
						}
				}
				if(expiryMonthInt<currentMonthInt){
					RequestDispatcher requestDispatcher1;
					requestDispatcher1 = request.getRequestDispatcher("/login.jsp");
					requestDispatcher1.forward(request, response);
				}
			} 
			if(expiryYearInt<currentYearInt){
				RequestDispatcher requestDispatcher1;
				requestDispatcher1 = request.getRequestDispatcher("/login.jsp");
				requestDispatcher1.forward(request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}else{
	username = (String) session.getAttribute("username");
	}
	System.out.println(username+" is username");
	
	Boolean usernameMatches = false;
	Boolean emailMatches = false;
	//List<String> usernameList = new ArrayList<String>();
	
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
					firstname=rs.getString(4);
					lastname=rs.getString(5);
					email=rs.getString(3);
					birthdate=rs.getString(6);
					System.out.println("birthdate is "+birthdate);
				}
			}
			
			connection.close();
		}
		catch(SQLException e) {
			System.out.println("SQLException caught: " +e.getMessage());
		}
	
	if (submit != null) {
		username = (String) session.getAttribute("username");
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
			connection = DriverManager.getConnection(connectionURL, "kskdevelopers", "mfsiablt");
			if(!connection.isClosed()){
				System.out.println("Successfully connected to " + "MySQL server using TCP/IP...");
			}else{
				System.out.println("Could not connect to " + "MySQL server using TCP/IP...");
			}
			Statement stmt = connection.createStatement();
			
			ResultSet rs = stmt.executeQuery("Select * from users");
			
			int resultNum = 0;
			
			while(rs.next()){
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
		
		
		if (password.equals(retypepassword)) {

			passwordmessage = "";
			
			if(!password.equals("")){
				
				passwordmessage = "";
				
				if(!email.equals("")){
					
					passwordmessage = "";
				
				/*if(emailMatches!=true){
					
					passwordmessage = "";*/

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
					String sql = "UPDATE users SET password = '"+password+
							"',first_name = '"+firstname+"', last_name = '"+lastname+"', email = '"+email+"', birth_date = '"+birthdate+
							"' WHERE username = '"+username+"'";
					stmt.executeUpdate(sql);

					connection.close();
					String redirectURL = "/LoginModule/welcome.jsp";
			    	response.sendRedirect(redirectURL);
				} catch (SQLException e) {
					System.out.println("SQLException caught: " + e.getMessage());
				}

			} else {
				
				passwordmessage = "Date is empty!";
				
			}
				/*} else{
					passwordmessage = "somebody is already using that email";
				}*/
				
				}else{
					passwordmessage = "email is blank";
				}
			
			} else{
				passwordmessage = "Password is blank";
			}

		} else {
			passwordmessage = "Password did not match!";
		}
		
	}}
     %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="edit.jsp" method="post">
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
				<td><%=username%>
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
				<td><input type="date" name="birthdate" value=<%=birthdate%>></td>
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