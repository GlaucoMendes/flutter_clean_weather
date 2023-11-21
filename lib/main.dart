import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'core/locator.dart';
import 'core/theme/weather_theme_data.dart';
import 'presentation/home/cubits/condition/current_condition_cubit.dart';
import 'presentation/home/cubits/forecast/forecast_cubit.dart';
import 'presentation/onboarding/cubits/location/location_cubit.dart';
import 'presentation/onboarding/onboarding_screen.dart';

void main() {
  Locator.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ForecastCubit>(create: (context) => ForecastCubit(GetIt.I())),
        BlocProvider<CurrentConditionCubit>(create: (context) => CurrentConditionCubit(GetIt.I())),
        BlocProvider<LocationCubit>(create: (context) => LocationCubit(GetIt.I())),
      ],
      child: MaterialApp(
        home: const OnboardingScreen(),
        theme: WeatherThemeData.theme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
