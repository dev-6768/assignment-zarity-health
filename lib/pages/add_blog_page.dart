import 'package:assignment_zarity_health/utils/constants.dart';
import 'package:assignment_zarity_health/widgets/alert_dialog_widget.dart';
import 'package:assignment_zarity_health/widgets/appbar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddBlogScreen extends StatefulWidget {
  const AddBlogScreen({super.key});

  @override
  State<AddBlogScreen> createState() => _AddBlogScreenState();
}

class _AddBlogScreenState extends State<AddBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  late AggregateQuerySnapshot countOfDocs;
  bool isProcessLoading = false;
  File? _image;


  Future<void> _pickImage() async {
    setState(() {
      isProcessLoading = true;
    });
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        isProcessLoading = false;
      });
    }
  }

  Future<String> _uploadImage(File image) async {
    try {

      final storageRef = FirebaseStorage.instance.ref("/blogs");
      final imagesRef = storageRef.child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      final uploadTask = imagesRef.putFile(image);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;

    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<void> _saveBlog() async {
    setState(() {
      isProcessLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      String imageUrl = ConstantUtils.noImage;

      if(_image != null) {
        imageUrl = await _uploadImage(_image!);
      }

      countOfDocs = await FirebaseFirestore.instance.collection('/blogs').count().get();

      await FirebaseFirestore.instance.collection('/blogs').add({
        'title': _titleController.text,
        'summary': _summaryController.text,
        'image': imageUrl,
        'index': countOfDocs.count
      });
    }

    setState(() {
      isProcessLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets.appBarWidget("Add Blog"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),

              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(
                  hintText: 'Summary',
                  border: OutlineInputBorder(),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a summary';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              _image == null
                  ? 
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0
                      )
                    ),
                    child:const  Center(child: Text('No image selected.'))
                  )
                  :
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0
                      )
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    
                  ), 

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  try {
                    await _pickImage();
                    if(context.mounted) {
                      SnackBarUtils.returnSnackBar(context, "Image picked successfully");
                    }
                    
                  }
                  
                  catch(exception) {
                    if(context.mounted) {
                      SnackBarUtils.returnSnackBar(context, "Some error occured while picking image.");
                    }
                    
                  }

                },
                
                child: const Text('Select Image'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  try {
                    await _saveBlog();
                    if(context.mounted) {
                      AlertDialogWidget.showAlertDialog(
                        AlertDialogWidget.primaryAlertDialog(context, countOfDocs.count!),
                        context
                      );
                      SnackBarUtils.returnSnackBar(context, "Blog saved successfully");
                    }
                
                  }

                  catch(exception) {
                    if(context.mounted) {
                      SnackBarUtils.returnSnackBar(context, "Some error occured while saving blog.");
                    }
                    
                  }
                },
                
                child: isProcessLoading == true ? const CircularProgressIndicator() : const Text("Save Blog Post")
              ),
            ],
          ),
        ),
      ),
    );
  }
}