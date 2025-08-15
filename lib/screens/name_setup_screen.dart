import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class NameSetupScreen extends StatefulWidget {
  final bool isEditing;

  const NameSetupScreen({Key? key, this.isEditing = false}) : super(key: key);

  @override
  _NameSetupScreenState createState() => _NameSetupScreenState();
}

class _NameSetupScreenState extends State<NameSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing) {
      _loadCurrentData();
    }
  }

  Future<void> _loadCurrentData() async {
    final name = await StorageService.getUserName() ?? '';
    final pages = await StorageService.getCompletedPages();
    setState(() {
      _nameController.text = name;
      _pagesController.text = pages.toString();
    });
  }

  Future<void> _saveName() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter your name')));
      return;
    }

    // Parse completed pages
    int completedPages = 0;
    if (_pagesController.text.trim().isNotEmpty) {
      try {
        completedPages = int.parse(_pagesController.text.trim());
        if (completedPages < 0 || completedPages > 604) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a number between 0 and 604')),
          );
          return;
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Please enter a valid number')));
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    await StorageService.saveUserName(_nameController.text.trim());
    await StorageService.saveCompletedPages(completedPages);

    if (widget.isEditing) {
      Navigator.pop(context, true); // Return true to indicate changes were made
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isEditing
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.green[800]),
              ),
            )
          : null,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Icon(Icons.person, size: 60, color: Colors.green[600]),
                      SizedBox(height: 24),
                      Text(
                        "Welcome to your",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green[800],
                        ),
                      ),
                      Text(
                        "Quran Memorization Journey",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32),
                      Text(
                        widget.isEditing
                            ? "Update your information"
                            : "What should we call you?",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Enter your name",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.green[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.green[600]!,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                        widget.isEditing
                            ? "Update completed pages (Optional)"
                            : "How many pages have you already completed? (Optional)",
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _pagesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "0 (if starting fresh)",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.blue[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.blue[600]!,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveName,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 3,
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "Start My Journey 🌙",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
