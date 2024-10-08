import 'package:hive/hive.dart';

class OnboardingService {
  // Define the box name
  static const String _onboardingBoxName = 'onboardingBox';

  // Open the onboarding box (you can make this async if needed)
  Future<Box> get _box async => await Hive.openBox(_onboardingBoxName);

  // Method to set onboarding as completed
  Future<void> setOnboardingCompleted(bool isCompleted) async {
    var box = await _box;
    await box.put('onboarding_completed', isCompleted);
  }

  // Method to check if onboarding is completed
  Future<bool> isOnboardingCompleted() async {
    var box = await _box;
    return box.get('onboarding_completed', defaultValue: false);
  }

  // Optionally, a method to reset onboarding status
  Future<void> resetOnboardingStatus() async {
    var box = await _box;
    await box.put('onboarding_completed', false);
  }

  // Close the box when needed (optional for cleanup)
  Future<void> closeBox() async {
    var box = await _box;
    await box.close();
  }
}
