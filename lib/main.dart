import 'package:flutter/material.dart';

void main() {
  runApp(const SafariBookingApp());
}

class SafariBookingApp extends StatelessWidget {
  const SafariBookingApp({super.key});

  static const primary = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سافر',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const HomePage(),
    );
  }
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

class SimplePage extends StatelessWidget {
  final String title;
  final Widget child;

  const SimplePage({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: child,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void go(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'سافر',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                go(
                  context,
                  const NotificationsPage(),
                );
              },
              icon: const Icon(
                Icons.notifications_none,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'خطط لرحلتك القادمة بسهولة',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3949AB),
                      Color(0xFF5C6BC0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'أين تريد أن تذهب؟',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ابحث عن رحلتك واحجز بسهولة',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          go(
                            context,
                            const SearchPage(),
                          );
                        },
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'البحث عن رحلة',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor:
                              SafariBookingApp.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'الخدمات',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ServiceCard(
                      icon: Icons.flight_takeoff,
                      title: 'الرحلات',
                      onTap: () {
                        go(
                          context,
                          const FlightsPage(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ServiceCard(
                      icon: Icons.hotel,
                      title: 'الفنادق',
                      onTap: () {
                        go(
                          context,
                          const HotelsPage(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ServiceCard(
                      icon: Icons.directions_car,
                      title: 'السيارات',
                      onTap: () {
                        go(
                          context,
                          const CarsPage(),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'رحلات مقترحة',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              DestinationCard(
                city: 'دبي',
                country: 'الإمارات العربية المتحدة',
                icon: Icons.location_city,
                onTap: () {
                  go(
                    context,
                    const DestinationPage(
                      city: 'دبي',
                      country: 'الإمارات العربية المتحدة',
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              DestinationCard(
                city: 'القاهرة',
                country: 'مصر',
                icon: Icons.account_balance,
                onTap: () {
                  go(
                    context,
                    const DestinationPage(
                      city: 'القاهرة',
                      country: 'مصر',
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              DestinationCard(
                city: 'إسطنبول',
                country: 'تركيا',
                icon: Icons.travel_explore,
                onTap: () {
                  go(
                    context,
                    const DestinationPage(
                      city: 'إسطنبول',
                      country: 'تركيا',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (index) {
            if (index == 1) {
              go(
                context,
                const BookingsPage(),
              );
            }

            if (index == 2) {
              go(
                context,
                const AccountPage(),
              );
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_border),
              selectedIcon: Icon(Icons.bookmark),
              label: 'حجوزاتي',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: SafariBookingApp.primary,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String city;
  final String country;
  final IconData icon;
  final VoidCallback onTap;

  const DestinationCard({
    super.key,
    required this.city,
    required this.country,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: SafariBookingApp.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    country,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'البحث عن رحلة',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'من',
                hintText: 'مدينة المغادرة',
                prefixIcon:
                    Icon(Icons.flight_takeoff),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                labelText: 'إلى',
                hintText: 'مدينة الوصول',
                prefixIcon:
                    Icon(Icons.flight_land),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const TextField(
              decoration: InputDecoration(
                labelText: 'تاريخ السفر',
                hintText: 'اختر التاريخ',
                prefixIcon:
                    Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  showMessage(
                    context,
                    'تم تنفيذ البحث',
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('بحث'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightsPage extends StatelessWidget {
  const FlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'الرحلات',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          InfoCard(
            icon: Icons.flight,
            title: 'رحلات متاحة',
            subtitle:
                'ابحث عن الرحلات واختر الرحلة المناسبة لك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.schedule,
            title: 'مواعيد مرنة',
            subtitle:
                'اختر تاريخ ووقت السفر الذي يناسبك.',
          ),
        ],
      ),
    );
  }
}

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'الفنادق',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          InfoCard(
            icon: Icons.hotel,
            title: 'فنادق مميزة',
            subtitle:
                'اختر الفندق المناسب لرحلتك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.star,
            title: 'إقامات موصى بها',
            subtitle:
                'خيارات إقامة في وجهات مختلفة.',
          ),
        ],
      ),
    );
  }
}

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'السيارات',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          InfoCard(
            icon: Icons.directions_car,
            title: 'تأجير السيارات',
            subtitle:
                'اختر سيارة تناسب احتياجات رحلتك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.location_on,
            title: 'استلام وتسليم',
            subtitle:
                'حدد مكان وموعد استلام السيارة.',
          ),
        ],
      ),
    );
  }
}

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'حجوزاتي',
      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.bookmark_border,
              size: 75,
              color: SafariBookingApp.primary,
            ),
            SizedBox(height: 15),
            Text(
              'لا توجد حجوزات حالياً',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'ستظهر حجوزاتك هنا بعد إتمام أي حجز.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'حسابي',
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.person,
              size: 42,
            ),
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              'حساب المستخدم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            leading:
                const Icon(Icons.person_outline),
            title: const Text('الملف الشخصي'),
            trailing: const Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onTap: () {
              showMessage(
                context,
                'صفحة الملف الشخصي',
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
            ),
            title: const Text('الإعدادات'),
            trailing: const Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onTap: () {
              showMessage(
                context,
                'صفحة الإعدادات',
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.help_outline),
            title: const Text('المساعدة'),
            trailing: const Icon(
              Icons.arrow_back_ios,
              size: 16,
            ),
            onTap: () {
              showMessage(
                context,
                'صفحة المساعدة',
              );
            },
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: 'الإشعارات',
     
