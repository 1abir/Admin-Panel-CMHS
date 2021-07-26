import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/forms/user_form.dart';
import 'package:admin_panel/models/RecentFile.dart';
import 'package:admin_panel/responsive.dart';
import 'package:admin_panel/screens/dashboard/components/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class PatientView extends StatelessWidget {
  const PatientView({
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
                        UserInfoClass temp = UserInfoClass.fromMap({});
                        temp.type = 1;
                        var suggessions = {
                          'user': appState.userModuleElement!.userIDs,
                        };
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return UserForm(
                                user: temp,
                                onSubmit: () {
                                  appState.userModuleElement!.createUser(temp);
                                },
                                temp: temp,
                                suggessions: suggessions,
                              );
                            });
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
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
                "Patient OverView",
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
                        appState.userModuleElement!.users.length,
                        (index) => _datarowPatient(index,appState.userModuleElement!.users,appState,context),
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

DataRow _datarowPatient(int index, List<UserInfoClass> users,FetchFireBaseData appState,BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        InkWell(
          onTap: (){
            UserInfoClass temp = UserInfoClass.fromMap(users[index].toMap());
            temp.key = users[index].key;
            var suggessions = {
              'user': appState.userModuleElement!.userIDs,
            };
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return UserForm(
                    user: temp,
                    onSubmit: () {
                      appState.userModuleElement!.updateElement(temp);
                    },
                    temp: temp,
                    suggessions: suggessions,
                  );
                });
          },
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/media_file.svg",
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(users[index].name),
              ),
            ],
          ),
        ),
      ),
      DataCell(Text(users[index].byear.toString())),
      DataCell(Text(users[index].gender)),
      DataCell(Text(users[index].credit.toString())),
    ],
  );
}
