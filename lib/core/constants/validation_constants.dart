/// Validation Constants for the School ERP System
/// Contains all validation rules, patterns, and error messages
class ValidationConstants {
  // Email validation
  static const String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String emailErrorMessage = 'Please enter a valid email address';
  
  // Password validation
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;
  static const String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]';
  static const String passwordErrorMessage = 'Password must contain at least 8 characters, including uppercase, lowercase, number and special character';
  static const String passwordWeakMessage = 'Password is too weak';
  static const String passwordMismatchMessage = 'Passwords do not match';
  
  // Phone number validation
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String phoneErrorMessage = 'Please enter a valid phone number';
  static const int phoneMinLength = 10;
  static const int phoneMaxLength = 15;
  
  // Name validation
  static const int nameMinLength = 2;
  static const int nameMaxLength = 50;
  static const String namePattern = r'^[a-zA-Z\s]+$';
  static const String nameErrorMessage = 'Name must contain only letters and spaces';
  static const String firstNameRequiredMessage = 'First name is required';
  static const String lastNameRequiredMessage = 'Last name is required';
  
  // Student ID validation
  static const String studentIdPattern = r'^[A-Z]{2}\d{6}$';
  static const String studentIdErrorMessage = 'Student ID must be in format: AB123456';
  static const int studentIdLength = 8;
  
  // Employee ID validation
  static const String employeeIdPattern = r'^EMP\d{6}$';
  static const String employeeIdErrorMessage = 'Employee ID must be in format: EMP123456';
  static const int employeeIdLength = 9;
  
  // Age validation
  static const int minStudentAge = 3;
  static const int maxStudentAge = 25;
  static const int minTeacherAge = 21;
  static const int maxTeacherAge = 70;
  static const String ageErrorMessage = 'Please enter a valid age';
  
  // Grade validation
  static const double minGrade = 0.0;
  static const double maxGrade = 100.0;
  static const String gradeErrorMessage = 'Grade must be between 0 and 100';
  
  // Percentage validation
  static const double minPercentage = 0.0;
  static const double maxPercentage = 100.0;
  static const String percentageErrorMessage = 'Percentage must be between 0 and 100';
  
  // Fee validation
  static const double minFeeAmount = 0.0;
  static const double maxFeeAmount = 999999.99;
  static const String feeAmountErrorMessage = 'Please enter a valid fee amount';
  
  // Salary validation
  static const double minSalary = 0.0;
  static const double maxSalary = 9999999.99;
  static const String salaryErrorMessage = 'Please enter a valid salary amount';
  
  // Address validation
  static const int addressMinLength = 10;
  static const int addressMaxLength = 200;
  static const String addressErrorMessage = 'Address must be between 10 and 200 characters';
  
  // Class name validation
  static const String classNamePattern = r'^[A-Z0-9\s-]+$';
  static const String classNameErrorMessage = 'Class name must contain only letters, numbers, spaces and hyphens';
  
  // Subject code validation
  static const String subjectCodePattern = r'^[A-Z]{2,4}\d{3}$';
  static const String subjectCodeErrorMessage = 'Subject code must be in format: CS101, MATH201, etc.';
  
  // Room number validation
  static const String roomNumberPattern = r'^[A-Z]?\d{1,4}[A-Z]?$';
  static const String roomNumberErrorMessage = 'Room number must be in format: 101, A201, 301B, etc.';
  
  // Date validation
  static const String dateErrorMessage = 'Please select a valid date';
  static const String birthDateErrorMessage = 'Please select a valid birth date';
  static const String futureDateErrorMessage = 'Date cannot be in the future';
  static const String pastDateErrorMessage = 'Date cannot be in the past';
  
  // Time validation
  static const String timeErrorMessage = 'Please select a valid time';
  static const String startTimeErrorMessage = 'Start time cannot be after end time';
  static const String endTimeErrorMessage = 'End time cannot be before start time';
  
  // File validation
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif'];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx'];
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB
  static const String fileTypeErrorMessage = 'File type not allowed';
  static const String fileSizeErrorMessage = 'File size exceeds the limit';
  
  // URL validation
  static const String urlPattern = r'^https?:\/\/[^\s/$.?#].[^\s]*$';
  static const String urlErrorMessage = 'Please enter a valid URL';
  
  // Required field messages
  static const String requiredFieldMessage = 'This field is required';
  static const String emailRequiredMessage = 'Email is required';
  static const String passwordRequiredMessage = 'Password is required';
  static const String phoneRequiredMessage = 'Phone number is required';
  static const String nameRequiredMessage = 'Name is required';
  static const String addressRequiredMessage = 'Address is required';
  static const String dateRequiredMessage = 'Date is required';
  static const String timeRequiredMessage = 'Time is required';
  static const String subjectRequiredMessage = 'Subject is required';
  static const String classRequiredMessage = 'Class is required';
  static const String roleRequiredMessage = 'Role is required';
  
  // Length validation messages
  static const String minLengthMessage = 'Must be at least {min} characters';
  static const String maxLengthMessage = 'Must not exceed {max} characters';
  static const String exactLengthMessage = 'Must be exactly {length} characters';
  
  // Number validation messages
  static const String minValueMessage = 'Must be at least {min}';
  static const String maxValueMessage = 'Must not exceed {max}';
  static const String invalidNumberMessage = 'Please enter a valid number';
  
  // Selection validation messages
  static const String selectionRequiredMessage = 'Please make a selection';
  static const String multipleSelectionMessage = 'Please select at least one option';
  
  // Custom validation patterns
  static const String alphaNumericPattern = r'^[a-zA-Z0-9]+$';
  static const String alphabeticPattern = r'^[a-zA-Z]+$';
  static const String numericPattern = r'^[0-9]+$';
  static const String alphaNumericSpacePattern = r'^[a-zA-Z0-9\s]+$';
  
  // Helper methods for validation
  static String getMinLengthMessage(int min) => minLengthMessage.replaceAll('{min}', min.toString());
  static String getMaxLengthMessage(int max) => maxLengthMessage.replaceAll('{max}', max.toString());
  static String getExactLengthMessage(int length) => exactLengthMessage.replaceAll('{length}', length.toString());
  static String getMinValueMessage(double min) => minValueMessage.replaceAll('{min}', min.toString());
  static String getMaxValueMessage(double max) => maxValueMessage.replaceAll('{max}', max.toString());
}