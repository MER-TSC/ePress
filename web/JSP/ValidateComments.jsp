<%-- 
    Document   : ValidateComments
    Created on : 20 mars 2018, 11:41:07
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Validate Comments</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT article_id, comment_id, a.title, email, alias, c.title, c.content, c.status FROM articles a JOIN comments c USING(article_id) WHERE c.status='PENDING'");
            ResultSet rs = ps.executeQuery();
        %>
        <table align="center" id="table1" border="2">
            <tr><td>Article</td><td>E-Mail</td><td>Alias</td><td>Comment Title</td><td>Comment Content</td></tr>
            <% while(rs.next()){ %>
            <tr>
                <td><a href="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>"><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></a></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(4))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(5))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(6))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(7))%></td>
                <td><form method="POST" action="/ePress/JSP/CommentDetails.jsp?comment_id=<%=rs.getInt(2)%>"><input type="submit" value="Details"></form></td>
                <% if(!(rs.getString(8).equals("APPROVED"))){%>
                <td><form method="POST" action="/ePress/ValidateComment?action=approve&comment_id=<%=rs.getInt(2)%>"><input type="submit" value="Approve"></form></td>
                <td><form method="POST" action="/ePress/ValidateComment?action=decline&comment_id=<%=rs.getInt(2)%>"><input type="submit" value="Decline"></form></td>
                <% } %>
            </tr>
            <% } rs.close(); ps.close(); %>
        </table>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>