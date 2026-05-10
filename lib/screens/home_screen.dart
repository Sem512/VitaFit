import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/app_state.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _ringController;
  late AnimationController _barsController;
  late Animation<double> _ringAnimation;
  late Animation<double> _barsAnimation;
  late AnimationController _bellController;

  final List<bool> _waterFilled = List.generate(8, (i) => i < 5);

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _barsController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _ringAnimation = CurvedAnimation(parent: _ringController, curve: Curves.easeOutCubic);
    _barsAnimation = CurvedAnimation(parent: _barsController, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 200), () {
      _ringController.forward();
      _barsController.forward();
    });
    _bellController = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 500),
);
  }

  @override
  void dispose() {
    _ringController.dispose();
    _barsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final surface3 = isDark ? AppColors.darkSurface3 : AppColors.lightSurface3;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final data = MockData.nutrition;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── TOP BAR ──────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Good morning, Shimeles',
                              style: theme.textTheme.displaySmall),
                          const SizedBox(height: 3),
                          Text('Wednesday, May 8 · Stay consistent!',
                              style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                   AnimatedBuilder(
  animation: _bellController,
  builder: (context, child) {
    return Transform.rotate(
      angle: math.sin(_bellController.value * math.pi * 8) *
    (1 - _bellController.value) *
    0.25,
      child: child,
    );
  },
  child: _IconBtn(
    icon: Icons.notifications_outlined,
    onTap: () {
      _bellController.forward(from: 0);
    },
  ),
),
                    const SizedBox(width: 10),
                    _AvatarBtn(initials: 'SH'),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── CALORIE RING CARD ────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.15),
                        AppColors.accent2.withOpacity(0.06),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left macros
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MacroStat(value: '${data.proteinG.toInt()}g', label: 'Protein', color: AppColors.orange),
                          const SizedBox(height: 16),
                          _MacroStat(value: '${data.carbsG.toInt()}g', label: 'Carbs', color: AppColors.blue),
                        ],
                      ),
                      // Center ring
                      Column(
                        children: [
                          AnimatedBuilder(
                            animation: _ringAnimation,
                            builder: (context, _) {
                              return SizedBox(
                                width: 120,
                                height: 120,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CustomPaint(
                                      size: const Size(120, 120),
                                      painter: _RingPainter(
                                        progress: _ringAnimation.value * data.calorieProgress,
                                        trackColor: isDark
                                            ? Colors.white.withOpacity(0.06)
                                            : Colors.black.withOpacity(0.06),
                                        progressColor: AppColors.accent,
                                        strokeWidth: 10,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${data.remainingCalories}',
                                          style: GoogleFonts.spaceGrotesk(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                        Text('remaining',
                                            style: GoogleFonts.dmSans(
                                                fontSize: 10,
                                                color: text2,
                                                letterSpacing: 0.3)),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'of ${data.targetCalories} kcal',
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),
                      // Right macros
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _MacroStat(value: '${data.fatG.toInt()}g', label: 'Fat', color: AppColors.purple, alignRight: true),
                          const SizedBox(height: 16),
                          _MacroStat(value: '${data.consumedCalories}', label: 'Consumed', color: text2, alignRight: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── MACRO PROGRESS CARDS ─────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: _MacroCard(
                        label: 'Protein',
                        value: '${data.proteinG.toInt()}g',
                        progress: data.proteinProgress,
                        color: AppColors.orange,
                        letter: 'P',
                        surface: surface,
                        border: border,
                        surface3: surface3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MacroCard(
                        label: 'Carbs',
                        value: '${data.carbsG.toInt()}g',
                        progress: data.carbsProgress,
                        color: AppColors.blue,
                        letter: 'C',
                        surface: surface,
                        border: border,
                        surface3: surface3,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _MacroCard(
                        label: 'Fat',
                        value: '${data.fatG.toInt()}g',
                        progress: data.fatProgress,
                        color: AppColors.purple,
                        letter: 'F',
                        surface: surface,
                        border: border,
                        surface3: surface3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── WATER INTAKE ────────────────────────────────────
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
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.blue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.water_drop_outlined, color: AppColors.blue, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Water Intake', style: theme.textTheme.headlineSmall),
                                Text('${_waterFilled.where((v) => v).length} of 8 glasses',
                                    style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                          Text(
                            '${(_waterFilled.where((v) => v).length * 0.25).toStringAsFixed(2)}L',
                            style: GoogleFonts.spaceGrotesk(
                                fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: List.generate(8, (i) {
                          final filled = _waterFilled[i];
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => setState(() => _waterFilled[i] = !_waterFilled[i]),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                height: 34,
                                decoration: BoxDecoration(
                                  color: filled ? AppColors.blue.withOpacity(0.18) : surface2,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: filled ? AppColors.blue.withOpacity(0.5) : border,
                                    width: 1.2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.water_drop,
                                  size: 14,
                                  color: filled ? AppColors.blue : (isDark ? AppColors.darkText3 : AppColors.lightText3),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── STEPS CARD ───────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.accentDim,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.directions_run_rounded, color: AppColors.accent, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('7,284',
                                    style: GoogleFonts.spaceGrotesk(
                                        fontSize: 24, fontWeight: FontWeight.w700,
                                        color: isDark ? AppColors.darkText1 : AppColors.lightText1)),
                                Text('Goal: 10,000', style: theme.textTheme.bodySmall),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: AnimatedBuilder(
                                animation: _barsAnimation,
                                builder: (context, _) => LinearProgressIndicator(
                                  value: _barsAnimation.value * 0.7284,
                                  minHeight: 6,
                                  backgroundColor: surface3,
                                  valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text('72.8% · 2,716 steps remaining',
                                style: theme.textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── WEEKLY ACTIVITY ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Weekly Activity', style: theme.textTheme.headlineLarge),
                    Text('Details',
                        style: theme.textTheme.labelLarge?.copyWith(color: AppColors.accent)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: border),
                  ),
                  child: AnimatedBuilder(
                    animation: _barsAnimation,
                    builder: (context, _) {
                      return SizedBox(
                        height: 80,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: List.generate(7, (i) {
                            final val = MockData.weeklyActivity[i];
                            final day = ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i];
                            final isToday = i == 2;
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: AnimatedContainer(
                                              duration: Duration(milliseconds: 400 + i * 80),
                                              curve: Curves.easeOutCubic,
                                              height: val == 0
                                                  ? 8
                                                  : (52 * val * _barsAnimation.value).clamp(8, 52),
                                              color: isToday
                                                  ? AppColors.accent
                                                  : val == 0
                                                      ? surface3
                                                      : AppColors.accent.withOpacity(0.4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(day,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 10,
                                          fontWeight: isToday ? FontWeight.w600 : FontWeight.w400,
                                          color: isToday
                                              ? AppColors.accent
                                              : (isDark ? AppColors.darkText3 : AppColors.lightText3),
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ── TODAY'S WORKOUT ──────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Workout", style: theme.textTheme.headlineLarge),
                    Text('See all',
                        style: theme.textTheme.labelLarge?.copyWith(color: AppColors.accent)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accent.withOpacity(0.10),
                          AppColors.accent2.withOpacity(0.04),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.accent.withOpacity(0.15)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Push Day A', style: theme.textTheme.headlineLarge),
                              const SizedBox(height: 4),
                              Text('Chest · Shoulders · Triceps',
                                  style: theme.textTheme.bodySmall),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  _Chip(label: '8 Exercises', color: AppColors.accent),
                                  const SizedBox(width: 8),
                                  _Chip(
                                    label: '~55 min',
                                    color: isDark ? AppColors.darkText2 : AppColors.lightText2,
                                    bgColor: surface2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accent.withOpacity(0.4),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 30),
                        ),
                      ],
                    ),
                  ),
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

// ── SUBWIDGETS ────────────────────────────────────────────────────────────────

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
        width: 40,
        height: 40,
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

class _AvatarBtn extends StatelessWidget {
  final String initials;
  const _AvatarBtn({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [AppColors.accent, AppColors.accent2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(initials,
            style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white)),
      ),
    );
  }
}

class _MacroStat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final bool alignRight;
  const _MacroStat({required this.value, required this.label, required this.color, this.alignRight = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(value,
            style: GoogleFonts.spaceGrotesk(fontSize: 20, fontWeight: FontWeight.w700, color: color)),
        const SizedBox(height: 2),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _MacroCard extends StatelessWidget {
  final String label;
  final String value;
  final double progress;
  final Color color;
  final String letter;
  final Color surface;
  final Color border;
  final Color surface3;

  const _MacroCard({
    required this.label,
    required this.value,
    required this.progress,
    required this.color,
    required this.letter,
    required this.surface,
    required this.border,
    required this.surface3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: border),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(letter,
                  style: GoogleFonts.spaceGrotesk(
                      fontSize: 14, fontWeight: FontWeight.w700, color: color)),
            ),
          ),
          const SizedBox(height: 8),
          Text(value,
              style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.darkText1
                      : AppColors.lightText1)),
          const SizedBox(height: 2),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 4,
              backgroundColor: surface3,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final Color color;
  final Color? bgColor;
  const _Chip({required this.label, required this.color, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor ?? color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: color)),
    );
  }
}

// ── RING PAINTER ──────────────────────────────────────────────────────────────

class _RingPainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  const _RingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    const startAngle = -1.5707963; // -π/2 (top)
    const fullAngle = 6.2831853; // 2π

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      fullAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) => old.progress != progress;
}
