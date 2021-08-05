import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuperAppMenu extends StatelessWidget {
  const SuperAppMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SuperAppMenuItem(
              icon: "assets/icons/order.svg",
              label: "Order",
              color: Colors.red,
            ),
            SuperAppMenuItem(
              icon: "assets/icons/after_sales.svg",
              label: "After Sales",
              color: Colors.yellow,
              navigationPath: "/aftersales/main",
            ),
            SuperAppMenuItem(
              icon: "assets/icons/training.svg",
              label: "Training",
              color: Colors.green,
            ),
            SuperAppMenuItem(
              icon: "assets/icons/elearning.svg",
              label: "E-Learning",
              color: Colors.blue.shade800,
            ),
          ],
        ),
      ),
    );
  }
}

class SuperAppMenuItem extends StatelessWidget {
  final Color color;
  final String label;
  final String icon;
  final String navigationPath;

  const SuperAppMenuItem({
    this.color = Colors.grey,
    this.label = "",
    this.icon = "",
    this.navigationPath = "",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, navigationPath);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(15),
            decoration: new BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              icon,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
