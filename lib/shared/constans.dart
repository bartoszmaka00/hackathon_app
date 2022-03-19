import 'package:flutter/material.dart';

// const Color miceDarkGreen = Color(0xFFF68D89B);
// const Color miceLightGreen = Color(0xFFF8DFFCD);

const Color miceDarkGreen = Color(0xFFF6FD379);
const Color miceLightGreen = Color(0xFFFDFFBE6);
const Color micemiddleGreen = Color(0xFFF98F46C);

const double mainMenuButonHeight=100.0;
const double mainMenuButonWidth=300.0;
const double mainMenuButonHeightSmall=70.0;
const double mainMenuButonWidthSmall=300.0;
const double mainMenuButtonFontSize=25;
const double mainMenuButtonFontSizeSmall=15;
const double circlesize = 50;

class Palette {
  static const MaterialColor miceButtonColor = const MaterialColor(
    0xFFF6FD379, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFFF68D89B ),//10%
      100: const Color(0xfff8dffcd),//20%
      200: const Color(0xffa04332),//30%
      300: const Color(0xff89392b),//40%
      400: const Color(0xff733024),//50%
      500: const Color(0xff5c261d),//60%
      600: const Color(0xff451c16),//70%
      700: const Color(0xff2e130e),//80%
      800: const Color(0xff170907),//90%
      900: const Color(0xff000000),//100%
    },
  );
}





