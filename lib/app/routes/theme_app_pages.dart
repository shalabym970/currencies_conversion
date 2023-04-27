import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../middleware/auth_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/login_view.dart';
import 'app_routes.dart';

class ThemeAppPages {


  static final routes = [
    GetPage(
        name: Routes.login,
        page: () => const LoginView(),
        binding: AuthBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.zoom),
  ];
}
