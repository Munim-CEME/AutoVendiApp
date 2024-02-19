
import 'package:flutter/material.dart';

import 'fonts_manager.dart';


TextStyle _getTextStyle(double fontSize, String fontFamily, FontWeight fontWeight, Color color){

  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, fontWeight: fontWeight, color: color);
}

// Regular Style
TextStyle getRegularStyle({double fontSize = FontSize.size12, required Color color, String fontFamily = FontConstants.fontFamily}){
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.regular, color);
}

// Light Style
TextStyle getLightStyle({double fontSize = FontSize.size12, required Color color, String fontFamily = FontConstants.fontFamily}){
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.light, color);
}

// <Medium> Style
TextStyle getMediumStyle({double fontSize = FontSize.size12, required Color color, String fontFamily = FontConstants.fontFamily}){
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.medium, color);
}

// Bold Style
TextStyle getBoldStyle({double fontSize = FontSize.size12, required Color color, String fontFamily = FontConstants.fontFamily}){
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.bold, color);
}

// SemiBold Style
TextStyle getSemiBoldStyle({double fontSize = FontSize.size12, required Color color, String fontFamily = FontConstants.fontFamily}){
  return _getTextStyle(fontSize, fontFamily, FontWeightManager.semiBold, color);
}