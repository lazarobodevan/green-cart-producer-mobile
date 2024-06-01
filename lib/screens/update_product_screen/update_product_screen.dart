import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';
import 'package:mobile_producer/json_data/product_categories.dart';
import 'package:mobile_producer/json_data/product_units.dart';
import 'package:mobile_producer/screens/update_product_screen/bloc/update_product_bloc.dart';
import 'package:mobile_producer/services/product_service.dart';
import 'package:mobile_producer/shared/components/custom_app_bar.dart';
import 'package:mobile_producer/shared/components/custom_button.dart';
import 'package:mobile_producer/shared/components/custom_date_picker.dart';
import 'package:mobile_producer/shared/components/custom_dropdown_button.dart';
import 'package:mobile_producer/shared/components/custom_link.dart';
import 'package:mobile_producer/shared/components/custom_switch_button.dart';
import 'package:mobile_producer/shared/components/custom_text_field.dart';
import 'package:mobile_producer/shared/components/picture_card.dart';
import 'package:mobile_producer/shared/enums/product_categories.dart';
import 'package:mobile_producer/shared/enums/product_unit.dart';
import 'package:mobile_producer/theme/typography_styles.dart';
import 'package:path/path.dart';

class UpdateProductScreen extends StatelessWidget {
  final String productId;

  const UpdateProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<UpdateProductBloc>(context)
      ..add(LoadProductEvent(productId: productId));

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
      bloc.add(UpdateProductInfoEvent(category: cat.name));
    }

    _onChangedUnit(dynamic unit) {
      var _unit = unit as ProductUnit;
      bloc.add(UpdateProductInfoEvent(unit: _unit.name));
    }

    _onChangedPrice(String price) {
      var _price = price.replaceAll(".", ",");
      _price = price.replaceAll("R\$", "");
      bloc.add(UpdateProductInfoEvent(price: _price));
    }

    _onChangedIsOrganic(bool isOrganic) {
      bloc.add(UpdateProductInfoEvent(isOrganic: isOrganic));
    }

    _onChangedHarvestDate(DateTime? date) {
      if (date != null) {
        var _date = formatter.format(date);
        bloc.add(UpdateProductInfoEvent(harvestDate: _date));
      }
    }

    _onChangedAvailableQuantity(String quantity) {
      int intQuantity = int.parse(quantity);
      bloc.add(UpdateProductInfoEvent(availableQuantity: intQuantity));
    }

    _getPicturesCount() {
      var metadata = bloc.productModel.picturesMetadata;
      if (metadata != null && metadata.isNotEmpty) {
        var max = metadata[0];
        for (int i = 0; i < metadata.length; i++) {
          if (metadata[i].position > max.position) {
            max = metadata[i];
          }
        }
        if (max.position > bloc.productModel.pictures!.length) {
          return bloc.productModel.pictures!.length + 1;
        }
      }
      return bloc.productModel.pictures!.length;
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Editar produto",
      ),
      body: BlocListener<UpdateProductBloc, UpdateProductState>(
        listener: (context, state) {
          if(state is SendedUpdateProductState){
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<UpdateProductBloc, UpdateProductState>(
          bloc: BlocProvider.of<UpdateProductBloc>(context)
            ..add(LoadProductEvent(productId: productId)),
          builder: (context, state) {

            bool loadingUpdate = false;

            if(state is SendingUpdateProductState){
              loadingUpdate = true;
            }else{
              loadingUpdate = false;
            }

            if (state is UpdateProductLoadingState) {
              _nameController.text = "";
              _availableQuantityController.text = "0";
              _priceController.text = "0.0";
              _descController.text = "";
              _harvestDateController.text = "";
              _availableQuantityController.text = "0";

              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UpdateInfoState || state is SendingUpdateProductState) {
              if (_nameController.text.isEmpty &&
                  _descController.text.isEmpty &&
                  _harvestDateController.text.isEmpty) {
                _nameController.text = bloc.productModel.name;
                _availableQuantityController.text =
                    bloc.productModel.availableQuantity.toString();
                _priceController.text =
                    double.parse(bloc.productModel.price.replaceAll(",", "."))
                        .toStringAsFixed(2);
                _descController.text = bloc.productModel.description;
                _harvestDateController.text =
                    bloc.productModel.harvestDate.toIso8601String();
                _availableQuantityController.text =
                    bloc.productModel.availableQuantity.toString();
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                "Fotos do produto (${bloc.productModel.pictures!.length}/5)",
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
                              var pictures = bloc.productModel.pictures!;
                              return Center(
                                child: PictureCard(
                                    key: UniqueKey(),
                                    isActive: false,
                                    index: index,
                                    onChanged: (picture, index) {
                                      //_onChangedPicture(picture, index);
                                    },
                                    pictureUrl: index < pictures.length
                                        ? pictures[index].url
                                        : null),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 10,
                              );
                            },
                            itemCount: _getPicturesCount(),
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
                                  bloc.add(UpdateProductInfoEvent(name: name)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField(
                              label: "Descrição",
                              hintText:
                                  "Ex: Banana prata doce cultivada no meu quintal...",
                              controller: _descController,
                              onChanged: (String desc) => bloc.add(
                                  UpdateProductInfoEvent(description: desc)),
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
                                    chosenValue: ProductCategories.values
                                        .byName(bloc.productModel.category),
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
                                    chosenValue: ProductUnit.values
                                        .byName(bloc.productModel.unit),
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
                                      date: bloc.productModel.harvestDate,
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
                                    CustomSwitchButton(
                                        value: bloc.productModel.isOrganic,
                                        onChanged: (value) {
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CustomButton(
                                onTap: () async {
                                  bloc.add(SendUpdateProductEvent(
                                      productModel: bloc.productModel));
                                },
                                text: "Atualizar",
                                isLoading: loadingUpdate,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text("Oops"),
            );
          },
        ),
      ),
    );
  }
}
