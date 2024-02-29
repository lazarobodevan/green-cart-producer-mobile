import 'package:dotted_line/dotted_line.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile_producer/shared/components/custom_app_bar.dart';
import 'package:mobile_producer/shared/components/custom_icon_button.dart';
import 'package:mobile_producer/shared/components/product_tile.dart';
import 'package:mobile_producer/shared/components/status_badge.dart';
import 'package:mobile_producer/shared/enums/order_status.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Detalhes do pedido"),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 235,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: 280,
                            height: 176,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "https://images.pexels.com/photos/143133/pexels-photo-143133.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: 3,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Detalhes da encomenda",
                              style: TypographyStyles.label1(),
                            ),
                            StatusBadge(status: OrderStatus.ACCEPTED)
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ID do pedido",
                              style: TypographyStyles.paragraph4()
                                  .copyWith(color: ThemeColors.gray6),
                            ),
                            Text(
                              "#123ABC456EF",
                              style: TypographyStyles.paragraph4(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Data do pedido",
                              style: TypographyStyles.paragraph4()
                                  .copyWith(color: ThemeColors.gray6),
                            ),
                            Text(
                              "17/01/2023 - 10:03h",
                              style: TypographyStyles.paragraph4(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Data do aceite",
                              style: TypographyStyles.paragraph4()
                                  .copyWith(color: ThemeColors.gray6),
                            ),
                            Text(
                              "18/01/2023 - 19:26h",
                              style: TypographyStyles.paragraph4(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantidade",
                              style: TypographyStyles.paragraph4()
                                  .copyWith(color: ThemeColors.gray6),
                            ),
                            Text(
                              "2 Kg",
                              style: TypographyStyles.paragraph4(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Valor unitário",
                              style: TypographyStyles.paragraph4()
                                  .copyWith(color: ThemeColors.gray6),
                            ),
                            Text(
                              "R\$2,99 /kg",
                              style: TypographyStyles.paragraph4(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineThickness: 1,
                          dashLength: 12,
                          dashGapLength: 12,
                          dashColor: ThemeColors.gray6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total pago",
                                style: TypographyStyles.label3(),
                              ),
                              Text("R\$5,98", style: TypographyStyles.label3())
                            ],
                          ),
                        ),
                        const DottedLine(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.center,
                          lineThickness: 1,
                          dashLength: 12,
                          dashGapLength: 12,
                          dashColor: ThemeColors.gray6,
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //Consumer observations
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Observações do consumidor",
                              style: TypographyStyles.label3(),
                            ),
                            ExpandableText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sapien nibh, egestas non metus vel, faucibus mollis elit. Nulla posuere vulputate justo vitae accumsan. Nullam velit massa, pulvinar sed lacus in, euismod feugiat ligula. Integer sodales efficitur erat, et ornare nibh maximus vitae.  Nulla venenatis, urna quis varius venenatis, urna neque rhoncus nisi, quis commodo justo urna a metus. Sed in enim mauris. Cras feugiat diam nec porta facilisis. Donec bibendum neque placerat sapien imperdiet, tristique tempus mauris scelerisque. Suspendisse viverra arcu sapien, sed efficitur nisi tristique vel. Cras luctus non enim ac gravida. Suspendisse euismod lacinia ipsum, non pellentesque urna rutrum quis. Nunc pharetra in neque sit amet pellentesque.",
                              expandText: "Ver mais",
                              style: TypographyStyles.paragraph3()
                                  .copyWith(color: ThemeColors.gray6),
                              animation: true,
                              animationCurve: Curves.ease,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        //Consumer observations
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Observações do produtor",
                              style: TypographyStyles.label3(),
                            ),
                            ExpandableText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sapien nibh, egestas non metus vel, faucibus mollis elit. Nulla posuere vulputate justo vitae accumsan. Nullam velit massa, pulvinar sed lacus in, euismod feugiat ligula. Integer sodales efficitur erat, et ornare nibh maximus vitae.  Nulla venenatis, urna quis varius venenatis, urna neque rhoncus nisi, quis commodo justo urna a metus. Sed in enim mauris. Cras feugiat diam nec porta facilisis. Donec bibendum neque placerat sapien imperdiet, tristique tempus mauris scelerisque. Suspendisse viverra arcu sapien, sed efficitur nisi tristique vel. Cras luctus non enim ac gravida. Suspendisse euismod lacinia ipsum, non pellentesque urna rutrum quis. Nunc pharetra in neque sit amet pellentesque.",
                              expandText: "Ver mais",
                              style: TypographyStyles.paragraph3()
                                  .copyWith(color: ThemeColors.gray6),
                              animation: true,
                              animationCurve: Curves.ease,
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Detalhes do produto",
                              style: TypographyStyles.label2(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ProductTile()
                          ],
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Detalhes do produtor",
                              style: TypographyStyles.label2(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //ProducerTile(producer: ProducerModel(),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: ThemeColors.black.withOpacity(.25),
                  blurRadius: 10,
                  offset: Offset(0, 1)),
            ], color: ThemeColors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Preço total",
                        style: TypographyStyles.paragraph3(),
                      ),
                      Text(
                        "R\$5,98",
                        style: TypographyStyles.label2(),
                      )
                    ],
                  ),
                  CustomIconButton(
                    onTap: () {Navigator.pushNamed(context, "/scanQRCode");},
                    text: "Retirar",
                    icon: Icons.camera_alt_outlined,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
