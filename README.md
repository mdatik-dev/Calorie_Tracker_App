# Calorie Tracker

A clean and beginner-friendly Flutter app for recording daily food calories.

## Features

- Displays the app name and today's date.
- Shows total calories consumed and a daily goal of **2,000 kcal**.
- Calculates remaining calories automatically.
- Add food with a name and calorie amount.
- Validates empty fields and positive numeric calorie values.
- Displays food entries with `ListView.builder`.
- Delete individual food entries.
- Updates all calorie summaries immediately after adding or deleting food.
- Uses an in-memory Dart `List`; data resets when the app restarts.
- No database, Firebase, Supabase, or API required.

## Project structure

```text
lib/
├── main.dart
├── models/
│   └── food_item.dart
├── screens/
│   └── home_screen.dart
├── dialogs/
│   └── add_food_dialog.dart
└── widgets/
    ├── calorie_summary_card.dart
    └── food_list_item.dart
```

## Run the project

1. Install Flutter and Android Studio (or configure another Flutter device).
2. Extract this project.
3. Open the project folder in VS Code or Android Studio.
4. This download contains the complete app source (`lib/`) and package configuration. If platform folders such as `android/`, `ios/`, or `web/` are not present, generate the platform scaffolding once from the project folder:

```bash
flutter create .
```

5. Then run:

```bash
flutter pub get
flutter run
```

## GitHub submission

Create a new empty GitHub repository, then run these commands from this project folder:

```bash
git init
git add .
git commit -m "Initial Calorie Tracker Flutter app"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```

Replace the remote URL with your own GitHub repository URL.
