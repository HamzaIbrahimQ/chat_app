import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _pickedImage;
  final _picker = ImagePicker();
  
  void _pickImage() async{
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
}

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        TextButton.icon(
          label: Text('Add Image'),
          icon: Icon(Icons.image),
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
