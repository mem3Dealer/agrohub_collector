import 'package:flutter/material.dart';

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  GlobalKey _scaffoldKey = GlobalKey();
  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }
  GlobalKey get scaffoldKey => _scaffoldKey;
}
