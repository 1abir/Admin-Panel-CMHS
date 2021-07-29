import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/screens/video_sc/video_cat_single_view/components/video_add_new.dart';
import 'package:admin_panel/screens/video_sc/video_cat_single_view/video_category_single_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class VideoCategoryView extends StatelessWidget {
  const VideoCategoryView({
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
                VideoAddNewButton(),
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
              "Video Categories",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Flexible(
            flex: 11,
            child: SingleChildScrollView(
              child: Consumer<FetchFireBaseData>(
                builder: (context, appState, _) => SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Name"),
                      ),
                    ],
                    rows: appState.videoModule == null ||
                            appState.videoModule!.videoCategories.isEmpty
                        ? []
                        : List.generate(
                            appState.videoModule!.videoCategories.length,
                            (index) {
                              return _videoCatDataRow(
                                  context,
                                  appState.videoModule!.videoCategories
                                      .elementAt(index));
                            },
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _videoCatDataRow(BuildContext context, String category) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/media_file.svg",
                height: 30,
                width: 30,
              ),
              // Builder(
              //   builder:(context)=>
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement<void, void>(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          VideoCategorySingleScreen(
                        category: category,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(category),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
