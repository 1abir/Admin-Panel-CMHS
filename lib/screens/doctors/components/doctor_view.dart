import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/models/RecentFile.dart';
import 'package:admin_panel/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class DoctorsView extends StatelessWidget {
  const DoctorsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * .99,
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
                  SizedBox(
                    width: defaultPadding,
                  ),
                  Consumer<FetchFireBaseData>(
                    builder: (context, appState, _) => ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: (){
                        appState.fetchUserModule();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text("Refresh"),
                    ),
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
                "Doctors OverView",
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
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Birth Year"),
                        ),
                        DataColumn(label: Text("Gender")),
                        DataColumn(label: Text("Credit")),
                      ],
                      rows: appState.userModuleElement==null?[]:List.generate(
                        appState.userModuleElement!.doctors.length,
                            (index) => _datarowDoctor(index,appState.userModuleElement!.doctors),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


DataRow _datarowDoctor(int index, List<UserInfoClass> docotrs,) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(docotrs[index].name),
            ),
          ],
        ),
      ),
      DataCell(Text(docotrs[index].byear.toString())),
      DataCell(Text(docotrs[index].gender)),
      DataCell(Text(docotrs[index].credit.toString())),
    ],
  );
}

