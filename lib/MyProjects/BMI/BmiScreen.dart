import 'package:first_app/MyProjects/BMI/cubit/bmi_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Bmiscreen extends StatelessWidget {
  const Bmiscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BmiCubit>();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 105, 14, 121),
      appBar: AppBar(
        title: const Text('Back'),
        leading: const Icon(CupertinoIcons.back),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Container(
                height: 150,
                width: double
                    .infinity, //بياخد المساحه كلها ميبقاش علي قد التيكست بس
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 226, 140, 241),
                  image: const DecorationImage(
                    alignment: Alignment.centerRight,
                    image: NetworkImage(
                        'https://assets.streamlinehq.com/image/private/w_210,h_210,ar_1/f_auto/v1/icons/free-illustrations-bundle/brooklyn/brooklyn/be-patient-2-v5wj0ce9yfc3lmwh493c.png?_a=DAJFJtWIZAA0'),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Interestig for you : ",
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(),
                      const Text(
                        "Yoga: benefits and risks",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Yoge Advertisment"),
                                content: const Text(
                                  "Yoga transforms your body and mind, boosting flexibility, strength, and inner peace. But remember, with great rewards come risks—injuries from improper form and dehydration in intense sessions. Embrace yoga's power, but practice with care to unlock its full potential.    JOIN NOW",
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // هتخرجه
                                    },
                                    child: const Text("Cancel"),
                                  )
                                ],
                              );
                            }),
                        child: const Text(
                          "tab to read more ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(children: [
              const Text(
                "BMI Calculator",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              BlocBuilder<BmiCubit, BmiState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      _genderItem(
                        "Female",
                        cubit,
                        isselected: cubit.selectedGender == Gender.FEMALE,
                        selected: Gender.FEMALE,
                      ),
                      _genderItem(
                        "Male",
                        cubit,
                        isselected: cubit.selectedGender == Gender.MALE,
                        selected: Gender.MALE,
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<BmiCubit, BmiState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      _WeightAgeContainer(cubit, "height"),
                      _WeightAgeContainer(cubit, "Age"),
                    ],
                  );
                },
              ),
            ]),
            BlocBuilder<BmiCubit, BmiState>(
              builder: (context, state) {
                return Container(
                  child: _getRadialGauge(cubit),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: InkWell(
                  onTap: () {
                    double bmi =
                        cubit.radialValue / ((cubit.selectedHeight / 100) * 2);
                    String message;
                    if (bmi < 18.5) {
                      message = 'Underweight';
                    } else if (bmi >= 18.5 && bmi < 24.9) {
                      message = 'Normal';
                    } else if (bmi >= 25 && bmi < 29.9) {
                      message = 'Overweight';
                    } else {
                      message = 'Obese';
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(message),
                            content: Text(
                              "your BMI is ${bmi.toInt()}",
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // هتخرجه
                                },
                                child: const Text("OK"),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 236, 133, 173),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Check your BMI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getRadialGauge(BmiCubit cubit) {
    return Expanded(
      child: SfRadialGauge(
          title: const GaugeTitle(
              text: 'Weight',
              textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          axes: <RadialAxis>[
            RadialAxis(minimum: 0, maximum: 150, ranges: <GaugeRange>[
              GaugeRange(
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                  startValue: 0,
                  endValue: 50,
                  color: const Color.fromARGB(255, 76, 147, 175),
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                  startValue: 50,
                  endValue: 100,
                  color: const Color.fromARGB(255, 226, 50, 147),
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  labelStyle: const GaugeTextStyle(color: Colors.white),
                  startValue: 100,
                  endValue: 150,
                  color: const Color.fromARGB(255, 170, 42, 196),
                  startWidth: 10,
                  endWidth: 10)
            ], pointers: <GaugePointer>[
              NeedlePointer(
                knobStyle: const KnobStyle(color: Colors.white),
                needleColor: (Colors.white),
                value: cubit.radialValue,
                enableDragging: true,
                onValueChanged: (value) {
                  cubit.changeRadialValue(value);
                },
              )
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Container(
                      child: Text(cubit.radialValue.toStringAsFixed(0),
                          style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ]),
    );
  }

  Expanded _WeightAgeContainer(
    BmiCubit cubit,
    String? text,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 140, 241),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  text == "height"
                      ? cubit.selectedHeight.toString()
                      : cubit.selectedAge.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 102, 100, 216),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                        shape: const CircleBorder(),
                        mini: true,
                        //logic
                        onPressed: () {
                          cubit.minusChange(text);
                        },
                        child: const Icon(Icons.remove)),
                    const SizedBox(
                      width: 10,
                    ),
                    FloatingActionButton(
                      shape: const CircleBorder(),
                      mini: true,
                      onPressed: () {
                        cubit.plusChange(text);
                      },
                      child: const Icon(Icons.add),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// gender method
  Widget _genderItem(
    String text,
    BmiCubit cubit, {
    required bool isselected,
    required Gender selected,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            cubit.changeGender(selected);
          },
          child: Container(
            height: 40,
            decoration: _boxDecoration(isselected: isselected),
            child: Center(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration({bool isselected = false}) {
    return BoxDecoration(
        color: isselected
            ? const Color.fromARGB(255, 243, 152, 243)
            : const Color.fromARGB(255, 190, 200, 206),
        borderRadius: BorderRadius.circular(20));
  }
}
