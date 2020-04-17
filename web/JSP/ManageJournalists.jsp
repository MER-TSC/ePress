<%-- 
    Document   : GereJournaliste
    Created on : 19 mars 2018, 20:33:36
    Author     : DELL
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Journalists</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <div align="center">
            <a href="/ePress/JSP/NewJournalist.jsp">New Journalist</a>
            <% 
                Connection cn = JDBConnection.Connect();
                PreparedStatement ps = cn.prepareStatement("SELECT username, last_name || ' ' || first_name AS name, email FROM users WHERE role='JOURNALIST' ORDER BY 2");
                ResultSet rs = ps.executeQuery();
            %>
            <table id="table1" border="2" align="center">
                <tr><td>Name</td><td>Username</td><td>Email</td></tr>
            <% while(rs.next()){ %>
                <tr>
                    <td><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(1))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></td>
                    <td><form method="POST" action="/ePress/DeleteJournalist?journalist=<%=StringEscapeUtils.escapeHtml(rs.getString(1))%>"><input type="submit" value="Delete"></form></td>
                    <td><form method="POST" action="/ePress/JSP/ModifyJournalist.jsp?journalist=<%=StringEscapeUtils.escapeHtml(rs.getString(1))%>"><input type="submit" value="Modify"></form></td>
                </tr>
            <% } %> 
            </table>
        </div>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
