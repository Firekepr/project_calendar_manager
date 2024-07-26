import 'package:project_calendar_manager/styles/font/font_size.dart';

extension HandleSize on FontSize {
  double get size {
    switch (this) {
      case FontSize.extremeBig:
        return 26.0;
      case FontSize.extraBig:
        return 22.0;
      case FontSize.big:
        return 20.0;
      case FontSize.middleBig:
        return 18.0;
      case FontSize.medium:
        return 16.0;
      case FontSize.small:
        return 14.0;
      case FontSize.extraSmall:
        return 12.0;
      default:
        return 12.0;
    }
  }
}