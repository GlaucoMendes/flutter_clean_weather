import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/services/geoposition_service.dart';
import 'package:flutter_clean_weather/core/services/permission_service.dart';
import 'package:flutter_clean_weather/core/utils/snacks.dart';
import 'package:flutter_clean_weather/presentation/home/home_screen.dart';
import 'package:flutter_clean_weather/presentation/onboarding/cubit/location_cubit.dart';
import 'package:flutter_clean_weather/presentation/onboarding/pages/search_location_page.dart';
import 'package:flutter_clean_weather/presentation/onboarding/widgets/location_button_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late LocationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<LocationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Weather'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.selectLocation, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            LocationButtonWidget(
              label: context.l10n.currentLocation,
              icon: Icons.my_location,
              onTap: () async {
                Dialogs.showLoading(context, context.l10n.waitingGPS);

                final permission = await PermissionService.requestLocationPermission();

                if (permission) {
                  try {
                    final position = await GeoPositionService.determinePosition();
                    await cubit.getLocation(position.latitude, position.longitude);

                    waitFrame(() => Navigator.of(context).pop());
                  } catch (e) {
                    waitFrame(() => Navigator.of(context).pop());
                    waitFrame(() => Snacks.show(context, e.toString()));
                  }
                } else {
                  waitFrame(() => Navigator.of(context).pop());
                  waitFrame(() => Snacks.show(context, context.l10n.locationPermissionDenied));
                }
              },
            ),
            const SizedBox(height: 8),
            LocationButtonWidget(
              label: context.l10n.searchLocation,
              icon: Icons.search,
              onTap: () async {
                await Navigator.of(context)
                    .push(MaterialPageRoute<dynamic>(builder: (_) => const SearchLocationPage()));
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationSuccessState) {
                  // Location Info
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Text(context.l10n.locationInfo, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      Text(state.location.localizedName, style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: 8),
                      Text(state.location.country.localizedName, style: Theme.of(context).textTheme.labelMedium),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => unawaited(
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomeScreen(location: state.location),
                            ),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Text(context.l10n.next),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
