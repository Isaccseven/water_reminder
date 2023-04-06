import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_reminder/core/fluid_constants.dart';
import 'package:water_reminder/model/fluid.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../core/color_constants.dart';
import '../dashboard/fluid_text_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  var box = Hive.box('fluids');

  int _amountOfWater = 0;

  static const _durations = [
    4000,
  ];

  List<double> _heightPercentages = [1.0];
  final double _minHeightPercentage = 0.8;
  final double _maxHeightPercentage = 0.01;


  _loadCounter() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _amountOfWater = (prefs.getInt('counter') ?? 0);
      _updateHeightPercentage();
    });
  }

  void _openDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add fluid"),
          content: Text("What kind of fluid do you want to add?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FluidTextButton(
                  fluid: Fluid(
                    type: FluidType.WATER,
                    amount: 200,
                    icon: FluidIcon.WATER,
                  ),
                  incrementFluid: _incrementFluid,
                ),
                FluidTextButton(
                  fluid: Fluid(
                    type: FluidType.TEA,
                    amount: 200,
                    icon: FluidIcon.TEA,
                  ),
                  incrementFluid: _incrementFluid,
                ),
                FluidTextButton(
                  fluid: Fluid(
                    type: FluidType.COFFEE,
                    amount: 200,
                    icon: FluidIcon.COFFEE,
                  ),
                  incrementFluid: _incrementFluid,
                ),
                FluidTextButton(
                  fluid: Fluid(
                    type: FluidType.JUICE,
                    amount: 200,
                    icon: FluidIcon.JUICE,
                  ),
                  incrementFluid: _incrementFluid,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _incrementFluid(Fluid fluid) async {
    _amountOfWater += fluid.amount;
    await prefs.setInt('counter', _amountOfWater);
    await box.add(fluid);
    print(await box.get("fluids"));
    setState(() {
    _updateHeightPercentage();
    });
  }

  Future<void> _resetCounter() async {
    _amountOfWater = 0;
    await prefs.setInt('counter', 0);
    setState(() {
      _updateHeightPercentage();
    });
  }

  void _updateHeightPercentage() {
    if (_amountOfWater > FluidConstants.maxAmountOfWater) {
      _heightPercentages = [
        _maxHeightPercentage,
      ];
      _amountOfWater = FluidConstants.maxAmountOfWater;
    }
    _heightPercentages = [
      _minHeightPercentage - (_amountOfWater / FluidConstants.maxAmountOfWater) *
          (_minHeightPercentage - _maxHeightPercentage)
    ];
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
            flex: 30,
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.15),
              child: Text(
                '$_amountOfWater ml',
                style: TextStyle(
                  color: ColorConstants.primaryColor.color,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 70,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.1,
                  child: SvgPicture.asset(
                    'assets/drink.svg',
                    width: 200,
                    semanticsLabel: 'Drink',
                    height: 200,
                  ),
                ),
                WaveWidget(
                  config: CustomConfig(
                    colors: [ColorConstants.primaryColor.color],
                    durations: _durations,
                    heightPercentages: _heightPercentages,
                  ),
                  backgroundColor: Colors.transparent,
                  size: const Size(double.infinity, double.infinity),
                  waveAmplitude: 0,
                ),
                Positioned(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.47,
                  child: GestureDetector(
                    onTap: () => _openDialog(),
                    onLongPress: _resetCounter,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: ColorConstants.primaryColor.color,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
