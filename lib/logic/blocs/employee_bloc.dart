import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/employee_repository.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _employeeRepository;

  EmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EmployeeInitial()) {
    on<LoadEmployees>(_onLoadEmployees);
    on<AddEmployee>(_onAddEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<DeleteEmployee>(_onDeleteEmployee);
    on<UndoDeleteEmployee>(_onUndoDeleteEmployee);
  }

  Future<void> _onLoadEmployees(
      LoadEmployees event,
      Emitter<EmployeeState> emit,
      ) async {
    emit(EmployeeLoading());
    try {
      final currentEmployees = await _employeeRepository.getCurrentEmployees();
      final previousEmployees = await _employeeRepository.getPreviousEmployees();
      emit(EmployeeLoaded(
        currentEmployees: currentEmployees,
        previousEmployees: previousEmployees,
      ));
    } catch (e) {
      emit(EmployeeError('Failed to load employees: ${e.toString()}'));
    }
  }

  Future<void> _onAddEmployee(
      AddEmployee event,
      Emitter<EmployeeState> emit,
      ) async {
    if (state is EmployeeLoaded) {
      try {
        await _employeeRepository.addEmployee(event.employee);
        add(LoadEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to add employee: ${e.toString()}'));
      }
    }
  }

  Future<void> _onUpdateEmployee(
      UpdateEmployee event,
      Emitter<EmployeeState> emit,
      ) async {
    if (state is EmployeeLoaded) {
      try {
        await _employeeRepository.updateEmployee(event.employee);
        add(LoadEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to update employee: ${e.toString()}'));
      }
    }
  }

  Future<void> _onDeleteEmployee(
      DeleteEmployee event,
      Emitter<EmployeeState> emit,
      ) async {
    if (state is EmployeeLoaded) {
      final currentState = state as EmployeeLoaded;
      try {
        // Find the employee to delete
        final employeeToDelete = [...currentState.currentEmployees, ...currentState.previousEmployees]
            .firstWhere((e) => e.id == event.id);

        await _employeeRepository.deleteEmployee(event.id);

        // Update state with the deleted employee for undo functionality
        final updatedCurrentEmployees = await _employeeRepository.getCurrentEmployees();
        final updatedPreviousEmployees = await _employeeRepository.getPreviousEmployees();

        emit(EmployeeLoaded(
          currentEmployees: updatedCurrentEmployees,
          previousEmployees: updatedPreviousEmployees,
          lastDeletedEmployee: employeeToDelete,
        ));
      } catch (e) {
        emit(EmployeeError('Failed to delete employee: ${e.toString()}'));
      }
    }
  }

  Future<void> _onUndoDeleteEmployee(
      UndoDeleteEmployee event,
      Emitter<EmployeeState> emit,
      ) async {
    if (state is EmployeeLoaded) {
      try {
        await _employeeRepository.addEmployee(event.employee);
        add(LoadEmployees());
      } catch (e) {
        emit(EmployeeError('Failed to undo delete: ${e.toString()}'));
      }
    }
  }
}