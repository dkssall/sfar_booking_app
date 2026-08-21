import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/booking.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

// رقم آخر مسافر استخدم الحجز في جلسة التطبيق الحالية.
String? currentPassengerPhone;

Future<void> _savePassengerPhone(String phone) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('passenger_phone', phone.trim());
  currentPassengerPhone = phone.trim();
}


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
class VisaPage extends StatelessWidget {
  const VisaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final visas = [
      'تأشيرة عمرة',
      'تأشيرة سياحية عُمان',
      'تأشيرة سياحية السعودية',
      'تأشيرة سياحية الإمارات',
      'تأشيرات أخرى',
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('التأشيرات'),
          backgroundColor: const Color(0xFF1459D9),
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: visas.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                leading: const Icon(
                  Icons.flight_takeoff,
                  color: Color(0xFF1459D9),
                ),
                title: Text(
                  visas[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                trailing: const Icon(Icons.arrow_back_ios, size: 18),
                onTap: () {
                  messageVisa(context, visas[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void messageVisa(BuildContext context, String visa) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم اختيار $visa'),
      ),
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
            color: Colors.blue.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.15),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'احجز أونلاين في أي مكان',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'حجز مقعد، تأشيرات، وتذاكر طيران',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.airplane_ticket_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'تذاكر طيران',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'أفضل الأسعار والعروض',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 1,
                      color: Colors.white70,
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'تأشيرات',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'إصدار تأشيرات بسرعة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 65,
                      width: 1,
                      color: Colors.white70,
                    ),
                    Expanded(
                      child: Column(
                        children: const [
                          Icon(
                            Icons.event_seat_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'حجز مقعد',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'اختر مقعدك بسهولة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
              height: 155,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final data =
                      services[index].data() as Map<String, dynamic>;

                  return SizedBox(
                    width: 115,
                    child: _serviceCard(
                      icon: Icons.miscellaneous_services_rounded,
title: index == 0
    ? 'خدمات نقل'
    : index == 1
        ? 'التأشيرات'
        : index == 2
            ? 'تذاكر طيران'
            : data['name'] ?? '',
subtitle: index == 0
    ? 'نقل آمن ومريح'
    : index == 1
        ? 'إصدار تأشيرات بسرعة'
        : 'أفضل أسعار تذاكر',
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
  onTap: () {
  if (title == 'خدمات نقل') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TransportPage(),
      ),
    );
  } else if (title == 'التأشيرات') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisaPage(),
      ),
    );
  } else {
    message(title);
  }
},
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
  width: double.infinity,
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
      onTap: () async {
        setState(() => selectedIndex = index);

        // فتح صفحة حجوزاتي فعليًا بدل عرض رسالة فقط
        if (index == 1) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyBookingsPage(),
            ),
          );

          // إعادة تحديد الرئيسية بعد الرجوع
          if (mounted) {
            setState(() => selectedIndex = 4);
          }
          return;
        }

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
class TransportPage extends StatefulWidget {
  const TransportPage({super.key});

  @override
  State<TransportPage> createState() => _TransportPageState();
}

class _TransportPageState extends State<TransportPage> {
  String? fromLocation;
  String? toLocation;

  final List<String> locations = [
    'صنعاء',
    'عدن',
    'تعز',
    'حضرموت',
    'الحديدة',
    'إب',
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('خدمات النقل'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: fromLocation,
                decoration: const InputDecoration(
                  labelText: 'من',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                items: locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    fromLocation = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: toLocation,
                decoration: const InputDecoration(
                  labelText: 'إلى',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                items: locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    toLocation = value;
                  });
                },
              ),

              const SizedBox(height: 30),

SizedBox(
  width: double.infinity,
  height: 55,
  child: ElevatedButton(
    onPressed: () {
      if (fromLocation == null || toLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يرجى تحديد منطقة الانطلاق والوجهة'),
          ),
        );
        return;
      }

      if (fromLocation == toLocation) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لا يمكن اختيار نفس المنطقة للانطلاق والوجهة'),
          ),
        );
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransportResultsPage(
            fromLocation: fromLocation!,
            toLocation: toLocation!,
          ),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFF8F7FC),
      foregroundColor: const Color(0xFF53699B),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    child: const Text(
      'بحث عن الرحلات',
      style: TextStyle(fontSize: 18),
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
class TransportResultsPage extends StatelessWidget {
  final String fromLocation;
  final String toLocation;

  const TransportResultsPage({
    super.key,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الرحلات المتاحة'),
          centerTitle: true,
          backgroundColor: const Color(0xFF1459D9),
          foregroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('trips')
              .where('isVisible', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('حدث خطأ أثناء تحميل الرحلات'),
              );
            }

            final trips = snapshot.data?.docs.where((doc) {
              final data = doc.data() as Map<String, dynamic>;

              return data['from'] == fromLocation &&
                  data['to'] == toLocation;
            }).toList();

            if (trips == null || trips.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'لا توجد رحلات متاحة حاليًا\nمن $fromLocation إلى $toLocation',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final data =
    trips[index].data() as Map<String, dynamic>;

final date = (data['date'] ?? '').toString();
final time = (data['time'] ?? '').toString();
final period = (data['period'] ?? '').toString();
final price = (data['price'] ?? '').toString();
final seats = (data['seats'] ?? '').toString();

return Card(
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$fromLocation ← → $toLocation',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text('📅 التاريخ: $date'),
                        const SizedBox(height: 7),

                        Text('🕐 الوقت: $time $period'),
                        const SizedBox(height: 7),

                        Text('💺 المقاعد المتاحة: $seats'),
                        const SizedBox(height: 7),

                        Text('💰 السعر: $price'),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BookingPage(
        fromLocation: fromLocation!,
        toLocation: toLocation!,
        date: date,
        time: time,
        period: period,
        price: price,
        seats: seats,
      ),
    ),
  );
},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFF1459D9),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'اختيار الرحلة',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
class BookingPage extends StatefulWidget {
  final String fromLocation;
  final String toLocation;
  final String date;
  final String time;
  final String period;
  final String price;
  final String seats;

  const BookingPage({
    super.key,
    required this.fromLocation,
    required this.toLocation,
    required this.date,
    required this.time,
    required this.period,
    required this.price,
    required this.seats,
  });

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  XFile? receiptImage;

  int passengerCount = 1;

  String paymentMethod = 'cash';

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> pickReceiptImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        receiptImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('بيانات الحجز'),
          centerTitle: true,
          backgroundColor: const Color(0xFF1459D9),
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.fromLocation} → ${widget.toLocation}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('📅 التاريخ: ${widget.date}'),
                      const SizedBox(height: 7),
                      Text('🕐 الوقت: ${widget.time} ${widget.period}'),
                      const SizedBox(height: 7),
                      Text('💰 السعر: ${widget.price}'),
                      const SizedBox(height: 7),
                      Text('💺 المقاعد المتاحة: ${widget.seats}'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'بيانات المسافر',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المسافر',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'عدد المقاعد',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (passengerCount > 1) {
                        setState(() {
                          passengerCount--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  Text(
                    '$passengerCount',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (passengerCount < int.tryParse(widget.seats)!) {
                        setState(() {
                          passengerCount++;
                        });
                      }
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'طريقة الدفع',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                value: 'cash',
                groupValue: paymentMethod,
                title: const Text('الدفع عن الحضور'),
                subtitle: const Text(
                  'يمكنك إلغاء الحجز لاحقًا',
                ),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                    receiptImage = null;
                  });
                },
              ),

              RadioListTile<String>(
                value: 'deposit',
                groupValue: paymentMethod,
                title: const Text('الدفع عن طريق الإيداع'),
                subtitle: const Text(
                  'لا يمكن إلغاء الحجز بعد الإرسال',
                ),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),

              if (paymentMethod == 'deposit') ...[
                const SizedBox(height: 15),

                OutlinedButton.icon(
                  onPressed: pickReceiptImage,
                  icon: const Icon(Icons.receipt_long),
                  label: Text(
                    receiptImage == null
                        ? 'إرفاق صورة الإيداع / الإيصال'
                        : 'تغيير صورة الإيصال',
                  ),
                ),

                if (receiptImage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    'تم اختيار صورة الإيصال ✓',
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],

              const SizedBox(height: 25),

ElevatedButton(
  onPressed: () async {
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال اسم المسافر ورقم الهاتف'),
        ),
      );
      return;
    }

    if (paymentMethod == 'deposit' && receiptImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إرفاق صورة الإيداع أو الإيصال'),
        ),
      );
      return;
    }

    try {
      final DatabaseReference bookingRef =
          FirebaseDatabase.instance.ref('bookings').push();

      final String bookingNumber =
          'SF-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      await _savePassengerPhone(phoneController.text.trim());

      await bookingRef.set({
        'bookingId': bookingRef.key,
        'bookingNumber': bookingNumber,
        'fromLocation': widget.fromLocation,
        'toLocation': widget.toLocation,
        'date': widget.date,
        'time': widget.time,
        'period': widget.period,
        'price': widget.price,
        'availableSeats': widget.seats,
        'passengerName': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'passengerCount': passengerCount,
        'paymentMethod': paymentMethod,
        'receiptAttached': receiptImage != null,
        'status': 'pending',
        'createdAt': ServerValue.timestamp,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تم إرسال الحجز بنجاح ✓\nرقم الحجز: #$bookingNumber',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // بعد نجاح الحجز نرجع للرئيسية ليتمكن المستخدم من فتح "حجوزاتي".
      await Future.delayed(const Duration(milliseconds: 700));
      if (mounted) {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء إرسال الحجز: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF1459D9),
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 52),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
  ),
  child: const Text(
    'إرسال الحجز',
    style: TextStyle(fontSize: 18),
  ),
),
                    ],
        ),
      ),
    ),
  );
}
}
class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  final phoneController = TextEditingController();

  List<Map<String, dynamic>> bookings = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPhone();
  }

  Future<void> _loadSavedPhone() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPhone = prefs.getString('passenger_phone');

    if (savedPhone != null && savedPhone.trim().isNotEmpty) {
      currentPassengerPhone = savedPhone.trim();
      phoneController.text = savedPhone.trim();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          searchBookings();
        }
      });
    }
  }
  bool loading = false;
  bool searched = false;

  String _normalizePhone(String value) {
    return value
        .trim()
        .replaceAll(' ', '')
        .replaceAll('-', '');
  }

  Future<void> searchBookings({bool showLoading = true}) async {
    final phone = _normalizePhone(phoneController.text);

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال رقم الهاتف'),
        ),
      );
      return;
    }

    if (showLoading && mounted) {
      setState(() {
        loading = true;
        searched = true;
        bookings = [];
      });
    }

    try {
      final snapshot =
          await FirebaseDatabase.instance.ref('bookings').get();

      final List<Map<String, dynamic>> results = [];

      if (snapshot.exists && snapshot.value is Map) {
        final data =
            Map<String, dynamic>.from(snapshot.value as Map);

        data.forEach((key, value) {
          if (value is! Map) return;

          final booking =
              Map<String, dynamic>.from(value);

          final bookingPhone =
              _normalizePhone(
            (booking['phone'] ?? '').toString(),
          );

          if (bookingPhone == phone) {
            booking['bookingKey'] = key;
            results.add(booking);
          }
        });
      }

      results.sort((a, b) {
        final aTime =
            _toInt(a['createdAt']);
        final bTime =
            _toInt(b['createdAt']);

        return bTime.compareTo(aTime);
      });

      if (!mounted) return;

      setState(() {
        bookings = results;
        loading = false;
        searched = true;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        searched = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('حدث خطأ أثناء البحث: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String statusText(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'تم تأكيد الحجز';
      case 'cancelled':
        return 'تم إلغاء الحجز';
      case 'pending':
      default:
        return 'قيد المراجعة';
    }
  }

  Color statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  IconData statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
      default:
        return Icons.hourglass_top;
    }
  }

  Widget _statusBox(String status) {
    final color = statusColor(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(.25),
        ),
      ),
      child: Row(
        children: [
          Icon(
            statusIcon(status),
            color: color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              statusText(status),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        '$label$value',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('حجوزاتي'),
          centerTitle: true,
          backgroundColor: const Color(0xFF1459D9),
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'رقم الهاتف',
                  hintText: 'أدخل رقم الهاتف المستخدم في الحجز',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => searchBookings(),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      loading ? null : searchBookings,
                  icon: loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.search),
                  label: Text(
                    loading
                        ? 'جاري البحث...'
                        : 'بحث عن حجوزاتي',
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF1459D9),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              if (searched && !loading)
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    bookings.isEmpty
                        ? 'لم يتم العثور على حجوزات بهذا الرقم'
                        : 'عدد الحجوزات: ${bookings.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),

              const SizedBox(height: 8),

              Expanded(
                child: !searched
                    ? const Center(
                        child: Text(
                          'أدخل رقم الهاتف للبحث عن حجوزاتك',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : bookings.isEmpty
                            ? const Center(
                                child: Text(
                                  'لا توجد حجوزات بهذا الرقم',
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () =>
                                    searchBookings(
                                      showLoading: false,
                                    ),
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: bookings.length,
                                  itemBuilder:
                                      (context, index) {
                                    final booking =
                                        bookings[index];

                                    final status =
                                        (booking['status'] ??
                                                'pending')
                                            .toString()
                                            .toLowerCase();

                                    final reason =
                                        (booking[
                                                    'cancellationReason'] ??
                                                '')
                                            .toString()
                                            .trim();

                                    final bookingNumber =
                                        (booking[
                                                    'bookingNumber'] ??
                                                '')
                                            .toString();

                                    final from =
                                        (booking[
                                                    'fromLocation'] ??
                                                '')
                                            .toString();

                                    final to =
                                        (booking[
                                                    'toLocation'] ??
                                                '')
                                            .toString();

                                    final date =
                                        (booking['date'] ?? '')
                                            .toString();

                                    final time =
                                        (booking['time'] ?? '')
                                            .toString();

                                    final period =
                                        (booking['period'] ?? '')
                                            .toString();

                                    final price =
                                        (booking['price'] ?? '')
                                            .toString();

                                    final passengerCount =
                                        (booking[
                                                    'passengerCount'] ??
                                                '')
                                            .toString();

                                    final paymentMethod =
                                        (booking[
                                                    'paymentMethod'] ??
                                                '')
                                            .toString();

                                    return Card(
                                      margin:
                                          const EdgeInsets.only(
                                        bottom: 14,
                                      ),
                                      elevation: 2,
                                      shape:
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(
                                          16,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(
                                          16,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          children: [
                                            Text(
                                              bookingNumber
                                                      .isEmpty
                                                  ? 'رقم الحجز'
                                                  : 'رقم الحجز: #$bookingNumber',
                                              style:
                                                  const TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(
                                                height: 12),

                                            if (from.isNotEmpty ||
                                                to.isNotEmpty)
                                              Text(
                                                '$from → $to',
                                                style:
                                                    const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                ),
                                              ),

                                            const SizedBox(
                                                height: 10),

                                            _infoRow(
                                              '📅 التاريخ: ',
                                              date,
                                            ),

                                            _infoRow(
                                              '🕐 الوقت: ',
                                              '$time $period'
                                                  .trim(),
                                            ),

                                            _infoRow(
                                              '💰 السعر: ',
                                              price,
                                            ),

                                            _infoRow(
                                              '👥 عدد المقاعد: ',
                                              passengerCount,
                                            ),

                                            if (paymentMethod
                                                .isNotEmpty)
                                              _infoRow(
                                                '💳 طريقة الدفع: ',
                                                paymentMethod ==
                                                        'deposit'
                                                    ? 'إيداع'
                                                    : 'دفع عند الحضور',
                                              ),

                                            const SizedBox(
                                                height: 8),

                                            _statusBox(status),

                                            if (status ==
                                                    'cancelled' &&
                                                reason.isNotEmpty) ...[
                                              const SizedBox(
                                                  height: 12),
                                              Container(
                                                width:
                                                    double.infinity,
                                                padding:
                                                    const EdgeInsets
                                                        .all(12),
                                                decoration:
                                                    BoxDecoration(
                                                  color: Colors
                                                      .red
                                                      .withOpacity(
                                                    .06,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                    12,
                                                  ),
                                                  border: Border.all(
                                                    color: Colors
                                                        .red
                                                        .withOpacity(
                                                      .20,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    const Text(
                                                      '📝 سبب الإلغاء:',
                                                      style:
                                                          TextStyle(
                                                        color:
                                                            Colors.red,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                        height: 6),
                                                    Text(
                                                      reason,
                                                      style:
                                                          const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
