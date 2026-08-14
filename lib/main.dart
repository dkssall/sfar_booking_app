import 'package:flutter/material.dart';

void main() {
  runApp(const SafariApp());
}

class SafariApp extends StatelessWidget {
  const SafariApp({super.key});

  static const primary = Color(0xFF3949AB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سافر',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
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
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                openPage(context, const NotificationsPage());
              },
              icon: const Icon(Icons.notifications_none),
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
                  fontSize: 17,
                ),
              ),

              const SizedBox(height: 25),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF3949AB),
                      Color(0xFF5C6BC0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'أين تريد أن تذهب؟',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'ابحث عن رحلتك واحجز بسهولة',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 22),

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          openPage(context, const SearchPage());
                        },
                        icon: const Icon(Icons.search),
                        label: const Text(
                          'البحث عن رحلة',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: SafariApp.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
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
                  fontSize: 23,
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
                        openPage(context, const FlightsPage());
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ServiceCard(
                      icon: Icons.hotel,
                      title: 'الفنادق',
                      onTap: () {
                        openPage(context, const HotelsPage());
                      },
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ServiceCard(
                      icon: Icons.directions_car,
                      title: 'السيارات',
                      onTap: () {
                        openPage(context, const CarsPage());
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'رحلات مقترحة',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              DestinationCard(
                city: 'دبي',
                country: 'الإمارات العربية المتحدة',
                icon: Icons.location_city,
                onTap: () {
                  openPage(
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
                  openPage(
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
                  openPage(
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
              openPage(context, const BookingsPage());
            }

            if (index == 2) {
              openPage(context, const AccountPage());
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
              color: SafariApp.primary,
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
                color: SafariApp.primary,
                size: 30,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                prefixIcon: Icon(Icons.flight_takeoff),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const TextField(
              decoration: InputDecoration(
                labelText: 'إلى',
                hintText: 'مدينة الوصول',
                prefixIcon: Icon(Icons.flight_land),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            const TextField(
              decoration: InputDecoration(
                labelText: 'تاريخ السفر',
                hintText: 'اختر التاريخ',
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  showMessage(context, 'تم تنفيذ البحث');
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
            subtitle: 'ابحث عن الرحلات واختر الرحلة المناسبة لك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.schedule,
            title: 'مواعيد مرنة',
            subtitle: 'اختر تاريخ ووقت السفر الذي يناسبك.',
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
            subtitle: 'اختر الفندق المناسب لرحلتك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.star,
            title: 'إقامات موصى بها',
            subtitle: 'خيارات إقامة في وجهات مختلفة.',
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
            subtitle: 'اختر سيارة تناسب احتياجات رحلتك.',
          ),
          SizedBox(height: 12),
          InfoCard(
            icon: Icons.location_on,
            title: 'استلام وتسليم',
            subtitle: 'حدد مكان وموعد استلام السيارة.',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.bookmark_border,
              size: 75,
              color: SafariApp.primary,
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
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'ستظهر حجوزاتك هنا بعد إتمام أي حجز.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
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
            leading: const Icon(Icons.person_outline),
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
            leading: const Icon(Icons.settings_outlined),
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
            leading: const Icon(Icons.help_outline),
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.notifications_none,
              size: 75,
              color: SafariApp.primary,
            ),
            SizedBox(height: 15),
            Text(
              'لا توجد إشعارات جديدة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationPage extends StatelessWidget {
  final String city;
  final String country;

  const DestinationPage({
    super.key,
    required this.city,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return SimplePage(
      title: city,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_city,
                size: 80,
                color: SafariApp.primary,
              ),

              const SizedBox(height: 20),

              Text(
                city,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                country,
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
  
