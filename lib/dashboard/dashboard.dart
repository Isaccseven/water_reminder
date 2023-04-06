import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/core/color_constants.dart';
import 'package:water_reminder/core/fluid_constants.dart';
import 'package:water_reminder/model/fluid.dart';

import 'fluid_grid_container.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences prefs;
  int _amountOfWater = 0;

  _loadCounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _amountOfWater = (prefs.getInt('counter') ?? 0);
    });
  }

  int _calculatePercentage() {
    return (_amountOfWater * 100) ~/ FluidConstants.maxAmountOfWater;
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCounter();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Center(
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    color: ColorConstants.primaryColor.color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 50,
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 10.0,
                percent: _calculatePercentage() / 100,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_calculatePercentage()}%',
                      style: TextStyle(
                        color: ColorConstants.primaryColor.color,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${FluidConstants.maxAmountOfWater - _amountOfWater} ml',
                            style: TextStyle(
                              color: ColorConstants.primaryColor.color,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '- $_amountOfWater ml',
                            style: TextStyle(
                              color: ColorConstants.primaryColor.color,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                backgroundColor:
                    ColorConstants.primaryColor.color.withOpacity(0.2),
                progressColor: ColorConstants.primaryColor.color,
              )),
          Expanded(
            flex: 40,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              children: [
                //FluidGridContainer(backgroundColor: ColorConstants.primaryColor.color, fluid: Fluid(amount: null),  )
              ],
            )
          ),
        ],
      ),
    );
  }
}
