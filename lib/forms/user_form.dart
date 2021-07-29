import 'package:admin_panel/backend/usermodule/user_info.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/forms/uuid_gen.dart';
import 'package:admin_panel/responsive.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class UserForm extends StatefulWidget {
  final UserInfoClass user;
  final UserInfoClass temp;
  final onSubmit;
  final onDelete;
  final suggessions;

  const UserForm(
      {required this.user,
      required this.onSubmit,
      required this.temp,
      this.onDelete,
      required this.suggessions});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _genderController = TextEditingController();
  final _typeController = TextEditingController();
  final _birthController = TextEditingController();

  final _specializationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _typeController.text = widget.user.type.toString();
    _userController.text = widget.user.key ?? '';
    _genderController.text = widget.user.gender;
    _birthController.text = widget.user.byear.toString();
    _specializationController.text = widget.user.specialization ?? '';
  }

  @override
  Widget build(BuildContext context) {
    int year = DateTime.now().year;
    var years = [for (var i = 1920; i <= year; i += 1) i.toString()];
    // debugPrint(years.toString());
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      if (widget.onDelete != null)
                        Opacity(
                          opacity: 0.95,
                          child: _AutoCompleteInputWidget(
                            typeAheadController: _userController,
                            suggessions: [
                              UidGen.uuid.v4(),
                            ],
                            onChanged: (value) {
                              if (value != null || value != '')
                                widget.temp.key = value;
                            },
                            text: widget.user.key ?? '',
                            title: 'ID ',
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Please Provide valid ID";
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
                            if (value != null) widget.temp.name = value;
                          },
                          text: widget.temp.name,
                          title: 'Name',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Name";
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
                          typeAheadController: _genderController,
                          suggessions: ['Male', 'Female', "Other"],
                          onChanged: (value) {
                            if (value != null) widget.temp.gender = value;
                          },
                          text: widget.user.gender,
                          title: 'Gender',
                          validator: (value) {
                            if (!['Male', 'Female', "Other"].contains(value)) {
                              return "Please Enter a correct gender";
                            }
                            // int? v = int.tryParse(value.toString());
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
                          typeAheadController: _birthController,
                          suggessions: years,
                          onChanged: (value) {
                            int? v = int.tryParse(value.toString());
                            if (v != null) widget.temp.byear = v;
                          },
                          text: widget.user.byear.toString(),
                          title: 'Birth Year',
                          validator: (value) {
                            if (!years.contains(value)) {
                              return "Please Enter a correct year";
                            }
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
                      if (widget.temp.isDoctor == 1)
                        Opacity(
                          opacity: 0.95,
                          child: _InputWidget(
                            onChanged: (value) {
                              if (value != null)
                                widget.temp.affiliation = value;
                            },
                            text: widget.temp.affiliation,
                            title: 'Affiliation',
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Please Provide Affiliation";
                              }
                              return null;
                            },
                          ),
                        ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      if (widget.temp.isDoctor == 1)
                        Opacity(
                          opacity: 0.95,
                          child: _AutoCompleteInputWidget(
                            typeAheadController: _specializationController,
                            suggessions: widget.suggessions['specialization'],
                            onChanged: (value) {
                              if (value != null)
                                widget.temp.specialization = value;
                            },
                            text: widget.temp.specialization ?? '',
                            title: 'Specialization',
                            validator: (value) {
                              if (value == null || value == '') {
                                return "Please Provide Specialization";
                              }
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
                          if (_formkey.currentState!.validate()) {
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
        // debugPrint(i);
        if (i
            .toString()
            .toLowerCase()
            .contains(pattern.toString().toLowerCase())) {
          ret.add(i.toString());
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

  const BasicDateTimeField(
      {Key? key, this.onChanged, this.title, this.initialValue})
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
                initialDate: currentValue ?? initialValue ?? DateTime.now(),
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
