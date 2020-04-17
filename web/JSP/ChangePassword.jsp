<%-- 
    Document   : ChangePassword
    Created on : 20 mars 2018, 09:45:43
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Password</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
        <form action="/ePress/ChangePassword" method="POST">
            <table>
                <tr><td>Old password : </td><td><input type="password" name="oldpassword"></td></tr>
                <tr><td>New password : </td><td><input type="password" name="newpassword"></td></tr>
                <tr><td>Confirm new password : </td><td><input type="password" name="newpasswordconfirmation"></td></tr>
                <tr><td></td><td><input type="Submit" value="Change Password"></td></tr>
            </table>
        </form>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
