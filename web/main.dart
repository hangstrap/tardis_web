// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:timezone/timezone.dart';
import 'package:timezone/browser.dart';

CheckboxInputElement showCurrentTime;
TextInputElement value_utc;
DateFormat dateFormat = new DateFormat( "MMM/d HH:mm:ss");
SelectElement selectAddTimezone;

Timer oneSecondTimer;

main() async{
 initializeTimeZone();
  oneSecondTimer = new Timer.periodic( const Duration( seconds: 1), oneSecondPassed);

  showCurrentTime =  querySelector('#showCurrentTime');
  showCurrentTime.onClick.listen(showCurrentTimeEventHandler);

  selectAddTimezone = querySelector( "#selectAddTimezone");

  selectAddTimezone.children.clear();
  await initializeTimeZone();
  selectAddTimezone.children.addAll( loadAllTimezones());

  value_utc = querySelector( "#value_utc");
  return null;
}

oneSecondPassed( Timer t){
  DateTime now = new DateTime.now().toUtc();
  if( showCurrentTime.checked){
    value_utc.value= "${dateFormat.format( now)}";
  }
}
showCurrentTimeEventHandler(_){
  print( "event from checkbox");
}
List<OptionElement> loadAllTimezones(){
  var result = [];


  var keys = timeZoneDatabase.locations.keys.toList();
  keys.sort();
  keys.forEach( (name){
    var optionElement =  new OptionElement( data:name, value:name);
    if( name== local.name){
      optionElement.selected = true;
    }
    result.add( optionElement);
  });
  return result;
}
