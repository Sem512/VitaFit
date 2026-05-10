import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final text3 = isDark ? AppColors.darkText3 : AppColors.lightText3;
    final border2 = isDark ? AppColors.darkBorder2 : AppColors.lightBorder2;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  ),
                  child: Icon(Icons.arrow_back_rounded, size: 18,
                      color: isDark ? AppColors.darkText1 : AppColors.lightText1),
                ),
              ),

              const SizedBox(height: 32),

              Text('Create\nAccount ✦', style: theme.textTheme.displayMedium),
              const SizedBox(height: 10),
              Text('Start your transformation today',
                  style: theme.textTheme.bodyLarge?.copyWith(color: text2)),

              const SizedBox(height: 40),

              _FieldLabel(label: 'Full Name'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.name,
                textCapitalization: TextCapitalization.words,
                style: theme.textTheme.bodyLarge,
                decoration: const InputDecoration(hintText: 'Shimeles Abebe'),
              ),

              const SizedBox(height: 16),

              _FieldLabel(label: 'Email Address'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: theme.textTheme.bodyLarge,
                decoration: const InputDecoration(hintText: 'you@example.com'),
              ),

              const SizedBox(height: 16),

              _FieldLabel(label: 'Password'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Min. 8 characters',
                  suffixIcon: IconButton(
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: text3, size: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password strength indicator
              _PasswordStrength(password: _passwordController.text),

              const SizedBox(height: 20),

              // Terms checkbox
              GestureDetector(
                onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 22, height: 22,
                      decoration: BoxDecoration(
                        color: _agreedToTerms ? AppColors.accent : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreedToTerms ? AppColors.accent : border2,
                          width: 1.5,
                        ),
                      ),
                      child: _agreedToTerms
                          ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: 'I agree to the ',
                          style: GoogleFonts.dmSans(fontSize: 13, color: text2),
                          children: [
                            TextSpan(
                              text: 'Terms of Service',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent),
                            ),
                            TextSpan(text: ' and ', style: GoogleFonts.dmSans(fontSize: 13, color: text2)),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.dmSans(
                                  fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.accent),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: (_isLoading || !_agreedToTerms) ? null : _handleSignup,
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: AppColors.accent.withOpacity(0.4),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Text('Create Account'),
                ),
              ),

              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.dmSans(fontSize: 14, color: text2),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: GoogleFonts.dmSans(
                              fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.accent),
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

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Text(label,
        style: GoogleFonts.dmSans(
          fontSize: 13, fontWeight: FontWeight.w500,
          color: isDark ? AppColors.darkText2 : AppColors.lightText2,
          letterSpacing: 0.2,
        ));
  }
}

class _PasswordStrength extends StatelessWidget {
  final String password;
  const _PasswordStrength({required this.password});

  int get _strength {
    if (password.isEmpty) return 0;
    int score = 0;
    if (password.length >= 8) score++;
    if (password.contains(RegExp(r'[A-Z]'))) score++;
    if (password.contains(RegExp(r'[0-9]'))) score++;
    if (password.contains(RegExp(r'[!@#\$%^&*]'))) score++;
    return score;
  }

  String get _label {
    switch (_strength) {
      case 1: return 'Weak';
      case 2: return 'Fair';
      case 3: return 'Good';
      case 4: return 'Strong';
      default: return '';
    }
  }

  Color get _color {
    switch (_strength) {
      case 1: return AppColors.red;
      case 2: return AppColors.orange;
      case 3: return AppColors.blue;
      case 4: return AppColors.accent;
      default: return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final surface3 = isDark ? AppColors.darkSurface3 : AppColors.lightSurface3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) => Expanded(
            child: Container(
              height: 3,
              margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
              decoration: BoxDecoration(
                color: i < _strength ? _color : surface3,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          )),
        ),
        const SizedBox(height: 6),
        Text('Password strength: $_label',
            style: GoogleFonts.dmSans(fontSize: 12, color: _color)),
      ],
    );
  }
}
