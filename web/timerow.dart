import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';

var dateFormatter = new DateFormat("MMM/d HH:mm:ss");
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

    var delete = new ButtonElement();
    delete.text = "delete";
    tableRow.addCell().children.add(delete);

    var subscription  = timeStream.listen( (time){
        textInput.value = "${dateFormatter.format( time)}";
    });


    delete.onClick.listen( (_){
      tableRow.remove();
      subscription.cancel();
    });

  }
  addToTable( TableElement table){
    table.children.add( tableRow);

  }
}
