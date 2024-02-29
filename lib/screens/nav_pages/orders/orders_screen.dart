import 'package:flutter/material.dart';
import 'package:mobile_producer/models/order/order.dart';
import 'package:mobile_producer/screens/nav_pages/orders/components/orders_tab.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/shared/enums/order_status.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 5, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: TextEditingController(),
                    hintText: "Buscar...",
                    onChanged: (String s){},
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    controller: _tabController,
                    indicatorColor: ThemeColors.primary3,
                    labelColor: ThemeColors.primary3,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      Tab(
                          child: Text("Pendentes",
                              style: TypographyStyles.paragraph3())),
                      Tab(
                        child: Text("Aceitos",
                            style: TypographyStyles.paragraph3()),
                      ),
                      Tab(
                        child: Text("Concluídos",
                            style: TypographyStyles.paragraph3()),
                      ),
                      Tab(
                        child: Text("Rejeitados",
                            style: TypographyStyles.paragraph3()),
                      ),
                      Tab(
                        child: Text("Cancelados",
                            style: TypographyStyles.paragraph3()),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              OrdersTab(
                orders: [
                  OrderModel(
                    id: "#123456ABCDEF",
                    productName: "Cenoura laranja - orgânico",
                    quantity: "2Kg",
                    status: OrderStatus.PENDING,
                    creationDate: "17, Janeiro, 24",
                    totalValue: "R\$5,98",
                  ),
                  OrderModel(
                    id: "#123456ABCDEF",
                    productName: "Cenoura laranja - orgânico",
                    quantity: "2Kg",
                    status: OrderStatus.PENDING,
                    creationDate: "17, Janeiro, 24",
                    totalValue: "R\$5,98",
                  ),
                ],
              ),
              OrdersTab(orders: [
                OrderModel(
                  id: "#123456ABCDEF",
                  productName: "Cenoura laranja - orgânico",
                  quantity: "2Kg",
                  status: OrderStatus.ACCEPTED,
                  creationDate: "17, Janeiro, 24",
                  totalValue: "R\$5,98",
                ),
                OrderModel(
                  id: "#123456ABCDEF",
                  productName: "Cenoura laranja - orgânico",
                  quantity: "2Kg",
                  status: OrderStatus.ACCEPTED,
                  creationDate: "17, Janeiro, 24",
                  totalValue: "R\$5,98",
                ),
              ]),
              OrdersTab(orders: [
                OrderModel(
                  id: "#123456ABCDEF",
                  productName: "Cenoura laranja - orgânico",
                  quantity: "2Kg",
                  status: OrderStatus.CONCLUDED,
                  creationDate: "17, Janeiro, 24",
                  totalValue: "R\$5,98",
                ),
              ]),
              OrdersTab(
                orders: [
                  OrderModel(
                    id: "#123456ABCDEF",
                    productName: "Cenoura laranja - orgânico",
                    quantity: "2Kg",
                    status: OrderStatus.REJECTED,
                    creationDate: "17, Janeiro, 24",
                    totalValue: "R\$5,98",
                  ),
                ],
              ),
              OrdersTab(
                orders: [
                  OrderModel(
                    id: "#123456ABCDEF",
                    productName: "Cenoura laranja - orgânico",
                    quantity: "2Kg",
                    status: OrderStatus.CANCELED,
                    creationDate: "17, Janeiro, 24",
                    totalValue: "R\$5,98",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
