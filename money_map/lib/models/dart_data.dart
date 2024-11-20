import 'individual_bar.dart';

class BarData {
  Map<int, double> daysAmount;
  List<IndividualBar> barData = [];

  BarData({required this.daysAmount});

  void initialize() {
    for (int i = 0; i < 7; i++) {
      barData.add(IndividualBar(x: i, y: daysAmount[i] ?? 0));
    }
  }
}