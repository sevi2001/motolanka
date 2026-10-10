import 'package:flutter/material.dart';

const bikeRed = Color(0xFFE50920);

class Bike {
  const Bike({
    required this.name,
    required this.price,
    required this.year,
    required this.mileage,
    required this.location,
    required this.images,
  });

  final String name;
  final String price;
  final int year;
  final String mileage;
  final String location;
  final List<String> images;
}

// Sample listings, not real advertisements.
const demoBikes = [
  Bike(
    name: 'TVS Apache RTR',
    price: 'LKR 650,000',
    year: 2022,
    mileage: '18,000 km',
    location: 'Colombo',
    images: ['assets/bikes/apache_rtr.png'],
  ),
  Bike(
    name: 'TVS Raider',
    price: 'LKR 520,000',
    year: 2023,
    mileage: '12,000 km',
    location: 'Kandy',
    images: ['assets/bikes/raider.png'],
  ),
];

class BikesScreen extends StatefulWidget {
  const BikesScreen({super.key});

  @override
  State<BikesScreen> createState() => _BikesScreenState();
}

class _BikesScreenState extends State<BikesScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = demoBikes.where((bike) {
      final searchable = '${bike.name} ${bike.location}'.toLowerCase();
      return searchable.contains(query.trim().toLowerCase());
    }).toList();

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'Motorbikes',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Explore sample bike listings.',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  hintText: 'Search bike model or town',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${filtered.length} listings',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (filtered.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No bikes found. Try another model or town.',
                    textAlign: TextAlign.center,
                  ),
                ),
              for (final bike in filtered)
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 18),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => BikeDetailsScreen(bike: bike),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BikePhoto(path: bike.images.first),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bike.name,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                bike.price,
                                style: const TextStyle(
                                  color: bikeRed,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${bike.year} · ${bike.mileage} · '
                                '${bike.location}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const SizedBox(height: 12),
                              const Row(
                                children: [
                                  Text('View details'),
                                  Spacer(),
                                  Icon(Icons.arrow_forward, color: bikeRed),
                                ],
                              ),
                            ],
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
}

class BikePhoto extends StatelessWidget {
  const BikePhoto({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      color: const Color(0xFFE2E2E4),
      padding: const EdgeInsets.all(12),
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.two_wheeler, size: 64, color: Color(0xFFE50920)),
                SizedBox(height: 12),
                Text('Bike photo unavailable'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BikeDetailsScreen extends StatelessWidget {
  const BikeDetailsScreen({super.key, required this.bike});

  final Bike bike;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Bike details')),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                const TabBar(
                  labelColor: bikeRed,
                  unselectedLabelColor: Colors.black54,
                  indicatorColor: bikeRed,
                  tabs: [
                    Tab(text: 'Images'),
                    Tab(text: 'Colours'),
                    Tab(text: '360° View'),
                  ],
                ),
                SizedBox(
                  height: 270,
                  child: TabBarView(
                    children: [
                      BikeGallery(images: bike.images),
                      const MediaNotReady(
                        icon: Icons.palette_outlined,
                        message: 'Colour photos will be added next.',
                      ),
                      const MediaNotReady(
                        icon: Icons.threesixty,
                        message:
                            '360° rotation needs a matching '
                            'sequence of bike photos.',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bike.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        bike.price,
                        style: const TextStyle(
                          color: bikeRed,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 20),
                          const SizedBox(width: 6),
                          Text(bike.location),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Card(
                        color: Colors.white,
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.calendar_month),
                              title: const Text('Year'),
                              trailing: Text('${bike.year}'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.speed),
                              title: const Text('Mileage'),
                              trailing: Text(bike.mileage),
                            ),
                            const ListTile(
                              leading: Icon(Icons.two_wheeler),
                              title: Text('Condition'),
                              trailing: Text('Used'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'About this listing',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'This is a sample listing for the MotoLanka '
                        'prototype. Prices and specifications are demo data.',
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: bikeRed,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(18),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Seller enquiries will be connected '
                                  'in a later step.',
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.mail_outline),
                          label: const Text('Send enquiry'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BikeGallery extends StatefulWidget {
  const BikeGallery({super.key, required this.images});

  final List<String> images;

  @override
  State<BikeGallery> createState() => _BikeGalleryState();
}

class _BikeGalleryState extends State<BikeGallery> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => selectedImage = index);
            },
            itemBuilder: (context, index) {
              return BikePhoto(path: widget.images[index]);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            '${selectedImage + 1} / ${widget.images.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class MediaNotReady extends StatelessWidget {
  const MediaNotReady({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 56, color: bikeRed),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
