import 'package:admin_panel/backend/backend.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/forms/transaction_form.dart';
import 'package:admin_panel/forms/uuid_gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../responsive.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({
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
                // Expanded(child: SearchField()),
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
                      TransactionInfo temp =
                          TransactionInfo.fromMap(<String, dynamic>{});
                      temp.fromId = appState.adminUser?.key ?? '';
                      temp.dateTime = DateTime.now();

                      var suggessions = {
                        'user': appState.userModuleElement?.userIDs ?? [],
                        'doctor': appState.userModuleElement?.doctorsIDs ?? [],
                        'me': [appState.adminUser?.key],
                        'meeting':
                            appState.meetingModuleElement?.meetingIds ?? [],
                        'txIDs': [UidGen.uuid.v4()],
                      };
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return TransactionForm(
                              transaction: temp,
                              onSubmit: () async {
                                if (temp.toId != null &&
                                    appState.userModuleElement != null) {
                                  appState.transactionModuleElement!
                                      .createMeeting(temp);
                                  for (var i
                                      in appState.userModuleElement!.doctors +
                                          appState.userModuleElement!.users) {
                                    if (i.key == temp.toId) {
                                      if (temp.type == "Credit") {
                                        i.credit -= temp.amount;
                                      } else if (temp.type == "Debit") {
                                        i.credit += temp.amount;
                                      }
                                      appState.userModuleElement!
                                          .updateElement(i);
                                      break;
                                    }
                                  }
                                }
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
              "Recent Transactions",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Flexible(
            flex: 10,
            child: SingleChildScrollView(
              child:
                  Consumer<FetchFireBaseData>(builder: (context, appState, _) {
                if (appState.transactionModuleElement == null ||
                    appState.userModuleElement == null) return Container();
                Map<String, String> idName = appState.userModuleElement != null
                    ? appState.userModuleElement!.idNameMap
                    : {};
                List<TransactionInfo> txList =
                    appState.transactionModuleElement!.transactions;
                return SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    horizontalMargin: 0,
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text("TxID"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Amount"),
                      ),
                      DataColumn(
                        label: Text("From"),
                      ),
                      DataColumn(
                        label: Text("To"),
                      ),
                      DataColumn(
                        label: Text("Type"),
                      ),
                    ],
                    rows: List.generate(
                      txList.length,
                      (index) =>
                          _txDataRow(txList[index], idName, context, appState),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow _txDataRow(TransactionInfo txInfo, Map<String, String> nmap,
    BuildContext context, FetchFireBaseData appState) {
  return DataRow(
    cells: [
      DataCell(
        InkWell(
          onTap: () {
            TransactionInfo temp = TransactionInfo.fromMap(txInfo.toMap());
            var prevAmount = txInfo.amount;
            var prevType = txInfo.type;
            // temp.dateTime = DateTime.now();
            temp.key = txInfo.key;
            var suggessions = {
              'user': appState.userModuleElement?.userIDs ?? [],
              'doctor': appState.userModuleElement?.doctorsIDs ?? [],
              'me': [appState.adminUser?.key],
              'meeting': appState.meetingModuleElement?.meetingIds ?? [],
              'txIDs': [txInfo.txID],
            };
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return TransactionForm(
                    transaction: txInfo,
                    onSubmit: () {
                      appState.transactionModuleElement!.updateMeeting(temp);
                      if (temp.toId != null &&
                          appState.userModuleElement != null) {
                        for (var i in appState.userModuleElement!.doctors +
                            appState.userModuleElement!.users) {
                          if (i.key == temp.toId) {
                            if (temp.type == "Credit") {
                              if (prevType == "Credit") {
                                var change = temp.amount - prevAmount;
                                i.credit -= change;
                              } else if (prevType == "Debit") {
                                var change = prevAmount + temp.amount;
                                i.credit += change;
                              }
                            } else if (temp.type == "Debit") {
                              if (prevType == "Credit") {
                                var change = temp.amount + prevAmount;
                                i.credit -= change;
                              } else if (prevType == "Debit") {
                                var change = prevAmount - temp.amount;
                                i.credit -= change;
                              }
                            }
                            appState.userModuleElement!.updateElement(i);
                            break;
                          }
                        }
                      }
                    },
                    temp: temp,
                    onDelete: () {
                      appState.transactionModuleElement!.deleteMeeting(txInfo);
                    },
                    suggessions: suggessions,
                  );
                });
          },
          child: Row(
            children: [
              Container(
                child: Icon(Icons.monetization_on_outlined),
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(txInfo.txID),
              ),
            ],
          ),
        ),
      ),
      txInfo.dateTime != null
          ? DataCell(Text(
              DateFormat("MMMM d, yyyy 'at' h:mma").format(txInfo.dateTime!)))
          : DataCell(Text('')),
      DataCell(Text(txInfo.amount.toString())),
      DataCell(Text(nmap[txInfo.fromId] ?? txInfo.fromId)),
      DataCell(Text(nmap[txInfo.toId ?? ''] ?? txInfo.toId ?? '')),
      DataCell(Text(nmap[txInfo.type] ?? txInfo.type))
    ],
  );
}
