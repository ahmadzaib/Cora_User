import 'package:flutter/material.dart';

import 'colors.dart';

appCounterDecoration(color) => BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    );
var appSeparationLineDecoration = BoxDecoration(
  shape: BoxShape.rectangle,
  color: blueAppColor.withOpacity(0.3),
);
rectangularBgColorBoxDecorationWithRadius(double radius) => BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(radius),
      color: gdColor,
    );

var appSeparationDarkLineDecoration = const BoxDecoration(
  shape: BoxShape.rectangle,
  color: Colors.grey,
);

rectangularWhiteBoxDecorationWithRadius(double radius) => BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(radius),
      color: Colors.white,
    );

rectangularWhiteBoxDecorationWithRadiusElevationwithBackgroundNetworkImage(
        double radius, double elevation, String image) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(image),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularAppBarBoxDecorationWithBlackRadiusElevation(
        double radius, double elevation, {Color? color}) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: (color != null) ? color : appBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularGreyBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: appBarColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularDarkGreyBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: darkGreyColor.withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularDarkAppBarColorBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: darkGrayColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

densedFieldDecorationWithoutPadding(
        {hint, verticalPad = 0.0, horizontalPad = 0.0, style}) =>
    InputDecoration(
        isDense: true,
        counterText: '',
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
            vertical: verticalPad, horizontal: horizontalPad),
        border: InputBorder.none,
        hintText: hint,
        hintStyle: style);

rectangularTextColorBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 1.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);
rectangularCustomTextColorBoxDecorationWithRadiusElevation(
        double radius, double elevation, Color color) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 1.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);
rectangularFieldColorBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: fieldColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 1.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularContainerBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: containerColor,
        boxShadow: [
          BoxShadow(
            color: surveyListContainerColor,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularCustomColorBoxDecorationWithRadius(
  double topLeft,
  double bottomLeft,
  double bottomRight,
  double topRight,
  Color color,
) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
            topRight: Radius.circular(topRight)),
        color: color);

optionsBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    border: Border.all(
      color: Colors.black,
      width: 0.6,
    ));

selectedOptionsBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    border: Border.all(color: appBarColor, width: 2.0),
    color: Colors.white);

ellipticalCustomColorBoxDecorationWithRadius(
  double x,
  double y,
  Color color,
) =>
    BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(
            x,
            y,
          ),
        ),
        color: color);

rectangularTextColorBoxDecorationWithDarkRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: darkGrayColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularTransparentBoxDecorationWithRadiusElevation(
        double radius, double elevation) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularGreyBorderDecorationWithRadius(double radius) => BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(color: textColor),
    );

rectangularAppBarColorBoxDecorationWithRadius(
  double topLeft,
  double bottomLeft,
  double bottomRight,
  double topRight,
  Color color,
) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
            topRight: Radius.circular(topRight)),
        color: color);

rectangularOrangeColorBoxDecorationWithRadius(
  double topLeft,
  double bottomLeft,
  double bottomRight,
  double topRight,
) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
            topRight: Radius.circular(topRight)),
        color: orangeColor);
ellipticalCustomColorBoxDecorationWithRadiusTop(
  double x,
  double y,
  double elevation,
  Color color,
) =>
    BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.elliptical(
            x,
            y,
          ),
        ),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: const Offset(-1, -1), //(x,y)
            blurRadius: elevation,
          ),
        ]);

// bix Decoration Box

bizAppBarDecorationBox({bool reverse = false}) =>
    BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            reverse ? appBarColor : appBarColor,
            reverse ? appBarColor : appBarColor,
          ],
        ),
        borderRadius: BorderRadius.circular(reverse ? 8 : 0),
        boxShadow: [
          BoxShadow(
              color: Colors.white.withOpacity(0.8),
              blurRadius: 0,
              spreadRadius: 0,
              offset: Offset(0, 0))
        ]);
bizManageContentAppBarDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [
          gdColor.withOpacity(0.80),
          bgColor.withOpacity(0.80),
        ],
      ),
    );
bizManageContentServicesAppBarDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.center,
        colors: [
          buttonColor,
          buttonColor,
        ],
      ),
    );
bizScafoldContainerDecorationBox({double opacity = 1.0}) => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          scafoldContainerColor1.withOpacity(opacity),
          scafoldContainerColor.withOpacity(opacity),
        ],
      ),
    );

bizContainerContainerDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          webTextCollor,
          whiteContainerColor,
        ],
      ),
    );
bizContainerDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          webTextCollor,
          brightestBlue,
        ],
      ),
    );
bizRectangularWhiteBoxDecorationWithRadiusElevationwithBackgroundImage(
        double radius, double elevation, String image) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: Colors.white,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(image),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);
bizRectangularWhiteBoxDecorationWithRadiusElevation(
        double radius, double elevation, {Color color = bgColor}) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: color,
        boxShadow: [
          BoxShadow(
            color: bgColor,
            offset: const Offset(0.0, 0.0), //(x,y)
            blurRadius: elevation,
          ),
        ]);

bixRectangularAppBarBoxDecorationWithRadiusElevation(
  double radius,
  double elevation, {
  Color? color,
  Color? borderColor,
  Color? shadowColor,
}) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: (color != null) ? color : appBarColor,
        border: Border.all(
            color: (borderColor != null) ? borderColor : Colors.transparent),
        boxShadow: [
          BoxShadow(
            color: (shadowColor != null) ? shadowColor : bgColor,
            offset: const Offset(0.0, 8), //(x,y)
            blurRadius: elevation,
          ),
        ]);
bizContentCardContainerDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [.92, 1],
        colors: [
          activityScreenHeaderColor.withOpacity(.99),
          gdColor,
        ],
      ),
    );
bizContentCardContainerDecorationBox4() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0, 0.6],
        colors: [
          gdColor,
          activityScreenHeaderColor.withOpacity(.99),
        ],
      ),
    );
bizContentCardContainerDecorationBox3() => BoxDecoration(
      color: activityScreenHeaderColor,
    );

bizContentCardContainerDecorationBox2() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          activityScreenHeaderColor,
          gdColor,
        ],
      ),
    );
bizMessengerBarDecorationBox({bool reverse = false}) => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          reverse ? whiteContainerColor : whiteContainerColor.withOpacity(0.80),
          reverse ? whiteContainerColor : whiteContainerColor.withOpacity(0.80),
        ],
      ),
      borderRadius: BorderRadius.circular(reverse ? 8 : 0),
    );
bizScafoldHomeContainerDecorationBox() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: [0.02, .965],
        colors: [
          scafoldContainerColor,
          scafoldContainerColor1,
        ],
      ),
    );

bizContainerContainerDecorationBoxOnboarding() => BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color(0xff001F53),
          Color(0xff000F32),
        ],
      ),
    );
userImageRectangularAppBarBoxDecorationWithRadiusElevation(
    double radius,
    String image,
    double elevation, {
      Color? color,
      Color? borderColor,
      Color? shadowColor,

    }
    ) =>
    BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(radius),
        color: (color != null) ? color : appBarColor,
        border: Border.all(
            color: (borderColor != null) ? borderColor : Colors.transparent),
        image: DecorationImage(image: AssetImage(image),fit: BoxFit.fill),
        boxShadow: [
          BoxShadow(
            color: (shadowColor != null) ? shadowColor : bgColor,
            offset: const Offset(0, 4), //(x,y)
            blurRadius: elevation,
          ),
        ]);

rectangularCustomColorBoxAndBorderDecorationWithRadius(
    double radius, Color fillColor, Color strokeColor,{borderWidth = 0.5}) =>
    BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      border: Border.all(color: strokeColor, width: borderWidth),
      color: fillColor,
    );