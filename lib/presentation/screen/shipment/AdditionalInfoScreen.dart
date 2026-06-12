import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/create_ship_cubit.dart';
import 'package:goods_delivery_app/bussiness/shipment_cubit.dart/shipment_state.dart';
import 'package:goods_delivery_app/datasource/model/shipment_model.dart';
import 'package:goods_delivery_app/presentation/screen/shipment/OrderSummaryScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/colors.dart';

class AdditionalInfoScreen extends StatefulWidget {
  const AdditionalInfoScreen({super.key});

  @override
  State<AdditionalInfoScreen> createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  String? selectedCargoType;

  final List<String> cargoTypes = [
    "لحوم",
    "منتجات معلبة",
    "خضروات وفواكه",
    "مواد غذائية جافة",
  ];

  int piecesCount = 1;
  int piecesweight = 1;
  String payer = "sender";

  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateShipCubit, ShipmentState>(
      listener: (context, state) {
        if (state is createShipLoaded) {
          print("تم انشاء شحنة");
          final createShipCubit = context.read<CreateShipCubit>();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OrderSummaryScreen()),
          );
        } else if (state is ShipError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,

          centerTitle: true,

          title: Text(
            "معلومات إضافية",
            style: GoogleFonts.cairo(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Builder(
              builder: (formContext) {
                final createShipCubit = formContext.read<CreateShipCubit>();
                return Form(
                  key: createShipCubit.formKey4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [
                              Text(
                                "نوع الحمولة",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),

                                decoration: BoxDecoration(
                                  color: AppColors.white,

                                  border: Border.all(color: AppColors.medgray),

                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedCargoType,
                                    isExpanded: true,

                                    hint: Text(
                                      "اختر نوع الحمولة",
                                      style: GoogleFonts.cairo(),
                                    ),

                                    items: cargoTypes.map((item) {
                                      return DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: GoogleFonts.cairo(),
                                        ),
                                      );
                                    }).toList(),

                                    onChanged: (value) {
                                      setState(() {
                                        selectedCargoType = value;
                                      });

                                      createShipCubit.goodsTypeController.text =
                                          value ?? "";
                                    },
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                "وزن الحمولة",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                height: 60,

                                decoration: BoxDecoration(
                                  color: AppColors.white,

                                  border: Border.all(color: AppColors.medgray),

                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          piecesweight++;
                                        });
                                        createShipCubit.weightController.text =
                                            piecesweight.toString();
                                      },

                                      icon: Icon(
                                        Icons.add_circle,
                                        color: AppColors.yallow,
                                      ),
                                    ),

                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "$piecesweight",

                                          style: GoogleFonts.cairo(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        if (piecesweight > 1) {
                                          setState(() {
                                            piecesweight--;
                                          });
                                          createShipCubit
                                              .weightController
                                              .text = piecesweight
                                              .toString();
                                        }
                                      },

                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: AppColors.yallow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                "عدد القطع",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                height: 60,

                                decoration: BoxDecoration(
                                  color: AppColors.white,

                                  border: Border.all(color: AppColors.medgray),

                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          piecesCount++;
                                        });

                                        createShipCubit
                                            .piecesCountController
                                            .text = piecesCount
                                            .toString();
                                      },

                                      icon: Icon(
                                        Icons.add_circle,
                                        color: AppColors.yallow,
                                      ),
                                    ),

                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          "$piecesCount",

                                          style: GoogleFonts.cairo(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {
                                        if (piecesCount > 1) {
                                          setState(() {
                                            piecesCount--;
                                          });

                                          createShipCubit
                                              .piecesCountController
                                              .text = piecesCount
                                              .toString();
                                        }
                                      },

                                      icon: Icon(
                                        Icons.remove_circle,
                                        color: AppColors.yallow,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                "من سيدفع رسوم التوصيل؟",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,

                                  border: Border.all(color: AppColors.medgray),

                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Column(
                                  children: [
                                    RadioListTile<String>(
                                      title: Text(
                                        "المرسل",
                                        style: GoogleFonts.cairo(),
                                      ),

                                      value: "sender",
                                      groupValue: payer,

                                      activeColor: AppColors.yallow,

                                      onChanged: (value) {
                                        setState(() {
                                          payer = value!;
                                        });
                                        createShipCubit.whoPays = value!;
                                      },
                                    ),

                                    RadioListTile<String>(
                                      title: Text(
                                        "المستلم",
                                        style: GoogleFonts.cairo(),
                                      ),

                                      value: "receiver",
                                      groupValue: payer,

                                      activeColor: AppColors.yallow,

                                      onChanged: (value) {
                                        setState(() {
                                          payer = value!;
                                        });
                                        createShipCubit.whoPays = value!;
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                "ملاحظات إضافية",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              TextFormField(
                                controller: createShipCubit.notesController,
                                maxLines: 5,

                                decoration: InputDecoration(
                                  hintText: "اكتب أي ملاحظات إضافية",

                                  hintStyle: GoogleFonts.cairo(),

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),

                                    borderSide: const BorderSide(
                                      color: AppColors.medgray,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),

                              Text(
                                "إضافة صورة للشحنة",
                                style: GoogleFonts.cairo(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              GestureDetector(
                                onTap: () {
                                  // Image Picker Here
                                },

                                child: Container(
                                  width: double.infinity,
                                  height: 180,

                                  decoration: BoxDecoration(
                                    color: AppColors.white,

                                    border: Border.all(
                                      color: AppColors.medgray,
                                      width: 1.5,
                                    ),

                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        color: AppColors.yallow,
                                        size: 55,
                                      ),

                                      const SizedBox(height: 12),

                                      Text(
                                        "إضافة صورة",
                                        style: GoogleFonts.cairo(
                                          color: AppColors.yallow,
                                          fontWeight: FontWeight.bold,
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

                      const SizedBox(height: 15),

                      BlocBuilder<CreateShipCubit, ShipmentState>(
                        builder: (context, state) {
                          if (state is ShipLoading) {
                            return ElevatedButton(
                              onPressed: null,

                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 50),

                                backgroundColor: AppColors.mainblue,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),

                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          return SizedBox(
                            width: double.infinity,
                            height: 55,

                            child: ElevatedButton(
                              onPressed: () {
                                final request = ShipmentRequest(
                                  goodsType:
                                      createShipCubit.goodsTypeController.text,

                                  weight:
                                      double.tryParse(
                                        createShipCubit.weightController.text,
                                      ) ??
                                      0,

                                  vehicleType:
                                      createShipCubit.truckTypeController.text,

                                  vehicleCapacityKg:
                                      createShipCubit.trucksizeController.text,

                                  whoPays: createShipCubit.whoPays,

                                  scheduledPickupAt:
                                      createShipCubit.scheduleController.text,

                                  additionalDetails:
                                      createShipCubit.notesController.text,

                                  media: [],

                                  route: RouteRequest(
                                    overviewPolyline: "abcd1234encodedpolyline",

                                    pickUpLat: createShipCubit
                                        .pickuplatController
                                        .text,
                                    pickUpLng: createShipCubit
                                        .pickuplngController
                                        .text,

                                    deliveryLat: createShipCubit
                                        .deliverylatController
                                        .text,
                                    deliveryLng: createShipCubit
                                        .deliverylngController
                                        .text,

                                    distance: 75,
                                    durationMinutes: 90,

                                    pickUpCheckpointDetails: CheckpointRequest(
                                      supervisorName: createShipCubit
                                          .pickupnameController
                                          .text,

                                      supervisorPhoneNumber: createShipCubit
                                          .pickupphoneController
                                          .text,

                                      address: createShipCubit
                                          .pickupaddressController
                                          .text,

                                      street: createShipCubit
                                          .pickupstreetController
                                          .text,

                                      buildingNumber: createShipCubit
                                          .pickupbuildingController
                                          .text,
                                    ),

                                    deliveryCheckpointDetails:
                                        CheckpointRequest(
                                          supervisorName: createShipCubit
                                              .deliverynameController
                                              .text,

                                          supervisorPhoneNumber: createShipCubit
                                              .deliveryphoneController
                                              .text,

                                          address: createShipCubit
                                              .deliveryaddressController
                                              .text,

                                          street: createShipCubit
                                              .deliverystreetController
                                              .text,

                                          buildingNumber: createShipCubit
                                              .deliverybuildingController
                                              .text,
                                        ),
                                  ),
                                );

                                createShipCubit.createShip(request);
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainblue,

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),

                              child: Text(
                                "اطلب الآن",

                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
