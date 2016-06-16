import 'dart:html';

class TimeRow {
  TableRowElement tableRow;
  TextInputElement textInput;

  TimeRow( String timezone) {
    tableRow = new TableRowElement();


    tableRow.id = "row_${timezone}";
    tableRow.addCell().text = "${timezone}";

    textInput = new TextInputElement();
    tableRow.addCell().children.add(textInput);

    var delete = new ButtonElement();
    delete.text = "delete";
    tableRow.addCell().children.add(delete);

    delete.onClick.listen( (_){
      //Remove from table;
      tableRow.remove();
    });
  }
  addToTable( TableElement table){
    table.children.add( tableRow);
  }
}
