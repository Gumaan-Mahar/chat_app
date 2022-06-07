import 'dart:io';

import 'package:chat_app/constants.dart';
import 'package:chat_app/controllers/login_screen_controller.dart';
import 'package:chat_app/controllers/main_controller.dart';
import 'package:chat_app/widgets/text_button.dart';
import 'package:country_list/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

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
          height: Get.height,
          width: Get.width,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Image.asset(
                            'assets/images/login_illustration.png'),),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: Get.width * 0.18),
                                child: Text(
                                  'Enter your phone number',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: Get.width * 0.048,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: isDarkMode ? Colors.white : Colors.black,
                                size: Get.width * 0.06,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 16.0, bottom: 8.0),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Chatmate will send an SMS message to verify your phone number. ',
                                style: TextStyle(
                                  fontSize: Get.width * 0.038,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'What\'s my number?',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: Get.width * 0.038,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => DropdownButton<String>(
                              value: loginController.selectedCountry.value,
                              dropdownColor:
                                  isDarkMode ? Colors.black : Colors.white,
                              alignment: Alignment.center,
                              underline: Container(
                                height: 1.5,
                                color: primarySwatchColor,
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: primarySwatchColor,
                              ),
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: Get.width * 0.038,
                              ),
                              items: Countries.list
                                  .map(
                                    (country) => DropdownMenuItem<String>(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: countryDialCodeController,
                                    maxLength: 4,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18.0,
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
                                          fontSize: 18.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: userPhoneNumberController,
                                    maxLength: 12,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 18.0,
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Carrier SMS charges may apply',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => CustomTextButton(
                    text: 'Next',
                    textColor: isDarkMode ? Colors.white : Colors.black,
                    buttonBackgroundColor: loginController.isDialCodeValid.value
                        ? primarySwatchColor
                        : Colors.grey,
                    handleOnPressed: loginController.isDialCodeValid.value
                        ? () async {
                            if (loginController.userPhoneNumber.value == '') {
                              await EasyLoading.showToast(
                                'Please, enter your phone number.',
                              );
                            } else {
                              try {
                                await EasyLoading.show(
                                    status: 'Connecting...',
                                    dismissOnTap: false);
                                final result =
                                    await InternetAddress.lookup('example.com');
                                await EasyLoading.dismiss();
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  final mobile = loginController
                                          .countryDialCode.value
                                          .trim() +
                                      loginController.userPhoneNumber.value
                                          .trim();
                                  loginController.registerUser(mobile, context);
                                }
                              } on SocketException catch (_) {
                                await EasyLoading.dismiss();
                                await EasyLoading.showToast(
                                    'Unable to connect to the internet.',
                                    toastPosition:
                                        EasyLoadingToastPosition.center,
                                    maskType: EasyLoadingMaskType.clear);
                              }
                            }
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
