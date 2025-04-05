import '../../logic/services/db_services.dart';
import '../models/employee.dart';

class EmployeeRepository {
  final DBService _dbService;

  EmployeeRepository({
    required DBService dbService,
  }) : _dbService = dbService;

  Future<List<Employee>> getEmployees() async {
    return await _dbService.getEmployees();
  }

  Future<void> addEmployee(Employee employee) async {
    await _dbService.addEmployee(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await _dbService.updateEmployee(employee);
  }

  Future<void> deleteEmployee(String id) async {
    await _dbService.deleteEmployee(id);
  }

  // Get current employees
  Future<List<Employee>> getCurrentEmployees() async {
    final employees = await _dbService.getEmployees();
    return employees.where((e) => e.isCurrent).toList()
      ..sort((a, b) => b.startDate.compareTo(a.startDate));
  }

  // Get previous employees
  Future<List<Employee>> getPreviousEmployees() async {
    final employees = await _dbService.getEmployees();
    return employees.where((e) => !e.isCurrent).toList()
      ..sort((a, b) => b.endDate!.compareTo(a.endDate!));
  }
}