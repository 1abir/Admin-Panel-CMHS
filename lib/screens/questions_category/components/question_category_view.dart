import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/data/firebase/detection.dart';
import 'package:admin_panel/forms/question_form.dart';
import 'package:admin_panel/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class QuestionCategoryView extends StatelessWidget {
  final int index;

  const QuestionCategoryView({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        height: MediaQuery.of(context).size.height * .99,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: SearchField()),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () {},
                    icon: Icon(Icons.add),
                    label: Text("Add New"),
                  ),
                  SizedBox(
                    width: defaultPadding,
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            Flexible(
              flex: 1,
              child: Text(
                detectionElementNames[index].toUpperCase().replaceAll("_", " "),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Consumer<FetchFireBaseData>(
                  builder: (context, appState, _) => DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Question"),
                      ),
                    ],
                    rows: appState.detectionModuleMap
                            .containsKey(detectionElementNames[index])
                        ? List.generate(
                            appState
                                .detectionModuleMap[
                                    detectionElementNames[index]]!
                                .questionsList!
                                .length,
                            (i) => _dataRow(
                              "assets/icons/media_file.svg",
                              appState
                                  .detectionModuleMap[
                                      detectionElementNames[index]]!
                                  .questionsList![i],
                              context,
                                  appState.detectionModuleMap[
                              detectionElementNames[index]]!,
                            ),
                          )
                        : <DataRow>[],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

DataRow _dataRow(String icon, FirebaseQuestionDetection qd,
    BuildContext context, DetectionModuleElement dme) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 30,
              width: 30,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  qd.text,
                  overflow: TextOverflow.fade,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    builder: (context) {
                      return QuestionForm(
                          firebaseQuestionDetection: qd, onSubmit: () {
                            dme.addQuestion(qd);
                      });
                    });
              },
            ),
          ],
        ),
      ),
    ],
  );
}
