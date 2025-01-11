import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:mobile_app/core/routes/app_router.dart';
import '../../core/base/base_view.dart';
import '../../controllers/calendar_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../models/task.dart';


class CalendarScreen extends BaseView<CalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCalendar(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  _buildTaskList(true),
                  _buildTaskList(false),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.black87, size: 24),
              const SizedBox(width: 12),
              GetX<CalendarController>(
                builder: (controller) => Text(
                  controller.formatDate(controller.selectedDate.value).tr,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () => controller.addTask(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add, color: Colors.white, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    'add_task'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return DatePicker(
      DateTime(
        controller.selectedDate.value.year,
        controller.selectedDate.value.month,
        1,
      ),
      height: 100,
      width: 70,
      initialSelectedDate: controller.selectedDate.value,
      daysCount: DateTime(
        controller.selectedDate.value.year,
        controller.selectedDate.value.month + 1,
        0,
      ).day,
      selectionColor: AppColors.primary,
      selectedTextColor: Colors.white,
      dateTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      dayTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
      ),
      monthTextStyle: TextStyle(
        fontSize: 12,
        color: Colors.grey[600],
      ),
      onDateChange: (date) {
        controller.selectedDate.value = date;
      },
    );
  }

  Widget _buildWeekDayHeaders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ['Mon'.tr, 'Tue'.tr, 'Wed'.tr, 'Thu'.tr, 'Fri'.tr, 'Sat'.tr, 'Sun'.tr]
          .map((day) => SizedBox(
                width: 40,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ))
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    if (controller.tasks.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return Obx(() => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: controller.tasks.length,
        itemBuilder: (context, index) => _buildDateCell(controller.tasks[index]),
      ),
    );
  }

  Widget _buildDateCell(Task task) {

    return Obx(() {
    final isSelected = controller.isSameDay(task.dueDate, controller.selectedDate.value);
    final isToday = controller.isSameDay(task.dueDate, DateTime.now());
    final isCurrentMonth = task.dueDate.month == controller.selectedDate.value.month;
      return InkWell(
      onTap: () => controller.selectDate(task.dueDate),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isToday && !isSelected
              ? Border.all(color: AppColors.primary)
              : null,
        ),
        child: Center(
          child: Text(
            '${task.dueDate.day}',
            style: TextStyle(
              color: !isCurrentMonth
                  ? Colors.grey[300]
                  : isSelected
                      ? Colors.white
                      : Colors.black87,
              fontSize: 15,
              fontWeight: isSelected || isToday ? FontWeight.w600 : null,
            ),
          ),
        ),
      ),
    );},);
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: _buildTab('Priority Task'.tr, true),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildTab('Daily Task'.tr, false),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, bool isPriority) {
    return Obx(() {
      final isSelected = controller.isPrioritySelected.value == isPriority;
      return InkWell(
        onTap: () => controller.toggleTaskType(isPriority),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? AppColors.primary : Colors.grey[300]!,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTaskList(bool isPriority) {
    return Obx(() {
      final tasks = controller.tasks.where((task) => 
        isPriority ? task.type == 'Priority Task'.tr : task.type == 'Daily Task'.tr
      ).toList();

      if (tasks.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.task_outlined,
                size: 64,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 16),
              Text(
                'No ${isPriority ? 'priority'.tr : 'daily'.tr} tasks'.tr,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return InkWell(
            onTap: () => controller.goToTaskDetail(task),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.design_services,
                          color: AppColors.primary,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          task.title.tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                        ),
                        onPressed: () => controller.goToTaskDetail(task),
                      ),
                    ],
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Text(
                      task.description.tr,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${controller.formatShortDate(task.createdAt)} - ${controller.formatShortDate(task.dueDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.home_outlined, false, () => Get.offNamed(AppRouter.home)),
          _buildNavItem(Icons.calendar_today, true, () => Get.offNamed(AppRouter.calendar)),
          _buildNavItem(Icons.person_outline, false, () => Get.offNamed(AppRouter.profile)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? AppColors.primary : Colors.grey,
        size: 28,
      ),
    );
  }
}
