import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:provider/provider.dart';
import 'controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Controller _controller = Provider.of<Controller>(context);
    final GlobalKey<AnimatorWidgetState> basicAnimation =
        GlobalKey<AnimatorWidgetState>();
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //this is to help settle the renderflex issue when keyboard opens up
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'DecisionMakerr',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TextField zone
            Container(
              height: 320,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Container(
                      margin: EdgeInsets.all(25),
                      child: TextField(
                        controller: TextEditingController(
                          text: _controller.input,
                        ), //texteditingcontroller is the one that listens to the inputfield
                        decoration: InputDecoration(
                          hintText: 'input option',
                          hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.withOpacity(0.3)),
                          labelText:
                              'Option ${_controller.optionNumber.toString()} ?',
                          labelStyle: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        onChanged: (value) {
                          _controller.input = value;
                        },
                      ),
                    ),
                  ),
                  //options listing
                  Container(
                    height: 60,
                    child: Padding(
                      padding: EdgeInsets.only(left: 12.0, right: 12),
                      child: _controller.options.isEmpty
                          ? Text('please input options')
                          : ListView(
                              children: [
                                Text(
                                  'OPTIONS ARE: ${_controller.options}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(height: 20),
                  //submit button
                  _buildFlatButton('submit', () {
                    _controller.submitButton();
                    print(_controller.options);
                  }, 20),
                ],
              ),
            ),
            //Decision zone
            Container(
              height: 320,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'The Decision is :',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  BounceIn(
                    key: basicAnimation,
                    child: Text(
                      '${_controller.randomReward.toUpperCase()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50, color: Colors.orangeAccent.shade700),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Decide button
                      _buildFlatButton('Decide', () {
                        _controller.decideButton();
                      }, 25),
                      _controller.hasDecided
                          ? SizedBox(width: 20)
                          : Container(),
                      //Reset Button
                      _controller.hasDecided
                          ? _buildFlatButton('Reset', () {
                              _controller.resetButton();
                            }, 25)
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildFlatButton(String text, Function pressed, [double size]) {
  return FlatButton(
    padding: EdgeInsets.all(8),
    child: Text(
      text,
      style: TextStyle(fontSize: size),
    ),
    onPressed: pressed,
    color: Colors.blueAccent,
  );
}
