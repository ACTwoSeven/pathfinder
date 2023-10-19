import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pathfinder/Pages/LoginPage.dart';
import 'package:pathfinder/misc/colors.dart';
import 'package:pathfinder/pages/RegisterPage.dart';


class ResponsiveButton extends StatefulWidget {
final bool? isResponsive;
final double? width;

ResponsiveButton({Key? key, this.width, this.isResponsive = false})
    : super(key: key);

@override
_ResponsiveButtonState createState() => _ResponsiveButtonState();
}

class _ResponsiveButtonState extends State<ResponsiveButton> {
  List<Widget> pages = [
    LoginPage(),
    RegisterPage(),
    RegisterPage(),
  ];

int index = 0;

  void updateIndex() {
  setState(() {
  index = (index + 1) % pages.length;
  });
}

@override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pages[index]),
      );
      },
    child: Container(
      width: widget.width,
      height: 60,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.mainColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset("img/button-one.png"),
            ],
          ),
        ),
      );
    }
}