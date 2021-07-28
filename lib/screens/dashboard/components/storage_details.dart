import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(
      builder: (context, appState, child) {
        if(appState.detectionModule == null) return Container();
        return Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detection Module Question",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: defaultPadding),
              // Chart(),
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(
                        color: Colors.green,
                        value: appState.detectionModuleMap[detectionElementNames[4]]!.questionsList!.length.toDouble(),
                        title: "OCD",
                        showTitle: true,
                        radius: 16,
                      ),
                      PieChartSectionData(
                        color: Color(0xFFEE2727),
                        value: appState.detectionModuleMap[detectionElementNames[5]]!.questionsList!.length.toDouble(),
                        title: "Social Interaction Problem",
                        showTitle: true,
                        radius: 16,
                      ),

                      PieChartSectionData(
                        color: primaryColor.withOpacity(0.1),
                        value: appState.detectionModuleMap[detectionElementNames[2]]!.questionsList!.length.toDouble(),
                        title: "Love Obsession",
                        showTitle: true,
                        radius: 13,
                      ),
                      PieChartSectionData(
                        color: primaryColor,
                        value: appState.detectionModuleMap[detectionElementNames[0]]!.questionsList!.length.toDouble(),
                        title: "Anxiety",
                        showTitle: true,
                        radius: 25,
                      ),
                      PieChartSectionData(
                        color: Color(0xFFFFCF26),
                        value: appState.detectionModuleMap[detectionElementNames[3]]!.questionsList!.length.toDouble(),
                        title: "Marital Problem",
                        showTitle: true,
                        radius: 19,
                      ),
                      PieChartSectionData(
                        color: Color(0xFF26E5FF),
                        value: appState.detectionModuleMap[detectionElementNames[1]]!.questionsList!.length.toDouble(),
                        title: "Depression",
                        showTitle: true,
                        radius: 22,
                      ),

                    ],
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: defaultPadding),
                      // Text(
                      //   "29.1",
                      //   style: Theme.of(context).textTheme.headline4!.copyWith(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w600,
                      //         height: 0.5,
                      //       ),
                      // ),
                      // Text("Mental\nProblems"),
                    ],
                  ),
                ),
              ],
            ),
          ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "OCD",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[4]]!.questionsList!.length} Questions",
                numOfFiles: 1328,
              ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "Anxiety",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[0]]!.questionsList!.length} Questions",
                numOfFiles: 1000,
              ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "Love Obsession",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[2]]!.questionsList!.length} Questions",
                numOfFiles: 1500,
              ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "Social Interaction Problem",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[5]]!.questionsList!.length} Questions",
                numOfFiles: 500,
              ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "Marital Problem",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[3]]!.questionsList!.length} Questions",
                numOfFiles: 500,
              ),
              StorageInfoCard(
                svgSrc:"assets/icons/media_file.svg",
                title: "Depression",
                amountOfFiles: "${appState.detectionModuleMap[detectionElementNames[1]]!.questionsList!.length} Questions",
                numOfFiles: 500,
              ),
            ],
          ),
        );
      }
    );
  }
}
