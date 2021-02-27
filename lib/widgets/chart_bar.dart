import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentAmountPercent;

  ChartBar({this.label, this.spentAmount, this.spentAmountPercent});
  @override
  Widget build(BuildContext context) {
    print("$spentAmountPercent hello");
    return Column(
      children: [
        FittedBox(child: Text("\$ ${spentAmount.toStringAsFixed(0)}")),
        Container(
          height: 60,
          width: 10,
          margin: EdgeInsets.only(top: 4, bottom: 4),
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
        Text(label),
      ],
    );
  }
}
