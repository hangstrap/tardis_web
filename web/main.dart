// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';

import 'timerow.dart';
import 'timezone.dart';

CheckboxInputElement showCurrentTime;
TextInputElement value_utc;
DateFormat dateFormat;
SelectElement selectAddTimezone;
ButtonElement addNewTimezone;
TableElement table;

Timer oneSecondTimer;


main() async {
  addNewTimezone = querySelector('#addNewTimezone');
  showCurrentTime = querySelector('#showCurrentTime');
  selectAddTimezone = querySelector("#selectAddTimezone");
  value_utc = querySelector("#value_utc");
  table = querySelector("#times");

  dateFormat = new DateFormat("MMM/d HH:mm:ss");
  selectAddTimezone = querySelector("#selectAddTimezone");

  oneSecondTimer =
      new Timer.periodic(const Duration(seconds: 1), oneSecondPassed);

  showCurrentTime.onClick.listen(showCurrentTimeEventHandler);
  addNewTimezone.onClick.listen(addNewTimezoneEventHandler);
  await addTimezonesOptionsToSelectElement(selectAddTimezone);
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

addNewTimezoneEventHandler(_) {
  var timeZone = selectAddTimezone.selectedOptions[0].value;
  new TimeRow(timeZone).addToTable(table);
}
