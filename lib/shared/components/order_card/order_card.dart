import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_producer/models/order/order.dart';
import 'package:mobile_producer/shared/components/action_button.dart';
import 'package:mobile_producer/shared/components/status_badge.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: ThemeColors.white,
        boxShadow: [
          BoxShadow(
              color: ThemeColors.black.withOpacity(.25),
              blurRadius: 4,
              offset: const Offset(0, 3))
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: StatusBadge(status: order.status)
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    order.productName,
                    overflow: TextOverflow.ellipsis,
                    style: TypographyStyles.label3(),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    order.quantity,
                    style: TypographyStyles.paragraph4(),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10,20,10,10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID do pedido", style: TypographyStyles.paragraph4().copyWith(color: ThemeColors.gray6),),
                    const SizedBox(height: 5,),
                    Text(order.id, style: TypographyStyles.paragraph4(),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data do pedido", style: TypographyStyles.paragraph4().copyWith(color: ThemeColors.gray6),),
                    const SizedBox(height: 5,),
                    Text(order.creationDate, style: TypographyStyles.paragraph4(),)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Valor total", style: TypographyStyles.paragraph4().copyWith(color: ThemeColors.gray6),),
                    const SizedBox(height: 5,),
                    Text(order.totalValue, style: TypographyStyles.paragraph4(),)
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Material(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,10,10,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                ActionButton(isFilled: false, onTap: (){}, text: "Cancelar"),
                ActionButton(isFilled: true, onTap: (){Navigator.pushNamed(context, "/orderDetails");}, text: "Ver detalhes"),
              ],),
            ),
          )
        ],
      ),
    );
  }
}
