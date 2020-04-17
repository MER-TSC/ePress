<%-- 
    Document   : Header
    Created on : 30 mars 2018, 11:49:38
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
	<%--<link rel="stylesheet" href="../CSS/Styles.css">--%>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            <jsp:include page="../CSS/Styles.css"/>
	</style>
    </head>
    <header style="">
        <div style="display: inline; height: 40px;">
            <ul style="list-style-type: none;display: inline;">
		<li style="float: left">
                    <a href="/ePress/"><img src="/ePress/IMG/EPress.png" class="logo"></a>
		</li>
		<li style="display: inline">
                    <div class="center" style="position: initial">
                        <form action="/ePress/JSP/Search.jsp" method="POST">
                            <input type="text" name="query" class="search" placeholder=" Search..">
                            <input type="submit" value=" " class="bt" >
                        </form><br><br>
                        <% if(session.getAttribute("name")!= null) { %>
                        Welcome : <%=StringEscapeUtils.escapeHtml(session.getAttribute("name").toString())%> (<%=StringEscapeUtils.escapeHtml(session.getAttribute("role").toString())%>)
                        <% } %>
                    </div>
		</li>	
            </ul>
        </div><br><br><br>
	<div style=" background-color: #f1f1f1; font-family: 'Segoe UI'; box-sizing: inherit; display: block;box-shadow: 0 0 7px rgba(0,0,0,0.3); margin-top: 35px">
            <ul style="text-align: center">
                <li><a href="/ePress/JSP/Home.jsp" class="nav">Home</a></li>
                <%
                    Connection cn = JDBConnection.Connect();
                    PreparedStatement ps = cn.prepareStatement("SELECT * FROM categories");
                    ResultSet rs = ps.executeQuery();
                    while(rs.next()){
                %>
                <li><a href="/ePress/JSP/Search.jsp?category_id=<%=rs.getInt(1)%>" class="nav"><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></a></li>
                <%  } rs.close(); ps.close();
                    if(session.getAttribute("username") == null){ %>
                <li><a href="/ePress/JSP/Login.jsp" class="nav">Login</a></li>
                <% } %>
            </ul>
            <% if(session.getAttribute("username") != null){ %>
            <ul style="text-align: center">
                <li><a href="/ePress/JSP/NewArticle.jsp" class="nav">New Article</a></li>
                <li><a href="/ePress/JSP/ArticlesList.jsp" class="nav">View Articles</a></li>
                <li><a href="/ePress/JSP/ChangePassword.jsp" class="nav">Update Password</a></li>
                <% if(session.getAttribute("role").toString().equals("MODERATOR")){%>>
                <li><a href="/ePress/JSP/ValidateArticles.jsp" class="nav">Validate Articles</a></li>
                <li><a href="/ePress/JSP/ValidateComments.jsp" class="nav">Validate Comments</a></li>
                <% if(session.getAttribute("role").toString().equals("ADMIN")){%>
                <li><a href="/ePress/JSP/ManageJournalists.jsp" class="nav">Manage Journalists</a></li>
                <li><a href="/ePress/JSP/ManageCategories.jsp" class="nav">Manage Categories</a></li>
                <% }} %>
                <li><a href="/ePress/Logout" class="nav">Logout</a></li>
            </ul>
            <% } %>
        </div>
    </header>
    <br><br>
</html>
