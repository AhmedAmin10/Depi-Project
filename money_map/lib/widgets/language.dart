import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  final String selectedLanguage;

  const LanguageScreen({super.key, required this.selectedLanguage});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final List<String> languages = [
    'English',
    // 'Indonesian',
    // 'Arabic',
    // 'Chinese',
    // 'Dutch',
    // 'French',
    // 'German',
    // 'Italian',
    // 'Korean',
    // 'Portuguese',
    // 'Russian',
    // 'Spanish',
  ];

  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.selectedLanguage; // Initialize with current state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, selectedLanguage); // Pass back language
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: Color(0xFF001B94),
                    ),
                  ),
                  
                const Center(
                  child: Text(
                    "Language",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff272e81),
                    ),
                  ),
                )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        languages[index],
                        style: const TextStyle(color: Colors.black), // Set language text color to black
                      ),
                      trailing: languages[index] == selectedLanguage
                          ? const Icon(
                              Icons.check,
                              color: Color(0xff272e81),
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          selectedLanguage = languages[index];
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}