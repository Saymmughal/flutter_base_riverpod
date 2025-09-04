# Flutter Base Riverpod Project

A professional Flutter application template built with modern architecture patterns, featuring a robust dark theme system, Riverpod state management, and optimized performance.

## 🚀 Features

### ✨ Core Features
- **🎨 Advanced Dark Theme System** - Seamless theme switching with system preference support
- **📱 Responsive Design** - Optimized for all screen sizes and orientations
- **⚡ High Performance** - Optimized rendering with minimal rebuilds
- **🔒 Authentication Ready** - Login screen with proper validation
- **📊 State Management** - Riverpod for efficient state management
- **💾 Local Storage** - Persistent local data storage with performance optimizations
- **🎯 Navigation** - Custom bottom navigation with smooth transitions
- **Cached Operations**: Background thread operations to prevent main thread blocking
- **Advanced Performance**: Further optimization for large-scale apps

### 🎨 Theme System
- **System Theme Detection** - Automatically follows device theme preference
- **Manual Theme Selection** - Light, Dark, and System modes
- **Persistent Theme Storage** - Remembers user's theme choice
- **Material 3 Design** - Modern Material Design implementation
- **Performance Optimized** - Cached calculations and background operations

### 🏗️ Architecture
- **Clean Architecture** - Separation of concerns with proper layers
- **Provider Pattern** - Riverpod for dependency injection
- **Repository Pattern** - Abstracted data access layer
- **Custom Extensions** - Flutter extensions for better development experience

## 🔗 Network Management

### Connection Manager
- **Real-time Monitoring**: Continuous internet connectivity tracking
- **Active Connection Check**: Verifies actual internet access
- **User Feedback**: Informs users about connection status
- **Error Handling**: Graceful handling of network issues
- **Performance Optimized**: Debounced connection checks to prevent frame skipping
- **Asynchronous UI Updates**: Non-blocking UI operations during connection changes

### Network Features
- **Connectivity Detection**: WiFi, mobile, and no connection states
- **Internet Validation**: Ensures actual internet access, not just network presence
- **Stream-based Updates**: Real-time connection status updates
- **User Notifications**: Clear feedback about network issues
- **Smart Toast Management**: Proper toast dismissal and state management
## ⚡ Performance Optimizations

### Main Thread Optimization
- **Cached Calculations**: Screen dimensions and font scaling cached to prevent repeated calculations
- **Background Operations**: SharedPreferences and network operations run off main thread
- **Debounced Checks**: Connection state changes debounced to prevent excessive network calls
- **Asynchronous UI Updates**: UI operations scheduled after current frame to prevent blocking

### Memory Management
- **Smart Caching**: Dimension and font calculations cached with automatic invalidation
- **Resource Cleanup**: Proper disposal of timers and streams
- **Efficient State Management**: Optimized provider updates to reduce rebuilds

### Performance Monitoring
- **Frame Rate Tracking**: Real-time monitoring of dropped frames in debug mode
- **Performance Metrics**: FPS and frame time monitoring
- **Debug Logging**: Comprehensive logging for performance analysis


## 📁 Project Structure

```
flutter_base_riverpod/
├── android/                 # Android platform-specific code
├── ios/                    # iOS platform-specific code
├── lib/                    # Main Dart source code
│   ├── data/              # Data layer
│   │   ├── db/           # Local database (SharedPreferences)
│   │   ├── model/        # Data models
│   │   └── repository/   # Repository implementations
│   ├── helper/            # Utility classes and helpers
│   ├── provider/          # Riverpod providers
│   ├── utils/             # App utilities and constants
│   │   └── app_styles/   # Theme and styling utilities
│   └── view/              # UI layer
│       ├── screens/       # App screens
│       └── widgets/       # Reusable widgets
├── assets/                 # App assets (fonts, icons, images)
├── test/                   # Test files
└── web/                    # Web platform support
```

## 🛠️ Technology Stack

### Core Technologies
- **Flutter**: 3.16+ (Latest stable)
- **Dart**: 3.2+
- **Riverpod**: 2.4+ (State management)
- **Material 3**: Modern Material Design

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  shared_preferences: ^2.2.0
  flutter_svg: ^2.0.9
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.16+
- Dart 3.2+
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Saymmughal/flutter_base_riverpod
   cd flutter_base_riverpod
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platform Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Compile SDK: 34

#### iOS
- Minimum iOS: 12.0
- Target iOS: 17.0

## 🎨 Theme System Architecture

### Theme Provider Structure
```dart
enum AppThemeMode { system, light, dark }

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  // Theme management with performance optimization
}
```

### Theme Data Organization
- **Light Theme**: Azure primary colors with white backgrounds
- **Dark Theme**: Green primary colors with dark backgrounds
- **System Theme**: Automatically follows device preference
- **Dynamic Colors**: Material 3 color scheme support

### Performance Optimizations
- **Smart Caching**: System brightness cached for 100ms
- **Selective Rebuilds**: Only necessary widgets rebuild on theme change
- **Non-blocking Operations**: Theme storage in background
- **Efficient Providers**: Riverpod `select` for minimal rebuilds

## 🏗️ State Management

### Riverpod Providers
```dart
// Theme management
final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>
final currentThemeModeProvider = Provider<AppThemeMode>
final isDarkModeProvider = Provider<bool>

// Navigation
final currentIndexProvider = StateNotifierProvider<CurrentIndexNotifier, int>
final bottomNavigationIndexProvider = Provider<List<Widget>>

// Authentication
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>
final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>
```

### Provider Benefits
- **Type Safety**: Compile-time error checking
- **Performance**: Minimal rebuilds with `select`
- **Testing**: Easy to mock and test
- **Dependency Injection**: Clean dependency management

## 📱 Screen Architecture

### Screen Hierarchy
```
SplashScreen
├── LoginScreen
└── MainScreen
    ├── HomeScreen
    ├── MenuScreen
    └── ThemeDemoScreen
```

### Screen Features
- **SplashScreen**: App initialization and loading
- **LoginScreen**: User authentication with validation
- **HomeScreen**: Main app interface with theme toggle
- **MenuScreen**: Navigation menu
- **ThemeDemoScreen**: Theme showcase and testing

## 🎯 Custom Extensions

### String Extensions
```dart
extension StringExtension on String {
  Widget toText({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
  }) => Text(this, style: TextStyle(...));
}
```

### Int Extensions
```dart
extension IntExtension on int {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
}
```

### Color Extensions
```dart
extension ColorExtension on Color {
  Color withValues({int? alpha, int? red, int? green, int? blue}) {
    // Modern color manipulation
  }
}
```

### API Calls
```dart
// Make API request
final response = await ApiRepo().postRequest(
  url: 'https://api.example.com/endpoint',
  data: {'key': 'value'},
);

// Handle response
if (response != null) {
  // Process successful response
}
```

### Local Storage
```dart
// Store data
await LocalDb.storeBearerToken('your_token');
await LocalDb.storeUserData(userData);

// Retrieve data
final token = await LocalDb.getBearerToken;
final userData = await LocalDb.getUserData;
```

### Performance Monitoring
```dart
// Check performance metrics
final metrics = PerformanceMonitor.instance.getPerformanceMetrics();
PerformanceMonitor.instance.logPerformanceMetrics();

// Connection management
bool isConnected = ConnectionManager().isConnected;
await ConnectionManager().refreshConnectionState();
```


## 🔧 Configuration

### Environment Configuration
```dart
class EnvConfig {
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL');
  static const String appName = String.fromEnvironment('APP_NAME');
  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: true);
}
```

### Theme Configuration
```dart
class AppThemeData {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    // Comprehensive theme configuration
  );
  
  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    // Comprehensive theme configuration
  );
}
```

### Color Configuration
```dart
class AppColors {
  // Primary colors
  static const Color greenPrimary = Color(0xFF4CAF50);
  static const Color azurePrimary = Color(0xFF2196F3);
  
  // Background colors
  static const Color whitePrimary = Color(0xFFFFFFFF);
  static const Color blackLight = Color(0xFF121212);
  
  // Text colors
  static const Color blackPrimary = Color(0xFF000000);
  static const Color whitePrimary = Color(0xFFFFFFFF);
}
```

## 📊 Data Layer

### Local Storage
```dart
class LocalDb {
  static const String _themeModeKey = 'theme_mode';
  static const String _bearerTokenKey = 'bearer_token';
  static const String _fcmTokenKey = 'fcm_token';
  
  // Theme persistence
  static Future<void> storeThemeMode(int value);
  static Future<int?> get getThemeMode;
  
  // Token management
  static Future<void> storeBearerToken(String token);
  static Future<String?> get getBearerToken;
  static Future<void> storeFcmToken(String token);
  static Future<String?> get getFcmToken;
}
```

### Models
- **Auth Models**: Login, ForgotPassword
- **Connection Model**: Network status
- **Radio List Model**: List data structures

## 🧪 Testing

### Test Structure
```
test/
├── widget_test.dart        # Widget tests
├── unit/                  # Unit tests
├── integration/           # Integration tests
└── mocks/                # Mock data and services
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

## 🚀 Build & Deployment

### Build Commands
```bash
# Debug build
flutter build apk --debug

# Release build
flutter build apk --release

# App bundle for Play Store
flutter build appbundle --release

# iOS build
flutter build ios --release
```

### Build Configuration
- **Android**: Gradle-based build system
- **iOS**: Xcode project configuration
- **Web**: Web-specific optimizations
- **Desktop**: Platform-specific builds

## 📱 Platform Support

### Supported Platforms
- ✅ **Android**: Full support with Material Design
- ✅ **iOS**: Full support with Cupertino design
- ✅ **Web**: Responsive web application
- ✅ **Desktop**: Windows, macOS, Linux support

### Platform-Specific Features
- **Android**: Material 3, adaptive icons, splash screen
- **iOS**: Cupertino widgets, app icons, launch screen
- **Web**: Responsive design, PWA support
- **Desktop**: Native window management

## 🔒 Security Features

### Data Protection
- **Secure Storage**: SharedPreferences for sensitive data
- **Token Management**: Secure bearer token storage
- **Input Validation**: Comprehensive form validation
- **Error Handling**: Graceful error management

### Best Practices
- No hardcoded secrets
- Secure token handling
- Input sanitization
- Error logging without sensitive data

## 📈 Performance Optimization

### Rendering Optimization
- **Minimal Rebuilds**: Only necessary widgets rebuild
- **Smart Caching**: Theme data caching
- **Efficient Providers**: Riverpod optimization
- **Memory Management**: Proper disposal and cleanup

### Theme Performance
- **Cached Calculations**: System brightness caching
- **Selective Updates**: Theme-aware rebuilds
- **Background Operations**: Non-blocking theme storage
- **Optimized Colors**: Efficient color calculations

## 🛠️ Development Workflow

### Code Style
- **Dart Analysis**: Strict linting rules
- **Formatting**: Consistent code formatting
- **Naming Conventions**: Clear and descriptive names
- **Documentation**: Comprehensive code comments

### Git Workflow
```bash
# Feature development
git checkout -b feature/theme-system
git add .
git commit -m "feat: implement dark theme system"
git push origin feature/theme-system

# Bug fixes
git checkout -b fix/performance-optimization
git add .
git commit -m "fix: optimize theme provider performance"
git push origin fix/performance-optimization
```

## 📚 API Reference

### Core Classes
- **ThemeNotifier**: Theme state management
- **AppThemeColors**: Theme-aware color utilities
- **LocalDb**: Local data persistence
- **AppThemeData**: Theme configuration

### Widgets
- **ThemeToggleWidget**: Theme switching interface
- **BottomNavigation**: Custom navigation bar
- **CustomTextField**: Enhanced text input
- **PrimaryButton**: Styled button component

## 🐛 Troubleshooting

### Common Issues

#### Theme Not Updating
```dart
// Ensure you're using the correct provider
final currentThemeMode = ref.watch(currentThemeModeProvider);

// Check if the widget is a ConsumerWidget
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Your code here
  }
}
```

#### Performance Issues
```dart
// Use select to prevent unnecessary rebuilds
final themeMode = ref.watch(themeProvider.select((theme) => theme));

// Cache expensive calculations
static Brightness _getCachedSystemBrightness() {
  // Caching logic
}
```

#### Build Errors
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check Flutter version
flutter --version

# Update Flutter
flutter upgrade
```

## 🤝 Contributing

### Contribution Guidelines
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

### Code Standards
- Follow Dart style guide
- Add comprehensive tests
- Update documentation
- Ensure performance optimization

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod contributors for state management
- Material Design team for design guidelines
- Flutter community for best practices

## 📞 Support

### Getting Help
- **Issues**: Create GitHub issues for bugs
- **Discussions**: Use GitHub discussions for questions
- **Documentation**: Check this README and code comments
- **Community**: Join Flutter community channels

### Contact Information
- **Repository**: [GitHub](https://github.com/Saymmughal/flutter_base_riverpod)
- **Issues**: [GitHub Issues](https://github.com/Saymmughal/flutter_base_riverpod/issues)
- **Email**: Saimmirzapk@gmail.com

---

**Built with ❤️ using Flutter and Riverpod**

*Last updated: December 2024*
