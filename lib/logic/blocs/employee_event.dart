import 'package:equatable/equatable.dart';
import '../../../data/models/employee.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object?> get props => [];
}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  const AddEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

class UpdateEmployee extends EmployeeEvent {
  final Employee employee;

  const UpdateEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}

class DeleteEmployee extends EmployeeEvent {
  final String id;

  const DeleteEmployee(this.id);

  @override
  List<Object> get props => [id];
}

class UndoDeleteEmployee extends EmployeeEvent {
  final Employee employee;

  const UndoDeleteEmployee(this.employee);

  @override
  List<Object> get props => [employee];
}
