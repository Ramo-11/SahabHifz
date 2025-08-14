import '../models/quran_data.dart';

class CelebrationService {
  static String getCelebrationMessage(String userName, int completedPages) {
    if (completedPages == QuranData.totalPages) {
      return "🎉 Subhan'Allah $userName! You've completed the entire Quran! 🎉";
    }

    if (QuranData.isJuzComplete(completedPages)) {
      int juzNumber = QuranData.getCompletedJuzCount(completedPages);
      return "🌟 Masha'Allah $userName! You've completed Juz $juzNumber! 🌟";
    }

    if (QuranData.isHizbComplete(completedPages)) {
      int hizbNumber = QuranData.getCompletedHizbCount(completedPages);
      return "✨ Excellent $userName! You've completed Hizb $hizbNumber! ✨";
    }

    int pagesLeft = QuranData.totalPages - completedPages;
    if (pagesLeft < 50) {
      return "Amazing progress $userName! You're so close to the finish! 💫";
    } else if (pagesLeft < 100) {
      return "Masha'Allah $userName! You're doing incredibly well! 🌟";
    } else if (completedPages % 50 == 0) {
      return "Fantastic milestone $userName! Keep up the excellent work! ✨";
    } else {
      return "Excellent $userName! Another page completed! 🌙";
    }
  }

  static String getCelebrationTitle(int completedPages) {
    if (completedPages == QuranData.totalPages) {
      return "Quran Complete! 🎉";
    }

    if (QuranData.isJuzComplete(completedPages)) {
      int juzNumber = QuranData.getCompletedJuzCount(completedPages);
      return "Juz $juzNumber Complete! 🌟";
    }

    if (QuranData.isHizbComplete(completedPages)) {
      int hizbNumber = QuranData.getCompletedHizbCount(completedPages);
      return "Hizb $hizbNumber Complete! ✨";
    }

    return "Congratulations! 🎊";
  }
}
