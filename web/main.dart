// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:async';

CheckboxInputElement showCurrentTime;

Timer oneSecondTimer;

void main() {
  oneSecondTimer = new Timer.periodic( const Duration( seconds: 1), oneSecondPassed);
  showCurrentTime =  querySelector('#showCurrentTime');

}

oneSecondPassed( Timer t){
  if( showCurrentTime.checked){

  }
}
showCurrentTimeEventHandler(_){
  if( showCurrentTime.checked){
      //update every element
  }
}
