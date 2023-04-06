import 'package:flutter/material.dart';

enum ColorConstants {
  backgroundColor,
  primaryColor,
  secondaryColor,
}

extension ColorConstantsExtension on ColorConstants {
  Color get color {
    switch (this) {
      case ColorConstants.backgroundColor:
        return const Color(0xFF928DFE);
      case ColorConstants.primaryColor:
        return const Color(0xFF928DFE);
      case ColorConstants.secondaryColor:
        return const Color(0xFF928DFE);
    }
  }
}