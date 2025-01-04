import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../../auth/services/auth_service.dart';
import '../controllers/home_controller.dart';
import '../widgets/header_section.dart';
import '../widgets/priority_task_card.dart';
import '../widgets/daily_task_item.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authService = getIt<AuthService>();
  final _controller = HomeController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final user = _authService.value;
    if (user?.uid != null) {
      await _controller.loadData(user!.uid);
    }
  }

  Future<void> _refreshData() async {
    final user = _authService.value;
    if (user?.uid != null) {
      await _controller.loadData(user!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ValueListenableBuilder<User?>(
          valueListenable: _authService,
          builder: (context, firebaseUser, _) {
            if (_controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, _) {
                        print('Current user name: ${_controller.userName}'); // Debug print
                        return HeaderSection(
                          userName: _controller.userName,
                          onNotificationTap: () {
                            // Handle notification tap
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'My Priority Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _controller.priorityTasks.length,
                        itemBuilder: (context, index) {
                          final task = _controller.priorityTasks[index];
                          return PriorityTaskCard(
                            task: task,
                            onTap: () {
                              // Navigate to task detail
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Daily Task',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.dailyTasks.length,
                      itemBuilder: (context, index) {
                        final task = _controller.dailyTasks[index];
                        return DailyTaskItem(
                          task: task,
                          onToggle: () {
                            if (firebaseUser?.uid != null) {
                              _controller.toggleTaskStatus(
                                firebaseUser!.uid,
                                task.id,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/add-task');
          if (result != null && mounted) {
            await _loadInitialData();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 