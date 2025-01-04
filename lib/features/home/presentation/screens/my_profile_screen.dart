import 'package:flutter/material.dart';
import '../../../../core/di/service_locator.dart';
import '../../services/user_service.dart';
import '../../../auth/services/auth_service.dart';
import '../widgets/profile_text_field.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _userService = getIt<UserService>();
  final _authService = getIt<AuthService>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _occupationController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final user = _userService.value;
    if (user != null) {
      _nameController.text = user.name;
      _emailController.text = user.email;
      _occupationController.text = user.occupation;
      _locationController.text = user.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0066FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              try {
                await _authService.signOut();
                if (mounted) {
                  await Navigator.of(context).pushReplacementNamed('/login');
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _userService,
        builder: (context, user, _) {
          if (_userService.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (user == null) {
            return const Center(child: Text('No user data found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileHeader(user),
                const SizedBox(height: 24),
                ProfileTextField(
                  label: 'Name',
                  controller: _nameController,
                ),
                const SizedBox(height: 16),
                ProfileTextField(
                  label: 'Email',
                  controller: _emailController,
                  enabled: false,
                ),
                const SizedBox(height: 16),
                ProfileTextField(
                  label: 'Occupation',
                  controller: _occupationController,
                ),
                const SizedBox(height: 16),
                ProfileTextField(
                  label: 'Location',
                  controller: _locationController,
                ),
                const SizedBox(height: 24),
                _buildSaveButton(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(user) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.photoUrl != null
                ? NetworkImage(user.photoUrl)
                : null,
            child: user.photoUrl == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _updateProfileImage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF0066FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProfileImage() async {
    // Implement image picker and update logic
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _handleSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0066FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    try {
      final updatedUser = _userService.value?.copyWith(
        name: _nameController.text,
        occupation: _occupationController.text,
        location: _locationController.text,
      );

      if (updatedUser != null) {
        await _userService.updateUser(updatedUser);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully')),
          );
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _occupationController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}