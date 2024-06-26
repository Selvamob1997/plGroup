// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/dimens.dart';
import 'colors_value.dart';

/// A chunk of styles used in the application.
/// Will be ignored for test since all are static values and would not change.
abstract class Styles {
  static TextStyle primaryW50014_withStrikeout = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fourteen,
    decoration: TextDecoration.lineThrough,
  );
  static TextStyle blackW50012 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: Dimens.twelve,
  );
  static TextStyle blackW50014 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: Dimens.fourteen,
  );
  static TextStyle blackW70016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: Dimens.sixteen,
  );
  static TextStyle blackW80025 = GoogleFonts.openSans(
    fontWeight: FontWeight.w800,
    color: Colors.black,
    fontSize: Dimens.twentyFive,
  );
  static TextStyle blackW60010 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.ten,
  );
  static TextStyle blackW60014 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.fourteen,
  );
  static TextStyle blackW60012 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.twelve,
  );
  static TextStyle blackW60016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.sixteen,
  );
  static TextStyle blackW60018 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.eighteen,
  );
  static TextStyle blackW60020 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.black,
    fontSize: Dimens.twenty,
  );

  static TextStyle boldBlack12 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.twelve,
  );
  static TextStyle boldBlack14 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.fourteen,
  );
  static TextStyle boldBlack16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.sixteen,
  );
  static TextStyle boldBlack18 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: Dimens.eighteen,
  );
  static TextStyle boldGreen14 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.green,
    fontSize: Dimens.fourteen,
  );

  static TextStyle black38W50016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black38,
    fontSize: Dimens.sixteen,
  );

  static TextStyle primary16w600 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.sixteen,
  );

  static TextStyle black38W40016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w400,
    color: Colors.black38,
    fontSize: Dimens.sixteen,
  );

  static TextStyle blackW50016withunderline = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: Dimens.sixteen,
    decoration: TextDecoration.underline
  );

  static TextStyle w600Green14 = GoogleFonts.openSans(
    fontWeight: FontWeight.w600,
    color: Colors.green,
    fontSize: Dimens.fourteen,
  );
  static TextStyle titleTextStyle = GoogleFonts.openSans(
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontSize: Dimens.eighteen);

  static TextStyle lightBlackW50012 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(0.5),
    fontSize: Dimens.twelve,
  );
  static TextStyle lightBlackLineThroughW50013 = GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.5),
      fontSize: Dimens.thirteen,
      // decoration: TextDecoration.lineThrough
      decoration: TextDecoration.lineThrough);

  static TextStyle primaryW50013 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.thirteen,
  );

  static TextStyle lightBlackW50014 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.black.withOpacity(0.5),
    fontSize: Dimens.fourteen,
  );
  static TextStyle lightBlackLineThroughW50014 = GoogleFonts.openSans(
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.5),
      fontSize: Dimens.fourteen,
      // decoration: TextDecoration.lineThrough
      decoration: TextDecoration.lineThrough);

  static TextStyle lightBlackLineThroughW80016 = GoogleFonts.openSans(
      fontWeight: FontWeight.w700,
      color: Colors.black.withOpacity(0.5),
      fontSize: Dimens.fifteen,
      // decoration: TextDecoration.lineThrough
      decoration: TextDecoration.lineThrough);

  static TextStyle lightBlackW80016 = GoogleFonts.openSans(
      fontWeight: FontWeight.w800,
      color: Colors.black.withOpacity(0.5),
      fontSize: Dimens.sixteen,
      // decoration: TextDecoration.lineThrough
      // decoration: TextDecoration.lineThrough
  );

  static TextStyle boldWhite12 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.twelve,
  );
  static TextStyle boldWhite14 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.fourteen,
  );
  static TextStyle boldWhite16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.sixteen,
  );
  static TextStyle boldWhite18 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.eighteen,
  );
  static TextStyle boldWhite20 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.twenty,
  );

  static TextStyle whiteW50018 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.white,
    fontSize: Dimens.eighteen,
  );

  static TextStyle primaryBold14 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fourteen,
  );
  static TextStyle primaryBold16 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.sixteen,
  );

  static TextStyle white15 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.fifteen,
  );

  static TextStyle white14 = GoogleFonts.openSans(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: Dimens.fourteen,
  );

  static TextStyle primaryW50014 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fourteen,
  );

  static TextStyle primaryW70015 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fifteen,
  );

  static TextStyle primaryW80016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w800,
    color: ColorsValue.primaryColor,
    fontSize: Dimens.sixteen,
  );

  static TextStyle errorW50012 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: Colors.red[700],
    fontSize: Dimens.twelve,
  );
  static TextStyle formFieldTextStyle = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.w500,
  );
  static TextStyle formFieldTextStyle13 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.thirteen,
    fontWeight: FontWeight.w500,
  );

  static TextStyle TextStyleblackw50013 = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: Dimens.thirteen,
    fontWeight: FontWeight.w500,
  );

  static TextStyle textButtonPrimaryTextStyle14 = GoogleFonts.openSans(
    color: ColorsValue.primaryColor,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.bold,
  );

  static TextStyle buttonWhiteTextStyle14 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.fourteen,
    fontWeight: FontWeight.w600,
  );

  static TextStyle buttonWhiteTextStyle16 = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.sixteen,
    fontWeight: FontWeight.w600,
  );
  static TextStyle buttonWhiteTextStyle = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: Dimens.eighteen,
    fontWeight: FontWeight.w700,
  );
  static TextStyle buttonTextStyleW50014 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: ColorsValue.buttonColor,
    fontSize: Dimens.fourteen,
  );
  static TextStyle buttonTextStyleW50016 = GoogleFonts.openSans(
    fontWeight: FontWeight.w500,
    color: ColorsValue.buttonColor,
    fontSize: Dimens.sixteen,
  );
  static TextStyle buttonTextStyleW70020 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    color: ColorsValue.buttonColor,
    fontSize: Dimens.twenty,
  );
  static TextStyle blackcolorTextStyleW70020 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    color: ColorsValue.blackcolor,
    fontSize: Dimens.fourteen,
  );
  static TextStyle buttonTextStyleW70013 = GoogleFonts.openSans(
    fontWeight: FontWeight.w700,
    // color: ColorsValue.buttonColor,
    color: Colors.black, //.buttonColor,
    fontSize: Dimens.thirteen,
  );
  static BoxDecoration containerDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.ten),
    border: Border.all(
      color: ColorsValue.primaryColor,
      width: Dimens.pointSix,
    ),
  );

  static BoxDecoration selectProductDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.ten),
    border: Border.all(
      color: ColorsValue.buttonColor,
      width: Dimens.pointSix,
    ),
  );

  static BoxDecoration gridDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(Dimens.thirty),
  );

  static BoxDecoration offerMessageDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: ColorsValue.primaryColor.withOpacity(0.15),
          offset: const Offset(1, 1),
          blurRadius: 16.0)
    ],
    border: Border.all(width: Dimens.one, color: Colors.transparent),
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );

  static var outlineBorderEnabledRadius5 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.five,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );
  static var outlineBorderEnabledRadius10 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.ten,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );
  static var searchEnabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.ten,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.buttonColor,
      width: Dimens.one,
    ),
  );
  static var outlineBorderRadius5 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.five,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );

  static var outlineBorderRadius10 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.ten,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );

  static var outlineBorderRadius15 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.fifteen,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );

  static var outlineBorderRadius10black26 = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(
        Dimens.ten,
      ),
    ),
    borderSide: BorderSide(
      color: ColorsValue.primaryColor,
      width: Dimens.one,
    ),
  );

  static var boxdecorationborderRadius10 = BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Dimens.ten,
        ),
      ),
      border: Border.all(
        color: ColorsValue.primaryColor,
        width: Dimens.one,)
  );

  static var roundedRectangle2 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimens.five),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: ColorsValue.primaryColor.withOpacity(0.15),
          offset: const Offset(1, 1),
          blurRadius: 16.0)
    ],
    border: Border.all(width: Dimens.one, color: Colors.grey.shade100),
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );
}
