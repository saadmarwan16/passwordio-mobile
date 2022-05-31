import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:passwordio/app/data/slider_colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo512.png'),
                  radius: 16.0,
                ),
              ),
              const CustomSizedBox12(),
              const Center(
                child: Text(
                  'Passwordio',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const CustomSizedBox12(),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text:
                            'Generate your secure password. Once you\'re done, click on the'),
                    TextSpan(
                      text: ' COPY ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'button to copy password')
                  ],
                ),
                style: TextStyle(color: Color.fromARGB(255, 79, 78, 78)),
                textAlign: TextAlign.center,
              ),
              const CustomSizedBox12(),
              TextField(
                controller: controller.currentPasswordEditingController,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Password goes here ...',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0.0,
                    horizontal: 16.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 154, 154),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 158, 154, 154),
                    ),
                  ),
                ),
              ),
              const CustomSizedBox12(),
              Obx(
                () => Row(
                  children: <Widget>[
                    Expanded(
                      child: LinearProgressIndicator(
                        value: controller.currentPassword.results.id / 5,
                        minHeight: 8.0,
                        color:
                            sliderColors[controller.currentPassword.results.id],
                        backgroundColor: sliderBackgroundColors[
                            controller.currentPassword.results.id],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Text(
                      controller.currentPassword.results.value,
                      style: TextStyle(
                        color:
                            sliderColors[controller.currentPassword.results.id],
                      ),
                    ),
                  ],
                ),
              ),
              const CustomSizedBox12(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: controller.copyPasswordToClipboard,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.purple),
                    ),
                    child: const Text('COPY'),
                  ),
                  const SizedBox(
                    width: 24.0,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.isFetchingPassword
                          ? null
                          : controller.fetchPassword,
                      style: ElevatedButton.styleFrom(),
                      child: Text(
                        controller.isFetchingPassword ? 'LOADING' : 'GENERATE',
                      ),
                    ),
                  ),
                ],
              ),
              const CustomSizedBox12(),
              const Text(
                'Password Length',
                style: TextStyle(color: Color.fromARGB(255, 79, 78, 78)),
              ),
              Obx(
                () => Slider(
                  value: controller.numberOfCharacters,
                  min: 4,
                  max: 128,
                  divisions: 128,
                  label: controller.numberOfCharacters.toInt().toString(),
                  onChanged: controller.changeNumberOfCharacter,
                ),
              ),
              Obx(
                () => ListTile(
                  title: const Text('Use uppercase'),
                  trailing: Switch.adaptive(
                    value: controller.isUseUppercase,
                    onChanged: controller.changeIsUseUppercase,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () => controller
                      .changeIsUseUppercase(!controller.isUseUppercase),
                ),
              ),
              Obx(
                () => ListTile(
                  title: const Text('Use lowercase'),
                  trailing: Switch.adaptive(
                    value: controller.isUseLowercase,
                    onChanged: controller.changeIsUseLowercase,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () => controller
                      .changeIsUseLowercase(!controller.isUseLowercase),
                ),
              ),
              Obx(
                () => ListTile(
                  title: const Text('Use numbers'),
                  trailing: Switch.adaptive(
                    value: controller.isUseNumbers,
                    onChanged: controller.changeIsUseNumbers,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () =>
                      controller.changeIsUseNumbers(!controller.isUseNumbers),
                ),
              ),
              Obx(
                () => ListTile(
                  title: const Text('Use special characters'),
                  trailing: Switch.adaptive(
                    value: controller.isUseSpecialCharacters,
                    onChanged: controller.changeIsUseSpecialCharacters,
                  ),
                  contentPadding: EdgeInsets.zero,
                  onTap: () => controller.changeIsUseSpecialCharacters(
                      !controller.isUseSpecialCharacters),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSizedBox12 extends StatelessWidget {
  const CustomSizedBox12({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 12.0,
    );
  }
}
