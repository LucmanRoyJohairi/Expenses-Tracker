import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentAmountPercent;

  ChartBar({this.label, this.spentAmount, this.spentAmountPercent});
  @override
  Widget build(BuildContext context) {
    //print("$spentAmountPercent hello");
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.12,
            child: FittedBox(
              child: Text(
                "\$ ${spentAmount.toStringAsFixed(0)}",
              ),
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 15,
            margin: EdgeInsets.only(
              top: constraints.maxHeight * 0.05,
              bottom: constraints.maxHeight * 0.05,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spentAmountPercent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: Text(label),
          ),
        ],
      );
    });
  }
}
