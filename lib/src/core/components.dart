import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:quizu/src/core/app_strings.dart';

String initialCountry = 'SA';
PhoneNumber number = PhoneNumber(isoCode: 'SA');
String? theNumber;

Widget defaultTextFormFailedIntal(
    {required TextEditingController controller,
    required BuildContext context}) {
  return InternationalPhoneNumberInput(
    onInputChanged: (PhoneNumber number) {
      print(number.phoneNumber);
      theNumber = number.phoneNumber;
    },
    onInputValidated: (bool value) {
      print(value);
    },
    selectorConfig: const SelectorConfig(
      selectorType: PhoneInputSelectorType.DIALOG,
    ),
    ignoreBlank: false,
    textStyle: Theme.of(context).textTheme.bodyLarge!,
    autoValidateMode: AutovalidateMode.disabled,
    selectorTextStyle: const TextStyle(color: Colors.black),
    initialValue: number,
    textFieldController: controller,
    formatInput: false,
    keyboardType:
        const TextInputType.numberWithOptions(signed: true, decimal: true),
    inputBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    onSaved: (PhoneNumber number) {
      print('On Saved: $number');
    },
  );
}

Widget defaultTextFormFaield({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required TextInputAction action,
  required FormFieldValidator valid,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: BorderSide(color: Colors.red.shade800)),
    ),
    validator: valid,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: action,
  );
}

defaultEleveBtn({
  required VoidCallback? onPressed,
  required String title
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
    onPressed: onPressed,
    child: Text(
      title,
      style: const TextStyle(color: Colors.black),
    ),
  );
}

defaultshowDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required VoidCallback? onclicked}) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          content: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            ElevatedButton(onPressed: onclicked, child: Text(AppString.ok))
          ],
        );
      });
}
