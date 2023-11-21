import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/core.dart';
import '../../../core/services/localization_service.dart';

class SelectLanguagePage extends StatefulWidget {
  final void Function() onNext;
  const SelectLanguagePage({required this.onNext, super.key});

  @override
  State<SelectLanguagePage> createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  Locale? currentLocale;

  @override
  Widget build(BuildContext context) {
    const supportedLocales = AppLocalizations.supportedLocales;
    currentLocale = Localizations.localeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.selectLanguage),
      ),
      body: ListView.builder(
        itemCount: supportedLocales.length,
        itemBuilder: (context, index) {
          final locale = supportedLocales[index];
          final name = _localeToLanguageName(context, locale);

          if (name != null) {
            return ListTile(
              title: Text(name),
              onTap: () {
                LocalizationService.locale.value = locale;
                setState(() {
                  currentLocale = locale;
                });
              },
              trailing: currentLocale == locale ? const Icon(Icons.check) : null,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: FilledButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: widget.onNext,
          child: Text(context.l10n.next),
        ),
      ),
    );
  }

  String? _localeToLanguageName(BuildContext context, Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return context.l10n.en;
      case 'pt':
        return context.l10n.pt;
      case 'zh':
        return context.l10n.zh;
    }
    return null;
  }
}
