import 'package:admin_panel/constants.dart';
import 'package:admin_panel/data/firebase/detection.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';

class QuestionForm extends StatefulWidget {
  final int? catIndex;
  final int? questionIndex;
  final FirebaseQuestionDetection firebaseQuestionDetection;
  final FirebaseQuestionDetection temp;
  final onSubmit;
  final onDelete;

  QuestionForm(
      {this.catIndex,
      this.questionIndex,
      required this.firebaseQuestionDetection,
      required this.onSubmit,
        required this.temp,
      this.onDelete});
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Container(
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
                        child: InputWidget(
                          onChanged: (value) {
                              widget.temp.text = value;
                          },
                          text: widget.firebaseQuestionDetection.text,
                          title: 'Question',
                          validator: (value){
                            if(value == null || value == ''){
                              return "Please Provide Question Text";
                            }
                            debugPrint('Inside deeebut : '+ widget.temp.text);

                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      // Align(Text('Image')),
                      Opacity(
                        opacity: 0.95,
                        child: InputWidget(
                          onChanged: (value) {
                            widget.temp.img_key = value;
                          },
                          text: widget.firebaseQuestionDetection.img_key,
                          title: 'Image Link',
                          validator: (value) {
                            if (value == null || value == '') return null;
                            var urlPattern =
                                r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                            bool hasM = RegExp(urlPattern, caseSensitive: false)
                                .hasMatch(value);
                            if (hasM) return null;
                            return "Provide a valid image URL";
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Opacity(
                        opacity: 0.95,
                        child: InputWidget(
                          onChanged: (value) {
                            if (value != null) {
                              int? iv = int.tryParse(value);
                              if (iv != null)
                                widget.temp.level = iv;
                            }
                          },
                          text: widget.firebaseQuestionDetection.level.toString(),
                          title: 'Level',
                          validator: (value) {
                            if (value == null) return null;
                            if (int.tryParse(value) == null) {
                              return "Provide a correct integer value";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      ExpansionTile(
                          // initiallyExpanded: true,
                          title: Text('Options'),
                          children: [
                            OptionList(
                                options: widget
                                    .firebaseQuestionDetection.optionList),
                          ]),
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
                        onPressed: () async{
                          if (_formkey.currentState!.validate()) {
                            // widget.firebaseQuestionDetection.copyFrom(temp2);
                            widget.firebaseQuestionDetection.copyFrom(widget.temp);
                            debugPrint('hi: '+ widget.firebaseQuestionDetection.text);
                            debugPrint("temp after: "+widget.temp.hashCode.toString());
                            debugPrint("main hash after: " + widget.firebaseQuestionDetection.hashCode.toString());
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

class OptionList extends StatelessWidget {
  final List<QuestionOption> options;

  const OptionList({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> opsWidgets = [];
    for (int i = 0; i < options.length; i++) {
      opsWidgets.add(Align(
        alignment: Alignment.centerLeft,
        child: Card(
          elevation: 5.0,
          color: Colors.orangeAccent,
          borderOnForeground: true,
          child: Container(
            margin: EdgeInsets.all(defaultPadding / 2),
            child: Text(
              "${i + 1}",
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ),
      ));
      opsWidgets.add(Padding(
        padding: EdgeInsets.only(left: defaultPadding),
        child: InputWidget(
            onChanged: (value) {
              options[i].text = value;
            },
            text: options[i].text,
            title: 'Text'),
      ));
      opsWidgets.add(SizedBox(
        height: 5.0,
      ));
      opsWidgets.add(Padding(
        padding: EdgeInsets.only(left: defaultPadding),
        child: InputWidget(
          onChanged: (value) {
            options[i].value = int.tryParse(value) ?? 0;
          },
          text: options[i].value.toString(),
          title: 'Value',
          validator: (value) {
            if (value == null) return null;
            if (int.tryParse(value) == null) {
              return "Provide a correct integer value";
            }
            return null;
          },
        ),
      ));
      opsWidgets.add(SizedBox(
        height: 5.0,
      ));
    }
    return Column(
      children: [...opsWidgets],
    );
  }
}

class InputWidget extends StatefulWidget {
  final onChanged;
  final String title;
  final text;
  final Function(String?)? validator;

  const InputWidget(
      {Key? key,
      required this.onChanged,
      required this.text,
      required this.title,
      this.validator})
      : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
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
