import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/app_input_field.dart';

/// Screen 01 – Sign In
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController(text: 'designslab');
  final _passwordCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onSignIn() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        backgroundColor: AppColors.scaffold,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: AppSizes.paddingM),
          child: GestureDetector(
            onTap: () => Navigator.maybePop(context),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.inputBg,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.textDark,
                size: AppSizes.iconS,
              ),
            ),
          ),
        ),
        title: Text(
          'Sign In',
          style: GoogleFonts.poppins(
            color: AppColors.textDark,
            fontSize: AppSizes.fontL,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingL),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSizes.paddingXL),

                // ── Headline ────────────────────────────────
                Text(
                  'Signin to Your Account',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),

                const SizedBox(height: AppSizes.paddingXL),

                // ── Username ────────────────────────────────
                AppInputField(
                  label: 'Username',
                  hint: 'designslab',
                  controller: _usernameCtrl,
                  keyboardType: TextInputType.text,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Enter your username' : null,
                ),

                const SizedBox(height: AppSizes.paddingM),

                // ── Password ────────────────────────────────
                AppInputField(
                  label: 'Password',
                  hint: 'Password',
                  controller: _passwordCtrl,
                  obscureText: _obscurePassword,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Enter your password' : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textLight,
                      size: AppSizes.iconM,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingM),

                // ── Remember Me + Forgot Password ───────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          setState(() => _rememberMe = !_rememberMe),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: _rememberMe
                                  ? AppColors.primary
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.paddingXS),
                              border: Border.all(
                                color: _rememberMe
                                    ? AppColors.primary
                                    : AppColors.textLight,
                                width: 1.5,
                              ),
                            ),
                            child: _rememberMe
                                ? const Icon(Icons.check,
                                    color: AppColors.textWhite, size: 14)
                                : null,
                          ),
                          const SizedBox(width: AppSizes.paddingS),
                          Text(
                            'Remember Me',
                            style: GoogleFonts.poppins(
                              fontSize: AppSizes.fontM,
                              color: AppColors.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          fontSize: AppSizes.fontM,
                          color: AppColors.danger,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSizes.paddingXL),

                // ── Sign In Button ───────────────────────────
                PrimaryButton(
                  label: 'Sign In',
                  onPressed: _onSignIn,
                ),

                const SizedBox(height: AppSizes.paddingL),

                // ── Sign Up Link ─────────────────────────────
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account ? ",
                      style: GoogleFonts.poppins(
                        fontSize: AppSizes.fontM,
                        color: AppColors.textMedium,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: GoogleFonts.poppins(
                            fontSize: AppSizes.fontM,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSizes.paddingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
