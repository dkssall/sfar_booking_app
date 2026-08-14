import 'package:flutter/material.dart';

void main() {
  runApp(const SafarApp());
}

class SafarApp extends StatelessWidget {
  const SafarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'سافر',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF8FAFD),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1769E0),
          primary: const Color(0xFF1769E0),
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
  int currentIndex = 0;

  final navy = const Color(0xFF173C78);
  final blue = const Color(0xFF1769E0);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _header()),
              SliverToBoxAdapter(child: _hero()),
              SliverToBoxAdapter(child: _bookCard()),
              SliverToBoxAdapter(child: _shortcuts()),
              SliverToBoxAdapter(child: _popularTrips()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
        bottomNavigationBar: _bottomNav(),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 12),
      child: Row(
        children: [
          _roundIcon(Icons.notifications_none_rounded),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text('مرحباً بك 👋',
                  style: TextStyle(fontSize: 18, color: Colors.black54)),
              SizedBox(height: 4),
              Text('احجز موعد سفرك بسهولة',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF132B52),
                  )),
              SizedBox(height: 4),
              Text('رحلات مريحة وآمنة في المواعيد التي تناسبك',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
          const SizedBox(width: 12),
          _roundIcon(Icons.menu_rounded),
        ],
      ),
    );
  }

  Widget _roundIcon(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFE1E7F0)),
      ),
      child: Icon(icon, color: navy, size: 30),
    );
  }

  Widget _hero() {
    return Container(
      height: 210,
      margin: const EdgeInsets.fromLTRB(18, 10, 18, 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [Color(0xFF274E83), Color(0xFF122A50)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 16,
            offset: const Offset(0, 7),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 20,
            top: 34,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text('سافر براحة',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('نوصلك إلى وجهتك',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
                Text('في الموعد المحدد',
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ],
            ),
          ),
          Positioned(
            left: -20,
            bottom: -10,
            child: Icon(Icons.directions_bus_filled_rounded,
                size: 190, color: Colors.white.withOpacity(.92)),
          ),
          Positioned(
            right: 25,
            bottom: 16,
            child: Row(
              children: [
                _dot(true),
                _dot(false),
                _dot(false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _dot(bool active) => Container(
        width: active ? 28 : 9,
        height: 9,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? blue : Colors.white70,
          borderRadius: BorderRadius.circular(10),
        ),
      );

  Widget _bookCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
      child: Material(
        color: navy,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.calendar_month_rounded,
                      color: Colors.white, size: 34),
                ),
                const SizedBox(width: 18),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('احجز موعد سفر',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text('اختر وجهتك والتاريخ المناسب لك',
                          style: TextStyle(
                              color: Colors.white70, fontSize: 14)),
                    ],
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Icon(Icons.arrow_back_rounded, color: navy, size: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shortcuts() {
    final items = [
      ('حجوزاتي', 'عرض وإدارة حجوزاتك', Icons.receipt_long_rounded),
      ('المواعيد المتاحة', 'تصفح المواعيد للسفر', Icons.access_time_rounded),
      ('الوجهات', 'استكشف جميع الوجهات', Icons.location_on_rounded),
      ('الدعم والمساعدة', 'تواصل معنا لأي استفسار', Icons.headset_mic_rounded),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 10),
      child: Row(
        children: items.map((e) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.045),
                      blurRadius: 14,
                      offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEAF1FF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(e.$3, color: blue, size: 28),
                  ),
                  const SizedBox(height: 10),
                  Text(e.$1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Color(0xFF172D50))),
                  const SizedBox(height: 4),
                  Text(e.$2,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 11, color: Colors.black54)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _popularTrips() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 0),
      child: Column(
        children: [
          Row(
            children: [
              Text('عرض الكل',
                  style: TextStyle(color: blue, fontSize: 15)),
              const Spacer(),
              const Text('الرحلات الشائعة',
                  style: TextStyle(
                      color: Color(0xFF132B52),
                      fontSize: 21,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _trip('سيئون', 'جدة', '25 مايو', '8:00', '120 ر.س')),
              const SizedBox(width: 10),
              Expanded(child: _trip('المكلا', 'سيئون', '24 مايو', '6:00', '100 ر.س')),
            ],
          )
        ],
      ),
    );
  }

  Widget _trip(String from, String to, String date, String time, String price) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 14,
              offset: const Offset(0, 5))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(to, style: const TextStyle(fontWeight: FontWeight.bold)),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.arrow_back_rounded, color: Colors.black26),
                ),
              ),
              Text(from, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 16, color: Colors.black54),
              const SizedBox(width: 5),
              Text(date, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const Spacer(),
              const Icon(Icons.access_time_rounded, size: 17, color: Colors.black54),
              const SizedBox(width: 4),
              Text(time, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 12),
          Text(price,
              style: TextStyle(
                  color: blue, fontSize: 17, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _bottomNav() {
    final labels = ['الرئيسية', 'حجوزاتي', 'احجز الآن', 'الرسائل', 'الملف الشخصي'];
    final icons = [
      Icons.home_rounded,
      Icons.calendar_month_rounded,
      Icons.add_circle_outline_rounded,
      Icons.chat_bubble_outline_rounded,
      Icons.person_outline_rounded,
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(.08),
              blurRadius: 20,
              offset: const Offset(0, -5))
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 78,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(labels.length, (i) {
              final selected = currentIndex == i;
              return GestureDetector(
                onTap: () => setState(() => currentIndex = i),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[i],
                        color: selected ? blue : Colors.grey.shade500,
                        size: i == 2 ? 31 : 25),
                    const SizedBox(height: 4),
                    Text(labels[i],
                        style: TextStyle(
                            color: selected ? blue : Colors.grey.shade600,
                            fontSize: 11,
                            fontWeight:
                                selected ? FontWeight.bold : FontWeight.normal)),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
