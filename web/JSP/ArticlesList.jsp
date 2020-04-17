<%-- 
    Document   : ListArticle
    Created on : 17 mars 2018, 01:42:17
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
        <title>Articles List</title>
    </head>
    <body style="text-align: center">
        <jsp:include page="Header.jsp"/><br>
        <%  
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps;
            if(request.getParameter("query") != null){
                ps = cn.prepareStatement("SELECT article_id, title, TO_CHAR(creation_date,'DD/MM/YYYY HH24:MI'), status FROM articles JOIN users USING (username) WHERE username=? AND (UPPER(title) LIKE UPPER(?) OR  UPPER(content) LIKE UPPER(?)) ORDER BY 4,3 DESC");
                ps.setString(2, "%"+request.getParameter("query")+"%");
                ps.setString(3, "%"+request.getParameter("query")+"%");
            }else{
                ps = cn.prepareStatement("SELECT article_id, title, TO_CHAR(creation_date,'DD/MM/YYYY HH24:MI'), status FROM articles JOIN users USING (username) WHERE username=? ORDER BY 4,3 DESC");
            }
            ps.setString(1, request.getSession().getAttribute("username").toString());
            ResultSet rs = ps.executeQuery();          
        %>
        <article align="center">    
            <form action="/ePress/JSP/ArticlesList.jsp" method="POST">
                <input type="text" name="query" value="<% if(request.getParameter("query") != null) out.print(request.getParameter("query"));%>" class="search" style="margin-left:auto; margin-right: auto;" placeholder=" Search in my articles..">
                <input type="submit" value=" " class="bt" >
            </form>
        </article>
            <br><br>
        <table border="1" >
            <tr><td>NO ART</td><td>Title</td><td>Creation Date</td><td>Status</td></tr>
            <% while(rs.next()){ %>
            <tr><td><%=rs.getInt(1)%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></td><td><%=StringEscapeUtils.escapeHtml(rs.getString(4))%></td>
                <td><form method="POST" action="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>"><input type="submit" value="DETAILS"></form></td>
                <% if(!(rs.getString(4).equals("APPROVED"))){%>
                <td><form method="POST" action="/ePress/JSP/ModifyArticle.jsp?article_id=<%=rs.getInt(1)%>"><input type="submit" value="MODIFY"></form></td>
                <td><form method="POST" action="/ePress/DeleteArticle?article_id=<%=rs.getInt(1)%>"><input type="submit" value="DELETE"></form></td>
                <% } %>
            </tr>
            <% } rs.close();ps.close();%> 
        </table>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
