import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // App Name
      'app_name': 'Task Management',
      'task_wan': 'TASK-WAN',
      'management_app': 'Management App',

      // Common
      'error': 'Error',
      'success': 'Success',
      'loading': 'Loading...',
      'submit': 'Submit',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'back': 'Back',
      'next': 'Next',
      'done': 'Done',
      'offline': 'Offline',
      'active_now': 'Active now',

      // Auth
      'login': 'Login',
      'register': 'Register',
      'forgot_password': 'Forgot Password?',
      'or_login_with': 'Or Login with',
      'or_register_with': 'Or Register with',
      'dont_have_account': 'Don\'t have an account?',
      'already_have_account': 'Already have an account?',
      'create_account': 'Create your account',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'username': 'Username',
      'remember_me': 'Remember me',
      'logout': 'Logout',
      'session_expired': 'Session expired',
      'verify_account': 'Verify Account',
      'verification_success': 'Your account has been\nVerified Successfully!',
      'go_to_home': 'Go to Home',

      // Verify Email
      'verify_email': 'Verify Email',
      'verify_email_message': 'Please check your email for the verification link.',
      'resend_verification_email': 'Resend Verification Email',


      // Login
      'login_to_your_account': 'Login to your account', 
      'login_to_your_account_message': 'Please enter your email and password to login.',

      // Register



      // Profile
      'profile': 'Profile',
      'my_profile': 'My Profile',
      'edit_profile': 'Edit Profile',
      'occupation': 'Occupation',
      'location': 'Location',
      'tasks_completed': 'Task Completed',
      'photo': 'Photo',
      'take_photo': 'Take Photo',
      'choose_from_gallery': 'Choose from Gallery',
      'remove_photo': 'Remove Photo',

      // Settings
      'settings': 'Settings',
      'notification': 'Notification',
      'security': 'Security',
      'language': 'Language',
      'help': 'Help',
      'about': 'About',
      'notification_tone': 'Notification Tone',
      'vibrate': 'Vibrate',
      'popup_notification': 'Pop up Notification',
      'high_priority': 'Use High Priority Notification',
      'notification_preview': 'Show previews of notification on the top\nof the screen',

      // Security
      'current_password': 'Current Password',
      'new_password': 'New Password',
      'password_changed': 'Password changed successfully',
      'password_error': 'Failed to change password',
      'password_mismatch': 'Passwords do not match',
      'fill_all_fields': 'Please fill all fields',
      'login_activity': 'Login Activity',

      // Language
      'english': 'English',
      'vietnamese': 'Vietnamese',
      'language_changed': 'Language changed successfully',
      'language_error': 'Failed to change language',

      // Tasks
      'tasks': 'Tasks',
      'add_task': 'Add Task',
      'edit_task': 'Edit Task',
      'task_detail': 'Task Detail',
      'task_name': 'Task Name',
      'description': 'Description',
      'due_date': 'Due Date',
      'priority': 'Priority',
      'progress': 'Progress',
      'todo_list': 'Todo List',
      'add_todo': 'Add Todo',
      'start': 'Start',
      'end': 'End',
      'high': 'High',
      'medium': 'Medium',
      'low': 'Low',

      // Statistics
      'statistics': 'Statistics',
      'total_tasks': 'Total Tasks',
      'completed_tasks': 'Completed Tasks',
      'monthly_progress': 'Monthly Progress',

      // Calendar
      'calendar': 'Calendar',
      'today': 'Today',
      'upcoming': 'Upcoming',
      'completed': 'Completed',
      'overdue': 'Overdue',

      // Error Messages
      'error_loading_user': 'Error loading user data: ',
      'error_logout': 'Error during logout: ',
      'error_location': 'Error getting location: ',
      'unknown_location': 'Unknown Location',
      'location_disabled': 'Location services are disabled',
      'location_permission_denied': 'Location permissions are denied',

      // Home
      'welcome': 'Welcome',
      'have_a_good_day': 'Have a good day!',
      'priority_task': 'Priority Task',
      'daily_task': 'Daily Task',
      'add_new': 'Add New',
      'no_priority_tasks': 'No priority tasks',
      'no_daily_tasks': 'No daily tasks',
      'days_left': 'days left',
    },

    'vi': {
      // App Name
      'app_name': 'Quản lý công việc',
      'task_wan': 'TASK-WAN',
      'management_app': 'Ứng dụng Quản lý',

      // Home
      'welcome': 'Chào mừng',
      'have_a_good_day': 'Hãy có một ngày tốt lành!',
      'priority_task': 'Công việc ưu tiên',
      'daily_task': 'Công việc hàng ngày',
      'add_new': 'Thêm mới',
      'no_priority_tasks': 'Không có công việc ưu tiên',
      'no_daily_tasks': 'Không có công việc hàng ngày',
      'progress': 'Tiến độ',
      'overdue': 'Quá hạn',
      'days_left': 'ngày còn lại',
      

      // Login
      'login': 'Đăng nhập',
      'or_login_with': 'Hoặc đăng nhập bằng',
      'dont_have_account': 'Chưa có tài khoản?',
      'already_have_account': 'Đã có tài khoản?',
      'create_account': 'Tạo tài khoản của bạn',
      'password': 'Mật khẩu',
      'remember_me': 'Ghi nhớ đăng nhập',
      'logout': 'Đăng xuất',
      'session_expired': 'Phiên đăng nhập đã hết hạn',
      'verify_account': 'Xác thực tài khoản',

      // Register
      'register': 'Đăng ký',
      'or_register_with': 'Hoặc đăng ký bằng',
      'confirm_password': 'Xác nhận mật khẩu',

      // Common
      'error': 'Lỗi',
      'success': 'Thành công',
      'loading': 'Đang tải...',
      'submit': 'Xác nhận',
      'cancel': 'Hủy',
      'save': 'Lưu',
      'delete': 'Xóa',
      'edit': 'Sửa',
      'back': 'Quay lại',
      'next': 'Tiếp theo',
      'done': 'Xong',
      'offline': 'Ngoại tuyến',
      'active_now': 'Đang hoạt động',

      // Auth
      'verification_success': 'Tài khoản của bạn đã được\nXác thực thành công!',
      'go_to_home': 'Về trang chủ',

      // Profile
      'profile': 'Hồ sơ',
      'my_profile': 'Hồ sơ của tôi',
      'edit_profile': 'Chỉnh sửa hồ sơ',
      'occupation': 'Nghề nghiệp',
      'location': 'Vị trí',
      'tasks_completed': 'Công việc đã hoàn thành',
      'photo': 'Ảnh',
      'take_photo': 'Chụp ảnh',
      'choose_from_gallery': 'Chọn từ thư viện',
      'remove_photo': 'Xóa ảnh',

      // Settings
      'settings': 'Cài đặt',
      'notification': 'Thông báo',
      'security': 'Bảo mật',
      'language': 'Ngôn ngữ',
      'help': 'Trợ giúp',
      'about': 'Thông tin',
      'notification_tone': 'Âm thanh thông báo',
      'vibrate': 'Rung',
      'popup_notification': 'Thông báo popup',
      'high_priority': 'Sử dụng thông báo ưu tiên cao',
      'notification_preview': 'Hiển thị xem trước thông báo ở\nđầu màn hình',

      // Security
      'current_password': 'Mật khẩu hiện tại',
      'new_password': 'Mật khẩu mới',
      'password_changed': 'Đổi mật khẩu thành công',
      'password_error': 'Đổi mật khẩu thất bại',
      'password_mismatch': 'Mật khẩu không khớp',
      'fill_all_fields': 'Vui lòng điền đầy đủ thông tin',
      'login_activity': 'Hoạt động đăng nhập',

      // Language
      'english': 'Tiếng Anh',
      'vietnamese': 'Tiếng Việt',
      'language_changed': 'Đã thay đổi ngôn ngữ',
      'language_error': 'Không thể thay đổi ngôn ngữ',

      // Tasks
      'tasks': 'Công việc',
      'add_task': 'Thêm công việc',
      'edit_task': 'Sửa công việc',
      'task_detail': 'Chi tiết công việc',
      'task_name': 'Tên công việc',
      'description': 'Mô tả',
      'due_date': 'Hạn chót',
      'priority': 'Độ ưu tiên',
      'todo_list': 'Danh sách việc cần làm',
      'add_todo': 'Thêm việc cần làm',
      'start': 'Bắt đầu',
      'end': 'Kết thúc',
      'high': 'Cao',
      'medium': 'Trung bình',
      'low': 'Thấp',

      // Statistics
      'statistics': 'Thống kê',
      'total_tasks': 'Tổng số công việc',
      'completed_tasks': 'Công việc đã hoàn thành',
      'monthly_progress': 'Tiến độ theo tháng',

      // Calendar
      'calendar': 'Lịch',
      'today': 'Hôm nay',
      'upcoming': 'Sắp tới',
      'completed': 'Đã hoàn thành',

      // Error Messages
      'error_loading_user': 'Lỗi tải dữ liệu người dùng: ',
      'error_logout': 'Lỗi khi đăng xuất: ',
      'error_location': 'Lỗi lấy vị trí: ',
      'unknown_location': 'Vị trí không xác định',
      'location_disabled': 'Dịch vụ vị trí bị tắt',
      'location_permission_denied': 'Quyền truy cập vị trí bị từ chối',
    },
  };
} 