import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_state.dart';

class WorkoutsScreen extends StatefulWidget {
  const WorkoutsScreen({super.key});

  @override
  State<WorkoutsScreen> createState() => _WorkoutsScreenState();
}

class _WorkoutsScreenState extends State<WorkoutsScreen> {
  int _selectedCategory = 0;
  final _categories = ['All', 'Push', 'Pull', 'Legs', 'Cardio', 'Core'];

  List<WorkoutData> get _filteredWorkouts {
    if (_selectedCategory == 0) return MockData.workouts;
    final cat = _categories[_selectedCategory];
    return MockData.workouts.where((w) => w.category == cat).toList();
  }

  void _openExerciseSheet(BuildContext context, WorkoutData workout) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;

    showModalBottomSheet(
      context: context,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (_) => Padding(
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
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    color: workout.color.withOpacity(0.14),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(Icons.fitness_center_rounded, color: workout.color, size: 26),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(workout.name,
                          style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: text1)),
                      const SizedBox(height: 3),
                      Text(workout.muscles,
                          style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _SheetStat(label: 'Record', value: workout.pr, color: AppColors.accent, surface2: surface2),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SheetStat(label: 'Program', value: workout.program, color: text1, surface2: surface2),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Last Session',
                style: GoogleFonts.dmSans(fontSize: 14, fontWeight: FontWeight.w600, color: text1)),
            const SizedBox(height: 10),
            ...[ ['Set 1', '80 kg × 10'], ['Set 2', '82.5 kg × 8'], ['Set 3', '82.5 kg × 7'], ['Set 4', '80 kg × 8'] ]
                .map((s) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(
                          color: surface2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(s[0], style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                            Text(s[1], style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w600, color: text1)),
                          ],
                        ),
                      ),
                    )),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Start This Exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface3 = isDark ? AppColors.darkSurface3 : AppColors.lightSurface3;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;

    return Scaffold(
      body: SafeArea(
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
                        Text('Workouts', style: theme.textTheme.displaySmall),
                        const SizedBox(height: 3),
                        Text('Choose your training focus', style: theme.textTheme.bodySmall),
                      ],
                    ),
                  ),
                  _IconBtn(icon: Icons.search_rounded, onTap: () {}),
                ],
              ),
            ),

            // Stats row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Expanded(child: _StatMini(value: '24', label: 'Workouts', color: AppColors.accent, surface: surface, border: border)),
                  const SizedBox(width: 10),
                  Expanded(child: _StatMini(value: '48,230', label: 'Volume kg', color: isDark ? AppColors.darkText1 : AppColors.lightText1, surface: surface, border: border)),
                  const SizedBox(width: 10),
                  Expanded(child: _StatMini(value: '6 🔥', label: 'Day Streak', color: AppColors.orange, surface: surface, border: border)),
                ],
              ),
            ),

            // Category chips
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final active = _selectedCategory == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: active ? AppColors.accent : surface,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: active ? AppColors.accent : border),
                      ),
                      child: Text(
                        _categories[i],
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: active ? Colors.white : text2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Push / Pull / Legs', style: theme.textTheme.headlineLarge),
            ),
            const SizedBox(height: 12),

            // Exercise list
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredWorkouts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) {
                  final w = _filteredWorkouts[i];
                  return GestureDetector(
                    onTap: () => _openExerciseSheet(context, w),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: surface,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(
                              color: w.color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(Icons.fitness_center_rounded, color: w.color, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(w.name, style: theme.textTheme.headlineSmall),
                                const SizedBox(height: 2),
                                Text(w.muscles, style: theme.textTheme.bodySmall),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentDim,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text('PR: ${w.pr}',
                                      style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.accent)),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded, color: text3),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Start workout button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.play_arrow_rounded, size: 22),
                  label: const Text('Start Push Day A'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    textStyle: GoogleFonts.dmSans(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
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

class _StatMini extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final Color surface;
  final Color border;
  const _StatMini({required this.value, required this.label, required this.color, required this.surface, required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 3),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _SheetStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color surface2;
  const _SheetStat({required this.label, required this.value, required this.color, required this.surface2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: surface2, borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: color),
              textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.labelSmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
