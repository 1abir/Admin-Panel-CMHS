import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/models/RecentFile.dart';
import 'package:admin_panel/screens/detection_sc/questions_category/question_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(child: SearchField()),
              Spacer(),
              SizedBox(width: defaultPadding,),
              // ElevatedButton.icon(
              //   style: TextButton.styleFrom(
              //     padding: EdgeInsets.symmetric(
              //       horizontal: defaultPadding * 1.5,
              //       vertical:
              //       defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
              //     ),
              //   ),
              //   onPressed: () {},
              //   icon: Icon(Icons.add),
              //   label: Text("Add New"),
              // ),
              SizedBox(width: defaultPadding,),
            ],
          ),
          SizedBox(height: defaultPadding),
          Text(
            "Categories",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Consumer<FetchFireBaseData>(
            builder: (context, appState,child) {
              return SizedBox(
                width: double.infinity,
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: defaultPadding,
                  columns: [
                    // DataColumn(
                    //   label: Text("No. "),
                    // ),
                    DataColumn(
                      label: Text("Name"),
                    ),
                  ],
                  rows: List.generate(
                    detectionElementNames.length,
                    (index) {
                      String title = detectionElementNames[index].toUpperCase().replaceAll("_", " ");
                      return _recentFileDataRow(
                          RecentFile(
                        title: title,
                        icon: "assets/icons/media_file.svg",
                      ),context,index);
                    },
                  ),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
  DataRow _recentFileDataRow(RecentFile fileInfo,BuildContext context,int index) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                fileInfo.icon!,
                height: 30,
                width: 30,
              ),
              // Builder(
              //   builder:(context)=>
              // ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushReplacement<void, void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => QuestionCategoryScreen(category: detectionElementNames[index],),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text('${fileInfo.title!}'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

