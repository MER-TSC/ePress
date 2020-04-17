<%-- 
    Document   : Home
    Created on : 13-Mar-2018, 10:02:35
    Author     : MERZAK
--%>

<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="Oracle.JDBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ePRESS</title>
    </head>
    <body style="text-align: center">
        <jsp:include page="Header.jsp"/><br>
        <% 
            int article_id=1;
            if(request.getParameter("article_id")!=null){
                article_id=Integer.parseInt(request.getParameter("article_id"));
            }  
            Connection cn = JDBConnection.Connect();
            PreparedStatement ps = cn.prepareStatement("SELECT article_id, title, content, image_url, post_date, last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE status='APPROVED' ORDER BY 3 DESC",ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY);
            ResultSet rs = ps.executeQuery();
            if (rs.absolute(article_id)) {
        %>
        <a href="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>"><h1><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></h1></a><br><br>
           <img src="/ePress/IMG/<%=StringEscapeUtils.escapeHtml(rs.getString(4))%>" align="middle" height="500" width="800"/><br><br>
           <%=StringEscapeUtils.escapeHtml(rs.getString(3).substring(0,rs.getString(3).length()/3))+" ... "%>
           <a href="/ePress/JSP/ArticleDetails.jsp?article_id=<%=rs.getInt(1)%>">Read more</a><br><br><br>
           <% }for(int i=1;i<10;i++){%>
                <a href="/ePress/JSP/Home.jsp?article_id=<%=i%>"><%=i%></a>
           <% }rs.close();ps.close(); %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
