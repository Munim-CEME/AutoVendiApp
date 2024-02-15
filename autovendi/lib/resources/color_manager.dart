import 'package:flutter/material.dart';

class ColorManager{
  static Color primary = HexColor.fromHex("#f54747");
  static Color grey = HexColor.fromHex("#737477");
  static Color greyWithOpacity = HexColor.fromHex("#B3B3B3B3");
  static Color darkGrey = HexColor.fromHex("#525252");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color primaryOpacity70 = HexColor.fromHex("#B3f54747");

  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color error = HexColor.fromHex("#e61f34");

  static Color black = HexColor.fromHex("#000000");
  static Color transparent = HexColor.fromHex("#00000000");

}



extension HexColor on Color{

  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length == 6){
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }

}

/*
The radix parameter specifies the base of the number system to be used
for parsing the given string representation of a number.
In this case, radix: 16 indicates that the string should be interpreted
as a hexadecimal number.
*/
