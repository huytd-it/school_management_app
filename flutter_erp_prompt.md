

Hãy bắt đầu implementation từ Bước 1 với thiết lập design system, sau đó tiến hành từng module theo thứ tự. Mỗi component cần được test kỹ lưỡng về UI/UX và performance trước khi chuyển sang bước tiếp theo.🎨 Visual Identity
- **Primary Color**: #9eefe1 (Soft mint green - calming, educational)
- **Secondary Color**: #1b4664 (Deep navy - professional, trustworthy)
- **Design Philosophy**: Modern minimalism với soft aesthetics
- **Typography**: Inter + Plus Jakarta Sans cho professional yet friendly feel

### 🔧 Technical Architecture
- **Backend**: Existing REST API với JWT authentication
- **State Management**: Flutter Bloc pattern
- **Navigation**: Auto Route với custom transitions
- **API Layer**: Dio với interceptors cho token management
- **Local Storage**: Shared Preferences (no SQLite needed)

### 📱 UI Components
- **Cards**: Soft shadows, 16px border radius, glass morphism effects
- **Buttons**: Rounded (12px), elevation-free, với hover states
- **Input Fields**: Filled style với focus states
- **Navigation**: Modern bottom bar với floating elements
- **Animations**: Staggered animations, smooth page transitions
- **Loading States**: Shimmer effects, skeleton screens

### # Prompt Tạo Ứng Dụng Flutter Quản Lý Trường Học Hoàn Chỉnh

## Yêu cầu tổng quan
Hãy tạo một ứng dụng quản lý trường học (School Management System) hoàn chỉnh bằng Flutter với các module chính phục vụ cho việc quản lý học sinh, giáo viên, lớp học, điểm số, và các hoạt động giáo dục.

## Bước 1: Thiết lập dự án và cấu trúc thư mục

### 1.1 Khởi tạo dự án
```bash
flutter create school_management_app
cd school_management_app
```

### 1.2 Cấu trúc thư mục đề xuất
```
lib/
├── core/
│   ├── constants/
│   ├── utils/
│   ├── services/
│   └── config/
├── data/
│   ├── models/
│   ├── repositories/
│   └── datasources/
├── presentation/
│   ├── screens/
│   ├── widgets/
│   └── bloc/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── main.dart
```

### 1.3 Dependencies cần thiết
Hãy thêm các package sau vào pubspec.yaml:
- flutter_bloc (state management)
- dio (HTTP client) - đã có backend REST API
- shared_preferences (local storage)
- get_it (dependency injection)
- auto_route (navigation)
- json_annotation (JSON serialization)
- fl_chart (charts)
- pdf (PDF generation)
- excel (Excel export)
- image_picker (image handling)
- file_picker (file selection)
- url_launcher (external links)
- table_calendar (calendar widget)
- qr_flutter (QR code generation)
- mobile_scanner (QR code scanning)
- google_fonts (custom fonts)
- flutter_svg (SVG support)
- cached_network_image (image caching)
- shimmer (loading effects)
- animations (smooth transitions)
- flutter_staggered_animations (staggered animations)

### 1.4 Design System Setup
Tạo file `lib/core/theme/app_theme.dart` với color scheme và theme data:

## Bước 2: Thiết kế cơ sở dữ liệu và Models

### 2.1 Entities chính cần tạo
Tạo các model/entity sau với đầy đủ thuộc tính:

1. **User (Base class)**
   - id, username, email, phone, avatar, role, status, createdAt, updatedAt

2. **Student**
   - extends User
   - studentId, classId, parentId, dateOfBirth, address, bloodGroup, admissionDate, emergencyContact

3. **Teacher**
   - extends User
   - teacherId, subject[], qualification, experience, salary, joiningDate, department

4. **Parent**
   - extends User
   - parentId, profession, studentIds[]

5. **Admin/Staff**
   - extends User
   - staffId, department, designation, permissions[]

6. **Class**
   - id, name, section, grade, teacherId, capacity, academicYear, schedule

7. **Subject**
   - id, name, code, description, credits, department, grade

8. **Assignment**
   - id, title, description, subjectId, classId, teacherId, dueDate, totalMarks, instructions, attachments[]

9. **Grade/Score**
   - id, studentId, subjectId, examType, marks, totalMarks, grade, semester, academicYear

10. **Attendance**
    - id, studentId, classId, date, status, checkInTime, checkOutTime, remarks

11. **Exam**
    - id, name, type, subjectId, classId, date, duration, totalMarks, instructions

12. **Event**
    - id, title, description, date, startTime, endTime, type, targetAudience[], location

13. **Notice**
    - id, title, content, publishDate, targetAudience[], priority, attachments[]

14. **Fee**
    - id, studentId, feeType, amount, dueDate, paidDate, status, academicYear, semester

15. **Timetable**
    - id, classId, day, periods[], teacherId, subjectId, startTime, endTime, room

### 2.2 API Integration Setup
Vì đã có backend với JWT và REST API:
- Setup Dio interceptor cho JWT token handling
- Create API service classes cho từng module
- Implement token refresh mechanism
- Error handling cho API responses

### 2.3 Color Scheme và Design System
Tạo design system với màu sắc và typography nhất quán:

#### Color Palette:
```dart
class AppColors {
  // Primary Colors
  static const Color primaryMint = Color(0xFF9EEFE1);      // #9eefe1 - Màu chính
  static const Color primaryNavy = Color(0xFF1B4664);      // #1b4664 - Màu phụ
  
  // Tonal Variations
  static const Color mintLight = Color(0xFFE8FCF8);        // Light mint
  static const Color mintSoft = Color(0xFFD1F7EF);        // Soft mint
  static const Color navyLight = Color(0xFF4A6B85);       // Light navy
  static const Color navyDark = Color(0xFF0F2A3D);        // Dark navy
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFFAFBFC);
  static const Color lightGray = Color(0xFFF5F6F8);
  static const Color mediumGray = Color(0xFFE1E5E9);
  static const Color darkGray = Color(0xFF6B7280);
  static const Color charcoal = Color(0xFF374151);
  
  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
```

#### Typography System:
```dart
class AppTextStyles {
  static const String primaryFont = 'Inter';
  static const String headingFont = 'Plus Jakarta Sans';
  
  // Heading Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: headingFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryNavy,
    height: 1.2,
  );
  
  static const TextStyle h2 = TextStyle(
    fontFamily: headingFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryNavy,
    height: 1.3,
  );
  
  // Body Styles với modern feel
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.charcoal,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGray,
    height: 1.4,
  );
}
```

#### Component Styles:
```dart
class AppDecorations {
  // Card Styles với soft shadows
  static BoxDecoration softCard = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.primaryNavy.withOpacity(0.08),
        offset: Offset(0, 4),
        blurRadius: 24,
        spreadRadius: 0,
      ),
    ],
  );
  
  // Input Field Decoration
  static InputDecoration textFieldDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.lightGray,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primaryMint, width: 2),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
  
  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryMint,
    foregroundColor: AppColors.primaryNavy,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );
  
  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.lightGray,
    foregroundColor: AppColors.primaryNavy,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );
}
```

## Bước 3: UI/UX Design System Implementation

### 3.1 Modern Layout Patterns
Implement các design patterns hiện đại:

#### Dashboard Cards với Soft Aesthetics:
```dart
class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? accentColor;
  
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.softCard,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (accentColor ?? AppColors.primaryMint).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: accentColor ?? AppColors.primaryMint, size: 24),
          ),
          SizedBox(height: 16),
          Text(value, style: AppTextStyles.h2),
          SizedBox(height: 4),
          Text(title, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
```

#### Navigation với Modern Bottom Bar:
```dart
class ModernBottomNav extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNavy.withOpacity(0.1),
            offset: Offset(0, -4),
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard_rounded, 'Dashboard', 0),
              _buildNavItem(Icons.school_rounded, 'Students', 1),
              _buildNavItem(Icons.assignment_rounded, 'Grades', 2),
              _buildNavItem(Icons.calendar_today_rounded, 'Schedule', 3),
              _buildNavItem(Icons.person_rounded, 'Profile', 4),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 3.2 Animation và Transitions
Implement smooth animations cho modern feel:

#### Page Transitions:
```dart
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  
  SlidePageRoute({required this.child})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          );
          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      );
}
```

#### Loading Animations:
```dart
class ShimmerLoading extends StatelessWidget {
  final Widget child;
  
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.lightGray,
      highlightColor: AppColors.white,
      child: child,
    );
  }
}
```

### 3.3 Component Library
Tạo reusable components với consistent styling:

#### Custom App Bar:
```dart
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryMint, AppColors.mintSoft],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded, color: AppColors.primaryNavy),
                  onPressed: () => Navigator.pop(context),
                ),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.h2.copyWith(color: AppColors.primaryNavy),
                ),
              ),
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }
  
  Size get preferredSize => Size.fromHeight(80);
}
```

#### Modern Input Fields:
```dart
class ModernTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.primaryNavy,
        )),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: AppDecorations.textFieldDecoration.copyWith(
            hintText: hint,
            prefixIcon: prefixIcon != null 
              ? Icon(prefixIcon, color: AppColors.darkGray, size: 20)
              : null,
          ),
        ),
      ],
    );
  }
}
```

### 3.4 JWT Integration Setup
Vì đã có backend với JWT:

```dart
class ApiService {
  final Dio _dio = Dio();
  String? _token;
  
  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await _refreshToken();
            handler.resolve(await _retry(error.requestOptions));
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }
  
  Future<void> setToken(String token) async {
    _token = token;
    await SharedPreferences.getInstance().then(
      (prefs) => prefs.setString('auth_token', token)
    );
  }
}
```

## Bước 4: Authentication & Authorization

### 4.1 Modern Login Interface
Tạo login screen với design hiện đại:

```dart
class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryMint.withOpacity(0.1),
              AppColors.white,
              AppColors.mintLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Spacer(),
                // Logo và Welcome Text
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryMint.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.school_rounded,
                    size: 48,
                    color: AppColors.primaryNavy,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: AppTextStyles.h1,
                ),
                SizedBox(height: 8),
                Text(
                  'Sign in to continue to SchoolApp',
                  style: AppTextStyles.bodyMedium,
                ),
                SizedBox(height: 48),
                
                // Login Form
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: AppDecorations.softCard,
                  child: Column(
                    children: [
                      ModernTextField(
                        label: 'Email or Username',
                        hint: 'Enter your email',
                        prefixIcon: Icons.person_outline_rounded,
                      ),
                      SizedBox(height: 20),
                      ModernTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        prefixIcon: Icons.lock_outline_rounded,
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: AppDecorations.primaryButtonStyle,
                          onPressed: () {/* Handle login */},
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### 4.2 Role-based Navigation
JWT integration với role-based routing:

```dart
class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService;
  
  Future<void> login(String email, String password) async {
    try {
      final response = await _apiService.post('/auth/login', {
        'email': email,
        'password': password,
      });
      
      final token = response.data['token'];
      final user = User.fromJson(response.data['user']);
      
      await _apiService.setToken(token);
      
      // Navigate based on role
      switch (user.role) {
        case UserRole.admin:
          navigatorKey.currentState?.pushReplacementNamed('/admin-dashboard');
          break;
        case UserRole.teacher:
          navigatorKey.currentState?.pushReplacementNamed('/teacher-dashboard');
          break;
        case UserRole.student:
          navigatorKey.currentState?.pushReplacementNamed('/student-dashboard');
          break;
        case UserRole.parent:
          navigatorKey.currentState?.pushReplacementNamed('/parent-dashboard');
          break;
      }
    } catch (e) {
      // Handle error với beautiful error UI
    }
  }
}
```

## Bước 5: Dashboard theo Role với Modern Design

### 5.1 Admin Dashboard với Glass Morphism Effect
```dart
class AdminDashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Admin Dashboard'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mintLight,
              AppColors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header với animated greeting
              AnimatedContainer(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryMint,
                      child: Icon(Icons.waving_hand, color: AppColors.primaryNavy),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good Morning!', style: AppTextStyles.h2),
                        Text('John Admin', style: AppTextStyles.bodyLarge),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Stats Cards với staggered animation
              Text('Overview', style: AppTextStyles.h2),
              SizedBox(height: 16),
              FlutterStaggeredAnimations.columnChildren(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      DashboardCard(
                        title: 'Total Students',
                        value: '1,234',
                        icon: Icons.school_rounded,
                        accentColor: AppColors.info,
                      ),
                      DashboardCard(
                        title: 'Active Teachers',
                        value: '89',
                        icon: Icons.person_rounded,
                        accentColor: AppColors.success,
                      ),
                      DashboardCard(
                        title: 'This Month Fees',
                        value: '\$45,200',
                        icon: Icons.payments_rounded,
                        accentColor: AppColors.warning,
                      ),
                      DashboardCard(
                        title: 'Attendance Rate',
                        value: '94.2%',
                        icon: Icons.check_circle_rounded,
                        accentColor: AppColors.primaryMint,
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 32),
              
              // Quick Actions với modern button design
              Text('Quick Actions', style: AppTextStyles.h2),
              SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildActionButton('Add Student', Icons.person_add_rounded, AppColors.info),
                  _buildActionButton('Create Notice', Icons.campaign_rounded, AppColors.warning),
                  _buildActionButton('View Reports', Icons.analytics_rounded, AppColors.success),
                  _buildActionButton('Manage Classes', Icons.class_rounded, AppColors.primaryMint),
                ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ModernBottomNav(),
    );
  }
  
  Widget _buildActionButton(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {/* Handle action */},
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 20),
              SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### 5.2 Student Dashboard với Card-based Layout
```dart
class StudentDashboard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'My Dashboard'),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              AppColors.primaryMint.withOpacity(0.1),
              AppColors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Student Info Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primaryMint, AppColors.mintSoft],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.person, color: AppColors.primaryNavy, size: 30),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sarah Johnson',
                            style: AppTextStyles.h2.copyWith(color: AppColors.primaryNavy),
                          ),
                          Text(
                            'Grade 10-A • Student ID: STU001',
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primaryNavy),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Today's Schedule
              Text('Today\'s Schedule', style: AppTextStyles.h2),
              SizedBox(height: 12),
              _buildScheduleCard('Mathematics', '9:00 - 10:00 AM', 'Room 101'),
              _buildScheduleCard('Physics', '10:15 - 11:15 AM', 'Lab 2'),
              _buildScheduleCard('English', '11:30 - 12:30 PM', 'Room 205'),
              
              SizedBox(height: 24),
              
              // Quick Stats
              Row(
                children: [
                  Expanded(child: _buildStatCard('Attendance', '95.5%', Icons.check_circle)),
                  SizedBox(width: 16),
                  Expanded(child: _buildStatCard('Avg. Grade', 'A-', Icons.star)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ModernBottomNav(),
    );
  }
}
```

## Bước 5: Student Management Module

### 5.1 Student Registration
- Complete registration form với photo
- Parent information
- Medical information
- Document upload (birth certificate, etc.)
- Student ID generation

### 5.2 Student Profile Management
- Personal information updates
- Academic history
- Disciplinary records
- Health records
- Emergency contacts

### 5.3 Student Directory
- Search và filter students
- Bulk operations
- Student cards với QR codes
- Export student lists

## Bước 6: Teacher Management Module

### 6.1 Teacher Registration
- Professional information
- Qualification documents
- Subject specializations
- Schedule preferences

### 6.2 Teacher Profile
- Personal và professional details
- Teaching history
- Performance evaluations
- Certification tracking

### 6.3 Teacher Directory
- Search by subject/department
- Workload analysis
- Performance reports

## Bước 7: Academic Management Module

### 7.1 Class Management
- Create và manage classes
- Student enrollment
- Class timetables
- Class performance analytics

### 7.2 Subject Management
- Subject creation với curriculum
- Teacher assignment
- Learning objectives
- Resource management

### 7.3 Curriculum Planning
- Academic calendar
- Lesson planning
- Syllabus tracking
- Progress monitoring

## Bước 8: Attendance Management

### 8.1 Student Attendance
- Daily attendance marking
- QR code-based check-in
- Bulk attendance entry
- Attendance reports
- Parent notifications

### 8.2 Teacher Attendance
- Staff attendance tracking
- Leave management
- Substitute arrangements

### 8.3 Attendance Analytics
- Attendance trends
- Defaulter lists
- Attendance certificates

## Bước 9: Assessment & Grading Module

### 9.1 Exam Management
- Exam scheduling
- Question paper management
- Seating arrangements
- Invigilator assignments

### 9.2 Grade Management
- Grade entry systems
- Grade calculations
- Report card generation
- Grade analytics
- Parent portals

### 9.3 Assignment System
- Assignment creation và distribution
- Submission tracking
- Online grading
- Plagiarism detection basic

## Bước 10: Timetable Management

### 10.1 Master Timetable
- School-wide timetable
- Room allocation
- Teacher availability
- Conflict resolution

### 10.2 Class Timetables
- Individual class schedules
- Period management
- Substitute handling
- Schedule notifications

### 10.3 Personal Schedules
- Student personal timetables
- Teacher schedules
- Calendar integration

## Bước 11: Communication Module

### 11.1 Notice Board
- School announcements
- Class-specific notices
- Event notifications
- Emergency alerts

### 11.2 Messaging System
- Teacher-Parent communication
- Group messaging
- File sharing
- Message history

### 11.3 Event Management
- School events calendar
- Event registration
- Photo galleries
- Event notifications

## Bước 12: Fee Management

### 12.1 Fee Structure
- Multiple fee types
- Installment options
- Late fee calculations
- Discount management

### 12.2 Payment Processing
- Online payment integration
- Payment history
- Receipt generation
- Outstanding fee tracking

### 12.3 Financial Reports
- Fee collection reports
- Outstanding amounts
- Payment analytics
- Financial statements

## Bước 13: Library Management

### 13.1 Book Management
- Book catalog
- ISBN tracking
- Category management
- Book conditions

### 13.2 Issue/Return System
- Book issuing
- Return tracking
- Fine calculations
- Renewal options

### 13.3 Library Analytics
- Popular books
- Reading habits
- Overdue tracking

## Bước 14: Transport Management

### 14.1 Route Management
- Bus routes
- Stop management
- Driver assignments
- Route optimization

### 14.2 Student Transport
- Student-route mapping
- Transport fees
- Safety tracking
- Parent notifications

## Bước 15: Reporting System

### 15.1 Academic Reports
- Student progress reports
- Class performance analysis
- Subject-wise analytics
- Comparative studies

### 15.2 Administrative Reports
- Attendance summaries
- Fee collection reports
- Staff reports
- Infrastructure utilization

### 15.3 Export Functionality
- PDF report generation
- Excel exports
- Email reports
- Automated report scheduling

## Bước 16: Parent Portal

### 16.1 Child Monitoring
- Real-time attendance
- Academic progress
- Behavioral reports
- Health records

### 16.2 Communication
- Teacher interaction
- Event participation
- Fee payments
- Feedback submission

## Bước 17: Mobile Optimization

### 17.1 Responsive Design
- Tablet-optimized interfaces
- Phone-friendly layouts
- Offline capability
- Push notifications

### 17.2 Performance Features
- Fast loading
- Efficient data sync
- Image compression
- Battery optimization

## Bước 18: Security & Privacy

### 18.1 Data Protection
- Student data encryption
- COPPA compliance
- Access logging
- Data backup

### 18.2 Access Control
- Role-based permissions
- Screen-level security
- Data-level restrictions
- Audit trails

## Yêu cầu kỹ thuật chi tiết

### State Management
- Flutter Bloc cho complex state
- Provider cho simple states
- Proper state persistence
- Error handling states

### UI/UX Requirements
- Child-friendly design elements
- Accessibility support
- Multiple language support
- Intuitive navigation
- Form validation với helpful messages

### Data Management
- SQLite cho offline storage
- REST API integration
- Real-time notifications
- Data synchronization
- Backup và restore

### Performance Requirements
- Fast app launch
- Smooth animations
- Efficient memory usage
- Background sync
- Offline functionality

## Deliverables Mong Muốn

1. **Complete Source Code** với detailed comments
2. **Database Schema** với sample educational data
3. **API Documentation** cho backend integration
4. **User Guides** cho từng role (Admin, Teacher, Student, Parent)
5. **Installation và Deployment Guide**
6. **Test Cases** covering all modules
7. **Screenshots** của tất cả major screens

## Lưu ý đặc biệt cho School Management

- **Child Safety**: Implement proper child protection measures
- **Privacy Compliance**: Follow educational data privacy laws
- **Parental Consent**: Proper consent mechanisms
- **Accessibility**: Support cho students với disabilities
- **Multi-language**: Support cho diverse student populations
- **Offline Mode**: Essential cho areas với poor connectivity
- **Scalability**: Design cho schools từ 100-5000+ students

## Tính năng nâng cao (Tùy chọn)

- **AI-powered Analytics**: Student performance prediction
- **Chatbot Support**: Automated FAQ responses
- **Biometric Integration**: Fingerprint attendance
- **GPS Tracking**: School bus tracking
- **Video Conferencing**: Online classes support
- **Digital Library**: E-book integration
- **Health Monitoring**: Basic health tracking

Hãy bắt đầu từ Bước 1 và thực hiện tuần tự. Mỗi module cần testing kỹ lưỡng và documentation đầy đủ. Đặc biệt chú ý đến user experience cho từng role và data security cho thông tin học sinh.