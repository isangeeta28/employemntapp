import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/employee.dart';

class DBService {
  static const String _employeesKey = 'employees';

  // Save all employees to SharedPreferences
  Future<void> saveEmployees(List<Employee> employees) async {
    final prefs = await SharedPreferences.getInstance();
    final employeeJsonList = employees.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_employeesKey, employeeJsonList);
  }

  // Get all employees from SharedPreferences
  Future<List<Employee>> getEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeeJsonList = prefs.getStringList(_employeesKey) ?? [];

    return employeeJsonList
        .map((jsonString) => Employee.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  // Add a new employee
  Future<void> addEmployee(Employee employee) async {
    final employees = await getEmployees();
    employees.add(employee);
    await saveEmployees(employees);
  }

  // Update an existing employee
  Future<void> updateEmployee(Employee updatedEmployee) async {
    final employees = await getEmployees();
    final index = employees.indexWhere((e) => e.id == updatedEmployee.id);

    if (index != -1) {
      employees[index] = updatedEmployee;
      await saveEmployees(employees);
    }
  }

  // Delete an employee by ID
  Future<void> deleteEmployee(String id) async {
    final employees = await getEmployees();
    employees.removeWhere((e) => e.id == id);
    await saveEmployees(employees);
  }
}