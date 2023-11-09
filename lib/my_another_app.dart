import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:get/get.dart';


class DiabetesData {
  final String category;
  final int value;
  DiabetesData(this.category, this.value);
}

class Glucose {
  final int glucose;
  Glucose(this.glucose);
}
class Insulin {
  final int insulin;

  Insulin(this.insulin);
}

class MyAnotherApp extends StatelessWidget {
  final List<DiabetesData> glucoseData = List.generate(50, (index) {
    return DiabetesData(index.toString(), diabetes['Glucose'][index]);
  });
  final List<Glucose> glucose = List.generate(50, (index) {
    return Glucose(diabetes['Glucose'][index]);
  });

  final List<DiabetesData> insulinData = List.generate(50, (index) {
    return DiabetesData(index.toString(), diabetes['Insulin'][index]);
  });
  final List<Insulin> insulin = List.generate(50, (index) {
    return Insulin(diabetes['Insulin'][index]);
  });

  final List<DiabetesData> statusData = List.generate(50, (index) {
    return DiabetesData(index.toString(), diabetes['Status'][index] == 'Yes' ? 1 : 0);
  });

  List<int> generateRandomList(int length, int minValue, int maxValue) {
    Random random = Random();
    List<int> resultList = List.generate(length, (index) {
      return random.nextInt(maxValue - minValue + 1) + minValue;
    });
    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    insulin.sort((a, b) => a.insulin.compareTo(b.insulin)); // Sort the data by insulin values
    glucose.sort((a, b) => a.glucose.compareTo(b.glucose)); // Sort the data by glucose values
    return Scaffold(
        appBar: AppBar(
          title: Text('Data Visualization'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        const Text('Glucose Histogram', style: TextStyle(
                            fontSize: 18
                        ),),
                        Container(
                          height: 300,
                          child: charts.BarChart(
                              [
                                charts.Series<Glucose, String>(
                                  id: 'Glucose',
                                  domainFn: (Glucose data, _) => '${data.glucose ~/ 10 * 10}-${(data.glucose ~/ 10 * 10) + 10}',
                                  measureFn: (Glucose data, _) => 1, // Count of occurrences, set to 1 for each data point
                                  data: glucose,
                                ),
                              ],
                              animate: true,
                              domainAxis: charts.OrdinalAxisSpec(
                                renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
                              ),
                              barGroupingType: charts.BarGroupingType.groupedStacked
                          ),
                        ),
                        SizedBox(height: 10,),
                        const Text('Glucose Bar Graph',style: TextStyle(
                            fontSize: 18
                        ),),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 300,
                            width: 800,
                            child: charts.BarChart(
                              [
                                charts.Series<DiabetesData, String>(
                                  id: 'Glucose',
                                  domainFn: (DiabetesData data, _) => data.category,
                                  measureFn: (DiabetesData data, _) => data.value,
                                  data: glucoseData,
                                ),
                              ],
                              animate: true,
                              // domainAxis: charts.OrdinalAxisSpec(
                              //   renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
                              // ),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding:EdgeInsets.all(5),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text('Insulin Histogram', style: TextStyle(
                            fontSize: 18
                        ),),
                        Container(
                          height: 300,
                          child: charts.BarChart(
                            [
                              charts.Series<Insulin, String>(
                                id: 'Insulin',
                                domainFn: (Insulin data, _) => '${data.insulin ~/ 50 * 50}-${(data.insulin ~/ 50 * 50) + 50}',
                                measureFn: (Insulin data, _) => 1, // Count of occurrences, set to 1 for each data point
                                data: insulin,
                              ),
                            ],
                            animate: true,
                            domainAxis: charts.OrdinalAxisSpec(
                              renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
                            ),
                            barGroupingType: charts.BarGroupingType.groupedStacked, // Add this line
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Insulin Bar Graph', style: TextStyle(
                            fontSize: 18
                        ),),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            height: 300,
                            width: 800,
                            child: charts.BarChart(
                              [
                                charts.Series<DiabetesData, String>(
                                  id: 'Insulin',
                                  domainFn: (DiabetesData data, _) => data.category,
                                  measureFn: (DiabetesData data, _) => data.value,
                                  data: insulinData,
                                ),
                              ],
                              animate: true,
                              secondaryMeasureAxis: const charts.NumericAxisSpec(
                                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                                  desiredTickCount: 10, // Adjust the number of tick marks as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text('Status Bar Plot', style: TextStyle(
                          fontSize: 18
                      ),),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 100,
                          width: 800,
                          child: charts.BarChart(
                            [
                              charts.Series<DiabetesData, String>(
                                id: 'Status',
                                domainFn: (DiabetesData data, _) => data.category,
                                measureFn: (DiabetesData data, _) => data.value,
                                data: statusData,
                              ),
                            ],
                            animate: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),



              ],
            ),
          ),
        ),
      );

  }
}

Random random = Random();
// Your diabetes data
final Map<String, dynamic> diabetes = {
  'Age': List.generate(50, (index) {
    return random.nextInt(70 - 25 + 1) + 25;
  }),
  'Gender': List.generate(50, (index) => index % 2 == 0 ? 'Male' : 'Female'),
  'BMI': List.generate(50, (index) {
    return random.nextInt(40 - 18 + 1) + 18;
  }),
  'Blood_Pressure': List.generate(50, (index) {
    return random.nextInt(180 - 80 + 1) + 80;
  }),
  'Glucose': List.generate(50, (index) {
    return random.nextInt(200 - 70 + 1) + 70;
  }),
  'Insulin': List.generate(50, (index) {
    return random.nextInt(300 - 0 + 1) + 0;
  }),
  'Cholesterol': List.generate(50, (index) {
    return random.nextInt(300 - 100 + 1) + 100;
  }),
  'HbA1c': List.generate(50, (index) {
    return random.nextInt(12 - 4 + 1) + 4;
  }),
  'Status': List.generate(50, (index){
    return ((random.nextInt(2)) == 0) ? "Yes" : "No";
  }),
};

