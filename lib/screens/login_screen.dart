import 'dart:developer';
import 'dart:io';
import 'dart:html' as html;

import 'package:chat_app/constants.dart';
import 'package:chat_app/controllers/login_screen_controller.dart';
import 'package:chat_app/controllers/main_controller.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:country_list/country_list.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ResponsiveController extends GetxController {}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenController loginController =
      Get.put(LoginScreenController());

  late final TextEditingController countryDialCodeController =
      TextEditingController(text: loginController.countryDialCode.value);
  late final TextEditingController userPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    countryDialCodeController.addListener(
      () => loginController
          .handleCountryDialCode(countryDialCodeController.text.trim()),
    );
    userPhoneNumberController.addListener(() =>
        loginController.userPhoneNumber.value = userPhoneNumberController.text);
    super.initState();
    log(loginController.countryCodes.toString());
  }

  @override
  dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    countryDialCodeController.dispose();
    userPhoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find();
    final bool isDarkMode =
        mainController.brightness == Brightness.dark ? true : false;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
              horizontal: Get.width < 768 ? Get.width * 0.02 : 0.0),
          child: Row(
            children: [
              Get.width >= 768
                  ? Expanded(
                      child:
                          Image.asset('assets/images/login_illustration.png'),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.width * 0.02,
                        ),
                        child: Text(
                          'Enter your phone number',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'Chatmate will send an SMS message to verify your phone number. ',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          children: const [
                            TextSpan(
                              text: 'What\'s my number?',
                              style: TextStyle(
                                color: primarySwatchColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          focusColor: Colors.teal.shade300,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.02,
                          ),
                          child: Obx(
                            () => DropdownButton<String>(
                              value: loginController.selectedCountry.value,
                              dropdownColor:
                                  isDarkMode ? Colors.black : Colors.white,
                              alignment: AlignmentDirectional.center,
                              underline: Container(
                                height: 1.5,
                                color: Colors.teal,
                              ),
                              isExpanded: true,
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: primarySwatchColor.shade700,
                              ),
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 16,
                              ),
                              items: Countries.list
                                  .map(
                                    (country) => DropdownMenuItem<String>(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(country.name),
                                      value: country.name,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                loginController.selectedCountry.value =
                                    value!.trim();
                                var selectedCountryDialCode = Countries.list
                                    .singleWhere(
                                        (element) => element.name == value)
                                    .dialCode
                                    .trim();
                                selectedCountryDialCode =
                                    selectedCountryDialCode.replaceRange(
                                        0, 1, '');
                                loginController.countryDialCode.value =
                                    selectedCountryDialCode;

                                countryDialCodeController.text =
                                    selectedCountryDialCode.trim();
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              controller: countryDialCodeController,
                              maxLength: 4,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 16.0,
                              ),
                              decoration: const InputDecoration(
                                counterText: '',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: primarySwatchColor,
                                    width: 1.5,
                                  ),
                                ),
                                prefixText: '+',
                                prefixStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02,
                              ),
                              child: TextFormField(
                                controller: userPhoneNumberController,
                                maxLength: 12,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 16.0,
                                ),
                                decoration: const InputDecoration(
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: primarySwatchColor,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Get.height * 0.04,
                        ),
                        child: Text(
                          'Carrier SMS charges may apply',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width < 768 ? Get.height * 0.4 : 0),
                        child: Obx(
                          () => CustomTextButton(
                            text: 'Next',
                            textColor: isDarkMode ? Colors.white : Colors.black,
                            buttonBackgroundColor:
                                loginController.isDialCodeValid.value
                                    ? primarySwatchColor
                                    : Colors.grey,
                            handleOnPressed: loginController
                                    .isDialCodeValid.value
                                ? () async {
                                    if (loginController.userPhoneNumber.value ==
                                        '') {
                                      await EasyLoading.showToast(
                                        'Please, enter your phone number.',
                                        toastPosition: Get.width >= 768
                                            ? EasyLoadingToastPosition.top
                                            : EasyLoadingToastPosition.center,
                                      );
                                    } else {
                                      await EasyLoading.show(
                                          status: 'Connecting...',
                                          dismissOnTap: false);
                                      if (kIsWeb) {
                                        var isConnected =
                                            html.window.navigator.onLine;
                                        if (isConnected != null) {
                                          if (isConnected == true) {
                                            final mobile = '+' +
                                                loginController
                                                    .countryDialCode.value
                                                    .trim() +
                                                loginController
                                                    .userPhoneNumber.value
                                                    .trim();
                                            loginController.registerUser(
                                                mobile, context);
                                            await EasyLoading.dismiss();
                                            log(mobile);
                                          } else {
                                            EasyLoading.showError(
                                                'Unable to connect to the internet!');
                                          }
                                        }
                                      } else {
                                        try {
                                          var connectivityResult =
                                              await (Connectivity()
                                                  .checkConnectivity());
                                          if (connectivityResult ==
                                                  ConnectivityResult.mobile ||
                                              connectivityResult ==
                                                  ConnectivityResult.wifi) {
                                            bool isConnected =
                                                await DataConnectionChecker()
                                                    .hasConnection;
                                            if (isConnected) {
                                              final mobile = '+' +
                                                  loginController
                                                      .countryDialCode.value
                                                      .trim() +
                                                  loginController
                                                      .userPhoneNumber.value
                                                      .trim();
                                              loginController.registerUser(
                                                  mobile, context);
                                              await EasyLoading.dismiss();
                                              log(mobile);
                                            } else {
                                              Get.snackbar(
                                                'Could not connect to the internet.',
                                                'Network is currently busy. Try again later!',
                                              );
                                            }
                                          } else {
                                            await EasyLoading.showError(
                                                'Kindly connect to the internet.');
                                          }
                                        } catch (e, S) {
                                          log(e.toString());
                                          log(S.toString());
                                        }
                                      }
                                    }
                                  }
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
