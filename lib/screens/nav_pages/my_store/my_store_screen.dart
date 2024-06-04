import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_producer/screens/nav_pages/my_store/bloc/my_store_bloc.dart';
import 'package:mobile_producer/services/product_service.dart';
import 'package:mobile_producer/shared/blocs/product_bloc/product_bloc.dart';
import 'package:mobile_producer/shared/components/custom_app_bar.dart';
import 'package:mobile_producer/shared/components/custom_icon_button.dart';
import 'package:mobile_producer/shared/components/custom_label.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/shared/components/product_card/product_card.dart';
import 'package:mobile_producer/theme/theme_colors.dart';
import 'package:mobile_producer/theme/typography_styles.dart';

class MyStoreScreen extends StatelessWidget {
  const MyStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyStoreBloc(
          productService: RepositoryProvider.of<ProductService>(context))
        ..add(MyStoreLoadProductsEvent(
            producerId: "3b264476-7b70-4f2d-b106-447481ea569a")),

      child: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {

          if (state is NewProductAddedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Produto adicionado com sucesso!")));
            BlocProvider.of<MyStoreBloc>(context).add(MyStoreLoadProductsEvent(
                producerId: "3b264476-7b70-4f2d-b106-447481ea569a"));
          }
        },
        child: Scaffold(
          appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              surfaceTintColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        controller: TextEditingController(),
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Pesquisar...",
                        onChanged: (String s) {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Meus produtos", style: TypographyStyles.label1()),
                    ],
                  ),
                ),
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              BlocProvider.of<ProductBloc>(context).add(ResetProductEvent());
              Navigator.pushNamed(context, "/product",arguments: null);
            },
            shape: const CircleBorder(),
            backgroundColor: ThemeColors.primary3,
            child: const Center(
              child: Icon(
                Icons.add,
                color: ThemeColors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<MyStoreBloc, MyStoreState>(
                    builder: (context, state) {
                      if (state is MyStoreLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is MyStoreLoadedState) {
                        var data = state.data;
                        var products = data.products.data;
                        return Expanded(
                          child: products.isNotEmpty
                              ? GridView.count(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.8,
                                  children: products
                                      .map((element) =>
                                          ProductCard(product: element))
                                      .toList())
                              : getAddNewProduct(context),
                        );
                      }

                      return Center(child: Text("Ocorreu um erro ao buscar no servidor..."));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getAddNewProduct(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Você ainda não tem nenhum produto.\nAdicione um!",
            style: TypographyStyles.paragraph2(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomIconButton(
              onTap: () {
                Navigator.pushNamed(context, "/product");
              },
              text: "Adicionar",
              icon: Icons.add)
        ],
      ),
    );
  }
}
