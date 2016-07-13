@TestOn( 'browser')

import 'dart:html';
import 'package:test/test.dart';

main( ){
  test( "find select", (){
        SelectElement selectAddTimezone = querySelector('#addNewTimezone');
        expect( selectAddTimezone, isNotNull);
  });
}
