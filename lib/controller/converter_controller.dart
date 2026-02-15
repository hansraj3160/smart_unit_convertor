import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConverterController extends GetxController {

  var selectedCategory = "".obs;
  var inputValue = 0.0.obs;
  var result = 0.0.obs;

  var fromUnit = "".obs;
  var toUnit = "".obs;
String get formattedResult =>
    result.value.toStringAsFixed(5);
final TextEditingController textController = TextEditingController();

  /// =======================
  /// LENGTH (base = meter)
  /// =======================
  final Map<String, double> lengthUnits = {
    "Meter (m)": 1.0,
    "Kilometer (km)": 1000.0,
    "Centimeter (cm)": 0.01,
    "Millimeter (mm)": 0.001,
    "Inch (in)": 0.0254,
    "Foot (ft)": 0.3048,
    "Yard (yd)": 0.9144,
    "Mile (mi)": 1609.34,
  };

  /// =======================
  /// MASS (base = kilogram)
  /// =======================
  final Map<String, double> massUnits = {
    "Kilogram (kg)": 1.0,
    "Gram (g)": 0.001,
    "Milligram (mg)": 0.000001,
    "Pound (lb)": 0.453592,
    "Ounce (oz)": 0.0283495,
    "Ton": 1000.0,
  };

  /// =======================
  /// TIME (base = second)
  /// =======================
  final Map<String, double> timeUnits = {
    "Second (s)": 1.0,
    "Minute (min)": 60.0,
    "Hour (h)": 3600.0,
    "Day": 86400.0,
    "Week": 604800.0,
  };

  /// =======================
  /// AREA (base = square meter)
  /// =======================
  final Map<String, double> areaUnits = {
    "Square Meter (m²)": 1.0,
    "Square Kilometer (km²)": 1000000.0,
    "Square Foot (ft²)": 0.092903,
    "Acre": 4046.86,
    "Hectare": 10000.0,
  };

  /// =======================
  /// VOLUME (base = liter)
  /// =======================
  final Map<String, double> volumeUnits = {
    "Liter (L)": 1.0,
    "Milliliter (mL)": 0.001,
    "Cubic Meter (m³)": 1000.0,
    "Gallon": 3.78541,
    "Cup": 0.24,
  };

  /// =======================
  /// SPEED (base = meter per second)
  /// =======================
  final Map<String, double> speedUnits = {
    "Meter/Second (m/s)": 1.0,
    "Kilometer/Hour (km/h)": 0.277778,
    "Miles/Hour (mph)": 0.44704,
  };

  /// =======================
  /// TEMPERATURE (formula based)
  /// =======================
  final List<String> temperatureUnits = [
    "Celsius (°C)",
    "Fahrenheit (°F)",
    "Kelvin (K)",
  ];

  void setCategory(String category) {
    selectedCategory.value = category;
     resetValues();
    switch (category) {
      case "Length":
        fromUnit.value = lengthUnits.keys.first;
        toUnit.value = lengthUnits.keys.elementAt(1);
        break;

      case "Mass / Weight":
        fromUnit.value = massUnits.keys.first;
        toUnit.value = massUnits.keys.elementAt(1);
        break;

      case "Time":
        fromUnit.value = timeUnits.keys.first;
        toUnit.value = timeUnits.keys.elementAt(1);
        break;

      case "Area":
        fromUnit.value = areaUnits.keys.first;
        toUnit.value = areaUnits.keys.elementAt(1);
        break;

      case "Volume":
        fromUnit.value = volumeUnits.keys.first;
        toUnit.value = volumeUnits.keys.elementAt(1);
        break;

      case "Speed":
        fromUnit.value = speedUnits.keys.first;
        toUnit.value = speedUnits.keys.elementAt(1);
        break;

      case "Temperature":
        fromUnit.value = temperatureUnits.first;
        toUnit.value = temperatureUnits[1];
        break;
    }
  }

  Map<String, double> get currentUnits {
    switch (selectedCategory.value) {
      case "Length":
        return lengthUnits;
      case "Mass / Weight":
        return massUnits;
      case "Time":
        return timeUnits;
      case "Area":
        return areaUnits;
      case "Volume":
        return volumeUnits;
      case "Speed":
        return speedUnits;
      default:
        return {};
    }
  }
void updateInput(String value) {
  inputValue.value = double.tryParse(value) ?? 0;
  convert();
}

  void convert() {

    /// Temperature (special logic)
    if (selectedCategory.value == "Temperature") {

      double value = inputValue.value;
      double celsius;

      if (fromUnit.value == "Celsius (°C)") {
        celsius = value;
      } else if (fromUnit.value == "Fahrenheit (°F)") {
        celsius = (value - 32) * 5 / 9;
      } else {
        celsius = value - 273.15;
      }

      if (toUnit.value == "Celsius (°C)") {
        result.value = celsius;
      } else if (toUnit.value == "Fahrenheit (°F)") {
        result.value = (celsius * 9 / 5) + 32;
      } else {
        result.value = celsius + 273.15;
      }

      return;
    }

    if (currentUnits.isEmpty) return;

    double baseValue =
        inputValue.value * currentUnits[fromUnit.value]!;

    result.value =
        baseValue / currentUnits[toUnit.value]!;
  }
void resetValues() {
  inputValue.value = 0;
  result.value = 0;
  fromUnit.value = "";
  toUnit.value = "";
  textController.clear();
}


  void swapUnits() {
  String temp = fromUnit.value;
  fromUnit.value = toUnit.value;
  toUnit.value = temp;
  convert();
}

}
