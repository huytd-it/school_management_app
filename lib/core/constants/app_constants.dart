/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'School Management';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.schoolmanagement.com'; // Replace with actual API URL
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language_code';
  static const String firstTimeKey = 'first_time';
  
  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleTeacher = 'teacher';
  static const String roleStudent = 'student';
  static const String roleParent = 'parent';
  static const String roleStaff = 'staff';
  
  // Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'dd/MM/yyyy hh:mm a';
  static const String monthYearFormat = 'MMMM yyyy';
  static const String dayMonthFormat = 'dd MMM';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // File Upload
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];
  
  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 20;
  static const int phoneNumberLength = 10;
  
  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Attendance Status
  static const String attendancePresent = 'present';
  static const String attendanceAbsent = 'absent';
  static const String attendanceLate = 'late';
  static const String attendanceHoliday = 'holiday';
  static const String attendanceLeave = 'leave';
  
  // Fee Status
  static const String feePaid = 'paid';
  static const String feePending = 'pending';
  static const String feeOverdue = 'overdue';
  static const String feePartial = 'partial';
  
  // Grade Types
  static const String gradeTypeExam = 'exam';
  static const String gradeTypeAssignment = 'assignment';
  static const String gradeTypeQuiz = 'quiz';
  static const String gradeTypeProject = 'project';
  
  // Event Types
  static const String eventTypeAcademic = 'academic';
  static const String eventTypeSports = 'sports';
  static const String eventTypeCultural = 'cultural';
  static const String eventTypeHoliday = 'holiday';
  static const String eventTypeMeeting = 'meeting';
  
  // Notice Priority
  static const String noticePriorityHigh = 'high';
  static const String noticePriorityMedium = 'medium';
  static const String noticePriorityLow = 'low';
  
  // Academic Terms
  static const String termFirst = 'first';
  static const String termSecond = 'second';
  static const String termThird = 'third';
  static const String termFinal = 'final';
  
  // Days of Week
  static const List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  
  // Months
  static const List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  
  // Blood Groups
  static const List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  
  // Genders
  static const List<String> genders = [
    'Male',
    'Female',
    'Other',
  ];
}