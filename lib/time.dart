Map<String, String> lastMonth = {
  "برمجة": "7w, 2d, 23h, 50m",
  "مشي": "5w, 2d, 18h, 50m",
  "قراءة": "1w, 2d, 15h, 20m",
  "مذاكرة": "8w, 3d, 12h, 40m",
  "English": "3d, 18h, 45m",
  "طلب علم أو تطبيقه": "2w, 3d, 17h, 25m",
  "تخطيط": "1w, 4d, 7h, 20m",
};

Map<String, String> currentMonthData = {};

void main() {
  print("للحافظة :");
  printForKeep();

  print("\n للجداول :");
  printForSheet();
}

void printForSheet() {
  Map<String, double> lastHours = lastHoursFunction();
  Map<String, double> currentHours = currentHoursFunction();
  //أطرحهم من بعض
  List<String> result = [];
  for (int i = 0; i < currentHours.length; i++) {
    //في حال تمت إضافة مهمة جديدة أجعلها صفي في الشهر الماضي
    if (lastHours[currentHours.keys.elementAt(i)] == null) {
      lastHours[currentHours.keys.elementAt(i)] = 0;
    }

    double totalHours = currentHours.values.elementAt(i) - lastHours.values.elementAt(i);
    result.add(totalHours.toStringAsFixed(2));
  }
  print(result.join("\t"));
}

void printForKeep() {
  Map<String, double> lastHours = lastHoursFunction();
  Map<String, double> currentHours = currentHoursFunction();
  //أطرحهم من بعض
  for (int i = 0; i < currentHours.length; i++) {
    //في حال تمت إضافة مهمة جديدة أجعلها صفي في الشهر الماضي
    if (lastHours[currentHours.keys.elementAt(i)] == null) {
      lastHours[currentHours.keys.elementAt(i)] = 0;
    }

    double totalHours = currentHours.values.elementAt(i) - lastHours.values.elementAt(i);
    print("${currentHours.keys.elementAt(i)}: ${totalHours.toStringAsFixed(2)}");
  }
}

///حول ساعات الشهر الماضي
Map<String, double> lastHoursFunction() {
  Map<String, double> lastHours = {};
  for (int i = 0; i < lastMonth.length; i++) {
    lastHours[lastMonth.keys.elementAt(i)] = parseDurationToHours(lastMonth.values.elementAt(i));
  }
  return lastHours;
}

///حول ساعات الشهر الحالي
Map<String, double> currentHoursFunction() {
  Map<String, double> currentHours = {};
  for (int i = 0; i < currentMonthData.length; i++) {
    currentHours[currentMonthData.keys.elementAt(i)] = parseDurationToHours(currentMonthData.values.elementAt(i));
  }
  return currentHours;
}

///حول الوقت إلى ساعات
double parseDurationToHours(String durationString) {
  //قسمها إلى قائمة
  List<String> components = durationString.split(', ');
  double totalHours = 0;

  for (String component in components) {
    //أستبدل كل الحروف التي ليست أرقام بمسافة فارغة ، مما يزيل أي أحرف غير رقمية.
    int value = int.parse(component.replaceAll(RegExp(r'[^\d]'), ''));

    if (component.contains('w')) {
      totalHours += value * 7 * 24;
    } else if (component.contains('d')) {
      totalHours += value * 24;
    } else if (component.contains('h')) {
      totalHours += value;
    } else if (component.contains('m')) {
      totalHours += value / 60;
    }
  }

  return totalHours;
}
