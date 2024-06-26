import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../theme/colors_value.dart';



class bottom_design_widgets extends StatelessWidget {
  const bottom_design_widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      // width: 1.5 * width,
      width: 1.5 * width,
      // height: 1.5 * width,
      height: 1.2 * width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            // Color(0xDB4BE8CC),
            // Color(0x005CDBCF),
            // Color(0xB8BB043B),
            // Color(0xFFE77397)
            ColorsValue.primaryColor,
            ColorsValue.primaryColor,
          ],
        ),
      ),
    );
  }
}