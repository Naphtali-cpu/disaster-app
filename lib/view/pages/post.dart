import 'dart:convert';
import 'dart:io';

import 'package:disastermanagement/base/BaseData.dart';
import 'package:disastermanagement/widgets/MySelectBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../base/functions.dart';
import '../../widgets/mybutton.dart';
import '../../widgets/mytext.dart';
import '../../widgets/mytextfields.dart';

class PostReport extends StatefulWidget {
  const PostReport({super.key});

  @override
  State<PostReport> createState() => _PostReportState();
}

class _PostReportState extends State<PostReport> {
  List<String> disasterList = [
    "Select Disaster",
  ];
  String disaster = "Select Disaster";
  final description = TextEditingController();
  final disaster_type = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  MyFunctions functions = MyFunctions();
  BaseData baseData = BaseData();

  double latitude = 0.0;
  double longitude = 0.0;

  File? pickedImage;
  VideoPlayerController? _videoPlayerController;

  pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
      });
    }
  }

  pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        pickedImage = File(pickedFile.path);
        _videoPlayerController = VideoPlayerController.file(pickedImage!)
          ..initialize().then((_) {
            setState(() {});
          });
      });
    }
  }

  getLocation() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  getdisasters()async{
    var response = jsonDecode(await baseData.getData('types'));
    if(response['success'] == true){
      for(int i =0;i<response['data'].length;i++){
        disasterList.add(response["data"][i]['name']);
      }
    }else{
      EasyLoading.showError("Failed to Fetch Disasters");
    }
  }

  @override
  void initState() {
    getLocation();
    getdisasters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: MyTextView(
                      data: 'Post Report',
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                      maxlines: 1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                      hintstrin: 'Description', controller: description),
                  const SizedBox(height: 10),
                  MySelectBox(disasterList, disaster, (newValue) {
                    debugPrint(newValue);

                    disaster = newValue;
                    setState(() {});
                  }),
                  const SizedBox(height: 10),
                  if (_videoPlayerController != null &&
                      _videoPlayerController!.value.isInitialized)
                    Column(
                      children: [
                        AspectRatio(
                          aspectRatio:
                              _videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController!),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_videoPlayerController!.value.isPlaying) {
                                  _videoPlayerController!.pause();
                                } else {
                                  _videoPlayerController!.play();
                                }
                              },
                              child: _videoPlayerController!.value.isPlaying
                                  ? const Text('Pause')
                                  : const Text('Play'),
                            ),
                          ],
                        ),
                      ],
                    )
                  else if (pickedImage != null)
                    Container(
                      height: 200,
                      child: Image.memory(
                        pickedImage!.readAsBytesSync(),
                        fit: BoxFit.contain,
                      ),
                    )
                  else
                    const Center(
                      child: MyTextView(
                        data: 'Preview of report image/video',
                        fontsize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          onPressed: pickImage,
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: MyTextView(
                              data: 'Take Photo',
                              fontWeight: FontWeight.w600,
                              colors: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        MaterialButton(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          onPressed: pickVideo,
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: MyTextView(
                              data: 'Record Video',
                              fontWeight: FontWeight.w600,
                              colors: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
                onPressed: () async {
                  if (description.text.isEmpty) {
                  } else {
                    EasyLoading.show(status: "Loading Please Wait");
                    await functions.postReport(
                      description.text,
                      disaster,
                      "image.jpg",
                      "$longitude, $latitude"
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MyTextView(
                    data: 'Post Report',
                    fontWeight: FontWeight.w600,
                    colors: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
