class OnboardingModel {
  String? title;
  String? image;

  OnboardingModel({
    this.image,
    this.title,
  });
}

List<OnboardingModel> onBoardingList = [
  OnboardingModel(
    title: "Welcome 111",
    image: "delivery1.png",
  ),
  OnboardingModel(
    title: "Welcome 222",
    image: "delivery2.png",
  ),
  OnboardingModel(
    title: "Welcome 333",
    image: "delivery3.png",
  ),
];
