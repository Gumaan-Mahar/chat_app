import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonBackgroundColor;
  final VoidCallback? handleOnPressed;

  const CustomTextButton(
      {Key? key,
      required this.text,
      required this.textColor,
      this.buttonBackgroundColor = primarySwatchColor,
      required this.handleOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size.fromWidth(Get.width * 0.3),
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(buttonBackgroundColor),
        backgroundColor:
            MaterialStateProperty.all<Color>(buttonBackgroundColor),
      ),
      onPressed: handleOnPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: Get.width * 0.045),
      ),
    );
  }
}
