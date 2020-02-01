class Localization {
  Table localizationTable;
  String languageId;
  boolean debug = false;

  Localization() {
    localizationTable = loadTable("localization.csv", "header");
    languageId = localizationTable.getColumnTitle(1);
  }

  String getText (String textKey) {
    int keyIndex = localizationTable.findRowIndex(textKey, "key");
    if (keyIndex == -1) {
      //Error
      if (debug) {
        println("[Localization] Key \"" + textKey + "\" not found on table");
      }
      return "[" + textKey + "]";
    }
    return localizationTable.getString(keyIndex, languageId);
  }
}

String getText (String textKey) {
  return localization.getText(textKey);
}
