import 'package:flutter/material.dart';

void main() {
  runApp(const ScavengerHuntApp());
}

class ScavengerHuntApp extends StatelessWidget {
  const ScavengerHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT Scavenger Hunt',
      theme: ThemeData(
        // LSU Brand Colors
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF461D7C), // LSU Purple
          primary: const Color(0xFF461D7C), // LSU Purple
          secondary: const Color(0xFFFDD023), // LSU Gold
          tertiary: const Color(0xFF76777B), // LSU Gray
        ),
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF461D7C),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF461D7C),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF461D7C), Color(0xFF2B1152)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView( // Added ScrollView here
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LSU Logo could be added here
                    const Icon(
                      Icons.school,
                      size: 80,
                      color: Color(0xFFFDD023), // LSU Goldaj
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'LSU',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Patrick F. Taylor Hall',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Scavenger Hunt',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFDD023), // LSU Gold
                      ),
                    ),
                    const SizedBox(height: 40),
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Text(
                              'Discover the hidden gems of Patrick F. Taylor Hall!',
                              style: TextStyle(
                                fontSize: 18,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Navigate through 10 exciting locations and learn about this amazing engineering building.',
                              style: TextStyle(
                                fontSize: 16,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                print("Navigating to ScavengerHuntScreen"); // Debug print
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const ScavengerHuntScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Begin Adventure',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScavengerHuntScreen extends StatefulWidget {
  const ScavengerHuntScreen({super.key});

  @override
  State<ScavengerHuntScreen> createState() => _ScavengerHuntScreenState();
}

class _ScavengerHuntScreenState extends State<ScavengerHuntScreen> {
  final TextEditingController _answerController = TextEditingController();
  int _currentQuestionIndex = 0;
  bool _isAnswerIncorrect = false;
  bool _isCompleted = false;
  bool _showLastSuccessMessage = false;
  
  // Track completed questions for progress display
  final List<bool> _completedQuestions = List.generate(10, (_) => false);

  final List<Map<String, dynamic>> _questions = [
    {
      'hint': 'Travel to the third floor and find a plaque with the same name as the building. What year did this person graduate?',
      'answer': '1959',
      'successMessage': 'Yes! Patrick F. Taylor was a real person who graduated in 1959 in petroleum engineering and that is what the building is named after.',
      'icon': Icons.school,
      'location': '3rd Floor Plaque'
    },
    {
      'hint': 'Now that we learned the origin about PFT, let\'s show what this building has to offer. Go to the computer lab on the same floor with the circular tables and count how many computers are in the room.',
      'answer': '42',
      'successMessage': 'Yes! PFT has a lot of computers and resources to help with anything you need help with.',
      'icon': Icons.computer,
      'location': 'Computer Lab'
    },
    {
      'hint': 'Go to the big famous staircase and count how many outlets there are.',
      'answer': '14',
      'successMessage': 'Yes! This famous staircase is where many students study.',
      'icon': Icons.stairs,
      'location': 'Main Staircase'
    },
    {
      'hint': 'What floor is Panera Bread located on?',
      'answer': '1',
      'successMessage': 'Yes! Panera Bread is located on the 1st floor, providing students with delicious food options without leaving the building.',
      'icon': Icons.restaurant,
      'location': 'Panera Bread'
    },
    {
      'hint': 'What floor can you find the engineering help center?',
      'answer': '3',
      'successMessage': 'Correct! The Engineering Help Center is on the 3rd floor, offering academic support to engineering students.',
      'icon': Icons.engineering,
      'location': 'Engineering Help Center'
    },
    {
      'hint': 'How many seats in the largest classroom, the RoyOMartin Auditorium?',
      'answer': '250',
      'successMessage': 'Correct! The RoyOMartin Auditorium has 250 seats, making it the largest classroom in PFT for lectures and events.',
      'icon': Icons.event_seat,
      'location': 'RoyOMartin Auditorium'
    },
    {
      'hint': 'What room is the Robotics Lab? (Number only)',
      'answer': '1300',
      'successMessage': 'That\'s right! Room 1300 houses the Robotics Lab where students work on cutting-edge robotics projects.',
      'icon': Icons.smart_toy,
      'location': 'Robotics Lab'
    },
    {
      'hint': 'What letter in the alphabet is the Student Services Suite?',
      'answer': 'x',
      'successMessage': 'Correct! The Student Services Suite is room X, providing important administrative support for engineering students.',
      'icon': Icons.support_agent,
      'location': 'Student Services Suite'
    },
    {
      'hint': 'There are a few vending machines in PFT. How many in total?',
      'answer': '8',
      'successMessage': 'Right! There are 8 vending machines throughout PFT, offering snacks and drinks for busy students.',
      'icon': Icons.local_drink,
      'location': 'Vending Machines'
    },
    {
      'hint': 'Finally, when was PFT renovated? (Year only, you can find this near a previously visited plaque)',
      'answer': '2014',
      'successMessage': 'Excellent! PFT was renovated in 2014 to create this modern facility for engineering education and research.',
      'icon': Icons.construction,
      'location': 'Renovation Plaque'
    },
  ];

  void _checkAnswer() {
    String userAnswer = _answerController.text.trim().toLowerCase();
    String correctAnswer = _questions[_currentQuestionIndex]['answer'].toLowerCase();
    
    if (userAnswer == correctAnswer) {
      _answerController.clear();
      _isAnswerIncorrect = false;
      
      // Mark this question as completed
      setState(() {
        _completedQuestions[_currentQuestionIndex] = true;
      });
      
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
        });
      } else {
        // For the last question, show success message first
        setState(() {
          _showLastSuccessMessage = true;
        });
      }
    } else {
      setState(() {
        _isAnswerIncorrect = true;
      });
    }
  }

  void _proceedToCompletion() {
    setState(() {
      _isCompleted = true;
      _showLastSuccessMessage = false;
    });
  }

  void _restart() {
    setState(() {
      _currentQuestionIndex = 0;
      _isAnswerIncorrect = false;
      _isCompleted = false;
      _showLastSuccessMessage = false;
      _answerController.clear();
      _completedQuestions.fillRange(0, _completedQuestions.length, false);
    });
  }

  void _showLocationSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Locations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // Fixed height for the ListView
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(
                        _questions[index]['icon'],
                        color: _completedQuestions[index]
                            ? Colors.green
                            : Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(_questions[index]['location']),
                      subtitle: Text(_completedQuestions[index] ? 'Completed' : 'Not visited yet'),
                      trailing: _completedQuestions[index]
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : const Icon(Icons.arrow_forward),
                      enabled: _completedQuestions[index] || index == _currentQuestionIndex,
                      onTap: () {
                        if (_completedQuestions[index] || index == _currentQuestionIndex) {
                          setState(() {
                            _currentQuestionIndex = index;
                          });
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PFT Scavenger Hunt', 
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        actions: [
          if (!_isCompleted && !_showLastSuccessMessage)
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: _showLocationSelector,
              tooltip: 'View Locations',
            ),
        ],
      ),
      body: _isCompleted 
          ? _buildCompletionScreen() 
          : _showLastSuccessMessage 
              ? _buildLastSuccessScreen() 
              : _buildQuestionScreen(),
bottomNavigationBar: !_isCompleted && !_showLastSuccessMessage
    ? BottomAppBar(
        height: 60,  // Explicit height
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: _showInfoDialog,
                tooltip: 'About PFT',
              ),
              // Fixed: Add SizedBox to constrain progress indicator
              Expanded(
                child: SizedBox(
                  height: 10,  // Set a fixed height
                  child: LinearProgressIndicator(
                    value: _completedQuestions.where((completed) => completed).length / _questions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${_completedQuestions.where((completed) => completed).length}/${_questions.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      )
    : null,
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.school,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('About PFT'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Text(
            'Patrick F. Taylor Hall is the largest academic building in Louisiana and one of the largest engineering education facilities in the United States. '
            'It houses the LSU College of Engineering and provides state-of-the-art laboratories, classrooms, and collaboration spaces for students and faculty.'
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionScreen() {
    return SingleChildScrollView(  // Added ScrollView here
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[200]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Challenge ${_currentQuestionIndex + 1} of ${_questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _questions[_currentQuestionIndex]['icon'],
                          size: 60,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _questions[_currentQuestionIndex]['location'],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Text(
                    _questions[_currentQuestionIndex]['hint'],
                    style: const TextStyle(fontSize: 18, height: 1.4),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _answerController,
                        decoration: InputDecoration(
                          labelText: 'Your Answer',
                          labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            ),
                          ),
                          errorText: _isAnswerIncorrect ? 'Incorrect, try again!' : null,
                          prefixIcon: const Icon(Icons.question_answer),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                        onSubmitted: (_) => _checkAnswer(),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit Answer',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_currentQuestionIndex > 0 && _completedQuestions[_currentQuestionIndex - 1])
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green, size: 24),
                      const SizedBox(height: 8),
                      Text(
                        _questions[_currentQuestionIndex - 1]['successMessage'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.green,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLastSuccessScreen() {
    return SingleChildScrollView(  // Added ScrollView here
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[200]!],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _questions[_questions.length - 1]['icon'],
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.green[50]!,
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Correct!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _questions[_questions.length - 1]['successMessage'],
                          style: const TextStyle(
                            fontSize: 18,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _proceedToCompletion,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Continue to Finish',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen() {
    return SingleChildScrollView(  // Added ScrollView here
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.7),
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.celebration,
                      size: 80,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Geaux Tigers!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'You have completed the PFT Scavenger Hunt!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Congratulations!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Thank you for participating in the PFT scavenger hunt! We hope you learned something interesting about the Patrick F. Taylor building and its resources.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'PFT Facts You Discovered:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: _questions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              _questions[index]['icon'],
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text(_questions[index]['location']),
                            dense: true,
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _restart,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.black87,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Start Over',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}