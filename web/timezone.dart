import "dart:html";

import 'package:timezone/timezone.dart';
import 'package:timezone/browser.dart';

addTimezonesOptionsToSelectElement(SelectElement selectElement) async {
  await initializeTimeZone();

  List<OptionElement> loadElements() {
    var result = [ new OptionElement(data:"UTC", value:"UTC")];
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
  selectElement.children.clear();
  selectElement.children.addAll(loadElements());
}

DateTime toLocalTime(String timezone, DateTime utcTime) {
  if( timezone == "UTC"){
    return utcTime;
  }else{
    return new TZDateTime.from(utcTime, getLocation(timezone));
  }
}

DateTime toUtc(String timezone, DateTime utcTime) {
//  if( timezone == "UTC"){
//    return new  TZDateTime.
//  }else{
    print(  utcTime.toIso8601String());
    return TZDateTime.parse( getLocation(timezone), utcTime.toIso8601String());
//  }
}
