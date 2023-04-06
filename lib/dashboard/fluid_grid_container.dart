import 'package:flutter/material.dart';

import '../model/fluid.dart';

class FluidGridContainer extends StatelessWidget {

  final Color backgroundColor;
  final Fluid fluid;


  FluidGridContainer({required this.backgroundColor, required this.fluid});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: EdgeInsets.all(5),
      color: backgroundColor,
      child: Row(
        children: [
          Icon(fluid.icon.icon),
          Text('${fluid.amount} ml')
        ],
      ),
    );
  }
}
