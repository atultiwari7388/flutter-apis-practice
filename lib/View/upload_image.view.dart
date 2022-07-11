import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;

class UploadImageView extends StatefulWidget {
  const UploadImageView({Key? key}) : super(key: key);

  @override
  State<UploadImageView> createState() => _UploadImageViewState();
}

class _UploadImageViewState extends State<UploadImageView> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  //create a function to pick an image
  Future pickImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      if (kDebugMode) {
        print("Something Went wrong");
      }
    }
  }

  //create a post api
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = await http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse("https://fakestoreapi.com/products");
    var request = http.MultipartRequest("POST", uri);
    request.fields["title"] = "First Image";

    var multiPart = http.MultipartFile("image", stream, length);

    request.files.add(multiPart);

    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      print("Successfully");
    } else {
      print("something went wrong");
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
          centerTitle: true,
          elevation: 1.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => pickImage(),
              child: Container(
                child: image == null
                    ? const Center(
                        child: Text("Pick Image"),
                      )
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 150),
            InkWell(
              onTap: () => uploadImage(),
              child: Container(
                height: 50,
                color: Colors.green,
                child: Center(
                  child: Text("Upload Image"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
