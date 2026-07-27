import 'package:goods_delivery_app/datasource/model/truck_size_model.dart';

class TruckData {
  static List<TruckSizeModel> closedTruck = [
    const TruckSizeModel(
      name: "شاحنة صغيرة",
      capacityKg: 900,
      description: "تتحمل حتى 900 كغ وحجم الصندوق 160 سم",
      price: "130",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      capacityKg: 2000,
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "200",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      capacityKg: 4000,
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "270",
      image: "assets/images/large_truck.png",
    ),
  ];

  static List<TruckSizeModel> openTruck = [
    const TruckSizeModel(
      capacityKg: 900,
      name: "شاحنة صغيرة",
      description: "تتحمل حتى 500 كغ وحجم الصندوق 160 سم",
      price: "130",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      capacityKg: 2000,
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "200",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      capacityKg: 4000,
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "270",
      image: "assets/images/large_truck.png",
    ),
  ];

  static List<TruckSizeModel> refrigeratedTruck = [
    const TruckSizeModel(
      capacityKg: 900,
      name: "شاحنة صغيرة",
      description: "تتحمل حتى 500 كغ وحجم الصندوق 160 سم",
      price: "180",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      capacityKg: 2000,
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "280",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      capacityKg: 4000,
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "380",
      image: "assets/images/large_truck.png",
    ),
  ];
}
