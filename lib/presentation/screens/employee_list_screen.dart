import 'package:employmentapp/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/employee.dart';
import '../../logic/blocs/employee_bloc.dart';
import '../../logic/blocs/employee_event.dart';
import '../../logic/blocs/employee_state.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/employee_list_item.dart';
import 'add_employee_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: BlocConsumer<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeLoaded && state.lastDeletedEmployee != null) {
            _showUndoSnackBar(context, state.lastDeletedEmployee!);
          } else if (state is EmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is EmployeeInitial || state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            if (state.currentEmployees.isEmpty && state.previousEmployees.isEmpty) {
              return const EmptyStateWidget();
            }

            return ListView(
              //padding: const EdgeInsets.all(16),
              children: [
                SizedBox(height: 10.0,),
                if (state.currentEmployees.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0, left: 14.0),
                    child: Text(
                      'Current employees',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ...state.currentEmployees.map((employee) =>
                      Dismissible(
                        key: Key(employee.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<EmployeeBloc>().add(DeleteEmployee(employee.id));
                        },
                        child: EmployeeListItem(employee: employee),
                      ),
                  ).toList(),
                ],

                if (state.previousEmployees.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8, left: 14.0),
                    child: Text(
                      'Previous employees',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  ...state.previousEmployees.map((employee) =>
                      Dismissible(
                        key: Key(employee.id),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          context.read<EmployeeBloc>().add(DeleteEmployee(employee.id));
                        },
                        child: EmployeeListItem(employee: employee),
                      ),
                  ).toList(),
                ],

                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Swipe left to delete',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong!'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEmployeeScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddEmployeeScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddEmployeeScreen(),
      ),
    );
  }

  void _showUndoSnackBar(BuildContext context, Employee deletedEmployee) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Employee data has been deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            context
                .read<EmployeeBloc>()
                .add(UndoDeleteEmployee(deletedEmployee));
          },
        ),
      ),
    );
  }
}