import 'package:admin_panel/backend/transactionmodule/tansaction.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/uuid_gen.dart';
import 'package:admin_panel/responsive.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class UserPaymentForm extends StatefulWidget {
  final TransactionInfo temp;
  final onSubmit;
  final onDelete;
  final suggessions;

  const UserPaymentForm(
      { required this.onSubmit,
        required this.temp,
        this.onDelete,
        required this.suggessions}) ;

  @override
  _UserPaymentFormState createState() => _UserPaymentFormState();
}

class _UserPaymentFormState extends State<UserPaymentForm> {
  final _formkey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _txController = TextEditingController();
  final _meetingController = TextEditingController();
  final _typeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.text = widget.temp.fromId;
    _txController.text = widget.temp.txID;
    _typeController.text = widget.temp.type;
    _meetingController.text = widget.temp.meetingId ?? '';
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
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _txController,
                          suggessions: [
                            UidGen.uuid.v4(),
                          ],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.txID = value;
                          },
                          text: widget.temp.txID ,
                          title: 'TxID ',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide valid TxID";
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
                            initialValue: widget.temp.dateTime??(widget.temp.dateTime = DateTime.now()),
                            onChanged: (value) {
                              widget.temp.dateTime = value;
                            },
                            title: 'Time',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: _AutoCompleteInputWidget(
                          typeAheadController: _userController,
                          suggessions: widget.suggessions['user'],
                          onChanged: (value) {
                            if (value != null || value != '')
                              widget.temp.fromId = value;
                          },
                          text: widget.temp.fromId,
                          title: 'Sender ID',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Sender UserID";
                            } else if (!widget.suggessions['user']
                                .contains(value)) {
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
                        child: _InputWidget(
                          onChanged: (value) {
                            double? t = double.tryParse(value.toString());
                            if (t != null) widget.temp.amount = t;
                          },
                          text: widget.temp.amount.toString(),
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
                              'Pay',
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
  final initialValue;

  const BasicDateTimeField({Key? key, this.onChanged, this.title, this.initialValue})
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
          initialValue: initialValue,
          format: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
          onChanged: (datetime) {
            if (onChanged != null) onChanged(datetime);
          },
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? initialValue?? DateTime.now(),
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
