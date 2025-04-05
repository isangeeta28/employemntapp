import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/theme.dart';
import 'data/repository/employee_repository.dart';
import 'logic/blocs/employee_bloc.dart';
import 'logic/blocs/employee_event.dart';
import 'presentation/screens/employee_list_screen.dart';

class MyApp extends StatelessWidget {
  final EmployeeRepository employeeRepository;

  const MyApp({super.key, required this.employeeRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc(
        employeeRepository: employeeRepository,
      )..add(LoadEmployees()),
      child: MaterialApp(
        title: 'Employee Management',
        theme: AppTheme.lightTheme,
        home: const EmployeeListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

