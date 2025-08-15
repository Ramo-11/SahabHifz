import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../models/quran_data.dart';
import '../services/storage_service.dart';
import '../services/celebration_service.dart';
import '../widgets/progress_circle.dart';
import '../widgets/stats_card.dart';
import '../widgets/motivational_quote.dart';
import 'name_setup_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int completedPages = 0;
  int pagesLeft = QuranData.totalPages;
  String userName = '';

  late ConfettiController _confettiController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _loadData();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final pages = await StorageService.getCompletedPages();
    final name = await StorageService.getUserName() ?? '';

    setState(() {
      completedPages = pages;
      pagesLeft = QuranData.totalPages - completedPages;
      userName = name;
    });
  }

  Future<void> _openSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NameSetupScreen(isEditing: true)),
    );

    // If changes were made, reload the data
    if (result == true) {
      _loadData();
    }
  }

  Future<void> _completePage() async {
    if (pagesLeft > 0) {
      setState(() {
        completedPages++;
        pagesLeft = QuranData.totalPages - completedPages;
      });

      await StorageService.saveCompletedPages(completedPages);

      // Trigger animations
      _confettiController.play();
      _buttonAnimationController.forward().then((_) {
        _buttonAnimationController.reverse();
      });

      // Show celebration dialog
      _showCelebrationDialog();
    }
  }

  void _showCelebrationDialog() {
    String title = CelebrationService.getCelebrationTitle(completedPages);
    String message = CelebrationService.getCelebrationMessage(
      userName,
      completedPages,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 50, color: Colors.amber),
              SizedBox(height: 16),
              Text(
                message,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = completedPages / QuranData.totalPages;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.green[600], size: 20),
            onPressed: _openSettings,
            tooltip: "Edit Profile",
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Confetti
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.orange,
                    Colors.pink,
                    Colors.yellow,
                  ],
                ),
              ),

              // Main content
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom -
                        kToolbarHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Header
                          SizedBox(height: 10),
                          Text(
                            "Assalamu Alaikum",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "May Allah make it easy for you 🤲",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),

                          SizedBox(height: 30),

                          // Progress Circle
                          ProgressCircle(
                            progress: progress,
                            pagesLeft: pagesLeft,
                            completedPages: completedPages,
                          ),

                          SizedBox(height: 24),

                          // Stats Cards
                          StatsCard(completedPages: completedPages),

                          SizedBox(height: 24),

                          // Complete page button
                          AnimatedBuilder(
                            animation: _buttonAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _buttonAnimation.value,
                                child: Container(
                                  width: double.infinity,
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: pagesLeft > 0
                                        ? _completePage
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: pagesLeft > 0
                                          ? Colors.green[600]
                                          : Colors.grey[400],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Text(
                                      pagesLeft > 0
                                          ? "Complete a Page! 📖"
                                          : "All Pages Completed! 🎉",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 20),

                          // Motivational quote
                          MotivationalQuote(),

                          SizedBox(height: 16),

                          // Powered by text
                          Text(
                            "Powered by Sahab Solutions",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(
                            height: 24,
                          ), // Reduced space since no floating action button
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
