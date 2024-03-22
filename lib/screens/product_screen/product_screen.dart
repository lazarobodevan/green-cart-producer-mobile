import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:mobile_producer/json_data/product_categories.dart';
import 'package:mobile_producer/json_data/product_units.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/screens/nav_pages/my_store/bloc/my_store_bloc.dart';
import 'package:mobile_producer/screens/product_screen/bloc/product_bloc.dart';
import 'package:mobile_producer/services/product_service.dart';
import 'package:mobile_producer/shared/components/custom_app_bar.dart';
import 'package:mobile_producer/shared/components/custom_button.dart';
import 'package:mobile_producer/shared/components/custom_date_picker.dart';
import 'package:mobile_producer/shared/components/custom_dropdown_button.dart';
import 'package:mobile_producer/shared/components/custom_label.dart';
import 'package:mobile_producer/shared/components/custom_link.dart';
import 'package:mobile_producer/shared/components/custom_switch_button.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/shared/components/picture_card.dart';
import 'package:mobile_producer/shared/enums/product_categories.dart';
import 'package:mobile_producer/shared/enums/product_unit.dart';
import 'package:mobile_producer/theme/typography_styles.dart';
import 'package:path/path.dart';

class ProductScreen extends StatelessWidget {

  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<ProductBloc>(context)..add(ResetProductEvent());

    final GlobalKey _formKey = GlobalKey();
    DateFormat formatter = DateFormat("dd/MM/yyyy");

    var _nameController = TextEditingController();
    var _descController = TextEditingController();
    var _priceController = MoneyMaskedTextController(
        decimalSeparator: ",", thousandSeparator: ".", leftSymbol: "R\$");
    var _availableQuantityController = TextEditingController();
    var _harvestDateController = TextEditingController();

    _onChangedCategory(dynamic category) {
      var cat = category as ProductCategories;
      bloc.add(UpdateProductEvent(category: cat.name));
    }

    _onChangedUnit(dynamic unit) {
      var _unit = unit as ProductUnit;
      bloc.add(UpdateProductEvent(unit: _unit.name));
    }

    _onChangedPrice(String price) {
      var _price = price.replaceAll(".", ",");
      _price = price.replaceAll("R\$", "");
      bloc.add(UpdateProductEvent(price: _price));
    }

    _onChangedIsOrganic(bool isOrganic) {
      bloc.add(UpdateProductEvent(isOrganic: isOrganic));
    }

    _onChangedHarvestDate(DateTime? date) {
      if (date != null) {
        var _date = formatter.format(date);
        bloc.add(UpdateProductEvent(harvestDate: _date));
      }
    }

    _onChangedAvailableQuantity(String value){
      bloc.add(UpdateProductEvent(availableQuantity: int.parse(value)));
    }

    _onChangedPicture(File? picture, int index) {
      if (picture != null) {
        var pictures = bloc.product.pictures;
        var metadata = bloc.product.picturesMetadata;

        if (index < pictures.length) {
          pictures[index] = picture;
          metadata[index] = ProductPictureMetadataModel(
              name: basename(picture.path), position: index);
        } else {
          pictures.add(picture);
          metadata.add(ProductPictureMetadataModel(
              name: basename(picture.path), position: pictures.length - 1));
        }
        bloc.add(
            UpdateProductEvent(pictures: pictures, picturesMetadata: metadata));
      }
    }

    return BlocProvider(
      create: (context) => MyStoreBloc(
          productService: RepositoryProvider.of<ProductService>(context)),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Adicionar produto",
        ),
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) async {
            if (state is NewProductAddedState) {
              await Future.delayed(Duration.zero);
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
            bloc: BlocProvider.of<ProductBloc>(context),
            builder: (context, state) {
              var bloc = BlocProvider.of<ProductBloc>(context);

              bool isActive = true;
              bool isLoading = false;

              if (state is NewProductAddingState) {
                isActive = false;
                isLoading = true;
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(bloc.product.availableQuantity.toString()),
                    ),
                    //Pictures
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Fotos do produto (${bloc.product.picturesMetadata.length}/5)",
                                style: TypographyStyles.label2(),
                              ),
                              CustomLink(text: "Editar", onTap: () {})
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Center(
                                child: PictureCard(
                                  index: index,
                                  onChanged: (picture, index) {
                                    _onChangedPicture(picture, index);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: bloc.product.picturesMetadata.length < 5
                                ? bloc.product.picturesMetadata.length + 1
                                : bloc.product.picturesMetadata.length,
                          ),
                        )
                      ],
                    ),

                    //Form
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: "Nome",
                              hintText: "Ex: Banana prata",
                              controller: _nameController,
                              onChanged: (String name) =>
                                  bloc.add(UpdateProductEvent(name: name)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              label: "Descrição",
                              hintText:
                                  "Ex: Banana prata doce cultivada no meu quintal...",
                              controller: _descController,
                              onChanged: (String desc) => bloc
                                  .add(UpdateProductEvent(description: desc)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                      label: "Preço",
                                      hintText: "Ex: 1,85",
                                      controller: _priceController,
                                      keyboardType: TextInputType.number,
                                      onChanged: _onChangedPrice),
                                ),
                                CustomDropdownButton(
                                    options: productCategories,
                                    text: "Categoria",
                                    onChanged: _onChangedCategory),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: CustomTextField(
                                    label: "Quantidade disponível",
                                    hintText: "Ex: 10",
                                    controller: _availableQuantityController,
                                    keyboardType: TextInputType.number,
                                    onChanged: _onChangedAvailableQuantity,
                                    textInputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  ),
                                ),
                                CustomDropdownButton(
                                    options: productUnits,
                                    text: "Unidade",
                                    onChanged: _onChangedUnit)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: CustomDatePicker(
                                      text: "Data da colheita",
                                      onChanged: (date) {
                                        _onChangedHarvestDate(date);
                                      },
                                    )),
                                Column(
                                  children: [
                                    Text(
                                      "Orgânico?",
                                      style: TypographyStyles.paragraph3(),
                                    ),
                                    CustomSwitchButton(onChanged: (value) {
                                      _onChangedIsOrganic(value);
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    //Button
                    Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton(
                              isActive: isActive,
                              isLoading: isLoading,
                              onTap: () async {
                                bloc.add(AddNewProductEvent(
                                    productModel: bloc.product));
                              },
                              text: "Cadastrar",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
