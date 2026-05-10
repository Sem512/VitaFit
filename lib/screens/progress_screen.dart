import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../models/app_state.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
  int _selectedPeriod = 0;
  final _periods = ['Weekly', 'Monthly', 'All Time'];

  static const _prs = [
    {'name': 'Bench Press', 'value': '132.5 kg', 'date': 'May 5, 2026', 'color': AppColors.accent},
    {'name': 'Back Squat', 'value': '160 kg', 'date': 'Apr 28, 2026', 'color': AppColors.blue},
    {'name': 'Deadlift', 'value': '200 kg', 'date': 'Apr 20, 2026', 'color': AppColors.purple},
    {'name': 'Overhead Press', 'value': '85 kg', 'date': 'Apr 15, 2026', 'color': AppColors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final border2 = isDark ? AppColors.darkBorder2 : AppColors.lightBorder2;
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;
    final gridColor = isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.05);

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Progress', style: theme.textTheme.displaySmall),
                    const SizedBox(height: 3),
                    Text('Track your transformation', style: theme.textTheme.bodySmall),
                  ],
                ),
              ),

              // Period toggle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: List.generate(_periods.length, (i) {
                    final active = _selectedPeriod == i;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < _periods.length - 1 ? 8 : 0),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedPeriod = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: 36,
                            decoration: BoxDecoration(
                              color: active ? AppColors.accent : surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: active ? AppColors.accent : border),
                            ),
                            child: Center(
                              child: Text(_periods[i],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: active ? Colors.white : text2,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 8),

              // Weight chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Weight', style: theme.textTheme.headlineLarge),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: '78.4',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 28, fontWeight: FontWeight.w700, color: text1),
                                  children: [
                                    TextSpan(
                                      text: ' kg',
                                      style: GoogleFonts.dmSans(
                                          fontSize: 14, fontWeight: FontWeight.w400, color: text2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text('↓ 0.6 kg this week',
                                  style: GoogleFonts.dmSans(
                                      fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Goal', style: GoogleFonts.dmSans(fontSize: 12, color: text2)),
                              Text('75 kg',
                                  style: GoogleFonts.spaceGrotesk(
                                      fontSize: 16, fontWeight: FontWeight.w600, color: text1)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 160,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (_) => FlLine(color: gridColor, strokeWidth: 1),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (v, _) => Text('${v.toInt()}kg',
                                      style: GoogleFonts.dmSans(fontSize: 10, color: text3)),
                                ),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (v, _) {
                                    final days = MockData.weekDays;
                                    final i = v.toInt();
                                    if (i >= 0 && i < days.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(days[i],
                                            style: GoogleFonts.dmSans(fontSize: 10, color: text3)),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            minX: 0,
                            maxX: 6,
                            minY: 77.5,
                            maxY: 80,
                            lineBarsData: [
                              LineChartBarData(
                                spots: List.generate(7, (i) => FlSpot(i.toDouble(), MockData.weeklyWeight[i])),
                                isCurved: true,
                                curveSmoothness: 0.35,
                                color: AppColors.accent,
                                barWidth: 2.5,
                                dotData: FlDotData(
                                  getDotPainter: (_, __, ___, i) => FlDotCirclePainter(
                                    radius: 4,
                                    color: AppColors.accent,
                                    strokeWidth: 2,
                                    strokeColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                                  ),
                                ),
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [AppColors.accent.withOpacity(0.2), AppColors.accent.withOpacity(0.0)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Calories chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Calories', style: theme.textTheme.headlineLarge),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Avg this week', style: theme.textTheme.bodySmall),
                          Text('2,187 kcal',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.accent)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 160,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                              getDrawingHorizontalLine: (_) => FlLine(color: gridColor, strokeWidth: 1),
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (v, _) {
                                    final i = v.toInt();
                                    if (i >= 0 && i < MockData.weekDays.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(MockData.weekDays[i],
                                            style: GoogleFonts.dmSans(fontSize: 10, color: text3)),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                            barGroups: List.generate(7, (i) {
                              final v = MockData.weeklyCalories[i];
                              final color = v == 0
                                  ? (isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.06))
                                  : v > 2400
                                      ? AppColors.red.withOpacity(0.7)
                                      : AppColors.accent.withOpacity(0.7);
                              return BarChartGroupData(
                                x: i,
                                barRods: [
                                  BarChartRodData(
                                    toY: v == 0 ? 200 : v,
                                    color: color,
                                    width: 24,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Personal records
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('Personal Records', style: theme.textTheme.headlineLarge),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: _prs.map((pr) {
                    final color = pr['color'] as Color;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
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
                              width: 44, height: 44,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.14),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.fitness_center_rounded, color: color, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pr['name'] as String, style: theme.textTheme.headlineSmall),
                                  const SizedBox(height: 2),
                                  Text(pr['date'] as String, style: theme.textTheme.labelSmall),
                                ],
                              ),
                            ),
                            Text(pr['value'] as String,
                                style: GoogleFonts.spaceGrotesk(
                                    fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.accent)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 16),

              // Progress photos
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Progress Photos', style: theme.textTheme.headlineLarge),
                    Text('Add Photo',
                        style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _PhotoPlaceholder(label: 'April 2026', isDark: isDark, border: border2),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PhotoPlaceholder(label: 'May 2026', isDark: isDark, border: border2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoPlaceholder extends StatelessWidget {
  final String label;
  final bool isDark;
  final Color border;
  const _PhotoPlaceholder({required this.label, required this.isDark, required this.border});

  @override
  Widget build(BuildContext context) {
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: border, style: BorderStyle.solid),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_a_photo_outlined, size: 28, color: text3),
            const SizedBox(height: 8),
            Text(label, style: GoogleFonts.dmSans(fontSize: 12, color: text3)),
          ],
        ),
      ),
    );
  }
}
