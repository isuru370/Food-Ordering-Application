import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String? id;
  final String? menuID;
  final String? verticalID;
  final String? storeID;
  final Title? title;
  final String? subTitle;
  final String? description;
  final MenuAvailability? menuAvailability;
  final List<String>? menuCategoryIDs;
  final String? createdDate;
  final String? modifiedDate;
  final String? createdBy;
  final String? modifiedBy;

  const Menu({
    this.id,
    this.menuID,
    this.verticalID,
    this.storeID,
    this.title,
    this.subTitle,
    this.description,
    this.menuAvailability,
    this.menuCategoryIDs,
    this.createdDate,
    this.modifiedDate,
    this.createdBy,
    this.modifiedBy,
  });

  // create a Menu object from JSON
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'] as String?,
      menuID: json['MenuID'] as String?,
      verticalID: json['VerticalID'] as String?,
      storeID: json['StoreID'] as String?,
      title: json['Title'] != null ? Title.fromJson(json['Title']) : null,
      subTitle: json['SubTitle'] as String?,
      description: json['Description'] as String?,
      menuAvailability: json['MenuAvailability'] != null
          ? MenuAvailability.fromJson(json['MenuAvailability'])
          : null,
      menuCategoryIDs: (json['MenuCategoryIDs'] as List<dynamic>?)
          ?.map((e) => e as String)
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
        menuID,
        verticalID,
        storeID,
        title,
        subTitle,
        description,
        menuAvailability,
        menuCategoryIDs,
        createdDate,
        modifiedDate,
        createdBy,
        modifiedBy,
      ];
}

class Title extends Equatable {
  final String? en;

  const Title({this.en});

  // create a Title object from JSON
  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
      en: json['en'] as String?,
    );
  }

  @override
  List<Object?> get props => [en];
}

class MenuAvailability extends Equatable {
  final Availability? sunday;
  final Availability? monday;
  final Availability? tuesday;
  final Availability? wednesday;
  final Availability? thursday;
  final Availability? friday;
  final Availability? saturday;

  const MenuAvailability({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  // create a MenuAvailability object from JSON
  factory MenuAvailability.fromJson(Map<String, dynamic> json) {
    return MenuAvailability(
      sunday: json['Sunday'] != null
          ? Availability.fromJson(json['Sunday'])
          : null,
      monday: json['Monday'] != null
          ? Availability.fromJson(json['Monday'])
          : null,
      tuesday: json['Tuesday'] != null
          ? Availability.fromJson(json['Tuesday'])
          : null,
      wednesday: json['Wednesday'] != null
          ? Availability.fromJson(json['Wednesday'])
          : null,
      thursday: json['Thursday'] != null
          ? Availability.fromJson(json['Thursday'])
          : null,
      friday: json['Friday'] != null
          ? Availability.fromJson(json['Friday'])
          : null,
      saturday: json['Saturday'] != null
          ? Availability.fromJson(json['Saturday'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        sunday,
        monday,
        tuesday,
        wednesday,
        thursday,
        friday,
        saturday,
      ];
}

class Availability extends Equatable {
  final String? startTime;
  final String? endTime;

  const Availability({this.startTime, this.endTime});

  //  create an Availability object from JSON
  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      startTime: json['StartTime'] as String?,
      endTime: json['EndTime'] as String?,
    );
  }

  @override
  List<Object?> get props => [startTime, endTime];
}
