<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <script src="https://www.jq22.com/jquery/jquery-2.1.1.js"></script>
</head>
<body>
<form method="post" action="createCard">
    <table>
        <tr>
            <td>customerId:</td><td><input type="text" value="${customerId}" name="customerId" id="customerId"/></td>
        </tr>
        <tr>
            <td>cardNumber:</td><td><input type="text" name="cardNumber" id="cardNumber"/></td>
        </tr>
        <tr>
            <td>holderName:</td><td><input type="text" name="holderName" id="holderName"/></td>
        </tr>
        <tr>
            <td>cvv2:</td><td><input type="text" name="cvv2" id="cvv2"/></td>
        </tr>
        <tr>
            <td>expirationMonth:</td><td><input type="text" name="expirationMonth" id="expirationMonth"/></td>
        </tr>
        <tr>
            <td>expirationYear:</td><td><input type="text" name="expirationYear" id="expirationYear"/></td>
        </tr>
        <tr>
            <td colspan="2" align="center"><input type="submit" value="submit"/></td>
        </tr>
    </table>
</form>
</body>
</html>