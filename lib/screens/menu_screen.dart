import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/menu/menu_repo_data.dart';
import '../bloc/menu_bloc/menu_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MenuBloc(menuRepoData: MenuRepoData())..add(GetMenu()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Menu')),
        body: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuProcess) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MenuSuccess) {
              if (state.menu.isEmpty) {
                return const Center(
                  child: Text('No menus available.'),
                );
              }
              return ListView.builder(
                itemCount: state.menu.length,
                itemBuilder: (context, index) {
                  final menu = state.menu[index];
                  return ListTile(
                    title: Text(menu.title?.en ?? 'Untitled Menu'),
                    subtitle: Text(menu.menuAvailability != null
                        ? 'Available: ${menu.menuAvailability!.monday?.startTime ?? 'N/A'} - ${menu.menuAvailability!.monday?.endTime ?? 'N/A'}'
                        : 'No availability data'),
                  );
                },
              );
            } else if (state is MenuFailure) {
              return Center(
                child: Text(
                  'Error: ${state.menuFailureMessage}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('Welcome to the Menu App'));
          },
        ),
      ),
    );
  }
}
