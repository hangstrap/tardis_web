import "dart:html";

import 'package:timezone/timezone.dart';
import 'package:timezone/browser.dart';

addTimezonesOptionsToSelectElement(SelectElement selectElement) async {
  await initializeTimeZone();

  List<OptionElement> loadElements() {
    var result = [];
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
  selectElement.children.clear();
  selectElement.children.addAll(loadElements());
}
