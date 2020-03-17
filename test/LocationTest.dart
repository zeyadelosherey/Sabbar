import 'package:flutter_test/flutter_test.dart';
import 'package:sabbar/utilities/Helpers.dart';

void main() {
  test('Calculate destination between 2 distination', () {
    expect(Helpers.calculateDistance(30.0424726,30.9754028 , 29.9628891,31.2494736), 27.835745437049027);
  });
}