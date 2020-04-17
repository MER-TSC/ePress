<%-- 
    Document   : Search
    Created on : 13 mars 2018, 09:57:49
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Oracle.JDBConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
         <%
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT article_id, title, content, post_date, last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE status='APPROVED' ORDER BY 3 DESC");
            if(request.getParameter("query") != null){
                ps = cn.prepareStatement("SELECT article_id, title, content, post_date, last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE (LOWER(content) LIKE LOWER(?) OR LOWER(title) LIKE LOWER(?)) AND status='APPROVED' ORDER BY 3 DESC");
                ps.setString(1,"%"+request.getParameter("query")+"%");
                ps.setString(2,"%"+request.getParameter("query")+"%");
            }else if(request.getParameter("category_id") != null){
                ps = cn.prepareStatement("SELECT article_id, title, content, post_date, last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE category_id=? AND status='APPROVED' ORDER BY 3 DESC");
                ps.setInt(1,Integer.parseInt(request.getParameter("category_id")));
            }
            ResultSet rs = ps.executeQuery();
         %>
        <% while(rs.next()){ %>
        <article style="margin-top: 90px;width: 1000px ; margin-left:100px ; background-color: lightgray; box-shadow: 0 0 7px 1px rgba(0, 0 , 0, .3); ">
            <table align="center">
                <tr><td>Title</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></td></tr>
                <tr><td>Content</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(3).substring(0,rs.getString(3).length()/3))+" ... "%><a href="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>">Read more</a></td></tr>
                <tr><td>Journalist</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(5))%></td></tr>
                <tr><td>Post Date</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(4))%></td></tr>
            </table>
        </article><br>
        <% } rs.close(); ps.close(); %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
