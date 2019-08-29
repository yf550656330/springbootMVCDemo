<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>
    <script src="https://www.jq22.com/jquery/jquery-2.1.1.js"></script>
</head>
<body>
<form action="createBankCode" method="post">
<table>
    <tr>
        <td>customerId:</td><td><input type="text" name="customerId" value="${customerId}" id="customerId"/></td>
    </tr>
    <tr>
        <td>clabe:</td><td><input type="text" name="clabe" id="clabe"/></td>
    </tr>
    <tr>
        <td>holderName:</td><td><input type="text" name="holderName" id="holderName"></td>
    </tr>
    <tr>
        <td>alias:</td><td><input type="text" name="alias" id="alias"></td>
    </tr>
    <tr>
        <td colspan="2" align="center"><input type="submit" value="submit"/></td>
    </tr>
</table>
</form>
</body>
</html>