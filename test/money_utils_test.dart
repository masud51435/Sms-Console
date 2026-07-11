import 'package:flutter_test/flutter_test.dart';
import 'package:sms_console/core/utils/helpers/money_utils.dart';

void main() {
  group('MoneyUtils.multiply', () {
    test('should multiply decimal strings correctly without floating point issues', () {
      expect(MoneyUtils.multiply("0.0079", 3), "0.0237");
      expect(MoneyUtils.multiply("0.0079", 1), "0.0079");
      expect(MoneyUtils.multiply("1.25", 2), "2.50");
      expect(MoneyUtils.multiply("0.1", 2), "0.2");
      expect(MoneyUtils.multiply("0.0079", 100), "0.7900");
    });

    test('should handle empty string', () {
      expect(MoneyUtils.multiply("", 3), "0.0000");
    });

    test('should handle integer strings', () {
      expect(MoneyUtils.multiply("5", 2), "10");
    });
  });
}
