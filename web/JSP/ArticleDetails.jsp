
<%@page import="Oracle.StringEscapeUtils"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="Oracle.JDBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <% 
        Connection cn = JDBConnection.Connect();
        PreparedStatement ps, ps2;
        ps = cn.prepareStatement("SELECT article_id, title, content, image_url, status, TO_CHAR(post_date,'DD/MM/YYYY HH24:MI'), last_name || ' ' || first_name AS name FROM articles JOIN users USING(username) WHERE article_id=?");
        ps.setInt(1, Integer.parseInt(request.getParameter("article_id")));
        ResultSet rs,rs2;
        rs = ps.executeQuery();
        if(rs.next()){
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></title>
    </head>
    <body style="text-align: center">
        <jsp:include page="Header.jsp"/>
        <article align="center">
            <h1 align="middle"><%=StringEscapeUtils.escapeHtml(rs.getString(2))%></h1><br>
            <img src="/ePress/IMG/<%=StringEscapeUtils.escapeHtml(rs.getString(4))%>" align="middle" height="500" width="800"><br>
            <p align="middle"><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></p><br>
            <h5>Written the : <%=StringEscapeUtils.escapeHtml(rs.getString(6))%> By : <%=StringEscapeUtils.escapeHtml(rs.getString(7))%></h5>
            <table align="center">
                <tr>
                    <td>
                        <a href="/ePress/Like?target=article&action=like&article_id=<%=request.getParameter("article_id")%>"><img src="/ePress/IMG/thumbs_upx.gif"/></a>
                        <%
                            ps2 = cn.prepareStatement("SELECT COUNT(*) FROM reacts WHERE article_id=? AND react_type='LIKE'");
                            ps2.setInt(1, Integer.parseInt(request.getParameter("article_id")));
                            rs2 = ps2.executeQuery();
                            if(rs2.next()){
                                out.print("<b>"+rs2.getInt(1)+"</b>");
                            }
                        %>
                    </td>
                    <td>
                        <a href="/ePress/Like?target=article&action=dislike&article_id=<%=request.getParameter("article_id")%>"><img src="/ePress/IMG/thumbs_downx.gif"/></a>
                        <%
                            ps2 = cn.prepareStatement("SELECT COUNT(*) FROM reacts WHERE article_id=? AND react_type='DISLIKE'");
                            ps2.setInt(1, Integer.parseInt(request.getParameter("article_id")));
                            rs2 = ps2.executeQuery();
                            if(rs2.next()){
                                out.print("<b>"+rs2.getInt(1)+"</b>");
                            }
                        %>
                    </td>
                </tr>
            </table>
            <br><br>
        <%  }
            if(session.getAttribute("role") != null){
                if(session.getAttribute("role").toString().equals("ADMIN")){%>
                <table>
                    <tr>
                    <%if((rs.getString(5)).equals("PENDING")){ %>
                        <td><form method="POST" action="/ePress/ValidateArticle?article_id=<%=rs.getInt(1)%>&action=approve"><input type="submit" value="Publish"></form></td>
                    <% } %>
                        <td><form method="POST" action="/ePress/ValidateArticle?article_id=<%=rs.getInt(1)%>&action=decline"><input type="submit" value="Archive"></form></td>
                    </tr>
                </table><br><br>
        <%  }}  
            ps = cn.prepareStatement("SELECT * FROM comments WHERE article_id=? AND status='APPROVED' ORDER BY comment_date");
            ps.setInt(1, Integer.parseInt(request.getParameter("article_id")));
            rs = ps.executeQuery();
            ps2 = cn.prepareStatement("SELECT 0 FROM DUAL");
            rs2 = ps2.executeQuery();
            while(rs.next()){
        %>
            <table align="center">
                <tr><td>Alias :</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(7))%></td><td>Date : </td><td><%=StringEscapeUtils.escapeHtml(rs.getString(5))%></td></tr>
                <tr><td>Title :</td><td><h4><%=StringEscapeUtils.escapeHtml(rs.getString(3))%></h4></td></tr>
                <tr><td>Content :</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(4))%></td></tr>
                <tr><td>Email :</td><td><%=StringEscapeUtils.escapeHtml(rs.getString(6))%></td></tr><br>
                <tr>
                    <td><a href="/ePress/Like?target=comment&action=like&comment_id=<%=rs.getInt(1)%>&article_id=<%=request.getParameter("article_id")%>"><img src="/ePress/IMG/thumbs_upx.gif"/></a>
                    <% 
                        ps2 = cn.prepareStatement("SELECT COUNT(*) FROM reacts WHERE comment_id=? AND react_type='LIKE'"); 
                        ps2.setInt(1,rs.getInt(1));
                        rs2 = ps2.executeQuery();
                        if(rs2.next()){ %>
                           <b><%= rs2.getInt(1) %></b>
                       <% } %></td>
                    <td><a href="/ePress/Like?target=comment&action=dislike&comment_id=<%=rs.getInt(1)%>&article_id=<%=request.getParameter("article_id")%>"><img src="/ePress/IMG/thumbs_downx.gif"/></a>
                    <% 
                        ps2 = cn.prepareStatement("SELECT COUNT(*) FROM reacts WHERE comment_id=? AND react_type='DISLIKE'"); 
                        ps2.setInt(1, rs.getInt(1));
                        rs2 = ps2.executeQuery();
                        if(rs2.next()){ %>
                            <b><%= rs2.getInt(1) %></b>
                        <% } %></td>
                </tr>
            </table>
        <% } ps.close();rs.close();ps2.close();rs2.close(); %>
            <article align="center">
                <form action="/ePress/AddComment?article_id=<%=request.getParameter("article_id")%>" method="POST">
                    <table align="center">
                        <tr>
                            <td>Title : </td>
                            <td><input type="text" name="title"></td>
                        </tr> 
                        <tr>
                            <td>Content : </td>
                            <td><textarea name="content" cols="80" rows="9" ></textarea></td>
                        </tr>
                        <tr>
                            <td>Email : </td>
                            <td><input type="text" name="email" ></td>
                        </tr>
                        <tr>
                            <td>Alias : </td>
                            <td><input type="text" name="alias"></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="Comment"></td>
                        </tr>                        
                    </table>
                </form>
            </article>
        </article>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
