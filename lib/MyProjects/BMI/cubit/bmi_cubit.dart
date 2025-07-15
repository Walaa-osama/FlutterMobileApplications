import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bmi_state.dart';

class BmiCubit extends Cubit<BmiState> {
  BmiCubit() : super(BmiInitial());
  var radialValue = 10.0; //selectedWeight
  Gender selectedGender = Gender.MALE;
  double selectedHeight = 180;
  // int selectedWeight = 0;
  int selectedAge = 0;

  void changeGender(Gender gender) {
    selectedGender = gender;
    emit(genderstate());
  }

  void changeRadialValue(double value) {
    radialValue = value;
    emit(radialstate());
  }

  void minusChange(String text) {
    if (text == "height") {
      selectedHeight--;
    } else {
      selectedAge--;
    }
    emit(minusstate());
  }

  void plusChange(String text) {
    if (text == "height") {
      selectedHeight++;
    } else {
      selectedAge++;
    }
    emit(plusstate());
  }
}

enum Gender {
  MALE,
  FEMALE,
}
