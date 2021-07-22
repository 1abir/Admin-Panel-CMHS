import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/models/RecentFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class RecentSessionsView extends StatelessWidget {
  const RecentSessionsView({
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
            child: Text(
              "Recent Sessions",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Flexible(
            flex: 8,
            child: SingleChildScrollView(
              child: Consumer<FetchFireBaseData>(
                builder: (context, appState, _) => SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("Doctor's Name"),
                      ),
                      DataColumn(
                        label: Text("Patient's Name"),
                      ),
                      DataColumn(
                        label: Text("Date Time"),
                      ),
                      DataColumn(
                        label: Text("Duration "),
                      ),
                    ],
                    rows: appState.meetingModuleElement==null?[]:List.generate(
                      appState.meetingModuleElement!.sessions.length,
                      (index) => _meetingDataRow(appState,index),
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
}

String _printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

DataRow _meetingDataRow(FetchFireBaseData appState, int index) {
  var meet = appState.meetingModuleElement!.sessions[index];
  var dname = meet.doctor_id;
  var pname = meet.patient_id;
  if(appState.userModuleElement!=null){
    for (var i in appState.userModuleElement!.doctors) {
      if (i.key == dname) {
        dname = i.name;
      }
    }
    for (var i in appState.userModuleElement!.users) {
      if (i.key == pname) {
        pname = i.name;
      }
    }
  }
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
              child: Text(dname),
            ),
          ],
        ),
      ),
      DataCell(Text(pname)),
      DataCell(Text(meet.meetingTime.toString())),
      DataCell(Text(_printDuration(Duration(seconds: meet.duration)))),
    ],
  );
}
