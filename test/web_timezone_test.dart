@TestOn( 'browser')

import 'dart:html';
import 'package:test/test.dart';
import 'package:timezone/browser.dart';


import '../web/timezone.dart' as underTest;

@TestOn( 'browser')
main () async{
  await initializeTimeZone();
  test("Should convert UTC time to Local", (){

    var utc = new DateTime.utc(2016, 03, 03, 09, 10);
    var result = underTest.toLocalTime("Pacific/Auckland", utc);
    expect( result.toIso8601String(), "2016-03-03T22:10:00.000+1300");
  });
  test( "should convert local to UTC", (){
    var result = underTest.toUtc( "Pacific/Auckland", 2016, 3,3 ,9, 10);
    expect( result.toIso8601String(), "2016-03-02T20:10:00.000Z");
  });
  test( "load selector with timezone", (){
    SelectElement selectAddTimezone = querySelector('#addNewTimezone');
    expect( selectAddTimezone,  isNotNull);
    underTest.addTimezonesOptionsToSelectElement( selectAddTimezone);
    expect( selectAddTimezone.children.length, greaterThan( 100));
  });
}
