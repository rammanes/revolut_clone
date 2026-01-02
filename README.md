# revolut_clone

Building a Revolut clone with Flutter. Just trying to learn and build something cool.

## What's this?

Started this project because I really like Revolut's UI and wanted to see if I could build something similar. It's mostly for learning Flutter and understanding how fintech apps work under the hood.

## What I'm planning to build

Still figuring things out, but here's what I want to add eventually:

- Multi-currency accounts
- Card stuff (virtual cards, physical cards)
- Transaction history
- Currency exchange
- Send money to people
- Some basic spending analytics
- Dark mode because why not
- Biometric login

Right now it's pretty much empty, just getting started.

## Setup

Standard Flutter stuff:

```bash
flutter pub get
flutter run
```

## Tech

- Flutter/Dart
- Supabase (backend)
- PowerSync (offline-first data sync)
- iOS and Android (maybe web later)

## Project structure

The usual Flutter structure, nothing fancy:

- `models/` - data warehousing
- `screens/` - pages
- `widgets/` - reusable components
- `services/` - API calls and business logic
- `utils/` - helpers
- `theme/` - styling

## Project structure

Modular feature-based architecture:

```
lib/
├── core/              # Shared/common code
│   ├── extensions/    # Dart extensions
│   ├── providers/     # Theme state, app-wide providers
│   ├── utils/         # Helper functions, constants
│   └── widgets/       # General reusable widgets
├── features/          # Feature modules (auth, home, transaction, etc.)
│   ├── feature_name/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── repository/
│   │   ├── screens/
│   │   └── widgets/
├── styles/            # Theme and colors
└── main.dart
```

## Development

Working on feature branches and merging via PRs. Check the commits/PRs to see how things progress.

---

This is just for learning. Not affiliated with Revolut or anything like that.
