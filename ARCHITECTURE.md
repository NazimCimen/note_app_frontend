# 🏗️ Clean Architecture Implementation

Bu proje, **Clean Architecture** prensiplerine uygun olarak tasarlanmıştır. Katmanlar arası temiz ayrım sağlanarak, sürdürülebilir ve test edilebilir bir kod yapısı oluşturulmuştur.

## 📁 Klasör Yapısı

```
lib/
├── core/                    # Infrastructure & Utilities
│   ├── cache/              # Local storage utilities
│   ├── connection/         # Network connection handling
│   ├── error/              # Error handling & failures
│   ├── init/               # App initialization & DI
│   └── utils/              # Shared utilities
│
├── domain/                  # Business Logic Layer
│   ├── entities/           # Pure business objects
│   ├── repositories/       # Abstract repository interfaces
│   └── usecases/          # Business use cases
│       └── auth/          # Authentication use cases
│
├── data/                   # Data Access Layer
│   ├── models/            # Data transfer objects
│   ├── services/          # External API services
│   └── repositories/      # Repository implementations
│
├── presentation/           # Presentation Layer
│   ├── auth/              # Authentication UI
│   │   ├── bloc/          # State management
│   │   ├── pages/         # Screen widgets
│   │   └── widgets/       # Feature-specific widgets
│   └── shared/            # Shared UI components
│       ├── components/    # Reusable components
│       └── widgets/       # Reusable widgets
│
├── shared/                 # Shared Resources
│   ├── config/            # App configuration
│   │   ├── localization/  # Internationalization
│   │   ├── routes/        # Navigation routes
│   │   └── theme/         # App theming
│   └── common/            # Common utilities
│
└── main.dart              # Application entry point
```

## 🎯 Clean Architecture Katmanları

### 1. **Domain Layer** (İş Mantığı Katmanı)
- **Entities**: Saf iş nesneleri, framework'den bağımsız
- **Use Cases**: İş kurallarını kapsayan sınıflar
- **Repository Interfaces**: Veri erişimi için sözleşmeler

```dart
// Örnek: Login Use Case
class LoginUseCase {
  const LoginUseCase(this._repository);
  
  final AuthRepository _repository;
  
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
```

### 2. **Data Layer** (Veri Erişim Katmanı)
- **Models**: API'den gelen verilerin DTO'ları
- **Services**: External API'lerle iletişim
- **Repository Implementations**: Domain interfaces'lerinin implementasyonu

```dart
// Örnek: Auth Repository Implementation
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;
  
  @override
  Future<Either<Failure, UserEntity>> signup(...) async {
    final result = await _service.signup(...);
    return result.fold(
      (failure) => Left(failure),
      (userModel) => Right(userModel.toEntity()),
    );
  }
}
```

### 3. **Presentation Layer** (Sunum Katmanı)
- **Pages**: Ekran widget'ları
- **BLoC/Cubit**: State management
- **Widgets**: UI bileşenleri

```dart
// Örnek: Auth Cubit with Use Cases
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  
  Future<void> login({required String email, required String password}) async {
    final params = LoginParams(email: email, password: password);
    final result = await loginUseCase(params);
    
    result.fold(
      (failure) => emit(AuthState.failure(failure.errorMessage)),
      (_) => emit(const AuthState.success()),
    );
  }
}
```

## 🔄 Veri Akışı

```
UI (Presentation) 
    ↓
BLoC/Cubit 
    ↓
Use Cases (Domain)
    ↓
Repository Interface (Domain)
    ↓
Repository Implementation (Data)
    ↓
Service (Data)
    ↓
External APIs
```

## 🎨 Dependency Injection

GetIt service locator kullanılarak dependency injection sağlanmıştır:

```dart
void setupDI() {
  // External dependencies
  getIt.registerLazySingleton<SupabaseClient>(...);
  
  // Data layer - Services
  getIt.registerLazySingleton<AuthService>(...);
  
  // Data layer - Repositories  
  getIt.registerLazySingleton<AuthRepository>(...);
  
  // Domain layer - Use cases
  getIt.registerLazySingleton<LoginUseCase>(...);
}
```

## 🧪 Test Edilebilirlik

Bu mimari yapısı sayesinde:
- **Unit Tests**: Use case'ler kolayca test edilebilir
- **Widget Tests**: UI bileşenleri izole test edilebilir
- **Integration Tests**: Tüm katmanlar birlikte test edilebilir
- **Mocking**: Interface'ler kolayca mock'lanabilir

## 📋 Avantajlar

1. **Separation of Concerns**: Her katman kendi sorumluluğuna odaklanır
2. **Testability**: Katmanlar bağımsız olarak test edilebilir
3. **Maintainability**: Kod değişiklikleri izole edilmiş
4. **Scalability**: Yeni özellikler kolayca eklenebilir
5. **Independence**: Framework'den bağımsız iş mantığı

## 🔧 Kullanılan Teknolojiler

- **State Management**: BLoC/Cubit pattern
- **Dependency Injection**: GetIt service locator
- **Error Handling**: Either pattern (dartz)
- **Code Generation**: Freezed, JSON Annotation
- **Functional Programming**: Dartz for Either/Option types

Bu mimari yapısı, **SOLID** prensiplerine uygun, sürdürülebilir ve ölçeklenebilir bir Flutter uygulaması geliştirmek için ideal bir temel sağlar.
