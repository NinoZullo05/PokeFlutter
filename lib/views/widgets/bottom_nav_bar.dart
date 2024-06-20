import 'package:flutter/material.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/compare_page.dart';
import 'package:myapp/views/home_page.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final unselectedItemColor = gray[300];

    void navigateToPage(Widget page) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      );
    }

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            if (selectedIndex != 0) {
              navigateToPage(const HomePage());
            }
            break;
          case 1:
            if (selectedIndex != 1) {
              navigateToPage(const ComparePage());
            }
            break;
          case 2:
            // Esempio di navigazione per il terzo elemento (QuizPage)
            // Sostituisci `QuizPage()` con la tua pagina desiderata
            navigateToPage(const HomePage());
            break;
          case 3:
            // Esempio di navigazione per il quarto elemento (FavoritePage)
            // Sostituisci `FavoritePage()` con la tua pagina desiderata
            navigateToPage(const HomePage());
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
