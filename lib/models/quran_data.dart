class QuranData {
  static const int totalPages = 604;

  static const List<int> juzEndPages = [
    21,
    41,
    61,
    81,
    101,
    121,
    141,
    161,
    181,
    201,
    221,
    241,
    261,
    281,
    301,
    321,
    341,
    361,
    381,
    401,
    421,
    441,
    461,
    481,
    501,
    521,
    541,
    561,
    581,
    604,
  ];

  static const List<int> hizbEndPages = [
    10,
    21,
    31,
    41,
    51,
    61,
    71,
    81,
    91,
    101,
    111,
    121,
    131,
    141,
    151,
    161,
    171,
    181,
    191,
    201,
    211,
    221,
    231,
    241,
    251,
    261,
    271,
    281,
    291,
    301,
    311,
    321,
    331,
    341,
    351,
    361,
    371,
    381,
    391,
    401,
    411,
    421,
    431,
    441,
    451,
    461,
    471,
    481,
    491,
    501,
    511,
    521,
    531,
    541,
    551,
    561,
    571,
    581,
    591,
    604,
  ];

  static int getJuzNumber(int completedPages) {
    for (int i = 0; i < juzEndPages.length; i++) {
      if (completedPages <= juzEndPages[i]) {
        return i + 1;
      }
    }
    return 30;
  }

  static int getHizbNumber(int completedPages) {
    for (int i = 0; i < hizbEndPages.length; i++) {
      if (completedPages <= hizbEndPages[i]) {
        return i + 1;
      }
    }
    return 60;
  }

  static bool isJuzComplete(int completedPages) {
    return juzEndPages.contains(completedPages);
  }

  static bool isHizbComplete(int completedPages) {
    return hizbEndPages.contains(completedPages);
  }

  static int getCompletedJuzCount(int completedPages) {
    int count = 0;
    for (int juzEnd in juzEndPages) {
      if (completedPages >= juzEnd) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  static int getCompletedHizbCount(int completedPages) {
    int count = 0;
    for (int hizbEnd in hizbEndPages) {
      if (completedPages >= hizbEnd) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }
}
