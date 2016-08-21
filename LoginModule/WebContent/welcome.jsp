<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("username")==null || session.getAttribute("username").equals("")){
	String redirectURL = "/LoginModule/login.jsp";
	response.sendRedirect(redirectURL);
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>welcome
	<%=session.getAttribute("username")%></h1>
	<h2><a href="/LoginModule/logout.jsp">Logout</a></h2>
	<h2><a href="/LoginModule/edit.jsp">Edit my details</a></h2>
	
</body>
</html>