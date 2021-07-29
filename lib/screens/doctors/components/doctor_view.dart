import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/detectionmodule/detection_module.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/forms/user_form.dart';
import 'package:admin_panel/forms/user_payment_form.dart';
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
                        UserInfoClass temp = UserInfoClass.fromMap({});
                        temp.type = 1;
                        temp.isDoctor = 1;

                        var suggessions = {
                          'user': appState.userModuleElement!.userIDs,
                          'specialization' : detectionElementNames,
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
                        DataColumn(label: Text("Affiliation")),
                        DataColumn(label: Text("Specialization")),
                        DataColumn(label: Text("Pay Due")),
                      ],
                      rows: appState.userModuleElement==null?[]:List.generate(
                        appState.userModuleElement!.doctors.length,
                            (index) => _datarowDoctor(index,appState.userModuleElement!.doctors,appState,context),
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


DataRow _datarowDoctor(int index, List<UserInfoClass> doctors,FetchFireBaseData appState, BuildContext context) {
  UserInfoClass user = doctors[index];
  TransactionInfo tempTx = TransactionInfo.fromMap({});
  tempTx.toId = user.key;
  tempTx.fromId = appState.adminUser?.key??'';
  tempTx.amount = user.credit * -1;
  tempTx.type = "Debit";
  return DataRow(
    cells: [
      DataCell(
        InkWell(
          onTap: (){
            UserInfoClass temp = UserInfoClass.fromMap(doctors[index].toMap());
            temp.key = doctors[index].key;
            temp.isDoctor = 1;
            var suggessions = {
              'user': appState.userModuleElement!.doctorsIDs,
              'specialization':detectionElementNames,
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
                child: Text(doctors[index].name),
              ),
            ],
          ),
        ),
      ),
      DataCell(Text(doctors[index].byear.toString())),
      DataCell(Text(doctors[index].gender)),
      DataCell(Text(doctors[index].credit.toString())),
      DataCell(Text(doctors[index].affiliation)),
      DataCell(Text(doctors[index].specialization??'')),
      if (doctors[index].credit < 0)
        DataCell(OutlinedButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return UserPaymentForm(
                      onSubmit: () async{
                        user.credit += tempTx.amount;
                        appState.userModuleElement!.updateElement(user);
                        appState.transactionModuleElement!.createMeeting(tempTx);
                      }, temp: tempTx, suggessions: {
                    'user':[appState.adminUser?.key]
                  });
                });
          },
          child: Text('Pay'),
        )),
      if (!(doctors[index].credit < 0)) DataCell(Text('')),
    ],
  );
}

