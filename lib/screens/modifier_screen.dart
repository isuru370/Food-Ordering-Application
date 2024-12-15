import 'package:flutter/material.dart';
import 'package:food_ordering_application/models/item_model.dart';
import 'package:provider/provider.dart';
import '../models/modifier_group_model.dart';
import '../provider/modifier_provider.dart';

class ModifierScreen extends StatefulWidget {
  final ModifierGroupRules modifierGroupRules;

  const ModifierScreen({
    super.key,
    required this.modifierGroupRules, // Ensure we pass modifierGroupRules here
  });

  @override
  State<ModifierScreen> createState() => _ModifierScreenState();
}

class _ModifierScreenState extends State<ModifierScreen> {
  late ModifierGroupRules modifierGroupRules;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      modifierGroupRules = widget.modifierGroupRules;

      context.read<ModifierProvider>().fetchModifier(modifierGroupRules);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier Groups'),
      ),
      body: Column(
        children: [
          Consumer<ModifierProvider>(
            builder: (context, modifierProvider, child) {
              if (modifierProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (modifierProvider.errorMessage != null) {
                return Center(child: Text(modifierProvider.errorMessage!));
              } else {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: modifierProvider.modifierList.length,
                    itemBuilder: (context, index) {
                      final modifierGroup =
                          modifierProvider.modifierList[index];
                      return CheckboxListTile(
                        title: Text(modifierGroup.title!.en ?? 'Unknown'),
                        value: modifierProvider.selectedModifierGroups[
                                modifierGroup.modifierGroupID] ??
                            false,
                        onChanged: (bool? selected) {
                          modifierProvider.updateSelection(
                            modifierGroup.modifierGroupID.toString(),
                            selected ?? false,
                          );
                        },
                      );
                    },
                  ),
                );
              }
            },
          ),
          Consumer<ModifierProvider>(
            builder: (context, modifierProvider, child) {
              return ElevatedButton(
                onPressed: () {
                  List<ModifierGroup> selectedGroups = modifierProvider
                      .modifierList
                      .where((modifierGroup) =>
                          modifierProvider.selectedModifierGroups[
                              modifierGroup.modifierGroupID] ==
                          true)
                      .toList();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Selected Groups'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: selectedGroups.map((group) {
                            return Text(group.title!.en ?? 'Unknown');
                          }).toList(),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Show Selected Groups'),
              );
            },
          ),
        ],
      ),
    );
  }
}
