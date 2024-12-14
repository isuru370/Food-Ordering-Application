import 'dart:developer';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../models/menu_model.dart';
import '../../repository/menu/menu_repo_data.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepoData menuRepoData;

  MenuBloc({required this.menuRepoData}) : super(MenuInitial()) {
    on<GetMenu>(_onGetMenu);
  }

  Future<void> _onGetMenu(GetMenu event, Emitter<MenuState> emit) async {
    emit(MenuProcess());
    try {
      await menuRepoData.fetchMenus().then(
        (responseMenu) {
          // Decode the response and add new menus to the existing list.
          final Map<String, dynamic> data = jsonDecode(responseMenu);
          if (data['Status'] == true) {
            final List<dynamic> menuJson = data['Result']['Menu'];
            final List<Menu> newMenus =
                menuJson.map((json) => Menu.fromJson(json)).toList();

            emit(MenuSuccess(menu: newMenus));
          } else {
            emit(const MenuFailure(
                menuFailureMessage:
                    'Failed to load menus: Status is not true'));
          }
        },
      );
    } catch (error) {
      log(error.toString());
      emit(const MenuFailure(menuFailureMessage: 'Failed to load menus'));
    }
  }
}
