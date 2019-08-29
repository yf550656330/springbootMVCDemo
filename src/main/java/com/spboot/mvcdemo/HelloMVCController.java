package com.spboot.mvcdemo;

import com.spboot.mvcdemo.request.dto.BankCodeReq;
import com.spboot.mvcdemo.request.dto.CardReq;
import com.spboot.mvcdemo.request.dto.CustomerReq;
import com.spboot.mvcdemo.request.dto.PayoutReq;
import com.spboot.mvcdemo.util.TestUtils;
import mx.openpay.client.BankAccount;
import mx.openpay.client.Card;
import mx.openpay.client.Customer;
import mx.openpay.client.Payout;
import mx.openpay.client.core.OpenpayAPI;
import mx.openpay.client.core.requests.transactions.CreateBankPayoutParams;
import mx.openpay.client.exceptions.OpenpayServiceException;
import mx.openpay.client.exceptions.ServiceUnavailableException;
import mx.openpay.client.utils.SearchParams;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class HelloMVCController {
    String merchantId = "mx5ojhfkmh7izcxginwy";
    String apiKey = "sk_af5f179a9bd2493e91e8bbbedc7fdb82";
    String endpoint = "https://sandbox-api.openpay.mx/";
    @RequestMapping("/mvc")
    public String Hello(){
        return "hello";
    }

    @RequestMapping("/welcome")
    public String welcome(){
        return "welcome";
    }
    @RequestMapping("/creatCustomer")
    public ModelAndView creatCustomer(CustomerReq req){
        OpenpayAPI api = new OpenpayAPI(endpoint, apiKey, merchantId);
        Customer customer = null;
        try {
            customer = api.customers().create(
                    new Customer().name(req.getCustomerName()).lastName(req.getLastName()).email(req.getEmail()).phoneNumber(req.getPhone())
                            .requiresAccount(true).externalId(req.getExternalId()));
        } catch (OpenpayServiceException e) {
            e.printStackTrace();
        } catch (ServiceUnavailableException e) {
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("bank_code_page");
        mv.addObject("customerId", customer.getId());
        return mv;
    }
    @RequestMapping("cardInfopage")
    public String cardInfopage(){
        return "create_card";
    }

    @RequestMapping("createCard")
    public ModelAndView createCard(CardReq req){

        OpenpayAPI api = new OpenpayAPI(endpoint, apiKey, merchantId);
        Card card = null;
        try {//a6quwfxfztqrjifeni3t
            card = api.cards().create(req.getCustomerId(), new Card()
                    .cardNumber(req.getCardNumber())
                    .holderName(req.getHolderName())
                    .cvv2(req.getCvv2())
                    .expirationMonth(req.getExpirationMonth())
                    .expirationYear(req.getExpirationYear())
                    .address(TestUtils.prepareAddress()));
        } catch (OpenpayServiceException e) {
            e.printStackTrace();
        } catch (ServiceUnavailableException e) {
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("create_customer_success");
        mv.addObject("cardId", card.getId());//kyvt2fvpdn72dqxu8gvg
        return mv;
    }
    @RequestMapping("bankcodePage")
    public String bankCodePage(){
        return "bank_code_page";
    }
    @RequestMapping("createBankCode")
    public ModelAndView createBankCode(BankCodeReq req){
        BankAccount bankAccount = new BankAccount()
                .clabe(req.getClabe()) // CLABE
                .holderName(req.getHolderName())
                .alias(req.getAlias());
        OpenpayAPI api = new OpenpayAPI(endpoint, apiKey, merchantId);
        BankAccount account = null;
        try {
            account = api.bankAccounts().create(req.getCustomerId(), bankAccount);
        } catch (Exception e) {
            try {
                api.customers().delete(req.getCustomerId());
            } catch (OpenpayServiceException ex) {
                ex.printStackTrace();
            } catch (ServiceUnavailableException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("payout");
        mv.addObject("bankId", account==null?0:account.getId());
        mv.addObject("customerId", req.getCustomerId());
        return mv;
    }

    @RequestMapping("payoutpage")
    public String payout(){

        return "payout";
    }
    @RequestMapping("createPayout")
    public ModelAndView createPayout(PayoutReq req){
        OpenpayAPI api = new OpenpayAPI(endpoint, apiKey, merchantId);
        Payout payout = null;
        try {
            payout = api.payouts().create(req.getCustomerId(), new CreateBankPayoutParams()
                    .bankAccountId(req.getBankId())
                    .amount(new BigDecimal(req.getAmount()))
                    .description(req.getDescription())
                    .orderId(req.getOrderId()));
        } catch (Exception e) {
            try {
                api.bankAccounts().delete(req.getCustomerId(),req.getBankId());
                api.customers().delete(req.getCustomerId());
            } catch (OpenpayServiceException ex) {
                ex.printStackTrace();
            } catch (ServiceUnavailableException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
        ModelAndView mv = new ModelAndView("create_customer_success");
        mv.addObject("id", payout.getId());
        return mv;
    }

}
