/// Utility for handling money without floating point issues
class MoneyUtils {
  /// Multiplies a decimal string by an integer factor safely.
  /// Example: "0.0079" * 3
  static String multiply(String decimalString, int factor) {
    if (decimalString.isEmpty) return "0.0000";
    
    // Find decimal point
    int dotIndex = decimalString.indexOf('.');
    if (dotIndex == -1) {
      return (int.parse(decimalString) * factor).toString();
    }
    
    int precision = decimalString.length - dotIndex - 1;
    // Remove dot and parse as integer (e.g., 0.0079 -> 79)
    String integerPart = decimalString.replaceFirst('.', '');
    int value = int.parse(integerPart);
    
    int result = value * factor;
    String resultStr = result.toString().padLeft(precision + 1, '0');
    
    // Re-insert dot
    int insertIndex = resultStr.length - precision;
    return '${resultStr.substring(0, insertIndex)}.${resultStr.substring(insertIndex)}';
  }
}
