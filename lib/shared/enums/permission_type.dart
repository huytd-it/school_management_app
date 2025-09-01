/// Permission types enumeration for the School ERP System
/// Defines all available permissions with their scopes and actions
enum PermissionType {
  // User Management Permissions
  userCreate('user.create', 'Create Users', 'User Management'),
  userRead('user.read', 'View Users', 'User Management'),
  userUpdate('user.update', 'Update Users', 'User Management'),
  userDelete('user.delete', 'Delete Users', 'User Management'),
  userAssignRole('user.assign_role', 'Assign Roles', 'User Management'),
  
  // Student Management Permissions
  studentCreate('student.create', 'Create Students', 'Student Management'),
  studentRead('student.read', 'View Students', 'Student Management'),
  studentUpdate('student.update', 'Update Students', 'Student Management'),
  studentDelete('student.delete', 'Delete Students', 'Student Management'),
  studentEnroll('student.enroll', 'Enroll Students', 'Student Management'),
  studentTransfer('student.transfer', 'Transfer Students', 'Student Management'),
  
  // Teacher Management Permissions
  teacherCreate('teacher.create', 'Create Teachers', 'Teacher Management'),
  teacherRead('teacher.read', 'View Teachers', 'Teacher Management'),
  teacherUpdate('teacher.update', 'Update Teachers', 'Teacher Management'),
  teacherDelete('teacher.delete', 'Delete Teachers', 'Teacher Management'),
  teacherAssignClass('teacher.assign_class', 'Assign Classes', 'Teacher Management'),
  
  // Academic Management Permissions
  classCreate('class.create', 'Create Classes', 'Academic Management'),
  classRead('class.read', 'View Classes', 'Academic Management'),
  classUpdate('class.update', 'Update Classes', 'Academic Management'),
  classDelete('class.delete', 'Delete Classes', 'Academic Management'),
  
  subjectCreate('subject.create', 'Create Subjects', 'Academic Management'),
  subjectRead('subject.read', 'View Subjects', 'Academic Management'),
  subjectUpdate('subject.update', 'Update Subjects', 'Academic Management'),
  subjectDelete('subject.delete', 'Delete Subjects', 'Academic Management'),
  
  curriculumCreate('curriculum.create', 'Create Curriculum', 'Academic Management'),
  curriculumRead('curriculum.read', 'View Curriculum', 'Academic Management'),
  curriculumUpdate('curriculum.update', 'Update Curriculum', 'Academic Management'),
  curriculumDelete('curriculum.delete', 'Delete Curriculum', 'Academic Management'),
  
  // Attendance Permissions
  attendanceCreate('attendance.create', 'Create Attendance', 'Attendance'),
  attendanceRead('attendance.read', 'View Attendance', 'Attendance'),
  attendanceUpdate('attendance.update', 'Update Attendance', 'Attendance'),
  attendanceDelete('attendance.delete', 'Delete Attendance', 'Attendance'),
  attendanceReport('attendance.report', 'Generate Reports', 'Attendance'),
  
  // Grades Permissions
  gradeCreate('grade.create', 'Create Grades', 'Grades'),
  gradeRead('grade.read', 'View Grades', 'Grades'),
  gradeUpdate('grade.update', 'Update Grades', 'Grades'),
  gradeDelete('grade.delete', 'Delete Grades', 'Grades'),
  gradeReport('grade.report', 'Generate Reports', 'Grades'),
  gradePublish('grade.publish', 'Publish Grades', 'Grades'),
  
  // Finance Management Permissions
  feeCreate('fee.create', 'Create Fees', 'Finance Management'),
  feeRead('fee.read', 'View Fees', 'Finance Management'),
  feeUpdate('fee.update', 'Update Fees', 'Finance Management'),
  feeDelete('fee.delete', 'Delete Fees', 'Finance Management'),
  feeCollect('fee.collect', 'Collect Fees', 'Finance Management'),
  
  paymentCreate('payment.create', 'Create Payments', 'Finance Management'),
  paymentRead('payment.read', 'View Payments', 'Finance Management'),
  paymentUpdate('payment.update', 'Update Payments', 'Finance Management'),
  paymentDelete('payment.delete', 'Delete Payments', 'Finance Management'),
  paymentApprove('payment.approve', 'Approve Payments', 'Finance Management'),
  
  payrollCreate('payroll.create', 'Create Payroll', 'Finance Management'),
  payrollRead('payroll.read', 'View Payroll', 'Finance Management'),
  payrollUpdate('payroll.update', 'Update Payroll', 'Finance Management'),
  payrollDelete('payroll.delete', 'Delete Payroll', 'Finance Management'),
  payrollProcess('payroll.process', 'Process Payroll', 'Finance Management'),
  
  // Administration Permissions
  announcementCreate('announcement.create', 'Create Announcements', 'Administration'),
  announcementRead('announcement.read', 'View Announcements', 'Administration'),
  announcementUpdate('announcement.update', 'Update Announcements', 'Administration'),
  announcementDelete('announcement.delete', 'Delete Announcements', 'Administration'),
  announcementPublish('announcement.publish', 'Publish Announcements', 'Administration'),
  
  eventCreate('event.create', 'Create Events', 'Administration'),
  eventRead('event.read', 'View Events', 'Administration'),
  eventUpdate('event.update', 'Update Events', 'Administration'),
  eventDelete('event.delete', 'Delete Events', 'Administration'),
  eventManage('event.manage', 'Manage Events', 'Administration'),
  
  facilityCreate('facility.create', 'Create Facilities', 'Administration'),
  facilityRead('facility.read', 'View Facilities', 'Administration'),
  facilityUpdate('facility.update', 'Update Facilities', 'Administration'),
  facilityDelete('facility.delete', 'Delete Facilities', 'Administration'),
  facilityBook('facility.book', 'Book Facilities', 'Administration'),
  
  inventoryCreate('inventory.create', 'Create Inventory', 'Administration'),
  inventoryRead('inventory.read', 'View Inventory', 'Administration'),
  inventoryUpdate('inventory.update', 'Update Inventory', 'Administration'),
  inventoryDelete('inventory.delete', 'Delete Inventory', 'Administration'),
  inventoryManage('inventory.manage', 'Manage Inventory', 'Administration'),
  
  // Communication Permissions
  messageCreate('message.create', 'Send Messages', 'Communication'),
  messageRead('message.read', 'View Messages', 'Communication'),
  messageUpdate('message.update', 'Update Messages', 'Communication'),
  messageDelete('message.delete', 'Delete Messages', 'Communication'),
  messageAll('message.all', 'Send to All', 'Communication'),
  
  notificationCreate('notification.create', 'Create Notifications', 'Communication'),
  notificationRead('notification.read', 'View Notifications', 'Communication'),
  notificationUpdate('notification.update', 'Update Notifications', 'Communication'),
  notificationDelete('notification.delete', 'Delete Notifications', 'Communication'),
  notificationSend('notification.send', 'Send Notifications', 'Communication'),
  
  // Reports Permissions
  reportGenerate('report.generate', 'Generate Reports', 'Reports'),
  reportView('report.view', 'View Reports', 'Reports'),
  reportExport('report.export', 'Export Reports', 'Reports'),
  reportSchedule('report.schedule', 'Schedule Reports', 'Reports'),
  reportAdmin('report.admin', 'Manage Reports', 'Reports'),
  
  // System Permissions
  systemSettings('system.settings', 'System Settings', 'System'),
  systemBackup('system.backup', 'System Backup', 'System'),
  systemRestore('system.restore', 'System Restore', 'System'),
  systemLogs('system.logs', 'View System Logs', 'System'),
  systemMaintenance('system.maintenance', 'System Maintenance', 'System'),
  
  // Dashboard Permissions
  dashboardAdmin('dashboard.admin', 'Admin Dashboard', 'Dashboard'),
  dashboardTeacher('dashboard.teacher', 'Teacher Dashboard', 'Dashboard'),
  dashboardStudent('dashboard.student', 'Student Dashboard', 'Dashboard'),
  dashboardParent('dashboard.parent', 'Parent Dashboard', 'Dashboard'),
  
  // Profile Permissions
  profileView('profile.view', 'View Profile', 'Profile'),
  profileUpdate('profile.update', 'Update Profile', 'Profile'),
  profilePassword('profile.password', 'Change Password', 'Profile'),
  profileAvatar('profile.avatar', 'Update Avatar', 'Profile');

  const PermissionType(this.value, this.displayName, this.module);

  final String value;
  final String displayName;
  final String module;

  /// Get permission from string value
  static PermissionType? fromString(String value) {
    try {
      return PermissionType.values.firstWhere(
        (permission) => permission.value == value,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get all permissions for a specific module
  static List<PermissionType> getByModule(String module) {
    return PermissionType.values
        .where((permission) => permission.module == module)
        .toList();
  }

  /// Get all available modules
  static List<String> getAllModules() {
    return PermissionType.values
        .map((permission) => permission.module)
        .toSet()
        .toList();
  }

  /// Check if this permission is a read permission
  bool get isReadPermission => value.endsWith('.read') || value.endsWith('.view');

  /// Check if this permission is a write permission
  bool get isWritePermission => 
      value.endsWith('.create') || 
      value.endsWith('.update') || 
      value.endsWith('.delete');

  /// Check if this permission is an admin permission
  bool get isAdminPermission => 
      module == 'System' || 
      value.contains('admin') || 
      value.endsWith('.admin');

  /// Get the action part of the permission
  String get action {
    final parts = value.split('.');
    return parts.length > 1 ? parts.last : value;
  }

  /// Get the resource part of the permission
  String get resource {
    final parts = value.split('.');
    return parts.length > 1 ? parts.first : value;
  }

  /// Get permission level (1 = read, 2 = write, 3 = admin)
  int get level {
    if (isAdminPermission) return 3;
    if (isWritePermission) return 2;
    if (isReadPermission) return 1;
    return 1;
  }

  /// Group permissions by module
  static Map<String, List<PermissionType>> groupByModule() {
    final grouped = <String, List<PermissionType>>{};
    
    for (final permission in PermissionType.values) {
      grouped.putIfAbsent(permission.module, () => []).add(permission);
    }
    
    return grouped;
  }

  /// Get CRUD permissions for a resource
  static List<PermissionType> getCrudPermissions(String resource) {
    return PermissionType.values
        .where((permission) => permission.resource == resource)
        .toList();
  }

  @override
  String toString() => displayName;
}