import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp2/model/weather_data_hourly.dart';
import 'package:weatherapp2/utils/custom_colors.dart';
import '../screens/controller/global_controller.dart';

class HourlyDataWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyDataWidget({Key? key, required this.weatherDataHourly}) : super(key: key);

  @override
  _HourlyDataWidgetState createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  late RxInt cardIndex;

  @override
  void initState() {
    super.initState();
    cardIndex = GlobalController().getIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            "Today",
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 12
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
            onTap: () {
              cardIndex.value = index;
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.5, 0),
                    blurRadius: 30,
                    spreadRadius: 1,
                    color: CustomColors.dividerLine.withAlpha(150),
                  ),
                ],
                gradient: cardIndex.value == index
                    ? const LinearGradient(colors: [
                  CustomColors.firstGradientColor,
                  CustomColors.secondGradientColor,
                ])
                    : null,
              ),
              child: HourlyDetails(
                index: index,
                cardIndex: cardIndex.toInt(),
                temp: widget.weatherDataHourly.hourly[index].temp!,
                timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                weatherIcon: widget.weatherDataHourly.hourly[index].weather![0].icon!,
              ),
            ),
          ));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int index;
  final int cardIndex;
  final int timeStamp;
  final String weatherIcon;
  HourlyDetails(
      {super.key,
        required this.index,
        required this.cardIndex,
        required this.timeStamp,
        required this.temp,
        required this.weatherIcon
      });
  String getTime(int timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000); // Chuyển đổi sang mili giây
    return DateFormat.jm().format(time); // Định dạng đối tượng DateTime
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
                color: cardIndex == index ? Colors.white : CustomColors.textColorBlack),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp℃",
            style: TextStyle(color: cardIndex == index ? Colors.white : CustomColors.textColorBlack),
          ),
        ),
      ],
    );
  }
}

