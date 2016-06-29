import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';
import 'timezone.dart';

var dateFormatter = new DateFormat("yyyy/MMM/d HH:mm:ss");
class TimeRow {
  TableRowElement tableRow;
  TextInputElement textInput;
   StreamSubscription<DateTime> timeStream;
   final String timezone;

  TimeRow( this.timezone,  Stream<DateTime> timeStream) {
    tableRow = new TableRowElement();


    tableRow.id = "row_${timezone}";
    tableRow.addCell().text = "${timezone}";

    textInput = new TextInputElement();
    tableRow.addCell().children.add(textInput);
    textInput.onInput.listen( userInput);
    var delete = new ButtonInputElement();
    delete.value = "Delete";
    tableRow.addCell().children.add(delete);

    var subscription  = timeStream.listen( (utcTime){
        var localTime = toLocalTime( timezone, utcTime);
        textInput.value = "${dateFormatter.format( localTime)}";
    });


    delete.onClick.listen( (_){
      tableRow.remove();
      subscription.cancel();
    });

  }
  addToTable( TableElement table){
    table.children.add( tableRow);

  }
  userInput(_){
    var value = textInput.value;
    try{
      DateTime time = dateFormatter.parseLoose( value);
      DateTime utcTime = toUtc( timezone, time);
      print( "Parsed ${time}  ${utcTime}");

    }on FormatException {
      print( "could not parse ${value}");
    };

  }
}
