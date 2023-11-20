import 'package:flutter/material.dart';
import 'package:flutter_clean_weather/core/core.dart';

class SearchLocationPage extends StatelessWidget {
  const SearchLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.searchLocation),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(context.l10n.searchLocation, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: context.l10n.searchLocationBy,
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
