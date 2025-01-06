import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/constants/app_colors.dart';

class CalendarPicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CalendarPicker({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildCalendar(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final month = DateFormat('MMMM, yyyy').format(selectedDate);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _onMonthChanged(-1),
        ),
        Text(
          month,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _onMonthChanged(1),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        _buildWeekDays(),
        const SizedBox(height: 8),
        _buildDays(),
      ],
    );
  }

  Widget _buildWeekDays() {
    const weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays
          .map((day) => SizedBox(
                width: 32,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildDays() {
    final daysInMonth = DateTime(
      selectedDate.year,
      selectedDate.month + 1,
      0,
    ).day;

    final firstDayOfMonth = DateTime(
      selectedDate.year,
      selectedDate.month,
      1,
    );

    final firstWeekday = firstDayOfMonth.weekday;
    final prevMonthDays = (firstWeekday + 6) % 7;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final day = index - prevMonthDays + 1;
        if (day < 1 || day > daysInMonth) {
          return const SizedBox();
        }

        final date = DateTime(selectedDate.year, selectedDate.month, day);
        final isSelected = _isSameDay(date, selectedDate);
        final isDisabled = _isDateDisabled(date);

        return GestureDetector(
          onTap: isDisabled ? null : () => onDateSelected(date),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                day.toString(),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : isDisabled
                          ? Colors.grey[400]
                          : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onMonthChanged(int delta) {
    final newDate = DateTime(
      selectedDate.year,
      selectedDate.month + delta,
      selectedDate.day,
    );
    onDateSelected(newDate);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isDateDisabled(DateTime date) {
    if (firstDate != null && date.isBefore(firstDate!)) return true;
    if (lastDate != null && date.isAfter(lastDate!)) return true;
    return false;
  }
} 