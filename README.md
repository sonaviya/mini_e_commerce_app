# mini_e_commerce_app

A new Flutter project.

## Getting Started

## ✅ Architecture

The app follows MVVM (Model-View-ViewModel) architecture with BLoC for state management.

## Models

Product → Represents product data from API.
CartItem → Represents an item in the shopping cart (stored in SQLite).

## Repository Layer

ProductRepository → Fetches products from API and caches them offline with SharedPreferences.
CartRepository → Manages cart items in SQLite (sqflite).

## BLoC / Cubit Layer

ProductBloc → Handles fetching, loading, and error states for product list.
CartBloc → Handles add/remove/update items and total price calculation.
SettingsCubit → Manages theme (light/dark/system) and localization (English/Spanish).

## UI Layer (Views)

HomeScreen → Displays product grid (with retry on error).
ProductDetailScreen → Shows full product details + add to cart.
CartScreen → Displays selected items with quantity controls and total price.
SettingsScreen → Allows changing language and toggling dark mode.

## 📦 Libraries Used and Why

- flutter_bloc + equatable → BLoC pattern for predictable and testable state management.
- http → API requests to https://fakestoreapi.com/products.
- shared_preferences → Cache product list for offline support.
- sqflite + path_provider → Persistent cart storage across app restarts.
- intl + flutter_localizations → Localization support (English + Spanish).
- cupertino_icons → iOS style icons.
- flutter_test + bloc_test + mockito → For unit and widget testing.
- github-actions workflow → CI/CD automation (build APK, run tests).

## ▶️ How to Run
## Clone or extract project

git clone <repo_url>
cd mini_ecommerce

## Install dependencies

flutter pub get

## Run app on emulator or device

flutter run

## Run tests

flutter test

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
