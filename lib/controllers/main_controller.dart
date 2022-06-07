import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final brightness = SchedulerBinding.instance!.window.platformBrightness;
  
}
