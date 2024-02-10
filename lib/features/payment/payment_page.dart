import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/user_profile/controller/user_profile_controller.dart';

class RazorPayPage extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const RazorPayPage(),
      );
  const RazorPayPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RazorPayPageState();
}

class _RazorPayPageState extends ConsumerState<RazorPayPage> {
  var currUser;
  @override
  Widget build(BuildContext context) {
    currUser = ref.watch(currentUserDetailsProvider).value;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              ElevatedButton(
                  onPressed: () {
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_RBCIHdXhdH7WPW',
                      'amount': 99900,
                      'name': 'Chandrakant',
                      // 'description': 'Fine T-Shirt',
                      // 'retry': {'enabled': true, 'max_count': 1},
                      // 'send_sms_hash': true,
                      'prefill': {
                        'contact': '9876543210',
                        'email': 'test@razorpay.com'
                      },
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                        handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                        handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                        handleExternalWalletSelected);
                    try {
                      razorpay.open(options);
                    } catch (e) {
                      debugPrint('Error : $e');
                    }
                  },
                  child: const Text("Pay with Razorpay")),
            ],
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.message.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.orderId.toString());
    // showAlertDialog(
    //     context, "Payment Successful", "Payment ID: ${response.paymentId}");
    ref.read(userProfileControllerProvider.notifier).updateUserProfile(
        userModel: currUser.copyWith(
          isTwitterBlue: true,
        ),
        context: context,
        bannerFile: null,
        profileFile: null);

    Fluttertoast.showToast(
      msg: "Payment Successful${response.paymentId}",
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
    // Fluttertoast.showToast(
    //     msg: "External Wallet Selected ${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
