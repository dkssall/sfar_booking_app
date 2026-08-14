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
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const HomePage(),
    );
  }
}

// ==================== الرئيسية ====================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void open(BuildContext context, Widget page) {
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
          centerTitle: true,
          title: const Text(
            'سافر',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                open(context, const NotificationsPage());
              },
            ),
          ],
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'مرحباً بك 👋',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'خطط لرحلتك القادمة بسهولة',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),

              // مربع البحث
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'أين تريد أن تذهب؟',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
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
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          open(context, const SearchPage());
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
                  fontSize: 22,
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
                        open(context, const FlightsPage());
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ServiceCard(
                      icon: Icons.hotel,
                      title: 'الفنادق',
                      onTap: () {
                        open(context, const HotelsPage());
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ServiceCard(
                      icon: Icons.directions_car,
                      title: 'السيارات',
                      onTap: () {
                        open(context, const CarsPage());
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'رحلات مقترحة',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              DestinationCard(
                city: 'دبي',
                country: 'الإمارات العربية المتحدة',
                icon: Icons.location_city,
                onTap: () {
                  open(
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
                  open(
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
                  open(
                    context,
                    const DestinationPage(
                      city: 'إسطنبول',
                      country: 'تركيا',
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),

        // القائمة السفلية
        bottomNavigationBar: NavigationBar(
          selectedIndex: 0,
          onDestinationSelected: (index) {

            if (index == 1) {
              open(context, const BookingsPage());
            }

            if (index == 2) {
              open(context, const AccountPage());
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

// ==================== بطاقة الخدمة ====================

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
          vertical: 20,
          horizontal: 5,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          children: [

            Icon(
              icon,
              size: 34,
              color: SafariBookingApp.primary,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== بطاقة الوجهة ====================

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

                  const SizedBox(height: 5),

                  Text(
                    country,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_back_ios_new,
              size: 17,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== البحث ====================

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم تنفيذ البحث'),
                    ),
                  );
                },

                icon: const Icon(Icons.search),

                label: const Text(
                  'بحث',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== الرحلات ====================

class FlightsPage extends StatelessWidget {
  const FlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
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

          SizedBox(height: 15),

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

// ==================== الفنادق ====================

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
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

          SizedBox(height: 15),

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

// ==================== السيارات ====================

class CarsPage extends StatelessWidget {
  const CarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
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

          SizedBox(height: 15),

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

// ==================== حجوزاتي ====================

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'حجوزاتي',

      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),

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

              Text(
                'ستظهر حجوزاتك هنا بعد إتمام أي حجز.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== الحساب ====================

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
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
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          ListTile(
            leading: const Icon(
              Icons.person_outline,
            ),

            title: const Text(
              'الملف الشخصي',
            ),

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

            title: const Text(
              'الإعدادات',
            ),

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
            leading: const Icon(
              Icons.help_outline,
            ),

            title: const Text(
              'المساعدة',
            ),

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

// ==================== الإشعارات ====================

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'الإشعارات',

      child: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: const [

            Icon(
              Icons.notifications_none,
              size: 75,
              color: SafariBookingApp.primary,
            ),

            SizedBox(height: 15),

            Text(
              'لا توجد إشعارات جديدة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
         
