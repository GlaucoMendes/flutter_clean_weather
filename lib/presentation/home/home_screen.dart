import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_weather/domain/entities/location.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/condition/current_condition_cubit.dart';
import 'package:flutter_clean_weather/presentation/home/cubits/forecast/forecast_cubit.dart';
import 'package:flutter_clean_weather/presentation/home/widgets/current_condition_widget.dart';
import 'package:flutter_clean_weather/presentation/home/widgets/forecast_widget.dart';

class HomeScreen extends StatefulWidget {
  final Location location;
  const HomeScreen({required this.location, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<ForecastCubit>().getForecastById(widget.location.key));
    unawaited(context.read<CurrentConditionCubit>().getCurrentCondition(widget.location.key));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(title: const Text('Clean Weather')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              CurrentConditionWidget(),
              SizedBox(height: 24),
              ForecastWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
