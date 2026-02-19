# Car 360 - Interactive Viewer

A premium Flutter application demonstrating a 360° interactive car viewer with smooth animations, multi-flavor support, and modern UI/UX.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: `3.38.5`
- FVM (optional but recommended)

### Run the App
1. Clone the repository.
2. Run `fvm flutter pub get`.
3. Launch with specific flavors:
   - **Dev**: `fvm flutter run --flavor dev -t lib/main_dev.dart`
   - **Prod**: `fvm flutter run --flavor prod -t lib/main_prod.dart`

**Note**: VS Code launch configurations are included in `.vscode/launch.json` for easy one-click debugging.

## 🏗 Architecture: Clean Architecture + MVVM
The project follows a feature-based Clean Architecture:
- **Presentation**: UI widgets and ViewModels (Riverpod).
- **Domain**: Pure Dart business logic and repository interfaces.
- **Data**: API implementations (Dio), Local Storage (Hive), and Repositories.

## 📦 Third-Party Packages
| Package | Purpose |
| :--- | :--- |
| **flutter_riverpod** | Robust state management with compile-time safety. |
| **go_router** | Declarative routing system with support for deep linking. |
| **dio** | Powerful HTTP client for advanced networking. |
| **hive** | Lightweight and fast NoSQL database for local persistence. |
| **flutter_screenutil** | Ensuring pixel-perfect responsiveness across all devices. |
| **flutter_dotenv** | Secure environment variable management for different flavors. |
| **package_info_plus** | Accessing platform-specific application metadata. |

## ✨ Features
- **Animated Splash**: Sleek car entry animation with logo fade-in.
- **360 Viewer**: Interactive object rotation with landscape lock.
- **Zoom & Pan**: Fully interactive detail exploration.
- **Color Customization**: Real-time car color changes.
- **Asset Pre-caching**: Optimized for smooth, lag-free interactions.
- `lib/core/`: Shared components (Networking, Routing, Theme, Services, Widgets).
- `lib/features/`: Feature-specific modules (Splash, Home).
  - `presentation/`: UI components and ViewModels.
  - `domain/`: Business entities and logic.
  - `data/`: Data sources and repository implementations.

## 🛡️ Technical Stack
- **State Management**: Riverpod (Notifier/AsyncNotifier)
- **Routing**: go_router
- **Networking**: Dio with standardized interceptors
- **Local Storage**: Hive
- **UI Responsiveness**: flutter_screenutil
- **Environment Handling**: flutter_dotenv
- **Linting**: very_good_analysis

## ⚙️ Flavor Configuration
The project supports two flavors:
- **Dev**: `com.qc.car360.dev`
- **Prod**: `com.qc.car360`

Build settings are managed in `android/app/build.gradle.kts` and `.env` files in `assets/env/`.

## 🛠️ Error Handling
Standardized `Failure` models are used globally. All network and data errors are mapped to these models before reaching the UI.
Raw exceptions are caught in the Data layer.

## 🎨 Design System
Reusable components are located in `lib/core/widgets/`.
Theme configuration (Material 3) is in `lib/core/theme/app_theme.dart`.
