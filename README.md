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
