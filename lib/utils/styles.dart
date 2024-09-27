import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Regular Text Styles
regularWhiteText8(color, {fontStyle}) => GoogleFonts.poppins(
  textStyle:   TextStyle(
    fontSize: 8,
    color: color,
    fontWeight: FontWeight.normal,
    fontStyle: fontStyle,
  )
);


regularWhiteText10(color, {fontStyle, fontWeight= FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 10,
      color: color,
      fontWeight:fontWeight,
      fontStyle: fontStyle,
    )
);

regularWhiteText9(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 9,
      color: color,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle,
    )
);

regularWhiteText12(color, {fontStyle,fontWeight=FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      decorationThickness: 0
    )
);
regularWhiteText13(color, {fontStyle,fontWeight= FontWeight.normal,}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 13,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText14(color, {fontStyle,fontWeight=FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 14,
      color: color,
      fontWeight:fontWeight,
      fontStyle: fontStyle,
      decorationThickness: 0
    )
);
regularWhiteText15(color, {fontStyle,  fontWeight = FontWeight.normal, }) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 15,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText11(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 11,
      color: color,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle,
    )
);

regularWhiteTextWithDecoration14(color, {fontStyle}) => TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 14,
    color: color,
    fontWeight: FontWeight.normal,
    fontStyle: fontStyle);
regularWhiteTextWithDecoration12(color, {fontStyle}) => TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 12,
    color: color,
    fontWeight: FontWeight.normal,
    fontStyle: fontStyle);

regularWhiteText16(color, {fontStyle,  fontWeight = FontWeight.normal,}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 16,
      color: color,
      fontWeight:fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText17(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 17,
      color: color,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle,
    )
);

regularWhiteText18(color, {fontStyle,fontWeight=FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText18WithLineSpace24(color, {fontStyle}) => TextStyle(
    fontSize: 18,
    color: color,
    fontWeight: FontWeight.normal,
    height: 2.4,
    fontStyle: fontStyle);
regularWhiteText22(color, {fontStyle,fontWeight=FontWeight.normal}) =>GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 22,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText20(color, {fontStyle, fontWeight =  FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText24(color, {fontStyle,fontWeight= FontWeight.normal}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 24,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    )
);
regularWhiteText36(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 36,
      color: color,
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle,
    )
);
//Bold Text Styles
boldWhiteText8(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 8,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText10(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 10,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText11(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 11,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText12(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText13(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 13,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText14(color, {decoration, fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 14,
      color: color,
      decoration: decoration,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText15(color, {decoration, fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 15,
      color: color,
      decoration: decoration,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteTextWithUnderline14(color, {decoration, fontStyle}) => TextStyle(
    fontSize: 14,
    color: color,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    fontStyle: fontStyle);

boldWhiteText16(color, {decoration, fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 16,
      color: color,
      decoration: decoration,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText17(color, {decoration, fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 17,
      color: color,
      decoration: decoration,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText18(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 18,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText19(color, {fontStyle}) =>GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 19,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText20(color, {fontStyle}) =>GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.w500,
      fontStyle: fontStyle,
    )
);
boldWhiteText22(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 22,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);

boldWhiteText32(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 32,
letterSpacing: -1,

      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText28(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 28,
      letterSpacing: -2,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText24(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 24,
      letterSpacing: -2,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
boldWhiteText40(color, {fontStyle}) => GoogleFonts.poppins(
    textStyle:   TextStyle(
      fontSize: 40,
      color: color,
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    )
);
