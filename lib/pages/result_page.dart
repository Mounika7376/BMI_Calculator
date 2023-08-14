import 'package:bmi_calculator/widgets/shared_widgets.dart';
import 'package:flutter/material.dart';

import '../model/bmi_data.dart';

class ResultPage extends StatelessWidget {
  /// Route name
  static const String routeName = '/results';

  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = ModalRoute.of(context)!.settings.arguments as BMIData;

    return Scaffold(
      appBar: AppBar(title: Text('BMI CALCULATOR')),
      body: Column(
        children: [
          SizedBox(height: 24),
          Text(
            'Your Result',
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          ReusableCard(
            child: ResultCard(bmiData: model),
          ),
          BottomButton(
            onPressed: () => Navigator.pop(context),
            text: 'RE-CALCULATE YOUR BMI',
          )
        ],
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final BMIData bmiData;

  const ResultCard({Key? key, required this.bmiData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    var cat = bmiData.category;

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cat.name,
              style: tt.headline5!.copyWith(
                color: cat.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              bmiData.bmi.toStringAsFixed(1),
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Normal BMI range:',
              style: tt.caption!.copyWith(fontSize: 24),
            ),
            SizedBox(height: 8),
            Text(
              '18,5 - 25 kg/m2',
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
