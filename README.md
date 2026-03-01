# SmartSaver (first_check_2)

SmartSaver is a Flutter app for tracking spending, managing a monthly budget, and viewing spending analytics based on saved checkout transactions.

## Features

- **Cart**
  - Add items with price, quantity, category, taxability, discounts
  - Checkout flow that saves a transaction locally
- **Budget**
  - Monthly budget setting
  - Simple “spent vs remaining” calculations
- **Analytics**
  - Monthly summary (spent, saved, projected)
  - Recent checkouts list
- **Local persistence**
  - Uses Isar for fast local storage

## Tech stack

- **Flutter** (Material 3)
- **State management**: Riverpod
- **Local DB**: Isar
- **Backend (optional / in-progress)**: Supabase

## Prerequisites

- **Flutter SDK** installed (this repo targets Dart `^3.11.0`)
- Platform toolchain for your target(s)
  - Android Studio + Android SDK for Android
  - Xcode for iOS

## Getting started

1. Install dependencies:

   ```bash
   flutter pub get
   ```

2. Generate Isar code (required when models change, and often needed on first clone):

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

3. Run the app:

   ```bash
   flutter run
   ```

## Isar notes

- Isar collections live in `lib/core/models/local_models.dart`.
- The generated file is `lib/core/models/local_models.g.dart`.
- If you edit any `@collection` / `@embedded` model, re-run build runner:

  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

## App initialization

Local database initialization happens in `lib/main.dart`:

- `WidgetsFlutterBinding.ensureInitialized()`
- `await LocalDbService().init();`

If you see runtime errors related to Isar not being opened/initialized, verify `LocalDbService.init()` is being called before any database usage.

## Configuration (Supabase)

Supabase constants are currently in:

- `lib/core/constants/app_constants.dart`

If you intend to use Supabase in production:

- Move keys/URLs out of source control (for example: `.env` + runtime config)
- Do not hardcode secrets in the repo

## Common commands

- Analyze code:

  ```bash
  flutter analyze
  ```

- Run tests:

  ```bash
  flutter test
  ```

- Re-generate code (after model changes):

  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```

## Troubleshooting

- **Build runner conflicts / stale generated files**
  - Re-run:

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

- **`findAll()` / query methods not found**
  - Ensure the file using Isar queries imports:
    - `package:isar/isar.dart`
