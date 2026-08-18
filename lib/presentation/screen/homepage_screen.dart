import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_cubit.dart';
import 'package:goods_delivery_app/bussiness/Profile_cubit/profile_state.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/Rating_state.dart';
import 'package:goods_delivery_app/bussiness/Rating_cubit/rating_summery_cubit.dart';
import 'package:goods_delivery_app/bussiness/Tracking_cubit/tracking_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/deleteShip_cubit.dart';
import 'package:goods_delivery_app/helper/core/service_locator.dart';
import 'package:goods_delivery_app/notifications/repo/notification_repo.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/getShip_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit/shipment_state.dart';
import 'package:goods_delivery_app/datasource/repository/Rating_repo.dart';
import 'package:goods_delivery_app/datasource/webserver/services/tracking_socket_service.dart';
import 'package:goods_delivery_app/helper/core/SharedPreferencesHelper.dart';
import 'package:goods_delivery_app/helper/core/service_locator.dart';
import 'package:goods_delivery_app/presentation/screen/Tracking/TripTrackingScreen.dart';
import 'package:goods_delivery_app/presentation/screen/personalnfo_Screen.dart';

import 'package:goods_delivery_app/presentation/widget/OrderDetailsBottomSheet.dart';
import 'package:goods_delivery_app/presentation/widget/custom_drawer.dart';
import 'package:goods_delivery_app/presentation/widget/orderCard_widget.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,

                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),

                  image: DecorationImage(
                    image: AssetImage("assets/images/road2.png"),
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

                        Text(
                          " اهلاً بعودتك",
                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Text(
                          "الوسيلة الأكثر اماناً لنقل بضائعك",

                          style: GoogleFonts.cairo(
                            color: AppColors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 160, // يجعل الأبيض يغطي جزء بسيط من الصورة
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,

                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(height: 15),

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.read<GetShipCubit>().fetchShip();
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Color(0xff4A5D8F),
                              ),
                            ),
                            Text(
                              "طلباتي الجارية",

                              style: GoogleFonts.cairo(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "اضغط على أي طلب لتتبع الرحلة",

                          style: GoogleFonts.cairo(
                            color: AppColors.naturalgray,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final result = await sl<NotificationRepo>()
                                .testNotification();
                            if (result) {
                              log('✅ تم إرسال إشعار الاختبار بنجاح');
                            } else {
                              log('❌ فشل إرسال إشعار الاختبار');
                            }
                          },
                          child: const Text('اختبار الإشعارات'),
                        ),
                        //const SizedBox(height: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: BlocBuilder<GetShipCubit, ShipmentState>(
                              builder: (context, state) {
                                if (state is GetShipLoaded) {
                                  final shipments = state
                                      .shipment
                                      .data
                                      .shipments
                                      .where(
                                        (s) =>
                                            s.status == "delivered" ||
                                            s.status == "in_transit",
                                      )
                                      .toList();
                                  if (shipments.isEmpty) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.local_shipping_outlined,
                                            size: 70,
                                            color: Colors.grey.shade400,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "لا يوجد شحنات قم بإنشاء أول شحنة",
                                            style: GoogleFonts.cairo(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: shipments.length,
                                    itemBuilder: (context, index) {
                                      final shipment = shipments[index];

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => MultiBlocProvider(
                                                  providers: [
                                                    BlocProvider(
                                                      create: (context) =>
                                                          GetRatingSummeryCubit(
                                                            context
                                                                .read<
                                                                  RatingRepo
                                                                >(),
                                                          )..fetchRatingSummery(
                                                            shipment
                                                                    .driver
                                                                    ?.id ??
                                                                0,
                                                          ),

                                                      //  child:
                                                      // DriverTrackingTestScreen(),
                                                    ),
                                                    BlocProvider(
                                                      create: (context) {
                                                        return TrackingCubit(
                                                          sl<
                                                            TrackingSocketService
                                                          >(),
                                                        )..startTracking(
                                                          shipmentId:
                                                              shipment.id,
                                                        );
                                                      },

                                                      child: Container(),
                                                    ),
                                                  ],
                                                  child: TripTrackingScreen(
                                                    shipment: shipment,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: OrderCard(shipment: shipment),
                                        ),
                                      );
                                    },
                                  );
                                }

                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool showActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            // 🔘 Toggle Slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  children: [
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 250),
                      alignment: showActive
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        decoration: BoxDecoration(
                          color: const Color(0xff4A5D8F),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => showActive = false);
                            },
                            child: Center(
                              child: Text(
                                "المنتهية",
                                style: GoogleFonts.cairo(
                                  color: showActive
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => showActive = true);
                            },
                            child: Center(
                              child: Text(
                                "قيد الإنشاء",
                                style: GoogleFonts.cairo(
                                  color: showActive
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: BlocBuilder<GetShipCubit, ShipmentState>(
                builder: (context, state) {
                  if (state is GetShipLoaded) {
                    final allShipments = state.shipment.data.shipments;

                    final activeShipments = allShipments.where((s) {
                      return s.status == "created" ||
                          s.status == "scheduled" ||
                          s.status == "accepted" ||
                          s.status == "assigned" ||
                          s.status == "picked_up" ||
                          s.status == "on_way_to_pickup";
                    }).toList();

                    final finishedShipments = allShipments.where((s) {
                      return s.status == "cancelled" || s.status == "expired";
                    }).toList();

                    final data = showActive
                        ? activeShipments
                        : finishedShipments;

                    // ✅ تحسين حالة عدم وجود بيانات (تستمر في العمل بشكل صحيح)
                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_shipping_outlined,
                              size: 70,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              showActive
                                  ? "لا توجد طلبات نشطة"
                                  : "لا توجد طلبات منتهية",
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        await context.read<GetShipCubit>().fetchShip();
                      },
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final shipment = data[index];

                          final canDelete =
                              shipment.status == "created" ||
                              shipment.status == "scheduled" ||
                              shipment.status == "accepted" ||
                              shipment.status == "assigned";

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 16,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (_) => OrderDetailsBottomSheet(
                                    shipment: shipment,
                                  ),
                                );
                              },
                              child: OrderCard(
                                shipment: shipment,
                                canDelete: canDelete,
                                onDelete: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text("إلغاء الطلبية"),
                                      content: const Text(
                                        "هل أنت متأكد من إلغاء هذه الطلبية؟",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text("تراجع"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text(
                                            "تأكيد الإلغاء",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );

                                  if (confirm == true) {
                                    context
                                        .read<DeleteShipCubit>()
                                        .cancelShipment(shipment.id);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "طلباتي",
            style: GoogleFonts.cairo(fontSize: 28, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
// ================= PROFILE PAGE =================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ===== الهيدر المنحني =====
                SizedBox(
                  height: 210,
                  child: ClipPath(
                    clipper: _HeaderCurveClipper(),
                    child: Container(
                      color: AppColors.lightblue,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 68),

                // ===== الاسم والبيانات =====
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is GetProfileLoaded) {
                      context.read<GetRatingSummeryCubit>().fetchRatingSummery(
                        state.me.data.id,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is GetProfileLoaded) {
                      final myPro = state.me.data;

                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                myPro.fullName,
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                ),
                              ),

                              const SizedBox(width: 10),

                              // Rating Widget - من نفس داتا البروفايل مباشرة
                              Builder(
                                builder: (context) {
                                  final ratingInfo =
                                      myPro.merchantProfile?.ratingInfo;
                                  final average =
                                      ratingInfo?.averageRating ?? 0.0;
                                  final count = ratingInfo?.totalRatings ?? 0;

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber.shade50,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.amber.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Colors.amber,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          average.toStringAsFixed(1),
                                          style: GoogleFonts.cairo(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "($count)",
                                          style: GoogleFonts.cairo(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          Text(
                            "${myPro.email} | ${myPro.phoneNumber}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              color: AppColors.naturalgray,
                            ),
                          ),
                        ],
                      );
                    }

                    if (state is ProfileLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is ProfileError) {
                      return Center(
                        child: Text(state.message, style: GoogleFonts.cairo()),
                      );
                    }

                    // الحالة الافتراضية
                    return const SizedBox();
                  },
                ),

                const SizedBox(height: 22),

                // ===== المحتوى =====
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        _SectionCard(
                          children: [
                            _SettingRow(
                              icon: Icons.article_outlined,
                              label: "معلومات شخصية",
                              trailingText: null,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const PersonalInfoScreen(),
                                  ),
                                );
                              },
                            ),
                            const _RowDivider(),
                            _SettingRow(
                              icon: Icons.notifications_none,
                              label: "الاشعارات",
                              trailingText: "تفعيل",
                              onTap: () {},
                            ),
                            const _RowDivider(),
                            _SettingRow(
                              icon: Icons.translate,
                              label: "اللغة",
                              trailingText: "العربية",
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _SectionCard(
                          children: [
                            _SettingRow(
                              icon: Icons.badge_outlined,
                              label: "الأمان",
                              trailingText: null,
                              onTap: () {},
                            ),
                            const _RowDivider(),
                            _SettingRow(
                              icon: Icons.wb_sunny_outlined,
                              label: "الوضع",
                              trailingText: "نهاري",
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        _SectionCard(
                          children: [
                            _SettingRow(
                              icon: Icons.support_agent_outlined,
                              label: "Help & Support",
                              trailingText: null,
                              ltr: true,
                              onTap: () {},
                            ),
                            const _RowDivider(),
                            _SettingRow(
                              icon: Icons.chat_bubble_outline,
                              label: "Contact us",
                              trailingText: null,
                              ltr: true,
                              onTap: () {},
                            ),
                            const _RowDivider(),
                            _SettingRow(
                              icon: Icons.lock_outline,
                              label: "Privacy policy",
                              trailingText: null,
                              ltr: true,
                              onTap: () {},
                            ),
                          ],
                        ),

                        const SizedBox(height: 90),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ===== الصورة الشخصية =====
            Positioned(
              top: 155,
              left: 0,
              right: 0,
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFCFE3F5),
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          // استبدلها بـ Image.asset("assets/images/avatar.png")
                          "https://api.dicebear.com/7.x/adventurer/png?seed=Laiba",
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.mainblue,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -2,
                      right: -2,
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 14,
                          color: AppColors.naturalgray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.72);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.34,
      size.width,
      size.height * 0.72,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ---------------------------------------------------------------------------
// بطاقة قسم
// ---------------------------------------------------------------------------
class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.medgray),
      ),
      child: Column(children: children),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.shade200,
    );
  }
}

// ---------------------------------------------------------------------------
// صف إعداد واحد
// ---------------------------------------------------------------------------
class _SettingRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailingText;
  final VoidCallback onTap;
  final bool ltr;

  const _SettingRow({
    required this.icon,
    required this.label,
    required this.trailingText,
    required this.onTap,
    this.ltr = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
          children: [
            Icon(icon, size: 20, color: AppColors.medgray),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.cairo(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText!,
                style: GoogleFonts.cairo(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.yallow,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
