import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/core/services/geoposition_service.dart';
import 'package:flutter_clean_weather/core/services/permission_service.dart';
import 'package:flutter_clean_weather/core/utils/snacks.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/presentation/home/home_screen.dart';
import 'package:flutter_clean_weather/presentation/onboarding/cubits/location/location_cubit.dart';
import 'package:flutter_clean_weather/presentation/onboarding/cubits/location_list/location_list_cubit.dart';
import 'package:flutter_clean_weather/presentation/onboarding/pages/search_location_page.dart';
import 'package:flutter_clean_weather/presentation/onboarding/widgets/location_button_widget.dart';
import 'package:get_it/get_it.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late LocationCubit cubit;

  Location? currentLocation;

  @override
  void initState() {
    super.initState();
    cubit = context.read<LocationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final location = currentLocation;
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
                final location = await Navigator.of(context).push(
                  MaterialPageRoute<Location>(
                    builder: (_) => BlocProvider(
                      create: (context) => LocationListCubit(GetIt.I()),
                      child: const SearchLocationPage(),
                    ),
                  ),
                );
                if (location != null) setState(() => currentLocation = location);
              },
            ),
            const SizedBox(height: 16),
            if (location != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(location.localizedName),
                    subtitle: Text(
                      '${location.administrativeArea.localizedName} (${location.administrativeArea.id}) - ${location.country.localizedName}',
                    ),
                    trailing: const Icon(Icons.push_pin_outlined),
                  ),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => unawaited(
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => HomeScreen(location: location),
                        ),
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Text(context.l10n.next),
                  ),
                ],
              ),
            BlocListener<LocationCubit, LocationState>(
              listener: (context, state) {
                if (state is LocationSuccessState) {
                  setState(() => currentLocation = state.location);
                } else if (state is LocationErrorState) {
                  Snacks.show(context, FailureMapper.map(state.failure));
                }
              },
              child: const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
