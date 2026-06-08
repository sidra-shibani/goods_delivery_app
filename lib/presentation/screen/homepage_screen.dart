import 'package:flutter/material.dart';
import 'package:goods_delivery_app/presentation/widget/custom_drawer.dart';
import 'package:goods_delivery_app/presentation/widget/shipmentBottomSheet_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goods_delivery_app/const/colors.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const OrdersPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedItemColor: AppColors.mainblue,
        unselectedItemColor: Colors.grey,

        selectedLabelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold),

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),

          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
            label: "طلباتي",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.33,
                width: double.infinity,

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),

                  image: DecorationImage(
                    image: AssetImage("assets/images/welcomepage.png"),
                    fit: BoxFit.cover,
                  ),
                ),

                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),

                    color: Colors.black.withOpacity(0.4),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [
                        // 🔹 الأيقونات
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            // MENU BUTTON
                            Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openDrawer();
                                  },

                                  child: Container(
                                    padding: const EdgeInsets.all(10),

                                    decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(12),
                                    ),

                                    child: const Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),

                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              child: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        Text(
                          "مرحباً بك",
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "جاهزون لشحن بضائعك",

                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "خدمة شحن سريعة وآمنة",

                          style: GoogleFonts.cairo(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // باقي الصفحة ...

              // 🔹 بطاقات الخدمات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const CreateShipmentBottomSheet(),
                        );
                      },
                      child: _buildCard(
                        icon: Icons.local_shipping,
                        title: "إنشاء طلب شحن",
                        subtitle: "ابدأ بإرسال بضائعك بسهولة",
                      ),
                    ),

                    const SizedBox(height: 15),

                    _buildCard(
                      icon: Icons.location_on,
                      title: "تتبع الشحنة",
                      subtitle: "تابع حالة الشحنة لحظة بلحظة",
                    ),

                    const SizedBox(height: 15),

                    _buildCard(
                      icon: Icons.history,
                      title: "السجل السابق",
                      subtitle: "استعرض الطلبات السابقة",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: AppColors.mainblue.withOpacity(0.1),

              borderRadius: BorderRadius.circular(15),
            ),

            child: Icon(icon, color: AppColors.mainblue),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,

              children: [
                Text(
                  title,

                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,

                  textAlign: TextAlign.right,

                  style: GoogleFonts.cairo(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= ORDERS PAGE =================

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "طلباتي",

          style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ================= PROFILE PAGE =================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          "الملف الشخصي",

          style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
