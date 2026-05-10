import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final text2 = isDark ? AppColors.darkText2 : AppColors.lightText2;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final border = isDark ? AppColors.darkBorder : AppColors.lightBorder;

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
                    color: surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: border),
                  ),
                  child: Icon(Icons.arrow_back_rounded, size: 18,
                      color: isDark ? AppColors.darkText1 : AppColors.lightText1),
                ),
              ),

              const SizedBox(height: 32),

              if (!_emailSent) ...[
                Text('Reset\nPassword 🔑', style: theme.textTheme.displayMedium),
                const SizedBox(height: 10),
                Text(
                  "Enter your email and we'll send you a link to reset your password.",
                  style: theme.textTheme.bodyLarge?.copyWith(color: text2),
                ),
                const SizedBox(height: 40),

                _FieldLabel(label: 'Email Address'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: theme.textTheme.bodyLarge,
                  decoration: const InputDecoration(hintText: 'you@example.com'),
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleReset,
                    child: _isLoading
                        ? const SizedBox(
                            width: 22, height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ),
                          )
                        : const Text('Send Reset Link'),
                  ),
                ),
              ] else ...[
                // Success state
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.accentDim,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.mark_email_read_outlined,
                        color: AppColors.accent, size: 38),
                  ),
                ),
                const SizedBox(height: 28),
                Center(
                  child: Text('Check your email',
                      style: theme.textTheme.displaySmall),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "We've sent a password reset link to\n${_emailController.text.isNotEmpty ? _emailController.text : 'your email'}",
                    style: theme.textTheme.bodyLarge?.copyWith(color: text2),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Sign In'),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () => setState(() => _emailSent = false),
                    child: Text(
                      "Didn't receive it? Resend",
                      style: GoogleFonts.dmSans(
                          fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.accent),
                    ),
                  ),
                ),
              ],

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
