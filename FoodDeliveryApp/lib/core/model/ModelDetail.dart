// To parse this JSON data, do
//
//     final foodData = foodDataFromMap(jsonString);

import 'dart:convert';

FoodData foodDataFromMap(String str) => FoodData.fromMap(json.decode(str));

String foodDataToMap(FoodData data) => json.encode(data.toMap());

class FoodData {
  String foodClass;
  String description;
  List<FoodNutrient> foodNutrients;
  List<FoodAttribute> foodAttributes;
  String foodCode;
  String startDate;
  String endDate;
  WweiaFoodCategory wweiaFoodCategory;
  int fdcId;
  String dataType;
  List<FoodPortion> foodPortions;
  String publicationDate;
  List<InputFood> inputFoods;

  FoodData({
    required this.foodClass,
    required this.description,
    required this.foodNutrients,
    required this.foodAttributes,
    required this.foodCode,
    required this.startDate,
    required this.endDate,
    required this.wweiaFoodCategory,
    required this.fdcId,
    required this.dataType,
    required this.foodPortions,
    required this.publicationDate,
    required this.inputFoods,
  });

  FoodData copyWith({
    String? foodClass,
    String? description,
    List<FoodNutrient>? foodNutrients,
    List<FoodAttribute>? foodAttributes,
    String? foodCode,
    String? startDate,
    String? endDate,
    WweiaFoodCategory? wweiaFoodCategory,
    int? fdcId,
    String? dataType,
    List<FoodPortion>? foodPortions,
    String? publicationDate,
    List<InputFood>? inputFoods,
  }) =>
      FoodData(
        foodClass: foodClass ?? this.foodClass,
        description: description ?? this.description,
        foodNutrients: foodNutrients ?? this.foodNutrients,
        foodAttributes: foodAttributes ?? this.foodAttributes,
        foodCode: foodCode ?? this.foodCode,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        wweiaFoodCategory: wweiaFoodCategory ?? this.wweiaFoodCategory,
        fdcId: fdcId ?? this.fdcId,
        dataType: dataType ?? this.dataType,
        foodPortions: foodPortions ?? this.foodPortions,
        publicationDate: publicationDate ?? this.publicationDate,
        inputFoods: inputFoods ?? this.inputFoods,
      );

  factory FoodData.fromMap(Map<String, dynamic> json) => FoodData(
    foodClass: json["foodClass"],
    description: json["description"],
    foodNutrients: List<FoodNutrient>.from(json["foodNutrients"].map((x) => FoodNutrient.fromMap(x))),
    foodAttributes: List<FoodAttribute>.from(json["foodAttributes"].map((x) => FoodAttribute.fromMap(x))),
    foodCode: json["foodCode"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    wweiaFoodCategory: WweiaFoodCategory.fromMap(json["wweiaFoodCategory"]),
    fdcId: json["fdcId"],
    dataType: json["dataType"],
    foodPortions: List<FoodPortion>.from(json["foodPortions"].map((x) => FoodPortion.fromMap(x))),
    publicationDate: json["publicationDate"],
    inputFoods: List<InputFood>.from(json["inputFoods"].map((x) => InputFood.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "foodClass": foodClass,
    "description": description,
    "foodNutrients": List<dynamic>.from(foodNutrients.map((x) => x.toMap())),
    "foodAttributes": List<dynamic>.from(foodAttributes.map((x) => x.toMap())),
    "foodCode": foodCode,
    "startDate": startDate,
    "endDate": endDate,
    "wweiaFoodCategory": wweiaFoodCategory.toMap(),
    "fdcId": fdcId,
    "dataType": dataType,
    "foodPortions": List<dynamic>.from(foodPortions.map((x) => x.toMap())),
    "publicationDate": publicationDate,
    "inputFoods": List<dynamic>.from(inputFoods.map((x) => x.toMap())),
  };
}

class FoodAttribute {
  int id;
  String value;
  FoodAttributeType foodAttributeType;
  int? rank;
  String? name;

  FoodAttribute({
    required this.id,
    required this.value,
    required this.foodAttributeType,
    this.rank,
    this.name,
  });

  FoodAttribute copyWith({
    int? id,
    String? value,
    FoodAttributeType? foodAttributeType,
    int? rank,
    String? name,
  }) =>
      FoodAttribute(
        id: id ?? this.id,
        value: value ?? this.value,
        foodAttributeType: foodAttributeType ?? this.foodAttributeType,
        rank: rank ?? this.rank,
        name: name ?? this.name,
      );

  factory FoodAttribute.fromMap(Map<String, dynamic> json) => FoodAttribute(
    id: json["id"],
    value: json["value"],
    foodAttributeType: FoodAttributeType.fromMap(json["foodAttributeType"]),
    rank: json["rank"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "value": value,
    "foodAttributeType": foodAttributeType.toMap(),
    "rank": rank,
    "name": name,
  };
}

class FoodAttributeType {
  int id;
  String name;
  String description;

  FoodAttributeType({
    required this.id,
    required this.name,
    required this.description,
  });

  FoodAttributeType copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      FoodAttributeType(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory FoodAttributeType.fromMap(Map<String, dynamic> json) => FoodAttributeType(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
  };
}

class FoodNutrient {
  Type type;
  int id;
  Nutrient nutrient;
  double amount;

  FoodNutrient({
    required this.type,
    required this.id,
    required this.nutrient,
    required this.amount,
  });

  FoodNutrient copyWith({
    Type? type,
    int? id,
    Nutrient? nutrient,
    double? amount,
  }) =>
      FoodNutrient(
        type: type ?? this.type,
        id: id ?? this.id,
        nutrient: nutrient ?? this.nutrient,
        amount: amount ?? this.amount,
      );

  factory FoodNutrient.fromMap(Map<String, dynamic> json) => FoodNutrient(
    type: typeValues.map[json["type"]]!,
    id: json["id"],
    nutrient: Nutrient.fromMap(json["nutrient"]),
    amount: json["amount"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "type": typeValues.reverse[type],
    "id": id,
    "nutrient": nutrient.toMap(),
    "amount": amount,
  };
}

class Nutrient {
  int id;
  String number;
  String name;
  int rank;
  String unitName;

  Nutrient({
    required this.id,
    required this.number,
    required this.name,
    required this.rank,
    required this.unitName,
  });

  Nutrient copyWith({
    int? id,
    String? number,
    String? name,
    int? rank,
    String? unitName,
  }) =>
      Nutrient(
        id: id ?? this.id,
        number: number ?? this.number,
        name: name ?? this.name,
        rank: rank ?? this.rank,
        unitName: unitName ?? this.unitName,
      );

  factory Nutrient.fromMap(Map<String, dynamic> json) => Nutrient(
    id: json["id"],
    number: json["number"],
    name: json["name"],
    rank: json["rank"],
    unitName: json["unitName"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "number": number,
    "name": name,
    "rank": rank,
    "unitName": unitNameValues.reverse[unitName],
  };
}

enum UnitName {
  G,
  KCAL,
  MG,
  UNIT_NAME_G
}

final unitNameValues = EnumValues({
  "g": UnitName.G,
  "kcal": UnitName.KCAL,
  "mg": UnitName.MG,
  "µg": UnitName.UNIT_NAME_G
});

enum Type {
  FOOD_NUTRIENT
}

final typeValues = EnumValues({
  "FoodNutrient": Type.FOOD_NUTRIENT
});

class FoodPortion {
  int id;
  MeasureUnit measureUnit;
  String modifier;
  int gramWeight;
  int sequenceNumber;
  String portionDescription;

  FoodPortion({
    required this.id,
    required this.measureUnit,
    required this.modifier,
    required this.gramWeight,
    required this.sequenceNumber,
    required this.portionDescription,
  });

  FoodPortion copyWith({
    int? id,
    MeasureUnit? measureUnit,
    String? modifier,
    int? gramWeight,
    int? sequenceNumber,
    String? portionDescription,
  }) =>
      FoodPortion(
        id: id ?? this.id,
        measureUnit: measureUnit ?? this.measureUnit,
        modifier: modifier ?? this.modifier,
        gramWeight: gramWeight ?? this.gramWeight,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        portionDescription: portionDescription ?? this.portionDescription,
      );

  factory FoodPortion.fromMap(Map<String, dynamic> json) => FoodPortion(
    id: json["id"],
    measureUnit: MeasureUnit.fromMap(json["measureUnit"]),
    modifier: json["modifier"],
    gramWeight: json["gramWeight"],
    sequenceNumber: json["sequenceNumber"],
    portionDescription: json["portionDescription"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "measureUnit": measureUnit.toMap(),
    "modifier": modifier,
    "gramWeight": gramWeight,
    "sequenceNumber": sequenceNumber,
    "portionDescription": portionDescription,
  };
}

class MeasureUnit {
  int id;
  String name;
  String abbreviation;

  MeasureUnit({
    required this.id,
    required this.name,
    required this.abbreviation,
  });

  MeasureUnit copyWith({
    int? id,
    String? name,
    String? abbreviation,
  }) =>
      MeasureUnit(
        id: id ?? this.id,
        name: name ?? this.name,
        abbreviation: abbreviation ?? this.abbreviation,
      );

  factory MeasureUnit.fromMap(Map<String, dynamic> json) => MeasureUnit(
    id: json["id"],
    name: json["name"],
    abbreviation: json["abbreviation"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "abbreviation": abbreviation,
  };
}

class InputFood {
  int id;
  String unit;
  String portionDescription;
  String portionCode;
  String foodDescription;
  int sequenceNumber;
  double ingredientWeight;
  int ingredientCode;
  String ingredientDescription;
  double amount;

  InputFood({
    required this.id,
    required this.unit,
    required this.portionDescription,
    required this.portionCode,
    required this.foodDescription,
    required this.sequenceNumber,
    required this.ingredientWeight,
    required this.ingredientCode,
    required this.ingredientDescription,
    required this.amount,
  });

  InputFood copyWith({
    int? id,
    String? unit,
    String? portionDescription,
    String? portionCode,
    String? foodDescription,
    int? sequenceNumber,
    double? ingredientWeight,
    int? ingredientCode,
    String? ingredientDescription,
    double? amount,
  }) =>
      InputFood(
        id: id ?? this.id,
        unit: unit ?? this.unit,
        portionDescription: portionDescription ?? this.portionDescription,
        portionCode: portionCode ?? this.portionCode,
        foodDescription: foodDescription ?? this.foodDescription,
        sequenceNumber: sequenceNumber ?? this.sequenceNumber,
        ingredientWeight: ingredientWeight ?? this.ingredientWeight,
        ingredientCode: ingredientCode ?? this.ingredientCode,
        ingredientDescription: ingredientDescription ?? this.ingredientDescription,
        amount: amount ?? this.amount,
      );

  factory InputFood.fromMap(Map<String, dynamic> json) => InputFood(
    id: json["id"],
    unit: json["unit"],
    portionDescription: json["portionDescription"],
    portionCode: json["portionCode"],
    foodDescription: json["foodDescription"],
    sequenceNumber: json["sequenceNumber"],
    ingredientWeight: json["ingredientWeight"]?.toDouble(),
    ingredientCode: json["ingredientCode"],
    ingredientDescription: json["ingredientDescription"],
    amount: json["amount"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "unit": unit,
    "portionDescription": portionDescription,
    "portionCode": portionCode,
    "foodDescription": foodDescription,
    "sequenceNumber": sequenceNumber,
    "ingredientWeight": ingredientWeight,
    "ingredientCode": ingredientCode,
    "ingredientDescription": ingredientDescription,
    "amount": amount,
  };
}

class WweiaFoodCategory {
  int wweiaFoodCategoryCode;
  String wweiaFoodCategoryDescription;

  WweiaFoodCategory({
    required this.wweiaFoodCategoryCode,
    required this.wweiaFoodCategoryDescription,
  });

  WweiaFoodCategory copyWith({
    int? wweiaFoodCategoryCode,
    String? wweiaFoodCategoryDescription,
  }) =>
      WweiaFoodCategory(
        wweiaFoodCategoryCode: wweiaFoodCategoryCode ?? this.wweiaFoodCategoryCode,
        wweiaFoodCategoryDescription: wweiaFoodCategoryDescription ?? this.wweiaFoodCategoryDescription,
      );

  factory WweiaFoodCategory.fromMap(Map<String, dynamic> json) => WweiaFoodCategory(
    wweiaFoodCategoryCode: json["wweiaFoodCategoryCode"],
    wweiaFoodCategoryDescription: json["wweiaFoodCategoryDescription"],
  );

  Map<String, dynamic> toMap() => {
    "wweiaFoodCategoryCode": wweiaFoodCategoryCode,
    "wweiaFoodCategoryDescription": wweiaFoodCategoryDescription,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
