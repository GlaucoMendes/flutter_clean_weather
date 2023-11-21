import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/core/core.dart';
import 'package:flutter_clean_weather/presentation/onboarding/cubits/location_list/location_list_cubit.dart';
import 'package:flutter_clean_weather/presentation/onboarding/widgets/location_tile.dart';

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  late final LocationListCubit cubit;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = context.read<LocationListCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.searchLocation),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(context.l10n.searchLocation, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: context.l10n.searchLocationBy,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => unawaited(cubit.getLocationByString(searchController.text)),
                  child: Text(context.l10n.search),
                ),
                const SizedBox(height: 16),
                BlocBuilder<LocationListCubit, LocationListState>(
                  builder: (context, state) {
                    const loading = Center(child: CircularProgressIndicator());
                    return switch (state) {
                      LocationListInitialState() => const SizedBox(),
                      LocationListLoadingState() => loading,
                      LocationListSuccessState() => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.locations.length,
                          itemBuilder: (context, index) {
                            final location = state.locations[index];
                            return InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => Navigator.of(context).pop(location),
                              child: LocationTile(location: location),
                            );
                          },
                        ),
                      LocationListErrorState() => Text(state.failure.toString()),
                    };
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
