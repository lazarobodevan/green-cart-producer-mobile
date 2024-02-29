import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_producer/theme/theme_colors.dart';

class PictureCard extends StatefulWidget {
  File? picture;
  final int index;
  final Function(File?, int) onChanged;
  PictureCard({super.key, this.picture, required this.onChanged, required this.index});

  @override
  State<PictureCard> createState() => _PictureCardState();
}

class _PictureCardState extends State<PictureCard> {
  late File? _picture;
  @override
  void initState() {
    super.initState();
    _picture = widget.picture;
  }
  
  Future<File?>_picImageFromCamera() async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    if(returnedImage == null) return null;
    setState(() {
      _picture = File(returnedImage.path);
    });
    return _picture;
  }
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        var picture = await _picImageFromCamera();
        widget.onChanged(picture, widget.index);
      },
      child: DottedBorder(
        radius: Radius.circular(12),
        borderType: BorderType.RRect,
        color: ThemeColors.gray3,
        dashPattern: [8,4],
        child: _picture != null ? Ink(width: 180,
            height: 100,child: Image.file(_picture!, fit: BoxFit.cover,)) :Ink(
          width: 180,
          height: 100,
          child: Center(child: Icon(Icons.add_circle_outline, color: ThemeColors.gray5,),),
        ),
      ),
    );
  }
}
