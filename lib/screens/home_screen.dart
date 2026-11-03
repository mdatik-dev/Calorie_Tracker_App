import 'package:flutter/material.dart';

import '../dialogs/add_food_dialog.dart';
import '../models/food_item.dart';
import '../widgets/calorie_summary_card.dart';
import '../widgets/food_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double _dailyGoal = 2000;
  final List<FoodItem> _foods = [];

  double get _totalCalories =>
      _foods.fold(0, (total, food) => total + food.calories);

  double get _remainingCalories =>
      (_dailyGoal - _totalCalories).clamp(0.0, _dailyGoal).toDouble();

  String get _todayDate {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    final now = DateTime.now();
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  Future<void> _showAddFoodDialog() async {
    final food = await showDialog<FoodItem>(
      context: context,
      builder: (_) => const AddFoodDialog(),
    );

    if (!mounted || food == null) return;
    setState(() => _foods.insert(0, food));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${food.name} added successfully'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _deleteFood(int index) {
    final removedFood = _foods[index];
    setState(() => _foods.removeAt(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedFood.name} deleted'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatCalories(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final overGoal = _totalCalories > _dailyGoal;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFE2F2E9),
              child: Icon(Icons.local_fire_department_rounded,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFoodDialog,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Food'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
          children: [
            Text(
              'Your daily nutrition',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF18352A),
                  ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today_rounded,
                    size: 15, color: Color(0xFF718078)),
                const SizedBox(width: 7),
                Text(_todayDate,
                    style: const TextStyle(color: Color(0xFF718078))),
              ],
            ),
            const SizedBox(height: 20),
            _DailyProgressCard(
              total: _totalCalories,
              goal: _dailyGoal,
              progress: (_totalCalories / _dailyGoal).clamp(0.0, 1.0).toDouble(),
              overGoal: overGoal,
              formatCalories: _formatCalories,
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Text(
                  'Calorie summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF18352A),
                      ),
                ),
                const Spacer(),
                Text('Daily goal: 2,000 kcal',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF718078),
                        )),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: CalorieSummaryCard(
                    title: 'Total',
                    value: _formatCalories(_totalCalories),
                    icon: Icons.local_fire_department_rounded,
                    color: const Color(0xFFE97835),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CalorieSummaryCard(
                    title: 'Daily Goal',
                    value: _formatCalories(_dailyGoal),
                    icon: Icons.flag_rounded,
                    color: const Color(0xFF3979C8),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CalorieSummaryCard(
                    title: 'Remaining',
                    value: _formatCalories(_remainingCalories),
                    icon: Icons.hourglass_bottom_rounded,
                    color: const Color(0xFF16845B),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                Text(
                  'Today’s food',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF18352A),
                      ),
                ),
                const Spacer(),
                Text('${_foods.length} ${_foods.length == 1 ? 'item' : 'items'}',
                    style: const TextStyle(color: Color(0xFF718078))),
              ],
            ),
            const SizedBox(height: 10),
            if (_foods.isEmpty)
              const _EmptyFoodState()
            else
              ListView.builder(
                itemCount: _foods.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final food = _foods[index];
                  return FoodListItem(
                    food: food,
                    onDelete: () => _deleteFood(index),
                    formattedCalories: _formatCalories(food.calories),
                  );
                },
              ),
            if (overGoal)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'You are ${_formatCalories(_totalCalories - _dailyGoal)} kcal over your daily goal.',
                  style: const TextStyle(
                    color: Color(0xFFD45A42),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DailyProgressCard extends StatelessWidget {
  const _DailyProgressCard({
    required this.total,
    required this.goal,
    required this.progress,
    required this.overGoal,
    required this.formatCalories,
  });

  final double total;
  final double goal;
  final double progress;
  final bool overGoal;
  final String Function(double) formatCalories;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF176B4C), Color(0xFF23966A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text('Calories consumed',
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w600)),
                ),
                Icon(Icons.auto_awesome_rounded,
                    color: Colors.white.withValues(alpha: 0.8)),
              ],
            ),
            const SizedBox(height: 7),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCalories(total),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 7, bottom: 5),
                  child: Text('kcal',
                      style: TextStyle(color: Colors.white70, fontSize: 15)),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor: Colors.white24,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFFFFD18A)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text('${(progress * 100).round()}% of daily goal',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
                const Spacer(),
                Text(
                  overGoal
                      ? 'Goal reached'
                      : '${formatCalories(goal - total)} kcal left',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFoodState extends StatelessWidget {
  const _EmptyFoodState();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFEAF4EE),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.restaurant_menu_rounded,
                  size: 30, color: Color(0xFF16845B)),
            ),
            const SizedBox(height: 12),
            const Text('No food added yet',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF18352A))),
            const SizedBox(height: 5),
            const Text(
              'Tap “Add Food” to record your first meal.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF718078)),
            ),
          ],
        ),
      ),
    );
  }
}
