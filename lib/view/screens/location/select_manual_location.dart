import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class SelectManuallyLocation extends StatefulWidget {
  const SelectManuallyLocation({super.key});

  @override
  State<SelectManuallyLocation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SelectManuallyLocation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color(0xFF383838),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFFFC700),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                      width: AppSceenSize.getWidth(context) * 0.6,
                      height: 45,
                      decoration: BoxDecoration(
                          color: const Color(0xFF383838),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Where are you?",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF7D7D7D)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              )))),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  SizedBox(
                    height: AppSceenSize.getHeight(context) * 0.6,
                    width: AppSceenSize.getWidth(context) * 0.8,
                    child: ListView.builder(
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: SizedBox(
                              height: 60,
                              width: AppSceenSize.getWidth(context) * 0.8,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: const [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "*",
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Home",
                                          style: TextStyle(
                                              color: Color(0xFf7D7D7D)),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "Kolkataa",
                                        style: TextStyle(
                                            color: Color(0xFF878787),
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  _buildAddCard(),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 40,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              // Detect the swipe up gesture and show the bottom sheet.
              if (details.primaryVelocity! < 0) {
                _showBottomSheet(context);
              }
            },
            child: const Center(
              child: Text(
                'swipe up for popular location',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildAddCard() {
    return Container(
      height: 40,
      width: AppSceenSize.getWidth(context) * 0.4,
      decoration: BoxDecoration(
          color: const Color(0xFF14BCF0),
          borderRadius: BorderRadius.circular(10)),
      child: const Center(
        child: Text(
          'Done',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          height: AppSceenSize.getHeight(context) * 0.6,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                color: Colors.grey,
                width: 80,
              ),
              Row(
                children: [
                  Column(
                    children: const [
                      Icon(Icons.location_on),
                      SizedBox(
                        height: 40,
                      ),
                      Icon(Icons.location_on)
                    ],
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pick-up",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          "My current location",
                          style: AppTextStyle.onboaringSubtitle,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {},
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Drop-off",
                                    style: TextStyle(color: Color(0xFFC8C7CC)),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'newtown',
                                    style: AppTextStyle.onboaringSubtitle,
                                  )
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    Image.asset('assets/icons/close.png'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Image.asset('assets/icons/ic_map.png'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              _buildListOfPopularLocation()
            ],
          ),
        );
      },
    );
  }

  _buildListOfPopularLocation() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Popular location",
            style: TextStyle(color: Color(0xFFC8C7CC)),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
              itemCount: 4,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Axis Mall",
                          style: AppTextStyle.onboaringSubtitle,
                        )
                      ],
                    ),
                    Icon(
                      Icons.star_outline,
                      size: 40,
                      color: Colors.grey.withOpacity(0.6),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
