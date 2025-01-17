<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml" lang="es-ES">
<head profile="http://gmpg.org/xfn/11">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
    <!-- <script type='text/javascript' src="https://openpay.s3.amazonaws.com/openpay.v1.js"></script> -->
    <script type='text/javascript' src="../lib/openpay.v1.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            function setDisableElements(_status){
                $('.disableOnSubmit').attr('disabled', _status);
            };

            function displayResultsCard(_message, _response, _sandboxMode) {
                setDisableElements(false);
                $('#responseCard').text(_message + (_response !== null ? ' ' + JSON.stringify(_response) : ''));
            };

            function successCard(_responseData) {
                displayResultsCard('Request proceessed successfully: ', _responseData);
            };
            function errorCard(_errorResponseData){
                displayResultsCard('An error has been ocurred: ', _errorResponseData);
            };

            function setMode(mode){
                if(mode ==='Sandbox'){
                    OpenPay.setSandboxMode(true);
                } else if(mode === 'Develop'){
                    OpenPay.setDevelopMode(true);
                } else {
                    OpenPay.setSandboxMode(false);
                    OpenPay.setDevelopMode(false);
                }
            }

            function callCreateToken() {
                var _id = '', _apiKey = '', _data = null, _dataCard = '';

                setDisableElements(true);
                $('#responseCard').text('');
                $('#dataCard').text('');
                setMode($('#mode').val());
                _id = $('#id').val();
                _apiKey = $('#apiKey').val();
                _dataCard = OpenPay.extractFormInfo($('#processCard'));
                $('#dataCard').text(JSON.stringify(_dataCard));
                try {
                    OpenPay.setId(_id);
                    OpenPay.setApiKey(_apiKey);
                    OpenPay.token.create(_dataCard, successCard, errorCard);
                } catch (e) {
                    setDisableElements(true);
                    displayResultsCard('Request failed (invalid data)', null);
                }
            };
            //Envio directo
            function callDirectCreateToken() {
                var _id = '', _apiKey = '', _data = null, _dataCard = '';

                setDisableElements(true);
                $('#responseCard').text('');
                $('#dataCard').text('');
                setMode($('#mode').val());
                _id = $('#id').val();
                _apiKey = $('#apiKey').val();
                try {
                    OpenPay.setId(_id);
                    OpenPay.setApiKey(_apiKey);
                    OpenPay.token.extractFormAndCreate($('#processCard'), successCard, errorCard);
                } catch (e) {
                    setDisableElements(true);
                    displayResultsCard('Request failed (invalid data)', null);
                }
            };


            $('#makeRequestCard').click(function(e){
                $('#showData').val() == 'true' ? callCreateToken() : callDirectCreateToken();
            });
            $('#updateRequestCard').click(function(e){
                var _id = '', _apiKey = '', _data = null, _dataCard = '', complete = false;
                if($('#apiKeyPut').val()==='' || $('#idPut')===''){
                    alert("The API Key and Merchant Id are required");
                }
                else {
                    setMode($('#mode').val());
                    _id = $('#idPut').val();
                    _apiKey = $('#apiKeyPut').val();
                    if($('#groupPut').val()!==null && $('#groupPut').val().length>0){
                        if( ($('#customerPut').val()!=null && $('#customerPut').val().length>0) && ($('#cardPut').val()!=null && $('#cardPut').val().length>0 ) ){
                            try {
                                OpenPay.setId(_id);
                                OpenPay.setApiKey(_apiKey);
                                OpenPay.Group.setId($('#groupPut').val());
                                _customerId = ($('#customerPut').val()!=null && $('#customerPut').val().length>0) ? $('#customerPut').val() : null;
                                _mycard 	= ($('#cardPut').val()!=null 	 && $('#cardPut').val().length>0) 	? $('#cardPut').val() : null;
                                OpenPay.Group.card.extractFormAndUpdateCard($('#putUpdateCard'), successCard, errorCard, _customerId, _mycard);
                            } catch(e){
                                setDisableElements(true);
                                displayResultsCard('Request failed (invalid data)', e, null);
                            }
                        }
                        else {
                            alert('If you send Group Id, too you will should send customer id and card id');
                        }
                    }
                    else if( ($('#customerPut').val()!=null && $('#customerPut').val().length>0) || ($('#cardPut').val()!=null && $('#cardPut').val().length>0) ) {
                        try {
                            OpenPay.setId(_id);
                            OpenPay.setApiKey(_apiKey);
                            _customerId = ($('#customerPut').val()!=null && $('#customerPut').val().length>0) ? $('#customerPut').val() : null;
                            _mycard 	= ($('#cardPut').val()!=null 	 && $('#cardPut').val().length>0) 	? $('#cardPut').val() : null;
                            OpenPay.card.extractFormAndUpdateCard($('#putUpdateCard'), successCard, errorCard, _customerId, _mycard);
                        } catch(e){
                            setDisableElements(true);
                            displayResultsCard('Request failed (invalid data)', e, null);
                        }
                    }
                    else {
                        alert("You should send to Customer ID or Card ID, other option, you send  Group ID with Customer ID and Card ID.");
                    }
                }
            });
            $('#updateRequestCardJson').click(function(e){
                var _id = '', _apiKey = '', _data = null, _dataCard = '', complete = false;
                if($('#apiKeyPut').val()==='' || $('#idPut')===''){
                    alert("The API Key and Merchant Id are required");
                }
                else {
                    setMode($('#mode').val());
                    _id = $('#idPut').val();
                    _apiKey = $('#apiKeyPut').val();
                    if($('#groupPut').val()!==null && $('#groupPut').val().length>0){
                        if( ($('#customerPut').val()!=null && $('#customerPut').val().length>0) && ($('#cardPut').val()!=null && $('#cardPut').val().length>0 ) ){
                            try {
                                var coma = false;
                                OpenPay.setId(_id);
                                OpenPay.setApiKey(_apiKey);
                                OpenPay.Group.setId($('#groupPut').val());
                                OpenPay.Group.setApiKey(_apiKey);
                                _customerId = ($('#customerPut').val()!=null && $('#customerPut').val().length>0) ? $('#customerPut').val() : null;
                                _mycard 	= ($('#cardPut').val()!=null 	 && $('#cardPut').val().length>0) 	? $('#cardPut').val() : null;
                                params = '{';
                                if($("#holderNamePut").val().length > 0){
                                    coma = true;
                                    params += '"holder_name":"'+$("#holderNamePut").val()+'"';
                                }
                                if($("#cvv2Put").val().length > 0){
                                    if(coma){
                                        params += ',';
                                    }
                                    params += '"cvv2":"'+$("#cvv2Put").val()+'"';
                                    coma = true;
                                }
                                if($("#expirationYearPut").val().length > 0){
                                    if(coma){
                                        params += ',';
                                    }
                                    params += '"expiration_year":"'+$("#expirationYearPut").val()+'"';
                                    coma = true;
                                }
                                if($("#expirationMonthPut").val().length > 0){
                                    if(coma){
                                        params += ',';
                                    }
                                    params += '"expiration_month":"'+$("#expirationMonthPut").val()+'"';
                                    coma = true;
                                }
                                params += '}';
                                OpenPay.Group.card.update(JSON.parse(params), successCard, errorCard, _customerId, _mycard);
                            } catch(e){
                                setDisableElements(true);
                                displayResultsCard('Request failed (invalid data)', e, null);
                            }
                        }
                        else {
                            alert('If you send Group Id, too you will should send customer id and card id');
                        }
                    }
                    else if( ($('#customerPut').val()!=null && $('#customerPut').val().length>0) || ($('#cardPut').val()!=null && $('#cardPut').val().length>0) ) {
                        var coma = false;
                        try {
                            OpenPay.setId(_id);
                            OpenPay.setApiKey(_apiKey);
                            _customerId = ($('#customerPut').val()!=null && $('#customerPut').val().length>0) ? $('#customerPut').val() : null;
                            _mycard 	= ($('#cardPut').val()!=null 	 && $('#cardPut').val().length>0) 	? $('#cardPut').val() : null;
                            params = '{';
                            if($("#holderNamePut").val().length > 0){
                                coma = true;
                                params += '"holder_name":"'+$("#holderNamePut").val()+'"';
                            }
                            if($("#cvv2Put").val().length > 0){
                                if(coma){
                                    params += ',';
                                }
                                params += '"cvv2":"'+$("#cvv2Put").val()+'"';
                                coma = true;
                            }
                            if($("#expirationYearPut").val().length > 0){
                                if(coma){
                                    params += ',';
                                }
                                params += '"expiration_year":"'+$("#expirationYearPut").val()+'"';
                                coma = true;
                            }
                            if($("#expirationMonthPut").val().length > 0){
                                if(coma){
                                    params += ',';
                                }
                                params += '"expiration_month":"'+$("#expirationMonthPut").val()+'"';
                                coma = true;
                            }
                            params += '}';
                            OpenPay.card.update(JSON.parse(params), successCard, errorCard, _customerId, _mycard);
                        } catch(e){
                            setDisableElements(true);
                            displayResultsCard('Request failed (invalid data)', e, null);
                        }
                    }
                    else {
                        alert("You should send to Customer ID or Card ID, other option, you send  Group ID with Customer ID and Card ID.");
                    }
                }
            });


            // --------------------------

            function validate() {
                console.log("validando...");
                var _number = '', _cvc = '', _month = '', _year = '', _type = '';
                setDisableElements(true);
                $('#valid').prop('checked', false);
                $('#accepted').prop('checked', false);
                $('#cvcValid').prop('checked', false);
                $('#cvcExpiry').prop('checked', false);
                $('#typeNumber').prop('checked', false);
                $('#typeName').text('');

                _number = ($('#cardNumberValidation').val() != '' ? $('#cardNumberValidation').val() : $('#cardTypes').val());
                _cvc = $('#cvc').val();
                _month = $('#expiryMonth').val();
                _year = $('#expiryYear').val();

                if (OpenPay.card.validateCardNumber(_number)) {
                    $('#valid').prop('checked', true);
                    console.log(_number);
                    _type = OpenPay.card.cardType(_number);
                    console.log(_type);
                    if (_type != '') {
                        $('#typeNumber').prop('checked', true);
                        $('#typeName').text('[' + _type.toUpperCase() + ']');
                    } else {
                        $('#typeName').text('UNKNOWN');
                    }
                }
                if (OpenPay.card.validateAcceptCardNumber(_number)) {
                    $('#accepted').prop('checked', true);
                }
                if (OpenPay.card.validateCVC(_cvc)) {
                    $('#cvcValid').prop('checked', true);
                }
                if (OpenPay.card.validateExpiry(_month, _year)) {
                    $('#cvcExpiry').prop('checked', true);
                }
                setDisableElements(false);
            }

            $('#makeValidation').click(function(e){
                validate();
            });


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
        fieldset {
            width: 800px;
        }
        label {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
    </style>
    <head profile="http://gmpg.org/xfn/11">
<body>
<h1>OpenPay Javascript API Library Test</h1>

<div class="table">
    <div class="tableRow">
        <div class="tableCell">
            <p>Mode: </p>
            <select id="mode" class="inputSelect disableOnSubmit">
                <option value="Develop">Develop</option>
                <option value="Sandbox">Sandbox</option>
                <option value="Production">Production</option>
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
            <input type="text" class="inputText disableOnSubmit" id="apiKey" value="pk_c74367b872364e91b3143c5d87d64bb8"
                   size="50" />
        </div>
    </div>
</div>


<fieldset>
    <legend><b>Create a : <select id="objectToCreate" class="inputSelect disableOnSubmit">
        <option value="false">token</option>
    </select> <b></legend>
    <div class="table">
        <div class="tableRow">
            <div class="tableCell">
                <p>Show Data: </p>
                <select id="showData" class="inputSelect disableOnSubmit">
                    <option value="true">true</option>
                    <option value="false">false</option>
                </select>
            </div>
        </div>
    </div>
    <!-- form to create a card -->
    <div class="table">
        <form id="processCard">
            <div class="tableRow">
                <div class="tableCell">
                    <p>Holder Name:</p>
                    <input type="text" data-openpay-card="holder_name" class="inputText disableOnSubmit" id="holderName" size="50"
                           value="Juan Perez Ramirez" />
                </div>
                <div class="tableCell">
                    <p>Card number:</p>
                    <input type="text" data-openpay-card="card_number" class="inputText disableOnSubmit" id="cardNumber" size="50"
                           value="4111111111111111" />
                </div>
            </div>
            <div class="tableRow">
                <div class="tableCell">
                    <p>Expiration year:</p>
                    <input type="text" data-openpay-card="expiration_year" class="inputText disableOnSubmit" id="expirationYear" size="4" value="20" />
                </div>
                <div class="tableCell">
                    <p>Expiration month:</p>
                    <input type="text" data-openpay-card="expiration_month" class="inputText disableOnSubmit" id="expirationMonth" size="4"
                           value="04" />
                </div>
            </div>

            <div class="tableRow">
                <div class="tableCell">
                    <p>cvv2:</p>
                    <input type="text" data-openpay-card="cvv2" class="inputText disableOnSubmit" id="cvv2" size="5" value="110" />
                </div>
            </div>

            <fieldset>
                <legend>Address:</legend>
                <div class="tableRow">
                    <div class="tableCell">
                        <p>Street:</p>
                        <input type="text" data-openpay-card-address="line1" class="inputText disableOnSubmit" id="line1" size="20" value="Av 5 de febrero" />
                    </div>
                    <div class="tableCell">
                        <p>Number:</p>
                        <input type="text" data-openpay-card-address="line2" class="inputText disableOnSubmit" id="line2" size="20" value="Roble 207" />
                    </div>
                    <div class="tableCell">
                        <p>References:</p>
                        <input type="text" data-openpay-card-address="line3" class="inputText disableOnSubmit" id="line3" size="20" value="Queretaro" />
                    </div>
                </div>
                <div class="tableRow">
                    <div class="tableCell">
                        <p>Postal code:</p>
                        <input type="text" data-openpay-card-address="postal_code" class="inputText disableOnSubmit" id="postal_code" size="6" value="76900" />
                    </div>
                    <div class="tableCell">
                        <p>City:</p>
                        <input type="text" data-openpay-card-address="city" class="inputText disableOnSubmit" id="city" size="20" value="Queretaro" />
                    </div>
                    <div class="tableCell">
                        <p>State:</p>
                        <input type="text" data-openpay-card-address="state" class="inputText disableOnSubmit" id="state" size="20" value="Queretaro" />
                    </div>
                </div>
                <div class="tableRow">
                    <div class="tableCell">
                        <p>Country code:</p>
                        <input type="text" data-openpay-card-address="country_code" class="inputText disableOnSubmit" id="country_code" size="3" value="MX" />
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
    <div class="table">
        <!-- fin form to create a card -->
        <div class="tableRow">
            <div class="tableCell">
                <p>
                    Create Card Request data <span id="responseMode" />:
                </p>
                <textarea id="dataCard" class="inputTextarea disableOnSubmit" rows="19" cols="50">

                </textarea>
            </div>
            <div class="tableCell">
                <p class="response">Request response:</p>
                <textarea id="responseCard" class="inputTextarea disableOnSubmit" rows="19" cols="50">
                </textarea>
            </div>
        </div>
        <div class="tableRow">
            <div class="tableCell">
                <input type="button" class="disableOnSubmit" id="makeRequestCard" value="Create" />
            </div>
        </div>
    </div>
</fieldset>

<fieldset>
    <legend>Validate a card:</legend>
    <div class="table">
        <div class="tableRow">
            <div class="tableCell">
                <p>Select Card Type:</p>
                <select id="cardTypes" class="inputSelect disableOnSubmit">
                    <option value="5555555555554444">5555555555554444 [MASTERCARD]</option>
                    <option value="5105105105105100">5105105105105100 [MASTERCARD]</option>
                    <option value="4111111111111111">4111111111111111 [VISA]</option>
                    <option value="4012888888881881">4012888888881881 [VISA]</option>
                    <option value="4917300800000000">4917300800000000 [VISA ELECTRON]</option>
                    <option value="378282246310005">378282246310005 [AMEX]</option>
                    <option value="378734493671000">378734493671000 [AMEX CORPORATE]</option>
                    <option value="30569309025904">30569309025904 [DINERS]</option>
                    <option value="6011111111111117">6011111111111117[DISCOVER]</option>
                    <option value="3530111333300000">3530111333300000 [JCB]</option>
                    <option value="630490017740292441">630490017740292441 [LASER]</option>
                </select>
            </div>
            <div class="tableCell">
                <p>Type Card Number:</p>
                <input type="text" id="cardNumberValidation" class="inputText disableOnSubmit" />
            </div>
        </div>
        <div class="tableRow">
            <div class="tableCell">
                <p>Expiry Month / Year</p>
                <select id="expiryMonth" class="inputSelect disableOnSubmit">
                    <option value="1" selected="selected">01</option>
                    <option value="2">02</option>
                    <option value="3">03</option>
                    <option value="4">04</option>
                    <option value="5">05</option>
                    <option value="6">06</option>
                    <option value="7">07</option>
                    <option value="8">08</option>
                    <option value="9">09</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select> <select id="expiryYear" class="inputSelect disableOnSubmit">
                <option value="2016">2016</option>
                <option value="2017">2017</option>
                <option value="2018" selected="selected">2018</option>
                <option value="2019">2019</option>
                <option value="2020">2020</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
            </select>
            </div>
            <div class="tableCell">
                <p>CVC:</p>
                <input type="text" id="cvc" class="inputText disableOnSubmit" />
            </div>
        </div>
        <div class="tableRow">
            <div class="tableCell">
                <p>Validation:</p>
                <label><input type="checkbox" id="valid" class="disableOnSubmit" /> Is the card number valid?</label><br /> <label><input
                    type="checkbox" id="accepted" class="disableOnSubmit" /> Is the card number accepted?</label><br /> <label><input
                    type="checkbox" id="cvcValid" class="disableOnSubmit" /> Is the CVC valid?</label><br /> <label><input
                    type="checkbox" id="cvcExpiry" class="disableOnSubmit" /> Is the expiry date valid?</label><br /> <label><input
                    type="checkbox" id="typeNumber" class="disableOnSubmit" /> Which brand is the card number? <span id="typeName"></span></label><br />
            </div>
        </div>
        <div class="tableRow">
            <input type="button" class="disableOnSubmit" id="makeValidation" value="Validate" />
        </div>
    </div>
</fieldset>

<fieldset>
    <legend>Update card data:</legend>
    <div class="table">
        <form id="getUpdateCard">
            <div class="tableRow">
                <div class="tableCell"><p>Request API Key:</p> <input type="text" class="inputText disableOnSubmit" id="apiKeyPut" value="pk_c74367b872364e91b3143c5d87d64bb8" size="50" /></div>
                <div class="tableCell"><p>Merchant ID:</p> <input type="text" class="inputText disableOnSubmit" id="idPut" value="mqxn16kmicqj2fde6fhi" size="50" /></div>
            </div>
            <div class="tableRow">
                <div class="tableCell"><p>Group ID:</p> <input type="text" class="inputText disableOnSubmit" id="groupPut" value="" size="50" /></div>
                <div class="tableCell"><p>Customer ID:</p> <input type="text" class="inputText disableOnSubmit" id="customerPut" value="" size="50" /></div>
            </div>
            <div class="tableRow">
                <div class="tableCell"><p>Card ID:</p> <input type="text" class="inputText disableOnSubmit" id="cardPut" value="" size="50" /></div>
            </div>
        </form>
    </div>
    <div class="table">
        <form id="putUpdateCard">
            <div class="tableRow">
                <div class="tableCell">
                    <p>Holder Name:</p>
                    <input type="text" data-openpay-card="holder_name" class="inputText disableOnSubmit" id="holderNamePut" size="50"
                           value="Juan Perez Ramirez" />
                </div>
                <div class="tableCell">
                    <p>cvv2:</p>
                    <input type="text" data-openpay-card="cvv2" class="inputText disableOnSubmit" id="cvv2Put" size="5" value="110" />
                </div>
            </div>
            <div class="tableRow">
                <div class="tableCell">
                    <p>Expiration year:</p>
                    <input type="text" data-openpay-card="expiration_year" class="inputText disableOnSubmit" id="expirationYearPut" size="4" value="20" />
                </div>
                <div class="tableCell">
                    <p>Expiration month:</p>
                    <input type="text" data-openpay-card="expiration_month" class="inputText disableOnSubmit" id="expirationMonthPut" size="4"
                           value="04" />
                </div>
            </div>
            <div class="tableRow">
                <div class="tableCell">
                    <p>* You can modified the fields.</p>
                </div>
                <div class="tableCell"><input type="button" class="disableOnSubmit" id="updateRequestCard" value="Update Form" /></div>
                <div class="tableCell"><input type="button" class="disableOnSubmit" id="updateRequestCardJson" value="Update Json" /></div>
            </div>
        </form>
    </div>
</fieldset>
</br>
</body>

</html>