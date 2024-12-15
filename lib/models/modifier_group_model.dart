import 'package:equatable/equatable.dart';

class ModifierGroup extends Equatable {
  final String? id;
  final String? modifierGroupID;
  final Title? title;
  final Title? description;
  final String? storeID;
  final String? displayType;
  final List<ModifierOption>? modifierOptions;
  final QuantityConstraintsRules? quantityConstraintsRules;
  final String? createdDate;
  final String? modifiedDate;
  final MetaData? metaData;

  const ModifierGroup({
    this.id,
    this.modifierGroupID,
    this.title,
    this.description,
    this.storeID,
    this.displayType,
    this.modifierOptions,
    this.quantityConstraintsRules,
    this.createdDate,
    this.modifiedDate,
    this.metaData,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json) {
    return ModifierGroup(
      id: json['ID'] as String?,
      modifierGroupID: json['ModifierGroupID'] as String?,
      title: json['Title'] != null ? Title.fromJson(json['Title']) : null,
      description: json['Description'] != null ? Title.fromJson(json['Description']) : null,
      storeID: json['StoreID'] as String?,
      displayType: json['DisplayType'] as String?,
      modifierOptions: (json['ModifierOptions'] as List<dynamic>?)
          ?.map((e) => ModifierOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      quantityConstraintsRules: json['QuantityConstraintsRules'] != null
          ? QuantityConstraintsRules.fromJson(json['QuantityConstraintsRules'])
          : null,
      createdDate: json['CreatedDate'] as String?,
      modifiedDate: json['ModifiedDate'] as String?,
      metaData: json['MetaData'] != null
          ? MetaData.fromJson(json['MetaData'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        modifierGroupID,
        title,
        description,
        storeID,
        displayType,
        modifierOptions,
        quantityConstraintsRules,
        createdDate,
        modifiedDate,
        metaData,
      ];
}

class Title extends Equatable {
  final String? en;

  const Title({this.en});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(en: json['en'] as String?);
  }

  @override
  List<Object?> get props => [en];
}

class ModifierOption extends Equatable {
  final String? id;
  final String? type;

  const ModifierOption({this.id, this.type});

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    return ModifierOption(
      id: json['Id'] as String?,
      type: json['Type'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, type];
}

class QuantityConstraintsRules extends Equatable {
  final Quantity? quantity;
  final dynamic overrides;

  const QuantityConstraintsRules({
    this.quantity,
    this.overrides,
  });

  factory QuantityConstraintsRules.fromJson(Map<String, dynamic> json) {
    return QuantityConstraintsRules(
      quantity: json['Quantity'] != null
          ? Quantity.fromJson(json['Quantity'])
          : null,
      overrides: json['Overrides'], 
    );
  }

  @override
  List<Object?> get props => [quantity, overrides];
}

class Quantity extends Equatable {
  final int? minPermitted;
  final int? maxPermitted;
  final bool? isMinPermittedOptional;
  final int? chargeAbove;
  final int? refundUnder;
  final int? minPermittedUnique;
  final int? maxPermittedUnique;

  const Quantity({
    this.minPermitted,
    this.maxPermitted,
    this.isMinPermittedOptional,
    this.chargeAbove,
    this.refundUnder,
    this.minPermittedUnique,
    this.maxPermittedUnique,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      minPermitted: json['MinPermitted'] as int?,
      maxPermitted: json['MaxPermitted'] as int?,
      isMinPermittedOptional: json['IsMinPermittedOptional'] as bool?,
      chargeAbove: json['ChargeAbove'] as int?,
      refundUnder: json['RefundUnder'] as int?,
      minPermittedUnique: json['MinPermittedUnique'] as int?,
      maxPermittedUnique: json['MaxPermittedUnique'] as int?,
    );
  }

  @override
  List<Object?> get props => [
        minPermitted,
        maxPermitted,
        isMinPermittedOptional,
        chargeAbove,
        refundUnder,
        minPermittedUnique,
        maxPermittedUnique,
      ];
}

class MetaData extends Equatable {
  const MetaData();

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return const MetaData();
  }

  @override
  List<Object?> get props => [];
}
