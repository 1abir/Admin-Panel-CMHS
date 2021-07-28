import 'dart:math';

import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/models/MyFiles.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery
        .of(context)
        .size;
    return Container(
      // width: do,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Overview",
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
              ),
              SizedBox(width: defaultPadding,),
            ],
          ),
          SizedBox(height: defaultPadding),
          Responsive(
            mobile: FileInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio: _size.width < 650 ? 1.3 : 1,
            ),
            tablet: FileInfoCardGridView(),
            desktop: FileInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(
        builder: (context, appState, child) {
          if (appState.userModuleElement == null || appState.am == null ||
              appState.videoModule == null) return Container(width: 50,height: 100,);
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
                                  percentage_info: "1 : $ratio",
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
                                    totalStorage: "$narticlecat Categories, $narticle Articles",
                                    color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                        .withOpacity(1.0),
                                    percentage: (narticlecat * 100.0 /
                                        (narticle + narticlecat)).ceil(),
                                    percentage_info: "1 : $ratioar"
                                ),
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
                                    percentage: (nvidcat * 100.0 / (nvideo + nvidcat))
                                        .ceil(),
                                    percentage_info: "1 : $ratiovid"
                                ),
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
                                    percentage_info : "",
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
          } catch (e) {
            return Container();
          }
          // GridView.custom(
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: crossAxisCount,
          //   crossAxisSpacing: defaultPadding,
          //   mainAxisSpacing: defaultPadding,
          //   childAspectRatio: childAspectRatio,
          // ),childrenDelegate: SliverChildListDelegate([
          //   Container(
          //     width: 250,
          //     height: 250,
          //     child: MentalConditionOverviewInfoCard(
          //       info: MentalConditionOverviewInfo(
          //         title: "Doctor User Ratio",
          //         numOfFiles: "1328",
          //         svgSrc: "assets/icons/media_file.svg",
          //         totalStorage: "1328 Persons",
          //         color: Colors.greenAccent,
          //         percentage: 35,
          //       ),
          //     ),
          //   ),
          // ]));
          //   GridView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: demoMyFiles.length,
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: crossAxisCount,
          //     crossAxisSpacing: defaultPadding,
          //     mainAxisSpacing: defaultPadding,
          //     childAspectRatio: childAspectRatio,
          //   ),
          //   itemBuilder: (context, index) => MentalConditionOverviewInfoCard(info: demoMyFiles[index]),
          // );
        }
    );
  }
}
