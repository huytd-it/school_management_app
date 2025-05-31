import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// Date and time formatting utilities
class DateFormatter {
  /// Format date to string
  static String formatDate(DateTime date) {
    return DateFormat(AppConstants.dateFormat).format(date);
  }
  
  /// Format time to string
  static String formatTime(DateTime time) {
    return DateFormat(AppConstants.timeFormat).format(time);
  }
  
  /// Format date and time to string
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }
  
  /// Format to month and year
  static String formatMonthYear(DateTime date) {
    return DateFormat(AppConstants.monthYearFormat).format(date);
  }
  
  /// Format to day and month
  static String formatDayMonth(DateTime date) {
    return DateFormat(AppConstants.dayMonthFormat).format(date);
  }
  
  /// Parse date from string
  static DateTime? parseDate(String dateString) {
    try {
      return DateFormat(AppConstants.dateFormat).parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  /// Parse time from string
  static DateTime? parseTime(String timeString) {
    try {
      return DateFormat(AppConstants.timeFormat).parse(timeString);
    } catch (e) {
      return null;
    }
  }
  
  /// Parse date and time from string
  static DateTime? parseDateTime(String dateTimeString) {
    try {
      return DateFormat(AppConstants.dateTimeFormat).parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }
  
  /// Get relative time string (e.g., "2 hours ago", "Yesterday")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 7) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else {
      return 'Just now';
    }
  }
  
  /// Get greeting based on time of day
  static String getGreeting() {
    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
  
  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  /// Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && 
           date.month == tomorrow.month && 
           date.day == tomorrow.day;
  }
  
  /// Get day of week name
  static String getDayOfWeek(DateTime date) {
    return DateFormat('EEEE').format(date);
  }
  
  /// Get short day of week name
  static String getShortDayOfWeek(DateTime date) {
    return DateFormat('EEE').format(date);
  }
  
  /// Get month name
  static String getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }
  
  /// Get short month name
  static String getShortMonthName(DateTime date) {
    return DateFormat('MMM').format(date);
  }
  
  /// Format duration to readable string
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ${minutes > 0 ? '$minutes min' : ''}';
    } else {
      return '$minutes ${minutes == 1 ? 'minute' : 'minutes'}';
    }
  }
  
  /// Get age from date of birth
  static int getAge(DateTime dateOfBirth) {
    final now = DateTime.now();
    int age = now.year - dateOfBirth.year;
    
    if (now.month < dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
      age--;
    }
    
    return age;
  }
  
  /// Get academic year string
  static String getAcademicYear(DateTime date) {
    final year = date.year;
    final month = date.month;
    
    // Assuming academic year starts in September
    if (month >= 9) {
      return '$year-${year + 1}';
    } else {
      return '${year - 1}-$year';
    }
  }
}