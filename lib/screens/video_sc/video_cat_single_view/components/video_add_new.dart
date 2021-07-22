import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/article_form.dart';
import 'package:admin_panel/forms/video_form.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoAddnewutton extends StatelessWidget {
  const VideoAddnewutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchFireBaseData>(builder: (context, appState, _) {
      Videos video = Videos.fromMap(<String,dynamic>{});
      var temp = Videos.fromMap(video.toMap());
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
              elevation: 5.0,
              barrierColor: Colors.white70,
              context: context,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              isScrollControlled: true,
              builder: (context) {
                return appState.videoModule!=null?VideosForm(
                  suggessions: appState.videoModule!.videoCategories.toList(growable: false),
                    temp: temp,
                    video: video,
                    onSubmit: () async {
                      video.copyFrom(temp);
                      appState.videoModule!.addVideos(video);
                      // appState.notify();
                    }):Container();
              });
        },
        icon: Icon(Icons.add),
        label: Text("Add New"),
      );
    });
  }
}
