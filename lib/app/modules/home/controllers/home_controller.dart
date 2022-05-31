import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwordio/app/data/password.dart';
import 'package:passwordio/app/modules/home/providers/password_provider.dart';

class HomeController extends GetxController {
  final _currentPasswordEditingController = TextEditingController().obs;
  TextEditingController get currentPasswordEditingController =>
      _currentPasswordEditingController.value;

  final _isUseUppercase = true.obs;
  bool get isUseUppercase => _isUseUppercase.value;

  final _isUseLowercase = true.obs;
  bool get isUseLowercase => _isUseLowercase.value;

  final _isUseNumbers = true.obs;
  bool get isUseNumbers => _isUseNumbers.value;

  final _isUseSpecialCharacters = true.obs;
  bool get isUseSpecialCharacters => _isUseSpecialCharacters.value;

  final _numberOfCharacters = 15.0.obs;
  double get numberOfCharacters => _numberOfCharacters.value;

  final _isFetchingPassword = false.obs;
  bool get isFetchingPassword => _isFetchingPassword.value;

  final _currentPassword = Password(
    results: Results(
      password: '',
      contains: [],
      length: 15,
      id: 0,
      value: 'Waiting',
    ),
  ).obs;
  Password get currentPassword => _currentPassword.value;

  @override
  void onClose() {
    currentPasswordEditingController.dispose();
  }

  void changeIsUseUppercase(bool newState) => _isUseUppercase.value = newState;

  void changeIsUseLowercase(bool newState) => _isUseLowercase.value = newState;

  void changeIsUseNumbers(bool newState) => _isUseNumbers.value = newState;

  void changeIsUseSpecialCharacters(bool newState) =>
      _isUseSpecialCharacters.value = newState;

  void changeNumberOfCharacter(double newValue) =>
      _numberOfCharacters.value = newValue;

  void copyPasswordToClipboard() {
    FlutterClipboard.copy(currentPassword.results.password)
        .then(
          (value) => createSnackbar(
            'Success',
            "Password copied to clipboard",
            false,
          ),
        )
        .onError(
          (error, stackTrace) => createSnackbar(
            'Error',
            "Cannot copy ungenerated password!",
            true,
          ),
        );
  }

  void createSnackbar(String title, String message, isError) {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      icon: Icon(
        isError ? Icons.error : Icons.check,
        color: Colors.white,
      ),
      colorText: Colors.white,
      backgroundColor: isError ? Colors.red[400] : Colors.green[600],
      animationDuration: const Duration(milliseconds: 250),
    );
  }

  Future<void> fetchPassword() async {
    try {
      _isFetchingPassword.value = true;
      final passwordProvider = PasswordProvider();

      final password = await passwordProvider.fetchPassword(
        numberOfCharacters.toInt(),
        isUseUppercase,
        isUseLowercase,
        isUseNumbers,
        isUseUppercase,
        isUseSpecialCharacters,
      );

      _currentPassword.value = password;
      _currentPasswordEditingController.value.value = TextEditingValue(
        text: password.results.password,
      );
    } catch (e) {
      createSnackbar('Error', "An unexpected error occured!", true);
    } finally {
      _isFetchingPassword.value = false;
    }
  }
}
