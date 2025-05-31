import '../constants/app_constants.dart';

/// Form validation utilities
class Validators {
  /// Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    
    return null;
  }
  
  /// Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < AppConstants.minPasswordLength) {
      return 'Password must be at least ${AppConstants.minPasswordLength} characters';
    }
    
    if (value.length > AppConstants.maxPasswordLength) {
      return 'Password must be less than ${AppConstants.maxPasswordLength} characters';
    }
    
    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    
    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    
    // Check for at least one digit
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }
    
    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    
    return null;
  }
  
  /// Confirm password validation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }
  
  /// Username validation
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    
    if (value.length < AppConstants.minUsernameLength) {
      return 'Username must be at least ${AppConstants.minUsernameLength} characters';
    }
    
    if (value.length > AppConstants.maxUsernameLength) {
      return 'Username must be less than ${AppConstants.maxUsernameLength} characters';
    }
    
    // Check for valid characters (alphanumeric and underscore)
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegex.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }
    
    return null;
  }
  
  /// Phone number validation
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    // Remove any non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length != AppConstants.phoneNumberLength) {
      return 'Please enter a valid ${AppConstants.phoneNumberLength}-digit phone number';
    }
    
    return null;
  }
  
  /// Name validation
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    if (value.length < 2) {
      return '$fieldName must be at least 2 characters';
    }
    
    // Check for valid characters (letters, spaces, hyphens, apostrophes)
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    if (!nameRegex.hasMatch(value)) {
      return '$fieldName can only contain letters, spaces, hyphens, and apostrophes';
    }
    
    return null;
  }
  
  /// Required field validation
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  /// Number validation
  static String? validateNumber(String? value, {
    String fieldName = 'Number',
    double? min,
    double? max,
  }) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    final number = double.tryParse(value);
    if (number == null) {
      return 'Please enter a valid number';
    }
    
    if (min != null && number < min) {
      return '$fieldName must be at least $min';
    }
    
    if (max != null && number > max) {
      return '$fieldName must be at most $max';
    }
    
    return null;
  }
  
  /// Date validation
  static String? validateDate(String? value, {String fieldName = 'Date'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    try {
      // Try to parse the date
      final parts = value.split('/');
      if (parts.length != 3) {
        return 'Please enter date in DD/MM/YYYY format';
      }
      
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      final date = DateTime(year, month, day);
      
      // Check if the date is valid
      if (date.day != day || date.month != month || date.year != year) {
        return 'Please enter a valid date';
      }
      
      return null;
    } catch (e) {
      return 'Please enter date in DD/MM/YYYY format';
    }
  }
  
  /// Age validation
  static String? validateAge(String? value, {
    int minAge = 3,
    int maxAge = 100,
  }) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    
    final age = int.tryParse(value);
    if (age == null) {
      return 'Please enter a valid age';
    }
    
    if (age < minAge) {
      return 'Age must be at least $minAge';
    }
    
    if (age > maxAge) {
      return 'Age must be at most $maxAge';
    }
    
    return null;
  }
  
  /// Student ID validation
  static String? validateStudentId(String? value) {
    if (value == null || value.isEmpty) {
      return 'Student ID is required';
    }
    
    // Example format: STU001, STU002, etc.
    final studentIdRegex = RegExp(r'^STU\d{3,}$');
    if (!studentIdRegex.hasMatch(value)) {
      return 'Invalid Student ID format (e.g., STU001)';
    }
    
    return null;
  }
  
  /// Percentage validation
  static String? validatePercentage(String? value, {String fieldName = 'Percentage'}) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    
    final percentage = double.tryParse(value);
    if (percentage == null) {
      return 'Please enter a valid percentage';
    }
    
    if (percentage < 0 || percentage > 100) {
      return '$fieldName must be between 0 and 100';
    }
    
    return null;
  }
}