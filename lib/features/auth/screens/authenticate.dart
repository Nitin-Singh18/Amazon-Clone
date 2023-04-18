import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../home/screens/home_screen.dart';
import '../services/auth_service.dart';
import 'auth_screen.dart';

class Authentication extends StatefulWidget {
  Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<UserProvider>().user.token.isNotEmpty
        ? const HomeScreen()
        : const AuthScreen();
  }
}
