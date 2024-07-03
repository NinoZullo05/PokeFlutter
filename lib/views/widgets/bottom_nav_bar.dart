import 'package:flutter/material.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/compare_page.dart';
import 'package:myapp/views/favourite_page.dart';
import 'package:myapp/views/home_page.dart';
import 'package:myapp/views/quiz_page.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unselectedItemColor = gray[300];

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            if (selectedIndex != 0) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const HomePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
            break;
          case 1:
            if (selectedIndex != 1) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const ComparePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
            break;
          case 2:
            if (selectedIndex != 2) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const QuizPage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
            break;
          case 3:
            if (selectedIndex != 3) {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      const FavouritePage(),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            }
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compare_arrows),
          label: "Compare",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: "Quiz",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Favorite",
        ),
      ],
      selectedLabelStyle: textTheme.labelMedium,
      unselectedLabelStyle:
          textTheme.labelMedium?.copyWith(color: unselectedItemColor),
      showUnselectedLabels: true,
      selectedItemColor: gray[400],
      unselectedItemColor: unselectedItemColor,
    );
  }
}
