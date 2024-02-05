import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GlassEditor extends StatefulWidget {
  const GlassEditor({super.key});

  @override
  State<GlassEditor> createState() => _GlassEditorState();
}

class _GlassEditorState extends State<GlassEditor> {
  String imageUrl = '';
  double height = 100;
  double width = 100;
  double sigmaX = 5;
  double sigmaY = 5;
  double borderRadius = 10;
  double colorOpacity = 3;
  double border = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Center(
        child: Container(
          color: Colors.red,
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              SizedBox(
                // color: Colors.green,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const Row(
                  children: [
                    Spacer(),
                    UrlLauncher(
                      url: 'https://github.com/apon06',
                      text: 'github me',
                    ),
                    Spacer(),
                    UrlLauncher(
                      url: 'https://github.com/apon06',
                      text: 'github code',
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Row(
                  children: [
                    SizedBox(
                      width: 392,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imageUrl),
                            // image: AssetImage(imageUrl)
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(borderRadius),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: sigmaX,
                              sigmaY: sigmaY,
                            ),
                            child: Container(
                              height: height,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white
                                      .withOpacity(colorOpacity / 100),
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  border: Border.all(
                                      width: border, color: Colors.white30)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    SizedBox(
                      width: 292,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                        text: '''

                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage('$imageUrl'),
                            // image: AssetImage('$imageUrl') // if your image in assets
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular($borderRadius),
                            child: BackdropFilter(
                              // import 'dart:ui'; // import this
                              filter: ImageFilter.blur(
                                sigmaX: $sigmaX,
                                sigmaY: $sigmaY,
                              ),
                              child: Container(
                                height: $height,
                                width: $width,
                                decoration: BoxDecoration(
                                    color: Colors.white
                                        .withOpacity($colorOpacity / 100),
                                    borderRadius:
                                        BorderRadius.circular($borderRadius),
                                    border: Border.all(
                                        width: $border, color: Colors.white30)),
                              ),
                            ),
                          ),
                        ),
''',
                                      ),
                                    );
                                  },
                                  child: const Text('Copy Code')),
                            ],
                          ),
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                imageUrl = value;
                              });
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter Image Url'),
                          ),
                          Slider(
                              max: 500,
                              min: 10,
                              label: "Height ${height.round().toString()}",
                              divisions: 500,
                              value: height,
                              onChanged: (value) {
                                setState(() {
                                  height = value;
                                });
                              }),
                          Slider(
                              max: 300,
                              min: 10,
                              value: width,
                              label: "Width ${width.round().toString()}",
                              divisions: 300,
                              onChanged: (value) {
                                setState(() {
                                  width = value;
                                });
                              }),
                          Slider(
                              max: 30,
                              min: 0,
                              value: sigmaX,
                              label: "SigmaX ${sigmaX.round().toString()}",
                              divisions: 30,
                              onChanged: (value) {
                                setState(() {
                                  sigmaX = value;
                                });
                              }),
                          Slider(
                              max: 30,
                              min: 0,
                              value: sigmaY,
                              label: "SigmaY ${sigmaY.round().toString()}",
                              divisions: 30,
                              onChanged: (value) {
                                setState(() {
                                  sigmaY = value;
                                });
                              }),
                          Slider(
                              max: 300,
                              min: 0,
                              value: borderRadius,
                              label:
                                  "BorderRadius ${borderRadius.round().toString()}",
                              divisions: 300,
                              onChanged: (value) {
                                setState(() {
                                  borderRadius = value;
                                });
                              }),
                          Slider(
                              max: 100,
                              min: 0,
                              value: border,
                              label: "Border ${border.round().toString()}",
                              divisions: 100,
                              onChanged: (value) {
                                setState(() {
                                  border = value;
                                });
                              }),
                          Slider(
                              max: 100,
                              min: 0,
                              value: colorOpacity,
                              label:
                                  "ColorOpacity ${colorOpacity.round().toString()}",
                              divisions: 100,
                              onChanged: (value) {
                                setState(() {
                                  colorOpacity = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UrlLauncher extends StatelessWidget {
  final String url;
  final String text;
  const UrlLauncher({
    super.key,
    required this.url,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (!await canLaunchUrlString(url)) {
        } else {
          await launchUrlString(url);
        }
      },
      icon: const Icon(AntDesign.github_fill),
      label: Text(text),
    );
  }
}
