// coverage:ignore-file

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pl_groups/app/utils/ennum_values.dart';
import 'package:pl_groups/app/theme/styles.dart';

import 'dimens.dart';

abstract class Utility {


  /// Returns a list of booleans by validating [password].
  ///
  /// for at least one upper case, at least one digit,
  /// at least one special character and and at least 6 characters long
  /// return [List<bool>] for each case.
  /// Validation logic
  /// r'^
  ///   (?=.*[A-Z])             // should contain at least one upper case
  ///   (?=.*?[0-9])            // should contain at least one digit
  ///  (?=.*?[!@#\$&*~]).{8,}   // should contain at least one Special character
  /// $
  static List<bool> passwordValidator(String password) {
    var validationStatus = <bool>[false, false, false, false, false];
    validationStatus[0] = password.length >= 8;
    validationStatus[1] = RegExp(r'(?=.*[A-Z])').hasMatch(password);
    validationStatus[2] = RegExp(r'(?=.*[a-z])').hasMatch(password);
    validationStatus[3] = RegExp(r'(?=.*?[0-9])').hasMatch(password);
    validationStatus[4] = RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password);
    return validationStatus;
  }



  /// Show loader
  static void showLoader() async {
    await Get.dialog(
      const Center(
        child: SizedBox(
          height: 60,
          width: 60,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }


// Version Update Dialog
  static void versionUpdatedialog() async {
    await Get.dialog(
      Center(
        child: SizedBox(
          height: Get.height/8,
          width: Get.width,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("Update Available.!!!")
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }








  /// Close loader
  static void closeLoader() {
    closeDialog();
  }

  /// Show info dialog
/*  static void showDialog(
    String message,
  ) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: const Text('Info'),
        content: Text(
          message,
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text(
              StringConstants.okay,
            ),
          ),
        ],
      ),
    );
  }*/

  /// Show alert dialog
  static void showAlertDialog({
    String? message,
    String? title,
    Function()? onPress,
  }) async {
    await Get.dialog(
      CupertinoAlertDialog(
        title: Text('$title'),
        content: Text('$message'),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: onPress,
            child: const Text('Yes'),
          ),
          const CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: closeDialog,
            child: Text('No'),
          )
        ],
      ),
    );
  }

  /// Close any open dialog.
  static void closeDialog() {
    if (Get.isDialogOpen ?? false) Get.back<void>();
  }

  /// Close any open snackbar
  static void closeSnackbar() {
    if (Get.isSnackbarOpen) Get.back<void>();
  }


  static showDialaogboxWarning(context, String message,String tittle) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async=>false,
        child: SizedBox(
          height: 250,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 280,
                        child: Column(
                          children: [
                            Text(message, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25 ),),
                            const SizedBox(height: 20),
                            //Buttons
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,size: 30,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static showDialaogboxSaved(context, String message,String tittle) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async=>false,
        child: SizedBox(
          height: 250,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Material(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 280,
                        child: Column(
                          children: [
                            Text(message, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 25 ),),
                            const SizedBox(height: 20),
                            //Buttons
                            SizedBox(
                              width: 100,
                              child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                },
                                icon: Icon(Icons.arrow_drop_down_circle,color: Colors.white,size: 30,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  static void showMessage(String? message, TypeOfMessage messageType,
      Function()? onTap, String actionName) {
    if (message == null || message.isEmpty) return;
    closeDialog();
    closeSnackbar();
    var backgroundColor = Colors.black;
    switch (messageType) {
      case TypeOfMessage.error:
        backgroundColor = Colors.red;
        break;
      case TypeOfMessage.information:
        backgroundColor = Colors.black.withOpacity(0.3);
        break;
      case TypeOfMessage.success:
        backgroundColor = Colors.green;
        break;
      default:
        backgroundColor = Colors.black;
        break;
    }
    Future.delayed(
      const Duration(seconds: 0),
      () {
        Get.rawSnackbar(
          messageText: Text(
            message,
            style: Styles.white15,
          ),
          mainButton: TextButton(
            onPressed: onTap ?? Get.back,
            child: Text(
              actionName,
              style: Styles.white14,
            ),
          ),
          backgroundColor: backgroundColor,
          margin: Dimens.edgeInsets15_15_15_15,
          borderRadius: Dimens.ten + Dimens.five,
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP
        );
      },
    );
  }
}
