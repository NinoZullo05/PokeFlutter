import 'package:flutter/material.dart';
import 'package:myapp/Utils/palette.dart';
import 'package:myapp/views/home_page.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            if (selectedIndex != 0) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
              Navigator.pop(context);
            }

            break;
          case 1:
            if (selectedIndex != 1) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            break;
          case 2:
            if (selectedIndex != 2) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            break;
          case 3:
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
            break;
          default:
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows), label: "Compare"),
        BottomNavigationBarItem(icon: Icon(Icons.quiz), label: "Quiz"),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: "Favorite"),
      ],
      selectedLabelStyle: textTheme.labelMedium,
      unselectedLabelStyle: textTheme.labelMedium?.copyWith(color: gray[300]),
      showUnselectedLabels: true,
      selectedItemColor: gray[400], // Colore dell'icona selezionata
      unselectedItemColor: gray[300], // Colore dell'icona non selezionata
    );
  }
}
