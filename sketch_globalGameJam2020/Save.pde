class Save {
  String path;
  JSONObject data;
  boolean debug = false;

  Save() {
    path = "data/save.json";
    createSaveFile();
  }

  void createSaveFile() {
    if (loadStrings(path) == null) {
      data = new JSONObject();
      data.setInt("id", 0);
      data.setString("languageId", languageId);
      saveJSONObject(data, path);
    } else {
      data = loadJSONObject(path);
    }
  }

  void editValue(String jsonKey, String value) {
    data.setString(jsonKey, value);
    saveJSONObject(data, path);
    if (debug) {
      println("[Save] " + data);
      println("[Save] " + "Saved");
    }
  }

  void editValue(String jsonKey, int value) {
    data.setInt(jsonKey, value);
    saveJSONObject(data, path);
    if (debug) {
      println("[Save] " + data);
      println("[Save] Saved");
    }
  }
}
