import 'package:flutter/material.dart';

void main() {
  runApp(const AjelApp());
}

class AjelApp extends StatelessWidget {
  const AjelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عاجل | للسفر والحجوزات',
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF7F9FE),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1459D9),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 4;

  final Color blue = const Color(0xFF1459D9);
  final Color darkBlue = const Color(0xFF092B78);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(child: _buildHero()),
              SliverToBoxAdapter(child: _buildServices()),
              SliverToBoxAdapter(child: _buildOffers()),
              SliverToBoxAdapter(child: _buildWhyUs()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          _circleButton(Icons.notifications_none_rounded),
          const Spacer(),
          Column(
            children: [
              Text(
                'عاجل',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  height: 1,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'للسفر والحجوزات',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          _circleButton(Icons.headset_mic_outlined),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4FF),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Color(0xFF092B78), size: 29),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0877E8),
              Color(0xFF1459D9),
              Color(0xFF063BA8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(.18),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: -30,
              bottom: -25,
              child: Icon(
                Icons.cloud,
                size: 150,
                color: Colors.white.withOpacity(.18),
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: Transform.rotate(
                angle: -.15,
                child: const Icon(
                  Icons.flight,
                  size: 75,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 115,
              top: 35,
              child: CustomPaint(
                size: const Size(100, 50),
                painter: DottedLinePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'احجز رحلتك الآن',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 31,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'بأسرع وأسهل طريقة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 17,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'رحلات طيران  •  حجوزات بر  •  إصدار تأشيرات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    height: 58,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 22),
                        Icon(
                          Icons.search_rounded,
                          color: darkBlue,
                          size: 30,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'ابحث عن رحلة',
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServices() {
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              'خدماتنا',
              style: TextStyle(
                color: darkBlue,
                fontSize: 27,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 245,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: [
                _serviceCard(
                  icon: Icons.flight_takeoff_rounded,
                  title: 'حجز رحلات طيران',
                  subtitle: 'أفضل الأسعار',
                  type: ServiceType.flight,
                ),
                _serviceCard(
                  icon: Icons.badge_outlined,
                  title: 'إصدار تأشيرات',
                  subtitle: 'سريع وموثوق',
                  type: ServiceType.visa,
                ),
                _serviceCard(
                  icon: Icons.directions_car_filled_rounded,
                  title: 'حجز رحلات بر',
                  subtitle: 'سهولة وراحة',
                  type: ServiceType.car,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required ServiceType type,
  }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(title),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        width: 245,
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  gradient: _serviceGradient(type),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 88,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 7),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LinearGradient _serviceGradient(ServiceType type) {
    switch (type) {
      case ServiceType.flight:
        return const LinearGradient(
          colors: [Color(0xFFEAF5FF), Color(0xFFB8D9FF)],
        );
      case ServiceType.visa:
        return const LinearGradient(
          colors: [Color(0xFFF0F4FF), Color(0xFFC9D9FF)],
        );
      case ServiceType.car:
        return const LinearGradient(
          colors: [Color(0xFFFFF7E8), Color(0xFFE9D2A2)],
        );
    }
  }

  Widget _buildOffers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'عروض مميزة',
                style: TextStyle(
                  color: darkBlue,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                'عرض الكل',
                style: TextStyle(
                  color: blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(Icons.chevron_left, color: blue),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 155,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xFFEAF4FF), Colors.white],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  left: -10,
                  bottom: -20,
                  child: Icon(
                    Icons.location_city_rounded,
                    size: 180,
                    color: Colors.blue.withOpacity(.12),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 20,
                  child: Icon(
                    Icons.flight,
                    size: 48,
                    color: blue,
                  ),
                ),
                Positioned(
                  right: 22,
                  top: 22,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'دبي',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'رحلات يومية',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'أفضل الأسعار',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 22,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ابتداءً من',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        '150',
                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'دولار',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyUs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'لماذا تختارنا؟',
            style: TextStyle(
              color: darkBlue,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _feature(
                  Icons.speed_rounded,
                  'سرعة في الإنجاز',
                  'إجراءات سهلة',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _feature(
                  Icons.verified_user_outlined,
                  'حجز آمن',
                  'موثوق 100%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _feature(
                  Icons.local_offer_outlined,
                  'أسعار منافسة',
                  'أفضل العروض',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _feature(
                  Icons.support_agent_rounded,
                  'دعم 24/7',
                  'خدمة عملاء',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _feature(IconData icon, String title, String subtitle) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF1FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: blue, size: 27),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.person_outline_rounded, 'حسابي', 0),
          _navItem(Icons.receipt_long_outlined, 'حجوزاتي', 1),
          _bookingButton(),
          _navItem(Icons.local_offer_outlined, 'العروض', 3),
          _navItem(Icons.home_rounded, 'الرئيسية', 4),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String title, int index) {
    final bool active = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 27,
              color: active ? blue : Colors.black87,
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: active ? blue : Colors.black87,
                fontWeight:
                    active ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookingButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = 2;
        });
      },
      child: Transform.translate(
        offset: const Offset(0, -18),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: blue,
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 5,
            ),
            boxShadow: [
              BoxShadow(
                color: blue.withOpacity(.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.luggage_outlined,
                color: Colors.white,
                size: 30,
              ),
              Text(
                'حجوزات',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ServiceType {
  flight,
  visa,
  car,
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();

    path.moveTo(0, 30);
    path.cubicTo(25, 0, 55, 55, 100, 15);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
