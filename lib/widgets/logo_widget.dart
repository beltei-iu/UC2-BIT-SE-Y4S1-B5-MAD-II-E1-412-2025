import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/beltei_international_university_in_cambodia.png',
      height: 100,
      width: 100,
    );
  }
}
