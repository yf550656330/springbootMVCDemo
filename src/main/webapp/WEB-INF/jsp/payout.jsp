<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>
    <script src="https://www.jq22.com/jquery/jquery-2.1.1.js"></script>
</head>
<body>
    <form method="post" action="createPayout">
        <table>
            <tr>
                <td>customerId:</td><td><input type="text" value="${customerId}" name="customerId" id="customerId"/></td>
            </tr>
            <tr>
                <td>bankId:</td><td><input type="text" value="${bankId}" name="bankId" id="bankId"/></td>
            </tr>
            <tr>
                <td>amount:</td><td><input type="text" name="amount" id="amount"/></td>
            </tr>
            <tr>
                <td>description:</td><td><input type="text" name="description" id="description"/></td>
            </tr>
            <tr>
                <td>orderId:</td><td><input type="text" name="orderId" id="orderId"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="submit"/></td>
            </tr>
        </table>
    </form>
</body>
</html>