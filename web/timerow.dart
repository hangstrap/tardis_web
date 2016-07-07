import 'dart:html';
import 'dart:async';
import 'package:intl/intl.dart';
import 'timezone.dart' as time_zone;

var dateFormatter = new DateFormat("yyyy/MMM/d HH:mm");

typedef void UserEnteredTime(DateTime time);

class TimeRow {
  TableRowElement tableRow;
  TextInputElement textInput;
  StreamSubscription<DateTime> timeStream;
  final String timezone;
  final UserEnteredTime userEnteredTimeCallback;

  TimeRow(this.timezone, Stream<DateTime> timeStream,
      this.userEnteredTimeCallback) {
    //store the timezone for loading the next time the user visits this site
    window.localStorage[timezone] = timezone;

    //Build up the GUI
    tableRow = new TableRowElement();
    //First display the timezone
    tableRow.id = "row_${timezone}";
    tableRow.addCell().text = "${timezone}";
    //Then a text box
    textInput = new TextInputElement();
    tableRow.addCell().children.add(textInput);
    //then a delete button
    var delete = new ButtonInputElement();
    delete.value = "Delete";
    tableRow.addCell().children.add(delete);

    //listen to user input
    textInput.onInput.listen((_) {
      var value = textInput.value;
      try {
        //convert what the user inputted into a UTC time and send back to the main app
        DateTime time = dateFormatter.parseLoose(value);
        DateTime utcTime = time_zone.toUtc(
            timezone, time.year, time.month, time.day, time.hour, time.minute);
        userEnteredTimeCallback(utcTime);
      } on FormatException {}
    });

    //Listen to stream of times that need to be displayed from the main app
    var subscription = timeStream.listen((utcTime) {
      if (document.activeElement != textInput) {
        //convert time to the correct timezone and display it
        var localTime = time_zone.toLocalTime(timezone, utcTime);
        textInput.value = "${dateFormatter.format( localTime)}";
      }
    });
    //Listen to user clicking the delete button
    delete.onClick.listen((_) {
      tableRow.remove();
      subscription.cancel();
      window.localStorage.remove(timezone);
    });
  }

  addToTable(TableElement table) {
    table.children.add(tableRow);
  }
}
