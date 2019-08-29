<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html lang="en">
<head>
	<script src="https://www.jq22.com/jquery/jquery-2.1.1.js"></script>
	<script type="text/javascript" src="https://resources.openpay.mx/lib/openpay.v1.min.js"></script>
	<script type="text/javascript" src="https://resources.openpay.mx/lib/openpay-data.v1.min.js"></script>
	<script type="text/javascript">

		$(function(){
			OpenPay.setId('mx5ojhfkmh7izcxginwy');
			OpenPay.setApiKey('pk_a6686b487df54902921173345304f5e9');
			OpenPay.setSandboxMode(true);
			var deviceDataId = OpenPay.deviceData.setup("formId");
			console.log("add:"+deviceDataId);
		});
		function login() {
			$.ajax({
				type: "POST",
				dataType: "json",
				url: "/creatCustomer",
				contentType : 'text/html;charset=UTF-8',
				data: JSON.stringify({"customerName":$("#customerName").val(),"lastName":$("#lastName").val(),"email":$("#email").val(), "phone":$("#phone").val(), "externalId":"12362"}),
				success: function (result) {
					console.log(result);//
					// if (result.resultCode == 200) {
					// 	alert("SUCCESS");
					// }
					;
				},
				error : function(e) {
					alert("error"+e);
				}
			});
		}
	</script>
</head>
<body>

	<welcome>
		<form id="form1" method="post" action="creatCustomer">
			<table>
				<tr>
					<td>name:</td><td><input name="customerName" id="customerName"/></td>
				</tr>
				<tr>
					<td>lastName:</td><td> <input name="lastName" id="lastName"/></td>
				</tr>
				<tr>
					<td>email:</td><td ><input name="email" id="email"/></td>
				</tr>
				<tr>
					<td>phone:</td><td ><input name="phone" id="phone"/></td>
				</tr>
				<tr>
					<td>externalId:</td><td ><input name="externalId" id="externalId"/></td>
				</tr>
				<tr><td colspan="2"><input type="submit" value="submit"/></td></tr>
			</table>
		</form>
</body>

</html>
