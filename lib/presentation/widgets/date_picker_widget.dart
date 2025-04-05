import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/theme.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final bool isStartDate;

  const DatePickerWidget({
    super.key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.isStartDate,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _displayedMonth = widget.initialDate ?? DateTime.now();
    _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 380,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quick action buttons
            if (widget.isStartDate)
              _buildStartDateButtons()
            else
              _buildEndDateButtons(),

            // Month navigation
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _displayedMonth = DateTime(
                          _displayedMonth.year,
                          _displayedMonth.month - 1,
                        );
                      });
                    },
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(_displayedMonth),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _displayedMonth = DateTime(
                          _displayedMonth.year,
                          _displayedMonth.month + 1,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),

            // Weekday headers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Sun', style: TextStyle(fontSize: 12)),
                  Text('Mon', style: TextStyle(fontSize: 12)),
                  Text('Tue', style: TextStyle(fontSize: 12)),
                  Text('Wed', style: TextStyle(fontSize: 12)),
                  Text('Thu', style: TextStyle(fontSize: 12)),
                  Text('Fri', style: TextStyle(fontSize: 12)),
                  Text('Sat', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            // Improved calendar grid
            _buildAdaptiveCalendarGrid(context),

            // Selected date display and actions
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: AppTheme.primaryColor
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _selectedDate == null
                        ? 'No date'
                        : DateFormat('d MMM yyyy').format(_selectedDate!),
                    style: const TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightBlue,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel',
                      style: TextStyle(
                          color: AppTheme.primaryColor
                      ),),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, _selectedDate),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStartDateButtons() {
    return Column(
      children: [
        // First row
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime.now();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightBlue,
                    foregroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Today'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Find next Monday
                    final now = DateTime.now();
                    final daysUntilMonday = (8 - now.weekday) % 7;
                    final nextMonday = now.add(Duration(days: daysUntilMonday == 0 ? 7 : daysUntilMonday));

                    setState(() {
                      _selectedDate = nextMonday;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Next Monday'),
                ),
              ),
            ],
          ),
        ),

        // Second row
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Find next Tuesday
                    final now = DateTime.now();
                    final daysUntilTuesday = (9 - now.weekday) % 7;
                    final nextTuesday = now.add(Duration(days: daysUntilTuesday == 0 ? 7 : daysUntilTuesday));

                    setState(() {
                      _selectedDate = nextTuesday;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightBlue,
                    foregroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('Next Tuesday'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // One week from today
                    final oneWeekLater = DateTime.now().add(const Duration(days: 7));

                    setState(() {
                      _selectedDate = oneWeekLater;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.lightBlue,
                    foregroundColor: AppTheme.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text('After 1 week'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEndDateButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedDate = null;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('No date'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime.now();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5F5F5),
                foregroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text('Today'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final year = _displayedMonth.year;
    final month = _displayedMonth.month;

    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    // Calculate the first weekday
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.5,
      ),
      itemCount: 42, // 6 weeks * 7 days
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        // Calculate the day to display
        final dayOffset = index - firstWeekdayOfMonth;
        final day = dayOffset + 1;

        if (dayOffset < 0 || day > daysInMonth) {
          // Days outside the current month
          return const SizedBox();
        }

        final date = DateTime(year, month, day);
        final isSelected = _selectedDate != null &&
            _selectedDate!.year == date.year &&
            _selectedDate!.month == date.month &&
            _selectedDate!.day == date.day;
        final isToday = DateTime.now().year == date.year &&
            DateTime.now().month == date.month &&
            DateTime.now().day == date.day;

        // Check if date is in selectable range
        final isSelectable = !date.isBefore(widget.firstDate) &&
            !date.isAfter(widget.lastDate);

        return GestureDetector(
          onTap: isSelectable ? () {
            setState(() {
              _selectedDate = date;
            });
          } : null,
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppTheme.primaryColor
                  : (isToday ? AppTheme.primaryColor.withOpacity(0.2) : Colors.transparent),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? Colors.white
                      : (isSelectable ? Colors.black : Colors.grey),
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // New method for adaptive calendar display
  Widget _buildAdaptiveCalendarGrid(BuildContext context) {
    final year = _displayedMonth.year;
    final month = _displayedMonth.month;

    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    // Calculate the first weekday (0 = Sunday, 1 = Monday, etc.)
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;

    // Calculate the number of rows needed
    final numberOfRows = ((firstWeekdayOfMonth + daysInMonth - 1) / 7).ceil();

    return Container(
      height: 50.0 * numberOfRows, // Calculate height based on actual rows needed
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1.2,
        ),
        itemCount: 7 * numberOfRows, // Only show the rows we need
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final row = index ~/ 7;
          final col = index % 7;
          final dayNumber = index - firstWeekdayOfMonth + 1;

          if (dayNumber < 1 || dayNumber > daysInMonth) {
            return const SizedBox(); // Empty cell
          }

          final date = DateTime(year, month, dayNumber);
          final isSelected = _selectedDate != null &&
              _selectedDate!.year == date.year &&
              _selectedDate!.month == date.month &&
              _selectedDate!.day == date.day;
          final isToday = DateTime.now().year == date.year &&
              DateTime.now().month == date.month &&
              DateTime.now().day == date.day;

          // Check if date is in selectable range
          final isSelectable = !date.isBefore(widget.firstDate) &&
              !date.isAfter(widget.lastDate);

          return GestureDetector(
            onTap: isSelectable ? () {
              setState(() {
                _selectedDate = date;
              });
            } : null,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryColor
                    : (isToday ? AppTheme.primaryColor.withOpacity(0.2) : Colors.transparent),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  dayNumber.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected
                        ? Colors.white
                        : (isSelectable ? Colors.black : Colors.grey),
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}