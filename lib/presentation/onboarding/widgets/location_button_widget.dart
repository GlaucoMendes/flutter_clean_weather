import 'package:flutter/material.dart';

class LocationButtonWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const LocationButtonWidget({required this.label, required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const Spacer(),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
