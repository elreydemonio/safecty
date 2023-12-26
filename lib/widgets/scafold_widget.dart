import 'package:flutter/material.dart';
import 'package:safecty/theme/app_colors.dart';
import 'package:safecty/theme/spacing.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            backgroundColor: Colors.orange.shade900,
            centerTitle: true,
            toolbarHeight: 1.0,
          ),
          Container(
            color: Colors.orange,
            child: MyCustomNavigationBar(
              selectedIndex: selectedIndex,
              onTabSelected: onTabSelected,
            ),
          ),
          Expanded(
            child: Center(
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomNavigationBar extends StatelessWidget {
  const MyCustomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: buildNavItem(
            context,
            Icons.home,
            "Inicio",
            "/home",
            0,
          ),
        ),
        Expanded(
          child: buildNavItem(
            context,
            Icons.search,
            "Buscar",
            "/search",
            1,
          ),
        ),
        Expanded(
          child: buildNavItem(
            context,
            Icons.person,
            "Perfil",
            "/profile",
            2,
          ),
        ),
      ],
    );
  }

  Widget buildNavItem(BuildContext context, IconData icon, String label,
      String route, int index) {
    return InkWell(
      onTap: () {
        onTabSelected(index);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        padding: const EdgeInsets.all(Spacing.medium),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIndex == index
                    ? Colors.grey.withOpacity(0.4)
                    : Colors.transparent,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                icon,
                color: AppColors.black,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
