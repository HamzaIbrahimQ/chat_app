import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';



class UserImagePicker extends StatefulWidget {

  UserImagePicker(this.imagePickFn);

  final Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _pickedImage;
  final _picker = ImagePicker();
  
  void _pickImage() async{
    final pickedFile = await _picker.getImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      widget.imagePickFn(_pickedImage);
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
