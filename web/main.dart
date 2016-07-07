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
  window.localStorage.forEach( (timeZone, _) {
    addNewRow( timeZone);
  });
}

oneSecondPassed(Timer t) {
  DateTime now = new DateTime.now().toUtc();

  if (showCurrentTime.checked) {
    timeStreamContoller.add(now);
  }
}

showCurrentTimeEventHandler(_) {
  print("event from checkbox");
}

userEnteredTime(DateTime time) {
  timeStreamContoller.add(time);
}

addNewTimezoneEventHandler(_) {
  addNewRow(selectAddTimezone.selectedOptions[0].value);
}

addNewRow(String timeZone) {
  new TimeRow(timeZone, timeStreamContoller.stream, userEnteredTime)
      .addToTable(table);
}
