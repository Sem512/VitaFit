import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/app_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final appState = context.watch<AppState>();
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surface2 = isDark ? AppColors.darkSurface2 : AppColors.lightSurface2;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final text1 = isDark ? AppColors.darkText1 : AppColors.lightText1;
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
                      child: Text('Profile', style: theme.textTheme.displaySmall),
                    ),
                    _IconBtn(icon: Icons.settings_outlined, onTap: () {}),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Profile hero card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accent.withOpacity(0.15), AppColors.accent.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.accent.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      // Avatar
                      Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.accent, AppColors.accent2],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text('AJ',
                              style: GoogleFonts.spaceGrotesk(
                                  fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('Shimeles Abebe',
                          style: GoogleFonts.spaceGrotesk(
                              fontSize: 20, fontWeight: FontWeight.w700, color: text1)),
                      const SizedBox(height: 4),
                      Text('🎯 Cut to 75kg · Build Muscle',
                          style: GoogleFonts.dmSans(
                              fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _ProfileStat(
                              value: '183cm',
                              label: 'Height',
                              bgColor: surface2.withOpacity(0.6),
                              text1: text1,
                              text2: text2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ProfileStat(
                              value: '78.4kg',
                              label: 'Weight',
                              bgColor: surface2.withOpacity(0.6),
                              text1: text1,
                              text2: text2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ProfileStat(
                              value: '24',
                              label: 'Workouts',
                              bgColor: surface2.withOpacity(0.6),
                              text1: AppColors.accent,
                              text2: text2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Appearance
              _SettingsGroup(
                title: 'Appearance',
                children: [
                  _SettingsItem(
                    icon: Icons.dark_mode_outlined,
                    iconBgColor: AppColors.accentDim,
                    iconColor: AppColors.accent,
                    label: 'Dark Mode',
                    trailing: CupertinoSwitch(
                      value: appState.isDark,
                      onChanged: (_) => appState.toggleTheme(),
                      activeColor: AppColors.accent,
                    ),
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.text_fields_rounded,
                    iconBgColor: AppColors.blue.withOpacity(0.14),
                    iconColor: AppColors.blue,
                    label: 'Text Size',
                    trailing: Text('Medium', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                ],
              ),

              // Fitness goals
              _SettingsGroup(
                title: 'Fitness Goals',
                children: [
                  _SettingsItem(
                    icon: Icons.track_changes_rounded,
                    iconBgColor: AppColors.red.withOpacity(0.12),
                    iconColor: AppColors.red,
                    label: 'Goal Weight',
                    trailing: Text('75 kg', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.local_fire_department_outlined,
                    iconBgColor: AppColors.orange.withOpacity(0.14),
                    iconColor: AppColors.orange,
                    label: 'Daily Calories',
                    trailing: Text('2,400 kcal', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.directions_run_rounded,
                    iconBgColor: AppColors.accentDim,
                    iconColor: AppColors.accent,
                    label: 'Daily Steps',
                    trailing: Text('10,000', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.water_drop_outlined,
                    iconBgColor: AppColors.blue.withOpacity(0.14),
                    iconColor: AppColors.blue,
                    label: 'Water Goal',
                    trailing: Text('2.0 L / day', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                ],
              ),

              // Notifications
              _SettingsGroup(
                title: 'Notifications',
                children: [
                  _SettingsItem(
                    icon: Icons.notifications_outlined,
                    iconBgColor: AppColors.purple.withOpacity(0.14),
                    iconColor: AppColors.purple,
                    label: 'Workout Reminders',
                    trailing: CupertinoSwitch(value: true, onChanged: (_) {}, activeColor: AppColors.accent),
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.water_drop_outlined,
                    iconBgColor: AppColors.blue.withOpacity(0.14),
                    iconColor: AppColors.blue,
                    label: 'Water Reminders',
                    trailing: CupertinoSwitch(value: true, onChanged: (_) {}, activeColor: AppColors.accent),
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.restaurant_outlined,
                    iconBgColor: AppColors.orange.withOpacity(0.14),
                    iconColor: AppColors.orange,
                    label: 'Meal Reminders',
                    trailing: CupertinoSwitch(value: false, onChanged: (_) {}, activeColor: AppColors.accent),
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                ],
              ),

              // Units & Data
              _SettingsGroup(
                title: 'Units & Data',
                children: [
                  _SettingsItem(
                    icon: Icons.straighten_rounded,
                    iconBgColor: AppColors.orange.withOpacity(0.14),
                    iconColor: AppColors.orange,
                    label: 'Units',
                    trailing: Text('Metric', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.sync_rounded,
                    iconBgColor: AppColors.blue.withOpacity(0.14),
                    iconColor: AppColors.blue,
                    label: 'Sync Health Data',
                    trailing: Text('Connected', style: GoogleFonts.dmSans(fontSize: 13, color: AppColors.accent)),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                ],
              ),

              // Account
              _SettingsGroup(
                title: 'Account',
                children: [
                  _SettingsItem(
                    icon: Icons.person_outline_rounded,
                    iconBgColor: AppColors.accentDim,
                    iconColor: AppColors.accent,
                    label: 'Edit Profile',
                    trailing: const SizedBox(),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.lock_outline_rounded,
                    iconBgColor: AppColors.purple.withOpacity(0.14),
                    iconColor: AppColors.purple,
                    label: 'Privacy & Security',
                    trailing: const SizedBox(),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                  ),
                  _SettingsItem(
                    icon: Icons.logout_rounded,
                    iconBgColor: AppColors.red.withOpacity(0.12),
                    iconColor: AppColors.red,
                    label: 'Sign Out',
                    labelColor: AppColors.red,
                    trailing: const SizedBox(),
                    trailingArrow: true,
                    surface: surface,
                    border: border,
                    text1: text1,
                    onTap: () => _showSignOutDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Version
              Center(
                child: Text('VitaFit v1.0.0',
                    style: GoogleFonts.dmSans(fontSize: 12, color: text3)),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          CupertinoDialogAction(
            isDestructiveAction: false,
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Sign Out'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
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

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  final Color bgColor;
  final Color text1;
  final Color text2;
  const _ProfileStat({required this.value, required this.label, required this.bgColor, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(value,
              style: GoogleFonts.spaceGrotesk(fontSize: 16, fontWeight: FontWeight.w700, color: text1)),
          const SizedBox(height: 2),
          Text(label, style: GoogleFonts.dmSans(fontSize: 11, color: text2)),
        ],
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SettingsGroup({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(title.toUpperCase(),
                style: GoogleFonts.dmSans(
                    fontSize: 12, fontWeight: FontWeight.w500, color: text2, letterSpacing: 0.8)),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String label;
  final Color? labelColor;
  final Widget trailing;
  final bool trailingArrow;
  final Color surface;
  final Color border;
  final Color text1;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    this.labelColor,
    required this.trailing,
    this.trailingArrow = false,
    required this.surface,
    required this.border,
    required this.text1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: surface,
          border: Border(bottom: BorderSide(color: border, width: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(9)),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label,
                  style: GoogleFonts.dmSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: labelColor ?? text1)),
            ),
            trailing,
            if (trailingArrow) ...[
              const SizedBox(width: 4),
              Icon(Icons.chevron_right_rounded, color: text3, size: 18),
            ],
          ],
        ),
      ),
    );
  }
}
