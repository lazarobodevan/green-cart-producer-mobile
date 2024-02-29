import 'package:mobile_producer/shared/enums/order_status.dart';

class OrderModel {
  final String id;
  final String productName;
  final String quantity;
  final OrderStatus status;
  final String creationDate;
  final String totalValue;

  OrderModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.status,
    required this.creationDate,
    required this.totalValue,
  });
}
