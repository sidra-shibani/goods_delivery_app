import 'package:goods_delivery_app/datasource/model/truck_size_model.dart';

class TruckData {
  static List<TruckSizeModel> closedTruck = [
    const TruckSizeModel(
      name: "شاحنة صغيرة",
      description: "تتحمل حتى 500 كغ وحجم الصندوق 160 سم",
      price: "50,000",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "100,000",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "200,000",
      image: "assets/images/large_truck.png",
    ),
  ];

  static List<TruckSizeModel> openTruck = [
    const TruckSizeModel(
      name: "شاحنة صغيرة",
      description: "تتحمل حتى 500 كغ وحجم الصندوق 160 سم",
      price: "50,000",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "100,000",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "200,000",
      image: "assets/images/large_truck.png",
    ),
  ];

  static List<TruckSizeModel> refrigeratedTruck = [
    const TruckSizeModel(
      name: "شاحنة صغيرة",
      description: "تتحمل حتى 500 كغ وحجم الصندوق 160 سم",
      price: "50,000",
      image: "assets/images/truck1_small.png",
    ),

    const TruckSizeModel(
      name: "شاحنة متوسطة",
      description: "تتحمل حتى 2 طن وحجم الصندوق 3 متر",
      price: "100,000",
      image: "assets/images/mid-truck.png",
    ),

    const TruckSizeModel(
      name: "شاحنة كبيرة",
      description: "تتحمل حتى 5 طن وحجم الصندوق 6 متر",
      price: "200,000",
      image: "assets/images/large_truck.png",
    ),
  ];
}
