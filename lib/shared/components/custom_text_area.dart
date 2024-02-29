import 'package:flutter/material.dart';
import 'package:mobile_producer/shared/components/custom_label.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class CustomTextArea extends StatelessWidget {
  const CustomTextArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomLabel(text:"Detalhes"),
        TextField(
          minLines: 6,
          maxLines: null,
          decoration: InputDecoration(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: 90,
            ),
            contentPadding: const EdgeInsets.all(7),
            hintText: "Exemplo: Você pode me encontrar na tenda 7 na\nfeira de "
                "sábado, e na tenda 6 na feira de quarta.",
            hintStyle: TypographyStyles.paragraph3().copyWith(
              color: ThemeColors.gray5,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                width: 1,
                color: ThemeColors.primary3,
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(width: 1, color: ThemeColors.gray3),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(width: 1, color: ThemeColors.gray3),
            ),
          ),
        ),
      ],
    );
  }
}
