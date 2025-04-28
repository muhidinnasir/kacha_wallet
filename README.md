# wanza_logistics_app

A Flutter-based remittance app designed to manage user transactions, view exchange rates, and send money securely. The app leverages mock APIs and local data storage for efficient data management.

## System requirements

Flutter 3.13.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision efbf63d9c6 (1 year, 5 months ago) • 2023-08-15 21:05:06 -0500
Engine • revision 1ac611c64e
Tools • Dart 3.1.0 • DevTools 2.25.0

## Features

- here the feature of the prject

## Application structure

```
root/
├── lib/
│   ├── core/             # Shared utilities, constants, extensions
│   ├── data/             # API services and data models
│   ├── domain/           # Business logic providers or state management
│   ├── presentation/     # UI widgets and screens
│   ├── main.dart         # App entry point
├── test/                 # Test cases
├── pubspec.yaml          # Dependencies
├── README.md             # Project documentation
├── .gitignore            # Ignored files

```

---

## Documentation

### Content for Documentation

#### 1. Architecture

Use the Feature-Driven Development (FDD) structure:

- Core: Utilities like extensions (`DateTimeExtension`), constants, and shared helpers.
- Data: Handles API calls (`ApiService`) and defines data models.
- Domain: Implements business logic and state management.
- Presentation: Contains UI widgets and screens.

#### 2. Challenges Faced

1. Dynamic Formatting of Transactions:

   - Challenge: Displaying dates in a user-friendly format across locales.
   - Solution: Created a reusable `DateTimeExtension` with customizable patterns and locale support.

2. Local Data Management:

   - Challenge: Storing user-specific data securely and avoiding duplication during registration.
   - Solution: Used `SharedPreferences` with email-based keys for storing user-specific details.

3. Custom Dialogs:
   - Challenge: Building reusable custom dialogs for transaction details.
   - Solution: Designed a `CustomTransactionDialog` widget with dynamic content.

#### 3. Solutions Implemented

- Reusable Widgets:
  - Components like  `ActionButton`, and `CustomDropdownFormField` simplify the UI.
- Extensions:
  - `DateTimeExtension` ensures consistent formatting across the app.
- State Management:
  - Used `Riverpod` for state management, providing a clean separation between UI and logic.
- Mock APIs:
  - Integrated a `ApiService` for testing without a real backend.

---

## installation

To run the application, follow these steps:

1. Clone the repository using `git clone 'ur github'`.
2. Navigate to the project directory using `cd yourProjectFolder`.
3. Install the required dependencies by running `flutter pub get`.
4. Run the application using `flutter run`.
