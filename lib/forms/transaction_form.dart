import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/backend/videomodule/videos.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/responsive.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final TransactionInfo transaction;
  final TransactionInfo temp;
  final onSubmit;
  final onDelete;
  final suggessions;

  const TransactionForm(
      {required this.transaction,
      required this.onSubmit,
      required this.temp,
      this.onDelete,
      required this.suggessions}) ;

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formkey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _doctorController = TextEditingController();
  final _meetingController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.text = widget.transaction.from_id;
    _doctorController.text = widget.transaction.to_id ?? '';
    _typeController.text = widget.transaction.type;
    _meetingController.text = widget.transaction.meeting_id ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
            height: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.height * .9
                : MediaQuery.of(context).size.height * .7,
            width: Responsive.isMobile(context)
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width * .65,
            child: ListView(
              children: <Widget>[
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.95,
                        child: _InputWidget(
                          onChanged: (value) {
                            widget.temp.txID = value;
                          },
                          text: widget.transaction.txID,
                          title: 'Txid',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Video Caption";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: BasicDateTimeField(
                            initialValue_: widget.transaction.dateTime,
                            onChanged: (value) {
                              widget.temp.dateTime = value;
                            },
                            title: 'Date',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _typeController,
                          suggessions: ['Credit', 'Debit'],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.type = value;
                          },
                          text: widget.transaction.type,
                          title: 'Type',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Credit of Debit";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _userController,
                          suggessions: widget.suggessions['user'] +
                              widget.suggessions['doctor'],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.from_id = value;
                          },
                          text: widget.transaction.from_id,
                          title: 'Sender ID',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Sender UserID";
                            } else if (!widget.suggessions['user']
                                    .contains(value) &&
                                !widget.suggessions['doctor'].contains(value)) {
                              return "Please Provide Correct UserID";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _doctorController,
                          suggessions: widget.suggessions['doctor'] +
                              widget.suggessions['user'],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.to_id = value;
                          },
                          text: widget.transaction.to_id,
                          title: 'Receiver ID ',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Sender UserID";
                            } else if (!widget.suggessions['user']
                                    .contains(value) &&
                                !widget.suggessions['doctor'].contains(value)) {
                              return "Please Provide Correct Receiver ID";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _meetingController,
                          suggessions: widget.suggessions['meeting'],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.meeting_id = value;
                          },
                          text: widget.transaction.meeting_id,
                          title: 'Meeting ID',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Correct Meeting ID";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _InputWidget(
                          onChanged: (value) {
                            double? t = double.tryParse(value.toString());
                            if (t != null) widget.temp.amount = t;
                          },
                          text: widget.transaction.amount.toString(),
                          title: 'amount',
                          validator: (value) {
                            double? t = double.tryParse(value.toString());
                            if (t == null) return "Enter a valid amount";
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Update',
                              style: TextStyle(color: Color(0xFF1E7879)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF1E7879),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()&& widget.temp.dateTime!=null) {
                            widget.onSubmit();
                            Navigator.of(context).maybePop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Please Fillup the fields Correctly")));
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (widget.onDelete != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Delete',
                                style: TextStyle(color: Color(0xFF1E7879)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.delete_forever_rounded,
                                color: Color(0xFF1E7879),
                              ),
                            ],
                          ),
                          onPressed: () {
                            if (widget.onDelete != null) widget.onDelete();
                            Navigator.of(context).maybePop();
                          },
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputWidget extends StatefulWidget {
  final onChanged;
  final String title;
  final text;
  final Function(String?)? validator;

  const _InputWidget(
      {Key? key,
      required this.onChanged,
      required this.text,
      required this.title,
      this.validator})
      : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<_InputWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Card(
            elevation: 5.0,
            borderOnForeground: true,
            child: Container(
              margin: EdgeInsets.all(defaultPadding),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                widget.onChanged(value);
              },
              initialValue: widget.text,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 45),
                hintText: widget.title,
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              validator: (value) {
                if (widget.validator == null) return null;
                return widget.validator!(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AutoCompleteInputWidget extends StatefulWidget {
  final onChanged;
  final String title;
  final text;
  final Function(String?)? validator;
  final suggessions;
  final TextEditingController typeAheadController;

  _AutoCompleteInputWidget(
      {Key? key,
      required this.onChanged,
      required this.text,
      required this.title,
      this.validator,
      this.suggessions,
      required this.typeAheadController})
      : super(key: key);

  @override
  _AutoCompleteInputWidgetState createState() =>
      _AutoCompleteInputWidgetState();

  List<String> getSuggestions(pattern) {
    var ret = <String>[];
    if (suggessions != null) {
      for (var i in suggessions) {
        if (i
            .toString()
            .toLowerCase()
            .contains(pattern.toString().toLowerCase())) {
          ret.add(i);
        }
      }
    }
    return ret;
  }
}

class _AutoCompleteInputWidgetState extends State<_AutoCompleteInputWidget> {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Card(
            elevation: 5.0,
            borderOnForeground: true,
            child: Container(
              margin: EdgeInsets.all(defaultPadding),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: widget.typeAheadController,
                onChanged: (value) {
                  widget.onChanged(value);
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 45),
                  hintText: widget.title,
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) {
                return widget.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(suggestion.toString()),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                widget.typeAheadController.text = suggestion.toString();
                widget.onChanged(suggestion.toString());
              },
              validator: (value) {
                return widget.validator!(value);
              },
              // onSaved: (value) => widget.typeAheadController.text = value??'',
            ),
          ),
        ],
      ),
    );
  }
}

class BasicDateTimeField extends StatelessWidget {
  final onChanged;
  final title;
  final initialValue_;

  const BasicDateTimeField({Key? key, this.onChanged, this.title, this.initialValue_})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Card(
        elevation: 5.0,
        borderOnForeground: true,
        child: Container(
          margin: EdgeInsets.all(defaultPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.button,
          ),
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        width: 500,
        child: DateTimeField(
          // format: DateFormat("yyyyMMddaHHmmss"),
          initialValue: initialValue_,
          format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
          onChanged: (datetime) {
            if (onChanged != null) onChanged(datetime);
          },
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? initialValue_?? DateTime.now(),
                lastDate: DateTime(2100));
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              final datetime = DateTimeField.combine(date, time);
              // if(onChanged!=null) onChanged(datetime);
              return datetime;
            } else {
              return currentValue;
            }
          },
        ),
      ),
    ]);
  }
}
