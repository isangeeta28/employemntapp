import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';
import '../../data/models/employee.dart';
import '../../logic/blocs/employee_bloc.dart';
import '../../logic/blocs/employee_event.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/role_selector_widget.dart';

class EditEmployeeScreen extends StatefulWidget {
  final Employee employee;

  const EditEmployeeScreen({super.key, required this.employee,});

  @override
  State<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  late TextEditingController _nameController;
  late String _selectedRole;
  late DateTime _startDate;
  late DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _selectedRole = widget.employee.role;
    _startDate = widget.employee.startDate;
    _endDate = widget.employee.endDate;
  }

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
        title: const Text('Edit Employee Details'),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assests/images/Vector.svg"),
            onPressed: () => _confirmDelete(context),
          ),
        ],
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
                prefixIcon: Icon(Icons.person_outline,
                    color: AppTheme.primaryColor),
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
                      _selectedRole,
                      style: const TextStyle(fontSize: 16),
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
                          Icon(Icons.edit_calendar_outlined, color: AppTheme.primaryColor, size: 20),
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
                  // foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child:  Text('Cancel',
                style: TextStyle(
                  color: AppTheme.primaryColor
                ),),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _updateEmployee,
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
      builder: (context) => RoleSelectorWidget(initialRole: _selectedRole),
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

  void _updateEmployee() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter employee name')),
      );
      return;
    }

    final updatedEmployee = widget.employee.copyWith(
      name: _nameController.text.trim(),
      role: _selectedRole,
      startDate: _startDate,
      endDate: _endDate,
    );

    context.read<EmployeeBloc>().add(UpdateEmployee(updatedEmployee));
    Navigator.pop(context);
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: const Text(
          'Are you sure you want to delete this employee? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<EmployeeBloc>().add(DeleteEmployee(widget.employee.id));
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close edit screen
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}