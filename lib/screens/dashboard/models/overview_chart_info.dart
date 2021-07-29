import 'package:flutter/material.dart';

class MentalConditionOverviewInfo {
  final String? svgSrc, title, totalStorage, numOfFiles;
  final int? percentage;

  final Color? color;

  String? percentageInfo;

  MentalConditionOverviewInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color,
    this.percentageInfo,
  });
}
