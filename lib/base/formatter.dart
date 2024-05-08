import 'package:intl/intl.dart';

class MyFormatter{
  static String formatNumber(String price){
    return (NumberFormat.decimalPattern('en_US').format(int.parse(price.replaceAll(',', '')))).toString();
  }

  static String dateformater(DateTime dateTime){
    return DateFormat('d MMMM y').format(dateTime);
  }

  static String formatDate(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate);

    // Format the date using the dateformater function
    String formattedDate = dateformater(parsedDate);

    // Handle the day's ordinal indicator
    String dayWithOrdinal = formattedDate.replaceAllMapped(
      RegExp(r'(\d)(st|nd|rd|th)'),
          (match) => '${match.group(1)}${_getOrdinalIndicator(int.parse(match.group(1)!))}',
    );

    return dayWithOrdinal;
  }

  static String _getOrdinalIndicator(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}