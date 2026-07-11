import 'package:flutter_test/flutter_test.dart';
import 'package:sms_console/features/sms_console/data/models/sms_message_model.dart';

void main() {
  group('SmsMessageModel', () {
    test('should parse from json correctly', () {
      final json = {
        "messageId": "SM3fa85f64",
        "provider": "TWILIO",
        "status": "ACCEPTED",
        "segmentCount": 2,
        "cost": "0.1500",
        "currency": "EUR"
      };

      final model = SmsMessageModel.fromJson(json);

      expect(model.messageId, "SM3fa85f64");
      expect(model.provider, "TWILIO");
      expect(model.status, "ACCEPTED");
      expect(model.segmentCount, 2);
      expect(model.cost, "0.1500");
      expect(model.currency, "EUR");
    });
  });
}
