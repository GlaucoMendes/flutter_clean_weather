part of '../core.dart';

extension ContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  Locale get locale => Localizations.localeOf(this);
}
