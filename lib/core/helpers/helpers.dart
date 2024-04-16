import 'package:image_picker/image_picker.dart';

import '../const/image_constant.dart';
import 'package:intl/intl.dart';

class Helpers {
  static DateTime data = DateTime.now();
  static int weekday = DateTime.now().weekday;
  static String weekdayName = Helpers.getWeekdayName(weekday);
  static String weekdayNameView = Helpers.getWeekday(weekday);
  static String dateForBR = Helpers.formatDateForBRDate(data);

  static List<String> images = [
    ImageConstant.imgDownload1,
    ImageConstant.imgRainyweather4,
    ImageConstant.imgRainyweather469x69,
    ImageConstant.imgRainyweather477x77,
    ImageConstant.imgRainyweather481x81,
    ImageConstant.imgCloudrainand,
  ];

  static String formatDateForBRDate(DateTime dateTime) {
    List<String> months = [
      "jan.",
      "fev.",
      "mar.",
      "abr.",
      "mai.",
      "jun.",
      "jul.",
      "ago.",
      "set.",
      "out.",
      "nov.",
      "dez."
    ];

    String day = dateTime.day.toString();
    String month = months[dateTime.month - 1]; // Adjusting month index
    String year = dateTime.year.toString();

    return "$day de $month de $year";
  }

  static List<String> semana = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  static List<String> semanasGetModel = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  static String getWeekdayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  static String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  static  pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.readAsBytes();
    }
  }

  static String convertToWeekday(String dtTxt) {
    if (dtTxt == "") {
      return "";
    } else {
      DateTime dateTime = DateTime.parse(dtTxt);
      String dayOfWeek = DateFormat.E().format(dateTime).toUpperCase();
      String time = DateFormat.Hm().format(dateTime);
      return '$dayOfWeek-${time}H';
    }
  }

  static String imageClima(String clima) {
    switch (clima) {
      case "Clear":
        return ImageConstant.imgDownload1;
      case "Clouds":
        return ImageConstant.imgRainyweather4;
      case "Rain":
        return ImageConstant.imgRainyweather469x69;
      case "Snow":
        return ImageConstant.imgRainyweather477x77;
      case "Drizzle":
        return ImageConstant.imgRainyweather481x81;
      case "Thunderstorm":
        return ImageConstant.imgCloudrainand;
      default:
        return "";
    }
  }
}
