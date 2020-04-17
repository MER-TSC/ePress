<%-- 
    Document   : NewCategory
    Created on : 20 mars 2018, 08:48:19
    Author     : MERZAK
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New Category</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/><br>
        <% if(session.getAttribute("role") != null && ((session.getAttribute("role")).equals("ADMIN") || (session.getAttribute("role")).equals("MODERATOR"))){ %>
        <form method="POST" action="/ePress/AddCategory">
            <table align="center">
                <tr>
                    <td>Category Name :</td>
                    <td><input type="text" name="category_name"></td>
                </tr>
                <br>
                <tr>
                    <td></td>
                    <td><input type="Submit" value="Add"></td>
                </tr>
                <br>   
            </table> 
        </form>
        <% } else out.print("<script>alert('You do not have suffisent privillage to view this page !')</script>"); %>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
