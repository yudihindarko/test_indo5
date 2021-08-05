import 'package:flutter/material.dart';

class IntroBodyTemplate extends StatelessWidget {
  final List<Widget> children;
  final double marginTop;
  final bool withGradient;
  const IntroBodyTemplate({
    this.children = const [],
    this.marginTop = 0,
    this.withGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          colorFilter: new ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.dstATop,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: withGradient
            ? BoxDecoration(
                // color: Colors.black,
                image: DecorationImage(
                  image: AssetImage("assets/images/background_gradient.png"),
                  fit: BoxFit.cover,
                ),
              )
            : null,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: marginTop),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Text(
                  "TEST INDONESIA 5",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
