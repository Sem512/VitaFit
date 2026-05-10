import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_state.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  final _searchController = TextEditingController();
  final data = MockData.nutrition;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _progressAnimation = CurvedAnimation(parent: _progressController, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 200), _progressController.forward);
  }

  @override
  void dispose() {
    _progressController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _openAddFoodSheet(BuildContext context, String mealName) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;

    showModalBottomSheet(
      context: context,
      backgroundColor: surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 36),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36, height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBorder2 : AppColors.lightBorder2,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Log Food — $mealName',
                  style: GoogleFonts.spaceGrotesk(fontSize: 18, fontWeight: FontWeight.w700, color: text1)),
              const SizedBox(height: 16),
              Container(
                height: 46,
                decoration: BoxDecoration(
                  color: surface2,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: border),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    Icon(Icons.search_rounded, color: text3, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: GoogleFonts.dmSans(fontSize: 14, color: text1),
                        decoration: InputDecoration(
                          hintText: 'Search 1M+ foods...',
                          hintStyle: GoogleFonts.dmSans(fontSize: 14, color: text3),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          filled: false,
                        ),
                      ),
                    ),
                    Icon(Icons.qr_code_scanner_rounded, color: AppColors.accent, size: 20),
                    const SizedBox(width: 12),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('Recent Foods',
                  style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
              const SizedBox(height: 10),
              ...MockData.recentFoods.map((f) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: surface2,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(f.name,
                                    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: text1)),
                                Text(f.serving,
                                    style: GoogleFonts.dmSans(fontSize: 12, color: text2)),
                              ],
                            ),
                          ),
                          Icon(Icons.add_circle_outline_rounded, color: AppColors.accent, size: 22),
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final surface3 = isDark ? AppColors.darkSurface3 : AppColors.lightSurface3;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nutrition', style: theme.textTheme.displaySmall),
                          const SizedBox(height: 3),
                          Text('Wednesday, May 8', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                    _IconBtn(icon: Icons.calendar_today_outlined, onTap: () {}),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.search_rounded, color: text3, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('Search food or scan barcode...',
                            style: GoogleFonts.dmSans(fontSize: 14, color: text3)),
                      ),
                      Icon(Icons.qr_code_scanner_rounded, color: AppColors.accent, size: 20),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Daily calorie summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent.withOpacity(0.12), AppColors.accent.withOpacity(0.04)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Daily Calories', style: theme.textTheme.headlineLarge),
                              const SizedBox(height: 3),
                              Text('${data.consumedCalories} of ${data.targetCalories} consumed',
                                  style: theme.textTheme.bodySmall),
                            ],
                          ),
                          RichText(
                            text: TextSpan(
                              text: '${data.remainingCalories}',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.accent),
                              children: [
                                TextSpan(
                                  text: ' left',
                                  style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w400, color: text2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (_, __) => LinearProgressIndicator(
                            value: _progressAnimation.value * data.calorieProgress,
                            minHeight: 8,
                            backgroundColor: surface3,
                            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _MacroSummary(label: 'Protein', value: '${data.proteinG.toInt()}g', color: AppColors.orange),
                          _MacroSummary(label: 'Carbs', value: '${data.carbsG.toInt()}g', color: AppColors.blue),
                          _MacroSummary(label: 'Fat', value: '${data.fatG.toInt()}g', color: AppColors.purple),
                          _MacroSummary(label: 'Water', value: '1.25L', color: AppColors.blue),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Meals
              _MealSection(
                emoji: '🌅',
                mealName: 'Breakfast',
                calories: 342,
                bgColor: AppColors.orange.withOpacity(0.14),
                items: MockData.breakfastItems,
                isDark: isDark,
                surface: surface,
                border: border,
                onAdd: () => _openAddFoodSheet(context, 'Breakfast'),
              ),
              _MealSection(
                emoji: '☀️',
                mealName: 'Lunch',
                calories: 211,
                bgColor: AppColors.blue.withOpacity(0.14),
                items: MockData.lunchItems,
                isDark: isDark,
                surface: surface,
                border: border,
                onAdd: () => _openAddFoodSheet(context, 'Lunch'),
              ),
              _MealSection(
                emoji: '🌙',
                mealName: 'Dinner',
                calories: 0,
                bgColor: AppColors.purple.withOpacity(0.14),
                items: const [],
                isDark: isDark,
                surface: surface,
                border: border,
                onAdd: () => _openAddFoodSheet(context, 'Dinner'),
                empty: true,
              ),
              _MealSection(
                emoji: '🍎',
                mealName: 'Snacks',
                calories: 0,
                bgColor: AppColors.accent.withOpacity(0.14),
                items: const [],
                isDark: isDark,
                surface: surface,
                border: border,
                onAdd: () => _openAddFoodSheet(context, 'Snacks'),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Icon(icon, size: 18, color: isDark ? AppColors.darkText2 : AppColors.lightText2),
      ),
    );
  }
}

class _MacroSummary extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _MacroSummary({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: GoogleFonts.spaceGrotesk(fontSize: 15, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _MealSection extends StatelessWidget {
  final String emoji;
  final String mealName;
  final int calories;
  final Color bgColor;
  final List<FoodItem> items;
  final bool isDark;
  final Color surface;
  final Color border;
  final VoidCallback onAdd;
  final bool empty;

  const _MealSection({
    required this.emoji,
    required this.mealName,
    required this.calories,
    required this.bgColor,
    required this.items,
    required this.isDark,
    required this.surface,
    required this.border,
    required this.onAdd,
    this.empty = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final surface3 = isDark ? AppColors.darkSurface3 : AppColors.lightSurface3;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text(emoji, style: const TextStyle(fontSize: 15))),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(mealName, style: theme.textTheme.headlineSmall),
                      Text('$calories kcal', style: theme.textTheme.bodySmall),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onAdd,
                child: Text('+ Add',
                    style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (items.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: border),
              ),
              child: Column(
                children: List.generate(items.length, (i) {
                  final f = items[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(f.name,
                                      style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w500, color: text1)),
                                  const SizedBox(height: 2),
                                  Text(f.serving,
                                      style: GoogleFonts.dmSans(fontSize: 12, color: text2)),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${f.calories} kcal',
                                    style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: text1)),
                                const SizedBox(height: 2),
                                Text('P:${f.protein.toInt()} C:${f.carbs.toInt()} F:${f.fat.toInt()}',
                                    style: GoogleFonts.dmSans(fontSize: 11, color: text2)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (i < items.length - 1)
                        Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    ],
                  );
                }),
              ),
            )
          else if (empty)
            GestureDetector(
              onTap: onAdd,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: border, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Icons.add_circle_outline_rounded, size: 28, color: isDark ? AppColors.darkText3 : AppColors.lightText3),
                    const SizedBox(height: 6),
                    Text('Log your ${mealName.toLowerCase()}',
                        style: GoogleFonts.dmSans(fontSize: 13, color: isDark ? AppColors.darkText3 : AppColors.lightText3)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
