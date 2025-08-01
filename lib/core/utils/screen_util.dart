import 'package:rick_and_morty/app_imports.dart';

class MainPageInit extends StatelessWidget {
  final Widget child;

  const MainPageInit({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomToast.parent(
      child: OrientationBuilder(
        builder: (_, orientation) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },

            child: child,
          );
        },
      ),
    );
  }
}

extension ResponsiveContext on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 1024;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1024;
}
