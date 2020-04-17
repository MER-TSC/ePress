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
        <title>Reset Password</title>
    </head>
    <body>
        <jsp:include page="Header.jsp"/>
        <form action="/ePress/ResetPassword" method="POST">
            <table>
                <tr><td>New password : </td><td><input type="password" name="newpassword"></td></tr>
                <tr><td>Confirm new password : </td><td><input type="password" name="newpasswordconfirmation"></td></tr>
                <tr><td></td><td><input type="Submit" value="Reset Password"></td></tr>
            </table>
        </form>
        <jsp:include page="Footer.jsp"/>
    </body>
</html>
