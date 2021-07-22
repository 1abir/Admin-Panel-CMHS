import 'package:admin_panel/backend/articlemodule/article.dart';
import 'package:admin_panel/constants.dart';
import 'package:admin_panel/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class ArticleForm extends StatefulWidget {
  final int? catIndex;
  final int? questionIndex;
  final Article article;
  final Article temp;
  final onSubmit;
  final onDelete;
  final suggessions;

  ArticleForm(
      {this.catIndex,
      this.questionIndex,
      required this.article,
      required this.onSubmit,
      required this.temp,
      this.onDelete,
      this.suggessions}) {
    debugPrint("Constructor Called");
  }

  @override
  _ArticleFormState createState() => _ArticleFormState();
}

class _ArticleFormState extends State<ArticleForm> {
  final _formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();


  @override
  void initState() {
    super.initState();
    _controller.text = widget.article.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: InputWidget(
                          onChanged: (value) {
                            widget.temp.head = value;
                            // temp2.text = value.toString();
                            debugPrint(widget.temp.head);
                            debugPrint(widget.temp.hashCode.toString());
                            debugPrint("main hash: " +
                                widget.article.hashCode.toString());
                          },
                          text: widget.article.head,
                          title: 'Head',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Article Head Text";
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
                        child: AutoCompleteInputWidget(
                          typeAheadController: _controller,
                          suggessions: widget.suggessions,
                          onChanged: (value) {
                            widget.temp.category = value;
                          },
                          text: widget.article.category,
                          title: 'Category',
                          validator: (value) {
                            if (value == null || value == '') {
                              return "Please Provide Category";
                            }
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
                            widget.temp.url = value;
                          },
                          text: widget.article.url,
                          title: 'URL',
                          validator: (value) {
                            if (value == null || value == '') return null;
                            var urlPattern =
                                r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
                            bool hasM = RegExp(urlPattern, caseSensitive: false)
                                .hasMatch(value);
                            if (hasM) return null;
                            return "Provide a valid URL";
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      // HtmlEditorSection(
                      //   controller: controller,
                      //   initialText: widget.article.bodyHtml,
                      // ),
                      ExpansionTile(
                          // initiallyExpanded: true,
                          title: Text('Body HTML'),
                          children: [
                            HtmlEditorSection(
                              controller: controller,
                              initialText: widget.article.bodyHtml,
                            ),
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
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            widget.temp.bodyHtml =
                                await controller.getText();
                            debugPrint("body html:" + widget.temp.bodyHtml);
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

class AutoCompleteInputWidget extends StatefulWidget {
  final onChanged;
  final String title;
  final text;
  final Function(String?)? validator;
  final suggessions;
  final TextEditingController typeAheadController;

  AutoCompleteInputWidget(
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

class _AutoCompleteInputWidgetState extends State<AutoCompleteInputWidget> {
  Widget build(BuildContext context) {
    debugPrint("inside uild callack called: ");
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
                debugPrint("suggession callack called: " +
                    widget.getSuggestions(pattern).toString());
                return widget.getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  leading: Icon(Icons.category),
                  title: Text(suggestion.toString()),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                debugPrint("on transation callack called: ");
                return suggestionsBox;
              },
              onSuggestionSelected: (suggestion) {
                debugPrint("on suggession callack called: " +
                    suggestion.runtimeType.toString() +
                    suggestion.toString() +
                    widget.typeAheadController.text);
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

class HtmlEditorSection extends StatefulWidget {
  final HtmlEditorController controller;
  final String initialText;

  const HtmlEditorSection(
      {Key? key, required this.controller, required this.initialText})
      : super(key: key);

  @override
  _HtmlEditorSectionState createState() => _HtmlEditorSectionState();
}

class _HtmlEditorSectionState extends State<HtmlEditorSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: FloatingActionButton(onPressed: () {
            widget.controller.toggleCodeView();
          }),
        ),
        SizedBox(
          height: 10,
        ),
        HtmlEditor(
          controller: widget.controller,
          htmlEditorOptions: HtmlEditorOptions(
            hint: "Write your Article",
            initialText: widget.initialText,
            // adjustHeightForKeyboard: false,
            // autoAdjustHeight: false,
            darkMode: true,
            shouldEnsureVisible: true,
          ),
          otherOptions: OtherOptions(
            height: 400,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) =>()async{
    //   widget.controller.insertHtml(widget.initialText);
    // });
  }
}
