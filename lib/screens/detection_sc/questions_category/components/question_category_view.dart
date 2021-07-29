import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/backend/detectionmodule/detection.dart';
import 'package:admin_panel/forms/question_form.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class QuestionCategoryView extends StatelessWidget {
  final String category;

  const QuestionCategoryView({Key? key, required this.category}) : super(key: key);

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
                  Spacer(),
                  // Expanded(child: SearchField()),
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Consumer<FetchFireBaseData>(builder: (context, appState, _) {
                    int key = appState
                            .detectionModuleMap[category]!
                            .questionsList!
                            .length +
                        1;
                    FirebaseQuestionDetection qd = FirebaseQuestionDetection(
                        text: '',
                        qKey: key.toString(),
                        category: category,
                        qVal: 0,
                        level: key,
                        optionList: <QuestionOption>[
                          QuestionOption(text: "একেবারেই হয় না", value: 0),
                          QuestionOption(text: "খুব সামান্য হয়", value: 1),
                          QuestionOption(text: "মোটামুটি হয়", value: 2),
                          QuestionOption(text: "বেশি হয়", value: 3),
                          QuestionOption(text: "অনেক বেশি হয়", value: 4),
                        ]);
                    var temp = FirebaseQuestionDetection.fromMap(qd.toMap());
                    return ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return QuestionForm(
                                  temp: temp,
                                  firebaseQuestionDetection: qd,
                                  onSubmit: () async {
                                    debugPrint("text: " + qd.text);
                                    qd.qKey = qd.level.toString();
                                    appState.detectionModuleMap[
                                            category]!
                                        .addQuestion(qd);
                                    // appState.notify();
                                  });
                            });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                    );
                  }),
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
                category.toUpperCase().replaceAll("_", " "),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Consumer<FetchFireBaseData>(
                  builder: (context, appState, _) => SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Question"),
                        ),
                      ],
                      rows: appState.detectionModuleMap
                              .containsKey(category)
                          ? List.generate(
                              appState
                                  .detectionModuleMap[
                                      category]!
                                  .questionsList!
                                  .length,
                              (i) => _dataRow(
                                  "assets/icons/media_file.svg",
                                  appState
                                      .detectionModuleMap[
                                          category]!
                                      .questionsList![i],
                                  context,
                                  appState.detectionModuleMap[
                                      category]!,
                                  appState),
                            )
                          : <DataRow>[],
                    ),
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

DataRow _dataRow(
    String icon,
    FirebaseQuestionDetection qd,
    BuildContext context,
    DetectionModuleElement dme,
    FetchFireBaseData appState) {
  var temp = FirebaseQuestionDetection.fromMap(qd.toMap());
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
                  '${qd.level}.    ${qd.text}',
                  overflow: TextOverflow.fade,
                ),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    isScrollControlled: true,
                    builder: (context) {
                      return QuestionForm(
                        firebaseQuestionDetection: qd,
                        temp: temp,
                        onSubmit: () async {
                          dme.updateQuestion(qd);
                        },
                        onDelete: () async {
                          dme.deleteQuestion(qd);
                          // appState.notify();
                        },
                      );
                    });
              },
            ),
          ],
        ),
      ),
    ],
  );
}
