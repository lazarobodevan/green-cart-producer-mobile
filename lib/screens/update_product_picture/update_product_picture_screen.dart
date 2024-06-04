import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_producer/shared/blocs/product_bloc/product_bloc.dart';
import 'package:mobile_producer/shared/components/custom_app_bar.dart';
import 'package:mobile_producer/shared/components/custom_button.dart';
import 'package:mobile_producer/shared/components/picture_card.dart';
import 'package:reorderables/reorderables.dart';

import '../update_product_screen/bloc/update_product_bloc.dart';

class UpdateProductPictureScreen extends StatelessWidget {
  final bool? isUpdate;

  const UpdateProductPictureScreen({super.key, this.isUpdate = false});

  @override
  Widget build(BuildContext context) {
    if (isUpdate == true) {
      return Container();
    } else {
      return Scaffold(
        appBar: CustomAppBar(title: "Atualizar fotos"),
        body: BlocBuilder(bloc: BlocProvider.of<ProductBloc>(context),
            builder: (context, state) {
              var bloc = BlocProvider.of<ProductBloc>(context);

              _onChangedPicture(file, index) {

              }

              _onReorder(int oldIndex, int newIndex) {
                
                bloc.add(ReorderProductPicture(oldIndex: oldIndex, newIndex: newIndex));
              }

              _onConfirmReorder(){
                Navigator.pop(context);
                bloc.add(ConfirmReorderProductPicture());
              }

              _getPicture(int index) {
                var length = bloc.product.pictures.length;
                var pictures = bloc.product.pictures;
                return index < length ? pictures[index] : null;
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${bloc.picturesMetadataCopy[0].name} - [${bloc.picturesMetadataCopy[0].position}]'),
                  ),
                  ReorderableWrap(
                      onReorder: _onReorder, children: bloc.picturesCopy
                      .asMap()
                      .entries
                      .map((e) {
                    return PictureCard(onChanged: _onChangedPicture,
                      index: e.key,
                      picture: e.value,);
                  }).toList()),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(onTap: _onConfirmReorder, text: "Confirmar alterações"),
                    ),
                  )
                ],
              );
            }),
      );
    }
  }
}
