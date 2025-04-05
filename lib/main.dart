import 'package:flutter/material.dart';
import 'app.dart';
import 'data/repository/employee_repository.dart';
import 'logic/services/db_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  final dbService = DBService();
  final employeeRepository = EmployeeRepository(dbService: dbService);

  runApp(MyApp(employeeRepository: employeeRepository));
}