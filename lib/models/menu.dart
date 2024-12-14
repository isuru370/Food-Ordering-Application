import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String? id;
  final String? menuId;
  final String? title;
  final Map<String, String>? availability;

  const Menu({
    this.id,
    this.menuId,
    this.title,
    this.availability,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      menuId: json['MenuID'],
      // Safely accessing 
      title: json['Title']?['en'], 
      availability: (json['MenuAvailability'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          '${value['StartTime']} - ${value['EndTime']}',
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [id, menuId, title, availability];
}
