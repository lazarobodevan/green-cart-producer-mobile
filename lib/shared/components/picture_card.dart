import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_producer/theme/theme_colors.dart';

class PictureCard extends StatefulWidget {
  File? picture;
  String? pictureUrl;
  bool? isActive;
  final int index;
  final Function(File?, int) onChanged;

  PictureCard(
      {super.key,
      this.picture,
      required this.onChanged,
      required this.index,
      this.pictureUrl,
      this.isActive});

  @override
  State<PictureCard> createState() => _PictureCardState();
}

class _PictureCardState extends State<PictureCard> {
  late File? _picture;
  late String? _pictureUrl;

  @override
  void initState() {
    super.initState();
    _picture = widget.picture;
    _pictureUrl = widget.pictureUrl;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _picture = null;
    _pictureUrl = null;
  }

  Future<File?> _picImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    if (returnedImage == null) return null;
    setState(() {
      _picture = File(returnedImage.path);
    });
    return _picture;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (widget.isActive == false) {
          return;
        }
        var picture = await _picImageFromCamera();
        widget.onChanged(picture, widget.index);
      },
      child: DottedBorder(
        radius: Radius.circular(12),
        borderType: BorderType.RRect,
        color: widget.pictureUrl == null && widget.picture == null
            ? ThemeColors.gray3
            : Colors.transparent,
        dashPattern: [8, 4],
        child: _pictureUrl != null
            ? Ink(
                width: 180,
                height: 100,
                child: Image.network(
                  widget.pictureUrl!,
                  fit: BoxFit.cover,
                  key: UniqueKey(),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ))
            : _picture != null
                ? Ink(
                    width: 180,
                    height: 100,
                    child: Image.file(
                      _picture!,
                      fit: BoxFit.cover,
                    ))
                : Ink(
                    width: 180,
                    height: 100,
                    child: const Center(
                      child: Icon(
                        Icons.add_circle_outline,
                        color: ThemeColors.gray5,
                      ),
                    ),
                  ),
      ),
    );
  }
}
