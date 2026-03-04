# Contributing

Thanks for your interest in contributing!

## Ways to contribute

- Report bugs
- Suggest features
- Improve documentation
- Submit pull requests

## Development setup

### Prerequisites

- Flutter SDK (Dart `^3.11.0`)
- Android Studio / Xcode depending on your target platform

### Install dependencies

```bash
flutter pub get
```

### Generate code (Isar)

If you change models in `lib/core/models/local_models.dart`, regenerate code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Run

```bash
flutter run
```

### Tests

```bash
flutter test
```

## Pull requests

- Keep PRs focused and small when possible
- Explain the problem and the approach
- If you change data models, include the generated code changes
- Run `flutter analyze` and ensure it is clean before submitting

## Reporting bugs

Please open a GitHub issue and include:

- Steps to reproduce
- Expected vs actual behavior
- Device/OS
- Flutter version (`flutter --version`)
- Relevant logs
