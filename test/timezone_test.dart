@TestOn('vm')
import 'package:test/test.dart';
import 'package:timezone/standalone.dart';
import 'package:timezone/timezone.dart';

main() async {
  await initializeTimeZone();
//  timeZoneDatabase.locations.forEach( (name, location) => print( "${name}"));

  test( "match no daylight savings", (){
    Location auckland = timeZoneDatabase.get( "Pacific/Auckland");
    DateTime utc = new DateTime.utc( 2016, 05,04, 09,10);
    TZDateTime aucklandTime = new TZDateTime.from( utc, auckland);
    expect( aucklandTime.toIso8601String(), equals( "2016-05-04T21:10:00.000+1200"));
  });
  test( "match  daylight savings", (){
    Location auckland = timeZoneDatabase.get( "Pacific/Auckland");
    DateTime utc = new DateTime.utc( 2016, 03, 03, 09,10);
    TZDateTime aucklandTime = new TZDateTime.from( utc, auckland);
    expect( aucklandTime.toIso8601String(), equals( "2016-03-03T22:10:00.000+1300"));
  });
}
