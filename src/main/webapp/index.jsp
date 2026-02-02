<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<%
    // Automatically redirect to the StudentServlet to load the list of students
    response.sendRedirect("students");
%>
</body>
</html>