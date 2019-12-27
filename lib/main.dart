import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User Interface",
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent),
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Simple Interset Calculator"),
        ),
        body: UserDisplay(),
      )));
}

class UserDisplay extends StatefulWidget {
  @override
  _UserDisplayState createState() => _UserDisplayState();
}

class _UserDisplayState extends State<UserDisplay> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollar', 'Others'];
  var _currentDropDownItem = 'Rupees';
  TextEditingController principleController = TextEditingController();
  TextEditingController roicontroller = TextEditingController();
  TextEditingController termController = TextEditingController();
  String displayanswer = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Form(
      key: _formkey,
      child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Image.asset('image/login_photo.jpg', width: 350.0),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    validator: (String value)
                    {
                      if(value.isEmpty)
                        return 'Please enter roi amount';
                    },
                    controller: principleController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Principle',
                        hintText: 'Enter Principal e.g. 1200',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: TextFormField(
                    controller: roicontroller,
                    validator: (String value) {
                      if (value.isEmpty)
                        return 'Please enter roi amount';
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Rate of Interest',
                        hintText: 'In percentage',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                            validator: (String value){
                              if(value.isEmpty)
                                return 'Please enter term amount';
                            },
                        controller: termController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in years',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                      Container(
                        width: 20.0,
                      ),
                      Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                          value: _currentDropDownItem,
                          onChanged: (String newValueSelected) {
                            _currentMenuList(newValueSelected);
                          },
                        ),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            "Calculate",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formkey.currentState.validate())
                                displayanswer = displayAnswer();
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(displayanswer),
              )
            ],
          )),
    );
  }

  void _currentMenuList(String newValueSelected) {
    setState(() {
      this._currentDropDownItem = newValueSelected;
    });
  }

  String displayAnswer() {
    double principal = double.parse(principleController.text);
    double roi = double.parse(roicontroller.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result =
        'After $term years, your investment will be worth $totalAmountPayable $_currentDropDownItem';
    return result;
  }

  void _reset() {
    principleController.text = '';
    roicontroller.text = '';
    termController.text = '';
    displayanswer = '';
    _currentDropDownItem = _currencies[0];
  }
}
