import 'package:flutter/material.dart';
import 'package:mobile_producer/shared/enums/order_status.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class StatusBadge extends StatelessWidget {
  final OrderStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  setColor() {
    Color color;
    switch (status) {
      case OrderStatus.ACCEPTED:
        color = ThemeColors.accepted;
        break;
      case OrderStatus.PENDING:
        color = ThemeColors.pending;
        break;
      case OrderStatus.CONCLUDED:
        color = ThemeColors.concluded;
        break;
      case OrderStatus.REJECTED:
        color = ThemeColors.rejected;
        break;
      case OrderStatus.CANCELED:
        color = ThemeColors.gray3;
        break;
    }
    return color;
  }

  setTextColor() {
    Color color;
    switch (status) {
      case OrderStatus.PENDING:
        color = Color(0xFF2845AC);
        break;
      case OrderStatus.ACCEPTED:
        color = Color(0xFF778015);
        break;
      case OrderStatus.REJECTED:
        color = Color(0xFF830E0E);
        break;
      case OrderStatus.CONCLUDED:
        color = ThemeColors.primary4;
        break;
      case OrderStatus.CANCELED:
        color = ThemeColors.gray6;
        break;
    }
  }

  setText() {
    String text;
    switch (status) {
      case OrderStatus.PENDING:
        text = "Pendente";
        break;
      case OrderStatus.ACCEPTED:
        text = "Aceito";
        break;
      case OrderStatus.REJECTED:
        text = "Rejeitado";
        break;
      case OrderStatus.CONCLUDED:
        text = "Concluído";
        break;
      case OrderStatus.CANCELED:
        text = "Cancelado";
        break;
    }
    return text;
  }

  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 25,
      decoration: BoxDecoration(
          color: setColor(), borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Text(
          setText(),
          style: TypographyStyles.paragraph4().copyWith(
            color: setTextColor(),
          ),
        ),
      ),
    );
  }
}
