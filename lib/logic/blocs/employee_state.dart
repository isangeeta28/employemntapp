import 'package:equatable/equatable.dart';
import '../../../data/models/employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> currentEmployees;
  final List<Employee> previousEmployees;
  final Employee? lastDeletedEmployee;

  const EmployeeLoaded({
    required this.currentEmployees,
    required this.previousEmployees,
    this.lastDeletedEmployee,
  });

  @override
  List<Object?> get props => [currentEmployees, previousEmployees, lastDeletedEmployee];

  EmployeeLoaded copyWith({
    List<Employee>? currentEmployees,
    List<Employee>? previousEmployees,
    Employee? lastDeletedEmployee,
  }) {
    return EmployeeLoaded(
      currentEmployees: currentEmployees ?? this.currentEmployees,
      previousEmployees: previousEmployees ?? this.previousEmployees,
      lastDeletedEmployee: lastDeletedEmployee,
    );
  }
}

class EmployeeError extends EmployeeState {
  final String message;

  const EmployeeError(this.message);

  @override
  List<Object> get props => [message];
}
