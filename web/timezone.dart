import "dart:html";

import 'package:timezone/timezone.dart';
import 'package:timezone/browser.dart';

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

DateTime toLocalTime(String timezone, DateTime utcTime) {
  if( timezone == "UTC"){
    return utcTime;
  }else{
    return new TZDateTime.from(utcTime, getLocation(timezone));
  }
}

DateTime toUtc(String timezone, int year, int month, int day, int hour, int minute) {
 if( timezone == "UTC"){
   return new  TZDateTime.utc( year, month, day, hour, minute);
 }else{
    return new TZDateTime( getLocation(timezone), year, month, day, hour, minute).toUtc();
 }
}
