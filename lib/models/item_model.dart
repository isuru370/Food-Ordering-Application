import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String? id;
  final String? menuItemID;
  final String? storeID;
  final Title? title;
  final Title? description;
  final String? imageURL;
  final PriceInfo? priceInfo;
  final QuantityInfo? quantityInfo;
  final SuspensionRules? suspensionRules;
  final ModifierGroupRules? modifierGroupRules;
  final RewardGroupRules? rewardGroupRules;
  final TaxInfo? taxInfo;
  final NutrientData? nutrientData;
  final DishInfo? dishInfo;
  final VisibilityInfo? visibilityInfo;
  final ProductInfo? productInfo;
  final List<String>? categoryIDs;
  final List<String>? allergens;
  final MetaData? metaData;

  const MenuItem({
    this.id,
    this.menuItemID,
    this.storeID,
    this.title,
    this.description,
    this.imageURL,
    this.priceInfo,
    this.quantityInfo,
    this.suspensionRules,
    this.modifierGroupRules,
    this.rewardGroupRules,
    this.taxInfo,
    this.nutrientData,
    this.dishInfo,
    this.visibilityInfo,
    this.productInfo,
    this.categoryIDs,
    this.allergens,
    this.metaData,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['ID'] as String?,
      menuItemID: json['MenuItemID'] as String?,
      storeID: json['StoreID'] as String?,
      title: json['Title'] != null ? Title.fromJson(json['Title']) : null,
      description: json['Description'] != null
          ? Title.fromJson(json['Description'])
          : null,
      imageURL: json['ImageURL'] as String?,
      priceInfo: json['PriceInfo'] != null
          ? PriceInfo.fromJson(json['PriceInfo'])
          : null,
      quantityInfo: json['QuantityInfo'] != null
          ? QuantityInfo.fromJson(json['QuantityInfo'])
          : null,
      suspensionRules: json['SuspensionRules'] != null
          ? SuspensionRules.fromJson(json['SuspensionRules'])
          : null,
      modifierGroupRules: json['ModifierGroupRules'] != null
          ? ModifierGroupRules.fromJson(json['ModifierGroupRules'])
          : null,
      rewardGroupRules: json['RewardGroupRules'] != null
          ? RewardGroupRules.fromJson(json['RewardGroupRules'])
          : null,
      taxInfo:
          json['TaxInfo'] != null ? TaxInfo.fromJson(json['TaxInfo']) : null,
      nutrientData: json['NutrientData'] != null
          ? NutrientData.fromJson(json['NutrientData'])
          : null,
      dishInfo:
          json['DishInfo'] != null ? DishInfo.fromJson(json['DishInfo']) : null,
      visibilityInfo: json['VisibilityInfo'] != null
          ? VisibilityInfo.fromJson(json['VisibilityInfo'])
          : null,
      productInfo: json['ProductInfo'] != null
          ? ProductInfo.fromJson(json['ProductInfo'])
          : null,
      categoryIDs: (json['CategoryIDs'] as List<dynamic>?)?.cast<String>(),
      allergens: (json['Allergens'] as List<dynamic>?)?.cast<String>(),
      metaData:
          json['MetaData'] != null ? MetaData.fromJson(json['MetaData']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        menuItemID,
        storeID,
        title,
        description,
        imageURL,
        priceInfo,
        quantityInfo,
        suspensionRules,
        modifierGroupRules,
        rewardGroupRules,
        taxInfo,
        nutrientData,
        dishInfo,
        visibilityInfo,
        productInfo,
        categoryIDs,
        allergens,
        metaData,
      ];
}

// Subclasses
class Title extends Equatable {
  final String? en;

  const Title({this.en});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(en: json['en'] as String?);
  }

  @override
  List<Object?> get props => [en];
}

class PriceInfo extends Equatable {
  final Price? price;

  const PriceInfo({this.price});

  factory PriceInfo.fromJson(Map<String, dynamic> json) {
    return PriceInfo(
      price: json['Price'] != null ? Price.fromJson(json['Price']) : null,
    );
  }

  @override
  List<Object?> get props => [price];
}

class Price extends Equatable {
  final double? deliveryPrice;
  final double? pickupPrice;
  final double? tablePrice;

  const Price({
    this.deliveryPrice,
    this.pickupPrice,
    this.tablePrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      deliveryPrice: _toDouble(json['DeliveryPrice']),
      pickupPrice: _toDouble(json['PickupPrice']),
      tablePrice: _toDouble(json['TablePrice']),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    return value as double?;
  }

  @override
  List<Object?> get props => [deliveryPrice, pickupPrice, tablePrice];
}

class QuantityInfo extends Equatable {
  final Quantity? quantity;

  const QuantityInfo({this.quantity});

  factory QuantityInfo.fromJson(Map<String, dynamic> json) {
    return QuantityInfo(
      quantity:
          json['Quantity'] != null ? Quantity.fromJson(json['Quantity']) : null,
    );
  }

  @override
  List<Object?> get props => [quantity];
}

class Quantity extends Equatable {
  final int? minPermitted;
  final int? maxPermitted;

  const Quantity({
    this.minPermitted,
    this.maxPermitted,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      minPermitted: json['MinPermitted'] as int?,
      maxPermitted: json['MaxPermitted'] as int?,
    );
  }

  @override
  List<Object?> get props => [minPermitted, maxPermitted];
}

// Empty placeholder classes for other fields
class SuspensionRules extends Equatable {
  const SuspensionRules();

  factory SuspensionRules.fromJson(Map<String, dynamic> json) =>
      const SuspensionRules();

  @override
  List<Object?> get props => [];
}

class ModifierGroupRules extends Equatable {
  final List<String>? ids;
  final List<dynamic>? overrides;

  const ModifierGroupRules({
    this.ids,
    this.overrides,
  });

  factory ModifierGroupRules.fromJson(Map<String, dynamic> json) {
    return ModifierGroupRules(
      ids: (json['IDs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      overrides: json['Overrides'] as List<dynamic>?,
    );
  }

  @override
  List<Object?> get props => [ids, overrides];
}

class RewardGroupRules extends Equatable {
  const RewardGroupRules();

  factory RewardGroupRules.fromJson(Map<String, dynamic> json) =>
      const RewardGroupRules();

  @override
  List<Object?> get props => [];
}

class TaxInfo extends Equatable {
  const TaxInfo();

  factory TaxInfo.fromJson(Map<String, dynamic> json) => const TaxInfo();

  @override
  List<Object?> get props => [];
}

class NutrientData extends Equatable {
  const NutrientData();

  factory NutrientData.fromJson(Map<String, dynamic> json) =>
      const NutrientData();

  @override
  List<Object?> get props => [];
}

class DishInfo extends Equatable {
  const DishInfo();

  factory DishInfo.fromJson(Map<String, dynamic> json) => const DishInfo();

  @override
  List<Object?> get props => [];
}

class VisibilityInfo extends Equatable {
  const VisibilityInfo();

  factory VisibilityInfo.fromJson(Map<String, dynamic> json) =>
      const VisibilityInfo();

  @override
  List<Object?> get props => [];
}

class ProductInfo extends Equatable {
  const ProductInfo();

  factory ProductInfo.fromJson(Map<String, dynamic> json) =>
      const ProductInfo();

  @override
  List<Object?> get props => [];
}

class MetaData extends Equatable {
  final bool? isDealProduct;

  const MetaData({this.isDealProduct});

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      isDealProduct: json['IsDealProduct'] as bool?,
    );
  }

  @override
  List<Object?> get props => [isDealProduct];
}
