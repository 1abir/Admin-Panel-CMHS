import 'package:flutter/material.dart';

class MentalConditionOverviewInfo {
  final String? svgSrc, title, totalStorage,numOfFiles;
  final int?  percentage;

  final Color? color;

  String? percentage_info;

  MentalConditionOverviewInfo({
    this.svgSrc,
    this.title,
    this.totalStorage,
    this.numOfFiles,
    this.percentage,
    this.color, this.percentage_info,
  });
}

//
// List demoMyFiles = [
//   CloudStorageInfo(
//     title: "Documents",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/Documents.svg",
//     totalStorage: "1.9GB",
//     color: primaryColor,
//     percentage: 35,
//   ),
//   CloudStorageInfo(
//     title: "Google Drive",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/google_drive.svg",
//     totalStorage: "2.9GB",
//     color: Color(0xFFFFA113),
//     percentage: 35,
//   ),
//   CloudStorageInfo(
//     title: "One Drive",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/one_drive.svg",
//     totalStorage: "1GB",
//     color: Color(0xFFA4CDFF),
//     percentage: 10,
//   ),
//   CloudStorageInfo(
//     title: "Documents",
//     numOfFiles: 5328,
//     svgSrc: "assets/icons/drop_box.svg",
//     totalStorage: "7.3GB",
//     color: Color(0xFF007EE5),
//     percentage: 78,
//   ),
// ];

//
// List demoMyFiles = [
//   MentalConditionOverviewInfo(
//     title: "Mild",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/media_file.svg",
//     totalStorage: "1328 Persons",
//     color: Colors.greenAccent,
//     percentage: 35,
//   ),
//   MentalConditionOverviewInfo(
//     title: "Moderate",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/media_file.svg",
//     totalStorage: "1000 Persons",
//     color: Colors.yellowAccent,
//     percentage: 35,
//   ),
//   // MentalConditionOverviewInfo(
//   //   title: "Medium",
//   //   numOfFiles: 1328,
//   //   svgSrc: "assets/icons/media_file.svg",
//   //   totalStorage:"1500 Persons",
//   //   color: Color(0xFFA4CDFF),
//   //   percentage: 10,
//   // ),
//   MentalConditionOverviewInfo(
//     title: "High",
//     numOfFiles: 5328,
//     svgSrc: "assets/icons/media_file.svg",
//     totalStorage: "1500 Persons",
//     color: Color(0xFFFFA113),
//     percentage: 13,
//   ),
//   MentalConditionOverviewInfo(
//     title: "Severe",
//     numOfFiles: 1028,
//     svgSrc: "assets/icons/media_file.svg",
//     totalStorage: "500 Persons",
//     color: Colors.redAccent,
//     percentage: 78,
//   ),
// ];
