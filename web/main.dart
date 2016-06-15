// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:timezone/timezone.dart';
import 'package:timezone/browser.dart';
//import "package:intl/intl_browser.dart";

CheckboxInputElement showCurrentTime;
TextInputElement value_utc;
DateFormat dateFormat;
SelectElement selectAddTimezone;
ButtonElement addNewTimezone;
TableElement table;

Timer oneSecondTimer;

main() async {
  //await findSystemLocale();
  //print( "default local ${Intl.defaultLocale}");

  dateFormat = new DateFormat("MMM/d HH:mm:ss");

  await initializeTimeZone();
  print(local.name);

  oneSecondTimer =
      new Timer.periodic(const Duration(seconds: 1), oneSecondPassed);

  showCurrentTime = querySelector('#showCurrentTime');
  showCurrentTime.onClick.listen(showCurrentTimeEventHandler);

  addNewTimezone = querySelector( '#addNewTimezone');
  addNewTimezone.onClick.listen( addNewTimezoneEventHandler);

  selectAddTimezone = querySelector("#selectAddTimezone");
  selectAddTimezone.children.clear();
  //await initializeTimeZone();
  selectAddTimezone.children.addAll(loadAllTimezones());

  table = querySelector( "#times");


  value_utc = querySelector("#value_utc");
}

oneSecondPassed(Timer t) {
  DateTime now = new DateTime.now().toUtc();
  if (showCurrentTime.checked) {
    value_utc.value = "${dateFormat.format( now)}";
  }
}

showCurrentTimeEventHandler(_) {
  print("event from checkbox");
}
addNewTimezoneEventHandler(_){
  var value = selectAddTimezone.selectedOptions[0].value;
  print( "Add button clicked ${selectAddTimezone.selectedIndex} ${value}");

  var tableRow = table.addRow();
  tableRow.id = "row_${value}";
  tableRow.addCell().text = "${value}";
  var time = new TextInputElement();
  tableRow.addCell().children.add(time);
  var delete = new ButtonElement();
  delete.text= "delete";
  tableRow.addCell().children.add( delete);
}

List<OptionElement> loadAllTimezones() {
  var result = [];

  var keys = timeZoneDatabase.locations.keys.toList();
  keys.sort();
  keys.forEach((name) {
    var optionElement = new OptionElement(data: name, value: name);
    if (name == local.name) {
      optionElement.selected = true;
    }
    result.add(optionElement);
  });

  return result;
}
