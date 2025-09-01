# Module Development Guide

## School ERP System - Clean Architecture Implementation

This guide provides comprehensive instructions for developing new modules in the School ERP system following Clean Architecture principles and maintaining consistency across the codebase.

## Table of Contents

1. [Architecture Overview](#architecture-overview)
2. [Module Structure](#module-structure)
3. [Development Workflow](#development-workflow)
4. [Code Standards](#code-standards)
5. [Testing Guidelines](#testing-guidelines)
6. [Common Patterns](#common-patterns)
7. [Examples](#examples)

## Architecture Overview

### Clean Architecture Layers

Our system follows Clean Architecture with these layers:

```
┌─────────────────────┐
│   Presentation      │ ← UI, BLoC, Pages, Widgets
├─────────────────────┤
│   Domain            │ ← Entities, Use Cases, Repository Interfaces
├─────────────────────┤
│   Data              │ ← Models, Data Sources, Repository Implementations
├─────────────────────┤
│   Core              │ ← Services, Utils, Constants, Errors
└─────────────────────┘
```

### Dependency Rule

- **Outer layers depend on inner layers**
- **Inner layers never depend on outer layers**
- **Domain layer has no dependencies**
- **All dependencies point inward**

## Module Structure

### Standard Module Template

```
features/
└── [module_name]/
    ├── domain/
    │   ├── entities/
    │   │   ├── [entity_name].dart
    │   │   └── [entity_name]_list.dart
    │   ├── repositories/
    │   │   └── [module_name]_repository.dart
    │   └── usecases/
    │       ├── get_[entity_name]_usecase.dart
    │       ├── create_[entity_name]_usecase.dart
    │       ├── update_[entity_name]_usecase.dart
    │       └── delete_[entity_name]_usecase.dart
    ├── data/
    │   ├── datasources/
    │   │   ├── [module_name]_local_datasource.dart
    │   │   └── [module_name]_remote_datasource.dart
    │   ├── models/
    │   │   ├── [entity_name]_model.dart
    │   │   └── [entity_name]_list_model.dart
    │   └── repositories/
    │       └── [module_name]_repository_impl.dart
    └── presentation/
        ├── bloc/
        │   ├── [module_name]_bloc.dart
        │   ├── [module_name]_event.dart
        │   └── [module_name]_state.dart
        ├── pages/
        │   ├── [module_name]_list_page.dart
        │   ├── [module_name]_detail_page.dart
        │   └── [module_name]_form_page.dart
        └── widgets/
            ├── [entity_name]_card.dart
            ├── [entity_name]_form.dart
            └── [entity_name]_list_item.dart
```

## Development Workflow

### Step 1: Domain Layer Development

#### 1.1 Define Entities

```dart
// features/student_management/domain/entities/student.dart
import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String studentId;
  final DateTime enrollmentDate;
  final bool isActive;

  const Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.studentId,
    required this.enrollmentDate,
    required this.isActive,
  });

  // Business logic methods
  String get fullName => '$firstName $lastName';
  bool get canEnroll => isActive && enrollmentDate.isBefore(DateTime.now());

  @override
  List<Object?> get props => [
    id, firstName, lastName, email, studentId, enrollmentDate, isActive
  ];
}
```

#### 1.2 Create Repository Interface

```dart
// features/student_management/domain/repositories/student_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/student.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<Student>>> getStudents();
  Future<Either<Failure, Student>> getStudentById(String id);
  Future<Either<Failure, Student>> createStudent(Student student);
  Future<Either<Failure, Student>> updateStudent(Student student);
  Future<Either<Failure, void>> deleteStudent(String id);
}
```

#### 1.3 Implement Use Cases

```dart
// features/student_management/domain/usecases/get_students_usecase.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/student.dart';
import '../repositories/student_repository.dart';

class GetStudentsUseCase {
  final StudentRepository repository;

  GetStudentsUseCase(this.repository);

  Future<Either<Failure, List<Student>>> call() async {
    return await repository.getStudents();
  }
}
```

### Step 2: Data Layer Development

#### 2.1 Create Models

```dart
// features/student_management/data/models/student_model.dart
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/student.dart';

part 'student_model.g.dart';

@JsonSerializable()
class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.studentId,
    required super.enrollmentDate,
    required super.isActive,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);

  factory StudentModel.fromEntity(Student student) {
    return StudentModel(
      id: student.id,
      firstName: student.firstName,
      lastName: student.lastName,
      email: student.email,
      studentId: student.studentId,
      enrollmentDate: student.enrollmentDate,
      isActive: student.isActive,
    );
  }

  Student toEntity() {
    return Student(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      studentId: studentId,
      enrollmentDate: enrollmentDate,
      isActive: isActive,
    );
  }
}
```

#### 2.2 Create Data Sources

```dart
// features/student_management/data/datasources/student_remote_datasource.dart
import '../../../../core/network/api_client.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/student_model.dart';

abstract class StudentRemoteDataSource {
  Future<List<StudentModel>> getStudents();
  Future<StudentModel> getStudentById(String id);
  Future<StudentModel> createStudent(StudentModel student);
  Future<StudentModel> updateStudent(StudentModel student);
  Future<void> deleteStudent(String id);
}

class StudentRemoteDataSourceImpl implements StudentRemoteDataSource {
  final ApiClient apiClient;

  StudentRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<StudentModel>> getStudents() async {
    try {
      final response = await apiClient.get('/students');
      final List<dynamic> data = response.data['data'];
      return data.map((json) => StudentModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerException('Failed to fetch students: $e');
    }
  }

  // Implement other methods...
}
```

#### 2.3 Implement Repository

```dart
// features/student_management/data/repositories/student_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/error_handler.dart';
import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_remote_datasource.dart';
import '../datasources/student_local_datasource.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentRemoteDataSource remoteDataSource;
  final StudentLocalDataSource localDataSource;

  StudentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Student>>> getStudents() async {
    try {
      final students = await remoteDataSource.getStudents();
      final entities = students.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ErrorHandler.handleException(e as Exception));
    }
  }

  // Implement other methods...
}
```

### Step 3: Presentation Layer Development

#### 3.1 Create BLoC

```dart
// features/student_management/presentation/bloc/student_event.dart
abstract class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object?> get props => [];
}

class StudentsLoadRequested extends StudentEvent {
  const StudentsLoadRequested();
}

class StudentCreateRequested extends StudentEvent {
  final Student student;

  const StudentCreateRequested(this.student);

  @override
  List<Object?> get props => [student];
}
```

```dart
// features/student_management/presentation/bloc/student_state.dart
abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {
  const StudentInitial();
}

class StudentLoading extends StudentState {
  const StudentLoading();
}

class StudentsLoaded extends StudentState {
  final List<Student> students;

  const StudentsLoaded(this.students);

  @override
  List<Object?> get props => [students];
}

class StudentError extends StudentState {
  final String message;

  const StudentError(this.message);

  @override
  List<Object?> get props => [message];
}
```

```dart
// features/student_management/presentation/bloc/student_bloc.dart
class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudentsUseCase getStudentsUseCase;
  final CreateStudentUseCase createStudentUseCase;

  StudentBloc({
    required this.getStudentsUseCase,
    required this.createStudentUseCase,
  }) : super(const StudentInitial()) {
    on<StudentsLoadRequested>(_onStudentsLoadRequested);
    on<StudentCreateRequested>(_onStudentCreateRequested);
  }

  Future<void> _onStudentsLoadRequested(
    StudentsLoadRequested event,
    Emitter<StudentState> emit,
  ) async {
    emit(const StudentLoading());

    final result = await getStudentsUseCase();
    result.fold(
      (failure) => emit(StudentError(failure.message)),
      (students) => emit(StudentsLoaded(students)),
    );
  }

  // Implement other event handlers...
}
```

#### 3.2 Create Pages

```dart
// features/student_management/presentation/pages/students_list_page.dart
class StudentsListPage extends StatelessWidget {
  const StudentsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToCreateStudent(context),
          ),
        ],
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StudentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () => _refreshStudents(context),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is StudentsLoaded) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return StudentListItem(
                  student: student,
                  onTap: () => _navigateToStudentDetail(context, student),
                );
              },
            );
          }

          return const Center(child: Text('No students found'));
        },
      ),
    );
  }

  void _refreshStudents(BuildContext context) {
    context.read<StudentBloc>().add(const StudentsLoadRequested());
  }

  void _navigateToCreateStudent(BuildContext context) {
    // Navigation logic
  }

  void _navigateToStudentDetail(BuildContext context, Student student) {
    // Navigation logic
  }
}
```

## Code Standards

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Private members**: `_camelCase`

### Documentation

```dart
/// Student entity representing a student in the school system
/// 
/// Contains basic student information including enrollment details
/// and academic status. Provides business logic methods for
/// common student operations.
class Student extends Equatable {
  /// Unique identifier for the student
  final String id;
  
  /// Student's first name
  final String firstName;
  
  /// Creates a new Student instance
  /// 
  /// All parameters are required except for optional fields
  /// marked with nullable types.
  const Student({
    required this.id,
    required this.firstName,
    // ... other parameters
  });

  /// Returns the full name of the student
  /// 
  /// Combines [firstName] and [lastName] with a space.
  /// Example: \"John Doe\"
  String get fullName => '$firstName $lastName';
}
```

### Error Handling

```dart
// Always use Either<Failure, T> for error-prone operations
Future<Either<Failure, Student>> getStudent(String id) async {
  try {
    final student = await dataSource.getStudent(id);
    return Right(student);
  } catch (e) {
    return Left(ErrorHandler.handleException(e as Exception));
  }
}
```

### State Management

```dart
// Use BLoC pattern with proper event/state separation
abstract class StudentEvent extends Equatable {
  const StudentEvent();
  
  @override
  List<Object?> get props => [];
}

class StudentLoadRequested extends StudentEvent {
  final String studentId;
  
  const StudentLoadRequested(this.studentId);
  
  @override
  List<Object?> get props => [studentId];
}
```

## Testing Guidelines

### Unit Tests Structure

```
test/
├── features/
│   └── [module_name]/
│       ├── domain/
│       │   ├── entities/
│       │   └── usecases/
│       ├── data/
│       │   ├── models/
│       │   ├── datasources/
│       │   └── repositories/
│       └── presentation/
│           └── bloc/
├── fixtures/
│   └── [module_name]_fixtures.dart
└── helpers/
    └── test_helper.dart
```

### Test Examples

```dart
// test/features/student_management/domain/usecases/get_students_usecase_test.dart
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStudentRepository extends Mock implements StudentRepository {}

void main() {
  late GetStudentsUseCase useCase;
  late MockStudentRepository mockRepository;

  setUp(() {
    mockRepository = MockStudentRepository();
    useCase = GetStudentsUseCase(mockRepository);
  });

  group('GetStudentsUseCase', () {
    final tStudents = [/* test students */];

    test(
      'should get list of students from repository',
      () async {
        // arrange
        when(mockRepository.getStudents())
            .thenAnswer((_) async => Right(tStudents));

        // act
        final result = await useCase();

        // assert
        expect(result, Right(tStudents));
        verify(mockRepository.getStudents());
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
```

## Common Patterns

### 1. Repository Pattern

```dart
// Always define interface in domain layer
abstract class EntityRepository {
  Future<Either<Failure, List<Entity>>> getEntities();
  Future<Either<Failure, Entity>> getEntity(String id);
}

// Implement in data layer
class EntityRepositoryImpl implements EntityRepository {
  final EntityRemoteDataSource remoteDataSource;
  final EntityLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EntityRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });
}
```

### 2. Use Case Pattern

```dart
// Single responsibility use cases
class GetEntityUseCase {
  final EntityRepository repository;

  GetEntityUseCase(this.repository);

  Future<Either<Failure, Entity>> call(String id) async {
    return await repository.getEntity(id);
  }
}
```

### 3. BLoC Pattern

```dart
// Event-driven state management
class EntityBloc extends Bloc<EntityEvent, EntityState> {
  final GetEntityUseCase getEntityUseCase;

  EntityBloc({required this.getEntityUseCase}) : super(EntityInitial()) {
    on<EntityLoadRequested>(_onEntityLoadRequested);
  }

  Future<void> _onEntityLoadRequested(
    EntityLoadRequested event,
    Emitter<EntityState> emit,
  ) async {
    emit(EntityLoading());
    
    final result = await getEntityUseCase(event.id);
    result.fold(
      (failure) => emit(EntityError(failure.message)),
      (entity) => emit(EntityLoaded(entity)),
    );
  }
}
```

## Module Integration Checklist

### Before Development
- [ ] Define module requirements and scope
- [ ] Design entities and their relationships
- [ ] Plan API endpoints and data structures
- [ ] Create user stories and acceptance criteria

### During Development
- [ ] Follow the layer-by-layer development approach
- [ ] Write unit tests for each component
- [ ] Use consistent naming conventions
- [ ] Add proper documentation
- [ ] Handle errors appropriately

### After Development
- [ ] Register dependencies in injection container
- [ ] Add navigation routes
- [ ] Update permissions and roles
- [ ] Add to module registry
- [ ] Write integration tests
- [ ] Update user documentation

### Code Review Checklist
- [ ] Follows Clean Architecture principles
- [ ] Proper separation of concerns
- [ ] All dependencies point inward
- [ ] Comprehensive error handling
- [ ] Unit tests with good coverage
- [ ] Proper documentation
- [ ] Consistent with existing code style
- [ ] Performance considerations addressed

## Examples

See the `features/auth/` module for a complete implementation example following these guidelines.

## Resources

- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [Dart Style Guide](https://dart.dev/guides/language/effective-dart)
- [Flutter Testing Guide](https://flutter.dev/docs/testing)

---

**Remember**: Consistency is key. Always follow these guidelines to maintain code quality and ensure the project remains maintainable as it grows."