// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:timezone/browser.dart';

import 'timerow.dart' as timerow;
import 'timezone.dart' as timezone;

CheckboxInputElement showCurrentTime;
DateFormat dateFormat;
SelectElement selectAddTimezone;
ButtonInputElement addNewTimezone;
TableElement table;

Timer oneSecondTimer;
Stream<DateTime> timeStream;
StreamController<DateTime> timeStreamContoller;

main() async {

  await initializeTimeZone();

  timeStreamContoller = new StreamController<DateTime>.broadcast();

  addNewTimezone = querySelector('#addNewTimezone');
  showCurrentTime = querySelector('#showCurrentTime');
  selectAddTimezone = querySelector("#selectAddTimezone");
  table = querySelector("#times");

  dateFormat = new DateFormat("MMM/d HH:mm:ss");
  selectAddTimezone = querySelector("#selectAddTimezone");

  //Every second we may need to display the time
  oneSecondTimer = new Timer.periodic(const Duration(seconds: 1), (Timer t) {
    DateTime now = new DateTime.now().toUtc();
    if (showCurrentTime.checked) {
      timeStreamContoller.add(now);
    }
  });

  addNewTimezone.onClick
      .listen((_) => addNewRow(selectAddTimezone.selectedOptions[0].value));

  addTimezonesOptionsToSelectElement(selectAddTimezone);

  //Load users last items from local storage
  window.localStorage.forEach((timeZone, _) => addNewRow(timeZone));
}

addTimezonesOptionsToSelectElement(SelectElement selectElement) async {
  selectElement.children.clear();
  selectElement.children.addAll(timezone.loadElements());
}

userEnteredTime(DateTime time) {
  timeStreamContoller.add(time);
}

addNewRow(String timeZone) {
  timerow.TimeRow row = new timerow.TimeRow(timeZone,
      timeStreamContoller.stream, (time) => timeStreamContoller.add(time));

  row.addToTable(table);
}
