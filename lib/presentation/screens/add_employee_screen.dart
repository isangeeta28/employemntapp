import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../data/models/employee.dart';
import '../../logic/blocs/employee_bloc.dart';
import '../../logic/blocs/employee_event.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/role_selector_widget.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _nameController = TextEditingController();
  String _selectedRole = '';
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Add Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Employee name',
                prefixIcon: Icon(
                  Icons.person_outline,
                color: AppTheme.primaryColor,),
              ),
            ),
            const SizedBox(height: 16),

            // Role Field
            GestureDetector(
              onTap: () => _showRoleSelector(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.work_outline, color: AppTheme.primaryColor),
                    const SizedBox(width: 12),
                    Text(
                      _selectedRole.isEmpty ? 'Select role' : _selectedRole,
                      style: TextStyle(
                        color:  Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Date Range
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showDatePicker(context, isStartDate: true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_calendar_outlined, color: AppTheme.primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('d MMM yyyy').format(_startDate),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showDatePicker(context, isStartDate: false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.edit_calendar_outlined, color: AppTheme.primaryColor, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            _endDate == null
                                ? 'No date'
                                : DateFormat('d MMM yyyy').format(_endDate!),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onPressed: () => Navigator.pop(context),
                child:  Text(
                  'Cancel',
                style: TextStyle(
                  color: AppTheme.primaryColor
                ),),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _saveEmployee,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRoleSelector(BuildContext context) async {
    final selectedRole = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => const RoleSelectorWidget(),
    );

    if (selectedRole != null) {
      setState(() {
        _selectedRole = selectedRole;
      });
    }
  }

  void _showDatePicker(BuildContext context, {required bool isStartDate}) async {
    final selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: DatePickerWidget(
          initialDate: isStartDate ? _startDate : _endDate,
          firstDate: isStartDate ? DateTime(2020) : _startDate,
          lastDate: DateTime(2030),
          isStartDate: isStartDate,
        ),
      ),
    );

    if (selectedDate != null || !isStartDate) {
      setState(() {
        if (isStartDate) {
          _startDate = selectedDate!;
          // If end date exists and is before the new start date, reset it
          if (_endDate != null && _endDate!.isBefore(_startDate)) {
            _endDate = null;
          }
        } else {
          _endDate = selectedDate;
        }
      });
    }
  }

  void _saveEmployee() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter employee name')),
      );
      return;
    }

    if (_selectedRole.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }

    final employee = Employee.create(
      name: _nameController.text.trim(),
      role: _selectedRole,
      startDate: _startDate,
      endDate: _endDate,
    );

    context.read<EmployeeBloc>().add(AddEmployee(employee));
    Navigator.pop(context);
  }
}

