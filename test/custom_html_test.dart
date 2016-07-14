@TestOn( 'browser')

import 'dart:html';
import 'package:test/test.dart';

main( ){
  setUp((){
    SelectElement options = new SelectElement();
    options.id = 'addNewTimezone';
    querySelector('body').children.add( options);
  });
  test( "find select", (){


        SelectElement selectAddTimezone = querySelector('#addNewTimezone');
        expect( selectAddTimezone, isNotNull);
  });
}
