import 'package:flutter/material.dart';
import 'package:mobile_producer/shared/components/custom_button.dart';
import 'package:mobile_producer/shared/components/custom_link.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                textAlign: TextAlign.center,
                style: TypographyStyles.headline2(),
              ),
              Text(
                "Olá! Bem-vind@ de volta :)",
                textAlign: TextAlign.center,
                style: TypographyStyles.label3().copyWith(
                  color: ThemeColors.gray6,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                controller: _emailController,
                onChanged: (String s){},
                hintText: "exemplo@gmail.com",
                prefixIcon: const Icon(Icons.mail),
                isObscureText: false,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextField(
                controller: _emailController,
                onChanged: (String s){},
                hintText: "Senha",
                prefixIcon: const Icon(Icons.lock),
                isObscureText: true,
                isShowSuffixIcon: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CustomLink(
                  text: "Esqueci a senha",
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(text: "Entrar", onTap: () {Navigator.of(context).pushNamed("/home");}),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não tem uma conta?",
                    style: TypographyStyles.label3(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomLink(text: "Cadastre-se", onTap: () {Navigator.of(context).pushNamed("/signup");})
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
