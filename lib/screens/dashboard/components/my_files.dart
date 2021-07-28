
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/models/MyFiles.dart';
import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Our Acheivement",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            // ElevatedButton.icon(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(
            //       horizontal: defaultPadding * 1.5,
            //       vertical:
            //           defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
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
    return Container();
    // return GridView.custom(
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: crossAxisCount,
    //       crossAxisSpacing: defaultPadding,
    //       mainAxisSpacing: defaultPadding,
    //       childAspectRatio: childAspectRatio,
    //     ),childrenDelegate: SliverChildListDelegate([
    //   MentalConditionOverviewInfoCard(
    //     info: MentalConditionOverviewInfo(
    //       title: "Doctor User Ration",
    //       numOfFiles: "1328",
    //       svgSrc: "assets/icons/media_file.svg",
    //       totalStorage: "1328 Persons",
    //       color: Colors.greenAccent,
    //       percentage: 35,
    //     ),
    //   )
    // ]));
    // return GridView.builder(
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
}
