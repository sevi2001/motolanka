import 'package:flutter/material.dart';

void main() {
  runApp(const MotoLankaApp());
}

const brandRed = Color(0xFFE50920);
const darkText = Color(0xFF191C24);

class MotoLankaApp extends StatelessWidget {
  const MotoLankaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MotoLanka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brandRed),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F8FA),
          foregroundColor: darkText,
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeScreen(onExplore: () => setState(() => selectedIndex = 1)),
          const StarterPage(
            title: 'Explore',
            icon: Icons.search,
            message: 'Bike and spare part listings will be added next.',
          ),
          const StarterPage(
            title: 'Saved items',
            icon: Icons.favorite_outline,
            message: 'Your favourite bikes and parts will appear here.',
          ),
          const StarterPage(
            title: 'Sell an item',
            icon: Icons.add_circle_outline,
            message: 'The bike and spare part listing form is coming next.',
          ),
          const StarterPage(
            title: 'My profile',
            icon: Icons.person_outline,
            message: 'Your account and listings will appear here.',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        indicatorColor: brandRed.withValues(alpha: 0.12),
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: brandRed),
            label: 'Home',
          ),
          NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            label: 'Saved',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Sell',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onExplore});

  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Row(
                children: [
                  Icon(Icons.two_wheeler, color: brandRed, size: 34),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'MotoLanka',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: darkText,
                      ),
                    ),
                  ),
                  Icon(Icons.location_on_outlined, size: 18),
                  SizedBox(width: 4),
                  Text('Sri Lanka'),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Your next ride\nstarts here',
                style: TextStyle(
                  fontSize: 34,
                  height: 1.15,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Discover motorbikes, spare parts, and accessories.',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: darkText,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.two_wheeler,
                      size: 62,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Find your next bike',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Explore bikes and parts in one place.',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: onExplore,
                      style: FilledButton.styleFrom(
                        backgroundColor: brandRed,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('Explore now'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Browse categories',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  CategoryCard(
                    title: 'Motorbikes',
                    icon: Icons.two_wheeler,
                    onTap: onExplore,
                  ),
                  CategoryCard(
                    title: 'Spare parts',
                    icon: Icons.settings_outlined,
                    onTap: () => showComingSoon(context, 'Spare parts'),
                  ),
                  CategoryCard(
                    title: 'Accessories',
                    icon: Icons.sports_motorsports_outlined,
                    onTap: () => showComingSoon(context, 'Accessories'),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Featured bikes',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              const Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Icon(Icons.two_wheeler, size: 42, color: brandRed),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          'We’ll add your bike photos and sample '
                          'listings in the next step.',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showComingSoon(BuildContext context, String category) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text('$category will be added in a later step.')),
      );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
            child: Column(
              children: [
                Icon(icon, size: 36, color: brandRed),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StarterPage extends StatelessWidget {
  const StarterPage({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
  });

  final String title;
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 64, color: brandRed),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
