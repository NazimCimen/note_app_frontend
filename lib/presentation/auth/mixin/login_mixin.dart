import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/presentation/auth/bloc/auth_cubit.dart';
import 'package:flutter_note_app/presentation/auth/view/login_view.dart';

mixin LoginMixin on State<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final ValueNotifier<bool> _obscureVN;

  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  ValueNotifier<bool> get obscureListenable => _obscureVN;
  bool get obscure => _obscureVN.value;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureVN = ValueNotifier<bool>(true);
    // Artık go_router otomatik olarak deep link'leri yakalıyor
    // deepLink(context: context); // Bu satırı kaldırdık
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _obscureVN.dispose();
    super.dispose();
  }

  Future<void> login(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (_validateForm()) {
      await context.read<AuthCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  bool _validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void changeObsecureText() {
    _obscureVN.value = !_obscureVN.value;
  }
}
