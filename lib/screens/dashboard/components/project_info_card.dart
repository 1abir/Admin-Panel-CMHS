import 'dart:math';

import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard/models/overview_chart_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'overview_card.dart';

class ProjectInfo extends StatelessWidget {
  const ProjectInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Container(
      // width: do,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Overview",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                width: defaultPadding,
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: ProjectInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: ProjectInfoCardGridView(),
            desktop: ProjectInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectInfoCardGridView extends StatelessWidget {
  const ProjectInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(builder: (context, appState, child) {
      if (appState.userModuleElement == null ||
          appState.am == null ||
          appState.videoModule == null)
        return Container(
          width: 50,
          height: 100,
        );
      try {
        int ndoc = appState.userModuleElement!.doctors.length;
        int nuser = appState.userModuleElement!.users.length;
        int ratio = (nuser * 1.0 / ndoc).ceil();
        int narticle = appState.am!.articleList!.length;
        int narticlecat = appState.am!.articleCategories.length;
        int ratioar = (nuser * 1.0 / ndoc).ceil();
        int nvideo = appState.videoModule!.videoList!.length;
        int nvidcat = appState.videoModule!.videoCategories.length;
        int ratiovid = (nuser * 1.0 / ndoc).ceil();
        return Container(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: MentalConditionOverviewInfoCard(
                  info: MentalConditionOverviewInfo(
                    title: "Doctor User Ratio",
                    numOfFiles: "1328",
                    svgSrc: "assets/icons/media_file.svg",
                    totalStorage: "$ndoc Doctors, $nuser Users",
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                    percentage: (ndoc * 100.0 / (ndoc + nuser)).ceil(),
                    percentageInfo: "1 : $ratio",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: MentalConditionOverviewInfoCard(
                  info: MentalConditionOverviewInfo(
                      title: "Articles",
                      numOfFiles: "",
                      svgSrc: "assets/icons/media_file.svg",
                      totalStorage:
                          "$narticlecat Categories, $narticle Articles",
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                      percentage:
                          (narticlecat * 100.0 / (narticle + narticlecat))
                              .ceil(),
                      percentageInfo: "1 : $ratioar"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: MentalConditionOverviewInfoCard(
                  info: MentalConditionOverviewInfo(
                      title: "Videos",
                      numOfFiles: "",
                      svgSrc: "assets/icons/media_file.svg",
                      totalStorage: "$nvidcat Categories, $nvideo Videos",
                      color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                      percentage: (nvidcat * 100.0 / (nvideo + nvidcat)).ceil(),
                      percentageInfo: "1 : $ratiovid"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: MentalConditionOverviewInfoCard(
                  info: MentalConditionOverviewInfo(
                    title: "Detection Modules",
                    numOfFiles: "",
                    svgSrc: "assets/icons/media_file.svg",
                    totalStorage: "${detectionElementNames.length} Modules",
                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        .withOpacity(1.0),
                    percentage: 100,
                    percentageInfo: "",
                  ),
                ),
              ),
            ],
          ),
        );
      } catch (e) {
        return Container();
      }
    });
  }
}
