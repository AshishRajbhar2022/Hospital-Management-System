<%-- 
    Document   : logout
    Created on : 15 Sep, 2025, 2:40:43 PM
    Author     : ashis
--%>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>

