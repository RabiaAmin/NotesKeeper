class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Learn, take notes, and stay organized",
    image: "assets/onBoarding1.png",
    desc: "Track your learning and take notes efficiently from anywhere.",
  ),
  OnboardingContents(
    title: "Capture your thoughts effortlessly",
    image: "assets/onBoarding2.png",
    desc: "Jot down ideas, organize your notes, and keep everything handy.",
  ),
  OnboardingContents(
    title: "Manage your notes on the go",
    image: "assets/onBoarding3.png",
    desc: "Quickly access and add notes wherever you are with real-time sync.",
  ),
];
