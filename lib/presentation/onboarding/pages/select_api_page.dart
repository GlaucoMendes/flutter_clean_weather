import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/enums/weather_api_enum.dart';

class SelectApiPage extends StatelessWidget {
  final void Function(WeatherApi api) onApiSelected;
  const SelectApiPage({required this.onApiSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 64),
          Text(context.l10n.selectApi, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          _ApiTag(
            asset: 'assets/logos/wapi.png',
            subttitle: context.l10n.wapiDescription,
            onTap: () => onApiSelected(WeatherApi.weatherapi),
          ),
          const SizedBox(height: 16),
          _ApiTag(
            asset: 'assets/logos/accu.png',
            subttitle: context.l10n.accuDescription,
            onTap: () => onApiSelected(WeatherApi.accuweather),
          ),
        ],
      ),
    );
  }
}

class _ApiTag extends StatelessWidget {
  final String asset;
  final String subttitle;
  final VoidCallback onTap;
  const _ApiTag({
    required this.onTap,
    required this.asset,
    required this.subttitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.8),
              ),
              child: Image(
                image: AssetImage(asset),
                height: 48,
                width: 200,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(subttitle),
        ],
      ),
    );
  }
}
