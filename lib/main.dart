import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Passwordio",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        switchTheme: SwitchThemeData(
          trackColor: MaterialStateProperty.all(Colors.purple[200]),
          thumbColor: MaterialStateProperty.all(Colors.purple[600]),
        ),
        colorScheme: const ColorScheme.light(
          primary: Colors.purple,
        ),
      ),
    ),
  );
}
