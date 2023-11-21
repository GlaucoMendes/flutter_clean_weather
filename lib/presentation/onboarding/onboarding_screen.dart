import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../core/locator.dart';
import 'pages/select_api_page.dart';
import 'pages/select_language_page.dart';
import 'pages/select_location_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.welcome),
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        children: [
          const SelectLanguagePage(),
          SelectApiPage(
            onApiSelected: (api) async {
              await Locator.updateWeatherRepository(api);
              unawaited(
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                ),
              );
            },
          ),
          const SelectLocationPage(),
        ],
      ),
    );
  }
}
