part of 'menu_bloc.dart';

sealed class MenuState extends Equatable {
  const MenuState();

  @override
  List<Object> get props => [];
}

final class MenuInitial extends MenuState {}

final class MenuProcess extends MenuState {}

final class MenuFailure extends MenuState {
  final String menuFailureMessage;
  const MenuFailure({required this.menuFailureMessage});

  @override
  List<Object> get props => [menuFailureMessage];
}

final class MenuSuccess extends MenuState {
  final List<Menu> menu;
  const MenuSuccess({required this.menu});

  @override
  List<Object> get props => [menu];
}
