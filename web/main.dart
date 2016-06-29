// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';

import 'timerow.dart';
import 'timezone.dart';

CheckboxInputElement showCurrentTime;
DateFormat dateFormat;
SelectElement selectAddTimezone;
ButtonInputElement addNewTimezone;
TableElement table;

Timer oneSecondTimer;
Stream<DateTime> timeStream;
StreamController<DateTime> timeStreamContoller;

main() async {
  addNewTimezone = querySelector('#addNewTimezone');
  showCurrentTime = querySelector('#showCurrentTime');
  selectAddTimezone = querySelector("#selectAddTimezone");
  table = querySelector("#times");

  dateFormat = new DateFormat("MMM/d HH:mm:ss");
  selectAddTimezone = querySelector("#selectAddTimezone");

  oneSecondTimer =
      new Timer.periodic(const Duration(seconds: 1), oneSecondPassed);

  showCurrentTime.onClick.listen(showCurrentTimeEventHandler);
  addNewTimezone.onClick.listen(addNewTimezoneEventHandler);
  await addTimezonesOptionsToSelectElement(selectAddTimezone);

  timeStreamContoller = new StreamController<DateTime>.broadcast();
}

oneSecondPassed(Timer t) {
  DateTime now = new DateTime.now().toUtc();

  if (showCurrentTime.checked) {
    timeStreamContoller.add( now);
  }
}

showCurrentTimeEventHandler(_) {
  print("event from checkbox");
}

addNewTimezoneEventHandler(_) {
  var timeZone = selectAddTimezone.selectedOptions[0].value;
  new TimeRow(timeZone,  timeStreamContoller.stream).addToTable(table);
}
