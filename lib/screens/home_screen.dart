import 'package:flutter/material.dart';
import 'package:weatherapp2/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weatherapp2/utils/custom_colors.dart';
import 'package:weatherapp2/widgets/comfort_level.dart';
import 'package:weatherapp2/widgets/current_weather_widget.dart';
import 'package:weatherapp2/widgets/header_widget.dart';
import 'package:weatherapp2/widgets/hourly_data_widget.dart';

import '../widgets/daily_data_forecast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/clouds.png",
                      height: 200,
                      width: 200,
                    ),
                    const CircularProgressIndicator()
                  ],
                )
              )
            : Center(
              child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),

                    CurrentWeatherWidget(
                      weatherDataCurrent: globalController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                      weatherDataHourly: globalController.getData().getHourlytWeather()
                    ),
                    DailyDataForecast(
                      weatherDataDaily: globalController.getData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                      weatherDataCurrent: globalController.getData().getCurrentWeather(),
                    ),
                  ],
                ),
            )),
      ),
    );
  }
}
