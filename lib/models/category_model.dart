import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String? id;
  final String? menuCategoryID;
  final String? menuID;
  final String? storeID;
  final Title? title;
  final Title? subTitle;
  final List<MenuEntity>? menuEntities;
  final String? createdDate;
  final String? modifiedDate;
  final String? createdBy;
  final String? modifiedBy;

  const Category({
    this.id,
    this.menuCategoryID,
    this.menuID,
    this.storeID,
    this.title,
    this.subTitle,
    this.menuEntities,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
  });

// create an Availability object from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'] as String?,
      menuCategoryID: json['MenuCategoryID'] as String?,
      menuID: json['MenuID'] as String?,
      storeID: json['StoreID'] as String?,
      title: json['Title'] != null ? Title.fromJson(json['Title']) : null,
      subTitle:
          json['SubTitle'] != null ? Title.fromJson(json['SubTitle']) : null,
      menuEntities: (json['MenuEntities'] as List<dynamic>?)
          ?.map((e) => MenuEntity.fromJson(e))
          .toList(),
      createdDate: json['CreatedDate'] as String?,
      modifiedDate: json['ModifiedDate'] as String?,
      createdBy: json['CreatedBy'] as String?,
      modifiedBy: json['ModifiedBy'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        id,
        menuCategoryID,
        menuID,
        storeID,
        title,
        subTitle,
        menuEntities,
        createdDate,
        modifiedDate,
        createdBy,
        modifiedBy,
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

class MenuEntity extends Equatable {
  final String? id;
  final String? type;

  const MenuEntity({this.id, this.type});

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      id: json['ID'] as String?,
      type: json['Type'] as String?,
    );
  }

  @override
  List<Object?> get props => [id, type];
}
