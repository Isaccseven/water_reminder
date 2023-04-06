import 'package:flutter/material.dart';

import '../model/fluid.dart';

class FluidTextButton extends StatelessWidget {
  Fluid fluid;
  final incrementFluid;

  FluidTextButton({required this.fluid, required this.incrementFluid});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Column(
        children: [
          Icon(fluid.icon.icon),
          Text(fluid.type.name),
        ],
      ),
      onPressed: () {
        incrementFluid!(fluid);
        Navigator.of(context).pop();
      },
    );
  }
}
