import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/forms/user_form.dart';
import 'package:admin_panel/forms/user_payment_form.dart';
import 'package:admin_panel/responsive.dart';
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
                "Patient OverView",
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Flexible(
              flex: 10,
              child: SingleChildScrollView(
                child: Consumer<FetchFireBaseData>(
                    builder: (context, appState, _) {
                  List<UserInfoClass> sortedUsers = [];
                  if (appState.userModuleElement != null) {
                    sortedUsers = List.from(appState.userModuleElement!.users);
                    sortedUsers.sort((a, b) {
                      return a.credit.compareTo(b.credit);
                    });
                  }
                  return SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      horizontalMargin: 0,
                      columnSpacing: defaultPadding,
                      columns: [
                        DataColumn(
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Id"),
                        ),
                        DataColumn(
                          label: Text("Birth Year"),
                        ),
                        DataColumn(label: Text("Gender")),
                        DataColumn(label: Text("Credit")),
                        DataColumn(label: Text("Pay Due")),
                      ],
                      rows: appState.userModuleElement == null
                          ? []
                          : List.generate(
                              sortedUsers.length,
                              (index) => _datarowPatient(
                                  index, sortedUsers, appState, context),
                            ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow _datarowPatient(int index, List<UserInfoClass> users,
    FetchFireBaseData appState, BuildContext context) {
  UserInfoClass user = users[index];
  TransactionInfo tempTx = TransactionInfo.fromMap({});
  tempTx.toId = user.key;
  tempTx.fromId = appState.adminUser?.key ?? '';
  tempTx.amount = user.credit * -1;
  tempTx.type = "Debit";
  return DataRow(
    cells: [
      DataCell(
        InkWell(
          onTap: () {
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
      DataCell(Text(users[index].key.toString())),
      DataCell(Text(users[index].byear.toString())),
      DataCell(Text(users[index].gender)),
      DataCell(Text(users[index].credit.toString())),
      if (users[index].credit < 0)
        DataCell(OutlinedButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return UserPaymentForm(
                      onSubmit: () async {
                        user.credit += tempTx.amount;
                        appState.userModuleElement!.updateElement(user);
                        appState.transactionModuleElement!
                            .createMeeting(tempTx);
                      },
                      temp: tempTx,
                      suggessions: {
                        'user': [appState.adminUser?.key]
                      });
                });
          },
          child: Text('Pay'),
        )),
      if (!(users[index].credit < 0)) DataCell(Text('')),
    ],
  );
}
