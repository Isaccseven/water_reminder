import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Fluid {
  final int amount;
  final FluidIcon icon;
  final FluidType type;

  Fluid({required this.amount, required this.icon, required this.type});

}

enum FluidIcon { WATER, COFFEE, TEA, JUICE }

enum FluidType { WATER,COFFEE, TEA, JUICE }

extension FluidTypeExtension on FluidType {
  String get name {
    switch (this) {
      case FluidType.WATER:
        return 'Water';
      case FluidType.COFFEE:
        return 'Coffee';
      case FluidType.TEA:
        return 'Tea';
      case FluidType.JUICE:
        return 'Juice';
    }
  }
}

extension FluidIconExtension on FluidIcon {
  IconData get icon {
    switch (this) {
      case FluidIcon.WATER:
        return Icons.water_drop;
      case FluidIcon.COFFEE:
        return Icons.local_cafe;
      case FluidIcon.TEA:
        return Icons.local_drink;
      case FluidIcon.JUICE:
        return Icons.local_bar;
    }
  }
}