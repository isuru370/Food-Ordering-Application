import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_application/app.dart';
import 'package:food_ordering_application/simple_bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}


