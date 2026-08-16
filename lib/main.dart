import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/booking.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const AjelApp());
}

class AjelApp extends StatelessWidget {
  const AjelApp({super.key});

  static const blue = Color(0xFF1459D9);
  static const darkBlue = Color(0xFF092B78);
  static const background = Color(0xFFF7F9FE);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'عاجل | للسفر والحجوزات',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: blue),
        fontFamily: 'Arial',
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

  void message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, textDirection: TextDirection.rtl),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AjelApp.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _header()),
              SliverToBoxAdapter(child: _hero()),
              SliverToBoxAdapter(child: _services()),
              SliverToBoxAdapter(child: _offers()),
              SliverToBoxAdapter(child: _whyUs()),
              const SliverToBoxAdapter(child: SizedBox(height: 110)),
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 12, 22, 14),
      child: Row(
        children: [
          _circleButton(
            Icons.notifications_none_rounded,
            () => message('لا توجد إشعارات جديدة'),
          ),
          const Spacer(),
          Column(
            children: const [
              Text(
                'عاجل',
                style: TextStyle(
                  color: AjelApp.darkBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'للسفر والحجوزات',
                style: TextStyle(
                  color: AjelApp.darkBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Spacer(),
          _circleButtonStatic(Icons.headset_mic_outlined),
        ],
      ),
    );
  }

  Widget _circleButtonStatic(IconData icon) {
    return Container(
      width: 54,
      height: 54,
      decoration: const BoxDecoration(
        color: Color(0xFFEFF4FF),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AjelApp.darkBlue, size: 29),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _circleButtonStatic(icon),
    );
  }

  Widget _hero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          image: const DecorationImage(
  image: AssetImage('assets/images/hero_plane.png'),
  fit: BoxFit.cover,
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
              left: -35,
              bottom: -35,
              child: Icon(
                Icons.cloud_rounded,
                size: 155,
                color: Colors.white.withOpacity(.17),
              ),
            ),
            Positioned(
              left: 24,
              top: 22,
              child: Transform.rotate(
                angle: -.15,
                child: const Icon(
                  Icons.flight_rounded,
                  size: 74,
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
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'بأسرع وأسهل طريقة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 13),
                  const Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 17),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'رحلات طيران  •  حجوزات بر  •  إصدار تأشيرات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => message('صفحة البحث عن رحلة'),
                    child: Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 22),
                          Icon(
                            Icons.search_rounded,
                            color: AjelApp.darkBlue,
                            size: 30,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'ابحث عن رحلة',
                            style: TextStyle(
                              color: AjelApp.darkBlue,
                              fontSize: 19,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
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

Widget _services() {
  return Padding(
    padding: const EdgeInsets.only(top: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            'خدماتنا',
            style: TextStyle(
              color: AjelApp.darkBlue,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 14),

        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('services')
              .where('isActive', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Padding(
                padding: EdgeInsets.all(22),
                child: Text('حدث خطأ في تحميل الخدمات'),
              );
            }

            final services = snapshot.data?.docs ?? [];

            if (services.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Text('لا توجد خدمات حالياً'),
              );
            }

            return SizedBox(
              height: 145,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final data =
                      services[index].data() as Map<String, dynamic>;

                  return SizedBox(
                    width: 108,
                    child: _serviceCard(
                      icon: Icons.miscellaneous_services_rounded,
title: index == 0
    ? 'خدمات نقل'
    : index == 1
        ? 'التأشيرات'
        : index == 2
            ? 'تذاكر طيران'
            : data['name'] ?? '',
                      subtitle: data['description'] ?? '',
                      image: index == 0
    ? 'assets/images/service_transport.png'
    : index == 1
        ? 'assets/images/service_visa.png'
        : index == 2
            ? 'assets/images/service_flight.png'
            : data['imageUrl'] ?? '',
                      gradient: const [
                        Color(0xFFFFFFFF),
                        Color(0xFFE9D2A2),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    ),
  );
}  
  Widget _serviceCard({
  required IconData icon,
  required String title,
  required String subtitle,
  required String image,
  required List<Color> gradient,
}) {
    return GestureDetector(
      onTap: () => message(title),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 4),
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
            Container(
  width: double.infinity,
  height: 65,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(18),
    gradient: LinearGradient(colors: gradient),
  ),
  child: Center(
child: Image.asset(
  image,
  width: 65,
  height: 65,
  fit: BoxFit.contain,
  errorBuilder: (context, error, stackTrace) {
    return const Icon(Icons.image_not_supported);
  },
),
),
  ),

            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
  color: Colors.grey.shade600,
  fontSize: 11,
),
            ),
            const SizedBox(height: 7),
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: AjelApp.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _offers() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'عروض مميزة',
                style: TextStyle(
                  color: AjelApp.darkBlue,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => message('عرض كل العروض'),
                child: const Row(
                  children: [
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: AjelApp.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(Icons.chevron_left, color: AjelApp.blue),
                  ],
                ),
              ),
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
                  left: 0,
                  bottom: 0,
                  child: Row(
                    children: [
                      _cityImageBox('جدة', Icons.water),
                      _cityImageBox('مكة', Icons.mosque),
                      _cityImageBox('الرياض', Icons.location_city),
                    ],
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'الرياض - مكة - جدة',
                        style: TextStyle(
                          color: AjelApp.darkBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'رحلات داخلية مميزة',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => message('تم اختيار العرض'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AjelApp.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 6,
                          ),
                          minimumSize: Size.zero,
                        ),
                        child: const Text('احجز الآن'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 18,
                  bottom: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'ابتداءً من',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '150',
                        style: TextStyle(
                          color: AjelApp.darkBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        'دولار',
                        style: TextStyle(
                          color: Colors.grey,
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

  Widget _cityImageBox(String city, IconData icon) {
    return Container(
      width: 92,
      height: 155,
      margin: const EdgeInsets.only(right: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF2D79D8), Color(0xFFDDEEFF)],
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(icon, color: Colors.white, size: 45),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(.22),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              city,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _whyUs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 30, 18, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'لماذا تختارنا؟',
            style: TextStyle(
              color: AjelApp.darkBlue,
              fontSize: 26,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _feature(Icons.speed_rounded, 'سرعة في الإنجاز', 'إجراءات سهلة')),
              const SizedBox(width: 8),
              Expanded(child: _feature(Icons.verified_user_outlined, 'حجز آمن', 'موثوق 100%')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _feature(Icons.local_offer_outlined, 'أسعار منافسة', 'أفضل العروض')),
              const SizedBox(width: 8),
              Expanded(child: _feature(Icons.support_agent_rounded, 'دعم 24/7', 'خدمة عملاء')),
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
            child: Icon(icon, color: AjelApp.blue, size: 27),
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
                    fontWeight: FontWeight.w900,
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

  Widget _bottomBar() {
    return Container(
      height: 86,
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
    final active = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedIndex = index);
        message(title);
      },
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 27,
              color: active ? AjelApp.blue : Colors.black87,
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: active ? AjelApp.blue : Colors.black87,
                fontWeight: active ? FontWeight.w900 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
Future<void> _showBookingDialog() async {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  await showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text(
          'حجز رحلة',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: dateController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'تاريخ الرحلة',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              TextField(
                controller: timeController,
                textDirection: TextDirection.rtl,
                decoration: const InputDecoration(
                  labelText: 'وقت الرحلة',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty ||
                  phoneController.text.trim().isEmpty ||
                  dateController.text.trim().isEmpty ||
                  timeController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('يرجى تعبئة جميع البيانات'),
                  ),
                );
                return;
              }

              await FirebaseFirestore.instance
                  .collection('bookings')
                  .add({
                'name': nameController.text.trim(),
                'phone': phoneController.text.trim(),
                'date': dateController.text.trim(),
                'time': timeController.text.trim(),
                'createdAt': FieldValue.serverTimestamp(),
              });

              if (dialogContext.mounted) {
                Navigator.pop(dialogContext);
              }

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم إرسال طلب الحجز بنجاح'),
                  ),
                );
              }
            },
            child: const Text('تأكيد الحجز'),
          ),
        ],
      );
    },
  );

  nameController.dispose();
  phoneController.dispose();
  dateController.dispose();
  timeController.dispose();
}
  
Widget _bookingButton() {
  return GestureDetector(
    onTap: () {
      setState(() => selectedIndex = 2);
      _showBookingDialog();
    },
    child: Transform.translate(
      offset: const Offset(0, -18),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: AjelApp.blue,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 5,
          ),
          boxShadow: [
            BoxShadow(
              color: AjelApp.blue.withOpacity(.30),
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
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path()
      ..moveTo(0, 30)
      ..cubicTo(25, 0, 55, 55, 100, 15);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
