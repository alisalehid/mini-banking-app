

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

extension ScreenSize on num {
  double get ofWidth {
    return MediaQuery.of(Get.context!).size.width * this;
  }

  double get ofHeight {
    return MediaQuery.of(Get.context!).size.height * this;
  }

  double get ofMinSize {
    return min(MediaQuery.of(Get.context!).size.width,
        MediaQuery.of(Get.context!).size.height) *
        this;
  }
}