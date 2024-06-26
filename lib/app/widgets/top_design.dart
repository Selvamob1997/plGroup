import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../theme/colors_value.dart';

class top_design_widgets extends StatelessWidget {
  const top_design_widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * width,
        height: 1.1 * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              // Color(0x007CBFCF),
              // Color(0xB316BFC4),
              ColorsValue.primaryColor,
              ColorsValue.primaryColor,
              // Color(0xB0CC426E),
              // Color(0xCDC5154B)
            ],
          ),
        ),
      ),
    );
  }
}