import 'dart:developer';
import 'package:chat_app/constants.dart';
import 'package:chat_app/screens/home_screen.dart';
import 'package:country_list/country_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginScreenController extends GetxController {
  RxString selectedCountry = 'Pakistan'.obs;
  RxString userPhoneNumber = ''.obs;
  RxString countryDialCode = '+92'.obs;
  RxBool isDialCodeValid = true.obs;

  final TextEditingController _codeController = TextEditingController();

  List<String> countryCodes = Countries.list.map((e) => e.dialCode).toList();

  void handleCountryDialCode(value) {
    if (countryCodes.contains(value)) {
      isDialCodeValid.value = true;
      var country =
          Countries.list.where((element) => element.dialCode == value).toList();
      selectedCountry.value = country[0].name;
      countryDialCode.value = country[0].dialCode;
    } else {
      isDialCodeValid.value = false;
      EasyLoading.showToast('Please, enter a valid country dial code!');
    }
  }

  Future registerUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 50),
      verificationCompleted: (PhoneAuthCredential authCredential) async {
        await _auth
            .signInWithCredential(authCredential)
            .then(
              (UserCredential result) => Get.to(
                HomeScreen(
                  user: result.user!,
                ),
              ),
            )
            .catchError(
          (error) {
            log(error);
          },
        );
      },
      verificationFailed: (FirebaseAuthException authException) {
        if (authException.code == 'invalid-phone-number') {
          log('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Enter SMS code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String smsCode = _codeController.text.trim();
                    PhoneAuthCredential _credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsCode);
                    await auth.signInWithCredential(_credential).then(
                      (UserCredential result) {
                        Get.to(
                          HomeScreen(user: result.user!),
                        );
                      },
                    ).catchError(
                      (error) {
                        log(error);
                      },
                    );
                  },
                  child: const Text("Done"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primarySwatchColor),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log(verificationId);
        log("Auto Retrieval Timeout");
      },
    );
  }
}
