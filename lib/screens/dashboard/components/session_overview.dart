import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/backend/meetingmodule/meeting_info.dart';
import 'package:admin_panel/forms/meeting_form.dart';
import 'package:admin_panel/forms/uuid_gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Sessions",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Consumer<FetchFireBaseData>(builder: (context, appState, _) {
                    return ElevatedButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 1.5,
                          vertical: defaultPadding /
                              (Responsive.isMobile(context) ? 2 : 1),
                        ),
                      ),
                      onPressed: () {
                        MeetingInfo temp = MeetingInfo.fromMap({});
                        temp.meetingTime = DateTime.now();
                        temp.key = UidGen.uuid.v4();
                        temp.type = 1;
                        var suggessions = {
                          'user': appState.userModuleElement!.userIDs,
                          'doctor': appState.userModuleElement!.doctorsIDs,
                          'meeting': appState.meetingModuleElement!.meetingIds,
                          'problem': detectionElementNames,
                        };
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return MeetingForm(
                                meeting: temp,
                                onSubmit: () {
                                  appState.meetingModuleElement!.createMeeting(temp);
                                },
                                temp: temp,
                                suggessions: suggessions,
                              );
                            });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                    );
                  }),
                ]),
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
                        label: Text("Doctor's id"),
                      ),
                      DataColumn(
                        label: Text("Patient's Name"),
                      ),
                      DataColumn(
                        label: Text("Meeting Time"),
                      ),
                      DataColumn(
                        label: Text("Duration "),
                      ),
                    ],
                    rows: appState.meetingModuleElement == null
                        ? []
                        : List.generate(
                            appState.meetingModuleElement!.sessions.length,
                            (index) =>
                                _meetingDataRow(appState, index, context),
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

DataRow _meetingDataRow(
    FetchFireBaseData appState, int index, BuildContext context) {
  var meet = appState.meetingModuleElement!.sessions[index];
  var dname = meet.doctor_id;
  var pname = meet.patient_id;
  if (appState.userModuleElement != null) {
    dname = appState.userModuleElement!.idNameMap[dname] ?? dname;
    pname = appState.userModuleElement!.idNameMap[pname] ?? pname;
  }
  return DataRow(
    cells: [
      DataCell(
        InkWell(
          onTap: () {
            MeetingInfo temp = MeetingInfo.fromMap(meet.toMap());
            temp.key = meet.key;
            var suggessions = {
              'user': appState.userModuleElement!.userIDs,
              'doctor': appState.userModuleElement!.doctorsIDs,
              'meeting': appState.meetingModuleElement!.meetingIds,
              'problem': detectionElementNames
            };
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return MeetingForm(
                    meeting: meet,
                    onSubmit: () {
                      appState.meetingModuleElement!.updateMeeting(temp);
                    },
                    temp: temp,
                    onDelete: () {
                      appState.meetingModuleElement!.deleteMeeting(meet);
                    },
                    suggessions: suggessions,
                  );
                });
          },
          child: Row(
            children: [
              Container(
                child: Icon(Icons.supervised_user_circle_outlined),
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
      ),
      DataCell(Text(pname)),
      meet.meetingTime != null
          ? DataCell(
              Text(DateFormat("EEEE, MMMM d, yyyy 'at' h:mma").format(meet.meetingTime!)))
          : DataCell(Text('')),
      DataCell(Text(_printDuration(Duration(seconds: meet.duration)))),
    ],
  );
}
