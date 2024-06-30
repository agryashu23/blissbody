import 'package:blissbody_app/constants/colors.dart';
import 'package:blissbody_app/controllers/gymController.dart';
import 'package:blissbody_app/data/data.dart';
import 'package:blissbody_app/helper/help_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final GymController gymController = Get.find<GymController>();
String? _selectedItem;

Widget PlanWidget(String title, dynamic item) {
  return Card(
    elevation: 2,
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  title,
                  style: TextStyle(
                      color: ColorConst.titleColor,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConst.primaryGrey),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: DropdownButton<String>(
                  elevation: 10,
                  isDense: true,
                  underline: SizedBox(),
                  hint: Text('Workout'),
                  value: _selectedItem,
                  onChanged: (value) {
                    item.add(value);
                  },
                  items: gymData.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 34,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: item.length,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: getW(context) * 0.05),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorConst.primaryGrey)),
                        child: Text(
                          item[index],
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Positioned(
                          top: 0,
                          right: 4,
                          bottom: 15,
                          child: GestureDetector(
                            onTap: () {
                              item.remove(item[index]);
                            },
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: ColorConst.websiteHomeBox,
                              child: Icon(
                                Icons.close_rounded,
                                size: 14,
                              ),
                            ),
                          ))
                    ],
                  );
                }),
          )
        ],
      ),
    ),
  );
}
