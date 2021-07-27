import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/videomodule/videomodulelement.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/video_form.dart';
import 'package:admin_panel/screens/video_sc/video_cat_single_view/components/video_add_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class VideoCategorySingleView extends StatelessWidget {
  final String category;

  const VideoCategorySingleView({Key? key, required this.category})
      : super(key: key);

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
                  VideoAddnewutton(),
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
                category,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Consumer<FetchFireBaseData>(
                  builder: (context, appState, _) {
                    List<Videos> videoList = appState.videoModule!.getVideosSublist(category);
                    return SizedBox(
                      width: double.infinity,
                      child: DataTable(
                        horizontalMargin: 0,
                        columnSpacing: defaultPadding,
                        columns: [
                          DataColumn(
                            label: Text("Video"),
                          ),
                        ],
                        rows: List.generate(
                          videoList.length,
                          (i) => _dataRow(
                              "assets/icons/media_file.svg",
                              videoList[i],
                              context,
                              appState.videoModule!,
                              appState),
                        ),
                      ),
                    );
                  },
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
    Videos video,
    BuildContext context,
    VideoModuleElement videoModule,
    FetchFireBaseData appState) {
  var temp = Videos.fromMap(video.toMap());
  temp.key = video.key;

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
                  video.caption,
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
                      return VideosForm(
                        suggessions: videoModule.videoCategories.toList(growable: false),
                        video: video,
                        temp: temp,
                        onSubmit: () async {
                          video.copyFrom(temp);
                          videoModule.updateVideos(video);
                        },
                        onDelete: () async {
                          videoModule.deleteVideos(video);
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
