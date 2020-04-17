<%-- 
    Document   : ValidateArticles
    Created on : 18 mars 2018, 17:35:23
    Author     : MERZAK
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
        <title>Validate Articles</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <% if(session.getAttribute("role") != null && ((session.getAttribute("role")).equals("ADMIN") || (session.getAttribute("role")).equals("MODERATOR"))){ %>
        <% 
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT article_id, title, TO_CHAR(creation_date,'DD/MM/YYYY HH24:MI'), status, last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE status='PENDING'");
            ResultSet rs = ps.executeQuery();
        %>
        <table border="1" style="text-align: center">
            <tr><td>ID</td><td>Title</td><td>Creation Date</td><td>Editor</td><td>Status</td></tr>
            <% while(rs.next()){ %>
            <tr>
                <td><%=rs.getInt(1)%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(5))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(4))%></td>
                <td><form method="POST" action="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>"><input type="submit" value="Details"></form></td>
                <td><form method="POST" action="/ePress/ValidateArticle?article_id=<%=rs.getInt(1)%>&action=approve"><input type="submit" value="Approve"></form></td>
                <td><form method="POST" action="/ePress/ValidateArticle?article_id=<%=rs.getInt(1)%>&action=decline"><input type="submit" value="Decline"></form></td>
            </tr>
            <% } rs.close();ps.close(); %> 
        </table>
        <% } else out.print("<script>alert('You do not have suffisent privillage to view this page !')</script>"); %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
