import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickettapper/InHome/pay.dart';
import 'package:tickettapper/InHome/qr_gen.dart';
import 'package:tickettapper/Payment/Colors.dart';
import 'package:tickettapper/Payment/transaction_service.dart';
import 'package:uuid/uuid.dart';
import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/google_pay_constants.dart'
    as google_pay_constants;
import 'cookie_button.dart';
import 'dialog_modal.dart';
// We use a custom modal bottom sheet to override the default height (and remove it).
import 'modal_bottom_sheet.dart' as custom_modal_bottom_sheet;
import 'order_sheet.dart';

enum ApplePayStatus { success, fail, unknown }

class BuySheet extends StatefulWidget {
  final bool applePayEnabled;
  final bool googlePayEnabled;
  final String squareLocationId;
  final String applePayMerchantId;
  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();


  BuySheet(
      {this.applePayEnabled,
      this.googlePayEnabled,
      this.applePayMerchantId,
      this.squareLocationId});

  @override
  BuySheetState createState() => BuySheetState();
}

class BuySheetState extends State<BuySheet> {
  ApplePayStatus _applePayStatus = ApplePayStatus.unknown;

  bool get _chargeServerHostReplaced => chargeServerHost != "https://tickettapper.herokuapp.com/chargeForCookie";

  bool get _squareLocationSet => widget.squareLocationId != "BT4ZW0W2NM5JG";

  bool get _applePayMerchantIdSet => widget.applePayMerchantId != "REPLACE_ME";

  void showOrderSheet() async {
    sleep(const Duration(seconds:1));
    var selection =
        await custom_modal_bottom_sheet.showModalBottomSheet<PaymentType>(
            context: BuySheet.scaffoldKey.currentState.context,
            builder: (context) => OrderSheet(applePayEnabled: widget.applePayEnabled, googlePayEnabled: widget.googlePayEnabled,));

    switch (selection) {
      case PaymentType.cardPayment:
        await onStartCardEntryFlow();
        break;
      case PaymentType.googlePay:
        if (_squareLocationSet && widget.googlePayEnabled) {
          _onStartGooglePay();
        } else {
          _showSquareLocationIdNotSet();
        }
        break;
      case PaymentType.applePay:
        if (_applePayMerchantIdSet && widget.applePayEnabled) {
          _onStartApplePay();
        } else {
          _showapplePayMerchantIdNotSet();
        }
        break;
    }
  }

  void printCurlCommand(String nonce) {
    var uuid = Uuid().v4();
    print(
        'curl --request POST https://connect.squareup.com/v2/locations/BT4ZW0W2NM5JG/transactions \\'
        '--header \"Content-Type: application/json\" \\'
        '--header \"Authorization: Bearer sq0atp-RP1Wo5gjDyH4ujKywtW3WA\" \\'
        '--header \"Accept: application/json\" \\'
        '--data \'{'
        '\"idempotency_key\": \"$uuid\",'
        '\"amount_money\": {'
        '\"amount\": $cookieAmount,'
        '\"currency\": \"Eur\"},'
        '\"card_nonce\": \"cnon:CBASEOUR395ND0AiJDZh7nBpCuU\"'
        '}\'');
  }

  void _showUrlNotSetAndPrintCurlCommand(String nonce) {
    showAlertDialog(
        context: BuySheet.scaffoldKey.currentContext,
        title: "Payment Sucessful",
        description:
        "Check your console for a CURL command to charge the nonce, or replace CHARGE_SERVER_HOST with your server host.");
    printCurlCommand(nonce);
  }

  void _showSquareLocationIdNotSet() {
    showAlertDialog(
        context: BuySheet.scaffoldKey.currentContext,
        title: "Missing Square Location ID",
        description:
            "To request a Google Pay nonce, replace squareLocationId in main.dart with a Square Location ID.");
  }

  void _showapplePayMerchantIdNotSet() {
    showAlertDialog(
        context: BuySheet.scaffoldKey.currentContext,
        title: "Missing Apple Merchant ID",
        description:
            "To request an Apple Pay nonce, replace applePayMerchantId in main.dart with an Apple Merchant ID.");
  }

  void _onCardEntryComplete() {
    if (_chargeServerHostReplaced) {
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Your order was successful",
          description:
              "Go to your Square dashbord to see this order reflected in the sales tab.");
    }
  }

  void _onCardEntryCardNonceRequestSuccess(CardDetails result) async {
    if (!_chargeServerHostReplaced) {
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
      _showUrlNotSetAndPrintCurlCommand(result.nonce);
      return;
    }
    try {
      await chargeCard(result);
      InAppPayments.completeCardEntry(
          onCardEntryComplete: _onCardEntryComplete);
    } on ChargeException catch (ex) {
      InAppPayments.showCardNonceProcessingError(ex.errorMessage);
    }
  }

  Future<void> onStartCardEntryFlow() async {
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow,
        collectPostalCode: true);
  }

  void _onCancelCardEntryFlow() {
    showOrderSheet();
  }

  void _onStartGooglePay() async {
    try {
      await InAppPayments.requestGooglePayNonce(
          priceStatus: google_pay_constants.totalPriceStatusFinal,
          price: getCookieAmount(),
          currencyCode: 'Eur',
          onGooglePayNonceRequestSuccess: _onGooglePayNonceRequestSuccess,
          onGooglePayNonceRequestFailure: _onGooglePayNonceRequestFailure,
          onGooglePayCanceled: onGooglePayEntryCanceled);
    } on PlatformException catch (ex) {
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Failed to start GooglePay",
          description: ex.toString());
    }
  }

  void _onGooglePayNonceRequestSuccess(CardDetails result) async {
    if (!_chargeServerHostReplaced) {
      _showUrlNotSetAndPrintCurlCommand(result.nonce);
      return;
    }
    try {
      await chargeCard(result);
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Your order was successful",
          description:
              "Go to your Square dashbord to see this order reflected in the sales tab.");
    } on ChargeException catch (ex) {
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Error processing GooglePay payment",
          description: ex.errorMessage);
    }
  }

  void _onGooglePayNonceRequestFailure(ErrorInfo errorInfo) {
    showAlertDialog(
        context: BuySheet.scaffoldKey.currentContext,
        title: "Failed to request GooglePay nonce",
        description: errorInfo.toString());
  }

  void onGooglePayEntryCanceled() {
    showOrderSheet();
  }

  void _onStartApplePay() async {
    try {
      await InAppPayments.requestApplePayNonce(
          price: getCookieAmount(),
          summaryLabel: 'Cookie',
          countryCode: 'US',
          currencyCode: 'USD',
          onApplePayNonceRequestSuccess: _onApplePayNonceRequestSuccess,
          onApplePayNonceRequestFailure: _onApplePayNonceRequestFailure,
          onApplePayComplete: _onApplePayEntryComplete);
    } on PlatformException catch (ex) {
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Failed to start ApplePay",
          description: ex.toString());
    }
  }

  void _onApplePayNonceRequestSuccess(CardDetails result) async {
    if (!_chargeServerHostReplaced) {
      await InAppPayments.completeApplePayAuthorization(isSuccess: false);
      _showUrlNotSetAndPrintCurlCommand(result.nonce);
      return;
    }
    try {
      await chargeCard(result);
      _applePayStatus = ApplePayStatus.success;
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Your order was successful",
          description:
              "Go to your Square dashbord to see this order reflected in the sales tab.");
      await InAppPayments.completeApplePayAuthorization(isSuccess: true);
    } on ChargeException catch (ex) {
      await InAppPayments.completeApplePayAuthorization(
          isSuccess: false, errorMessage: ex.errorMessage);
      showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Error processing ApplePay payment",
          description: ex.errorMessage);
      _applePayStatus = ApplePayStatus.fail;
    }
  }

  void _onApplePayNonceRequestFailure(ErrorInfo errorInfo) async {
    _applePayStatus = ApplePayStatus.fail;
    await InAppPayments.completeApplePayAuthorization(
        isSuccess: false, errorMessage: errorInfo.message);
    showAlertDialog(
          context: BuySheet.scaffoldKey.currentContext,
          title: "Error request ApplePay nonce",
          description: errorInfo.toString());
  }

  void _onApplePayEntryComplete() {
    if (_applePayStatus == ApplePayStatus.unknown) {
      // the apple pay is canceled
      showOrderSheet();
    }
  }

  NFCpay(){
    MyNFCState().startNFC();
    showOrderSheet();
  }

  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(canvasColor: Colors.transparent),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: new IconThemeData(color: Colors.white),
            ),
          key: BuySheet.scaffoldKey,
          body: Builder(

            builder: (context) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(50.0),
                              color: Color(0xFF18D191)),
                          child: new Icon(
                            Icons.euro_symbol,
                            color: Colors.black,
                            ),
                          ),
                        new Container(
                          margin: new EdgeInsets.only(right: 250.0, top: 50.0),
                          height: 80.0,
                          width: 80.0,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(50.0),
                              color: Color(0xFFFC6A7F)),
                          child: new Icon(
                            Icons.home,
                            color: Colors.black,
                            ),
                          ),
                        new Container(
                          margin: new EdgeInsets.only(left: 250.0, top: 50.0),
                          height: 80.0,
                          width: 80.0,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(50.0),
                              color: Color(0xFFFFCE56)),
                          child: new Icon(
                            Icons.directions_bus,
                            color: Colors.black,
                            ),
                          ),
                      ],
                      ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
                          child: new Text(
                            "Ticket Tapper",
                            style: new TextStyle(fontSize: 30.0),
                            ),
                          )
                      ],
                      ),
                    new SizedBox(
                      height: 20.0,
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child:
                          CookieButton(text: "Start NFC",
                                           onPressed: showOrderSheet), // Try NFC pay
                    ),
                  ],
                )),
          ),
        ),
      );
}
