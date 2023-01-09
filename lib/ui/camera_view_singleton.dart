import 'dart:ui';

/// Singleton to record size related data
class CameraViewSingleton {
  static double ratio = 1;
  static Size screenSize = Size(500, 500);
  static Size inputImageSize = Size(500, 500);
  static Size get actualPreviewSize =>
      Size(screenSize.width, screenSize.width * ratio);
}
