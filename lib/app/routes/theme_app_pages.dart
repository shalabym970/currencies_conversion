import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import '../middleware/auth_middleware.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import 'app_routes.dart';

class ThemeAppPages {


  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeView(),
        binding: HomeBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.zoom),
  ];
}
