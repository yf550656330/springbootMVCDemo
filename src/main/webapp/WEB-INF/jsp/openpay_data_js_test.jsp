<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es-ES">
<head profile="http://gmpg.org/xfn/11">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script type='text/javascript' src="https://openpay.s3.amazonaws.com/openpay.v1.js"></script>
    <!-- Add openpay-data.v1.js after opnepay.v1.js -->
    <script type='text/javascript' src="https://openpay.s3.amazonaws.com/openpay-data.v1.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            OpenPay.setSandboxMode(true);
            // Setup Form after calling setSandboxMode
            var deviceDataId = OpenPay.deviceData.setup("openpayForm", "deviceIdField");
            //var deviceDataId = OpenPay.deviceData.setup();

            $('#deviceId').text(deviceDataId);
            $('#deviceSessionId').val($('#deviceIdField').val());
        });
    </script>
    <style type="text/css">
        .tableCell {
            width: 48%;
            display: table-cell;
            padding: 10px;
        }
        .tableRow {
            width: 800px;
            display: table-row;
        }
        p {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #333;
            margin-top: 5px;
            margin-right: 0px;
            margin-bottom: 8px;
            margin-left: 0px;
        }
        .table {
            display: table;
            width: 800px;
            padding: 5px;
            margin: 0px;
        }
        .inputText {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            width: 100%;
        }
        .inputTextarea {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            height: 280px;
            width: 100%;
        }
        label {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
    </style>
<body>
<h1>OpenPay Javascript API Library Test</h1>

<div class="table">
    <div class="tableRow">
        <div class="tableCell">
            <p>Mode:</p>
            <select id="mode" class="inputSelect disableOnSubmit">
                <option value="true">Sandbox</option>
                <option value="false">Production</option>
            </select>
        </div>
    </div>
    <div class="tableRow">
        <div class="tableCell">
            <p>Merchant ID:</p>
            <input type="text" class="inputText disableOnSubmit" id="id" value="mqxn16kmicqj2fde6fhi" size="50" />
        </div>
        <div class="tableCell">
            <p>Request API Key:</p>
            <input type="text" class="inputText disableOnSubmit" id="apiKey" value="pk_c74367b872364e91b3143c5d87d64bb8" size="50" />
        </div>
    </div>
</div>

<div class="table">
    <form id="openpayForm">
        <fieldset>
            <legend>SessionId</legend>
            <div class="tableRow">
                <div class="tableCell">
                    <p>Generated Session Id: <span id="deviceId"></span></p>
                </div>
            </div>
            <div class="tableRow">
                <div class="tableCell">
                    <p>Hidden value:</p>
                    <input type="text" class="inputText disableOnSubmit" id="deviceSessionId" size="50"/>
                </div>
            </div>
        </fieldset>
    </form>
</div>


</body>
</html>