/// API Constants for the School ERP System
/// Contains all API-related constants and endpoints
class ApiConstants {
  // Base configuration
  static const String baseUrl = 'https://api.schoolerp.com/v1';
  static const int connectTimeout = 30;
  static const int receiveTimeout = 30;
  static const int sendTimeout = 30;
  
  // API Version
  static const String apiVersion = 'v1';
  
  // Authentication endpoints
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerification = '/auth/resend-verification';
  
  // User Management endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String changePassword = '/user/change-password';
  static const String uploadAvatar = '/user/avatar';
  static const String users = '/users';
  static const String userById = '/users/{id}';
  
  // Role and Permission endpoints
  static const String roles = '/roles';
  static const String permissions = '/permissions';
  static const String assignRole = '/users/{id}/roles';
  static const String revokeRole = '/users/{id}/roles/{roleId}';
  
  // Academic Management endpoints
  static const String students = '/academic/students';
  static const String teachers = '/academic/teachers';
  static const String classes = '/academic/classes';
  static const String subjects = '/academic/subjects';
  static const String curriculum = '/academic/curriculum';
  static const String grades = '/academic/grades';
  static const String attendance = '/academic/attendance';
  
  // Finance Management endpoints
  static const String fees = '/finance/fees';
  static const String payments = '/finance/payments';
  static const String payroll = '/finance/payroll';
  static const String budget = '/finance/budget';
  static const String financialReports = '/finance/reports';
  
  // Administration endpoints
  static const String announcements = '/admin/announcements';
  static const String events = '/admin/events';
  static const String facilities = '/admin/facilities';
  static const String inventory = '/admin/inventory';
  
  // Communication endpoints
  static const String messages = '/communication/messages';
  static const String notifications = '/communication/notifications';
  static const String parentPortal = '/communication/parent-portal';
  
  // File Management endpoints
  static const String uploadFile = '/files/upload';
  static const String downloadFile = '/files/download';
  static const String deleteFile = '/files/{id}';
  
  // Dashboard endpoints
  static const String dashboard = '/dashboard';
  static const String adminDashboard = '/dashboard/admin';
  static const String teacherDashboard = '/dashboard/teacher';
  static const String studentDashboard = '/dashboard/student';
  static const String parentDashboard = '/dashboard/parent';
  
  // Reports endpoints
  static const String reports = '/reports';
  static const String academicReports = '/reports/academic';
  static const String attendanceReports = '/reports/attendance';
  static const String gradeReports = '/reports/grades';
  
  // Search and Filter endpoints
  static const String search = '/search';
  static const String filters = '/filters';
  
  // System Configuration endpoints
  static const String settings = '/system/settings';
  static const String backup = '/system/backup';
  static const String systemInfo = '/system/info';
  
  // Utility methods
  static String userByIdUrl(String id) => userById.replaceAll('{id}', id);
  static String assignRoleUrl(String userId) => assignRole.replaceAll('{id}', userId);
  static String revokeRoleUrl(String userId, String roleId) => 
      revokeRole.replaceAll('{id}', userId).replaceAll('{roleId}', roleId);
  static String deleteFileUrl(String fileId) => deleteFile.replaceAll('{id}', fileId);
  
  // HTTP Status Codes
  static const int statusOk = 200;
  static const int statusCreated = 201;
  static const int statusNoContent = 204;
  static const int statusBadRequest = 400;
  static const int statusUnauthorized = 401;
  static const int statusForbidden = 403;
  static const int statusNotFound = 404;
  static const int statusUnprocessableEntity = 422;
  static const int statusInternalServerError = 500;
  
  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String userAgentHeader = 'User-Agent';
  
  // Content Types
  static const String jsonContentType = 'application/json';
  static const String formDataContentType = 'multipart/form-data';
  static const String urlEncodedContentType = 'application/x-www-form-urlencoded';
}