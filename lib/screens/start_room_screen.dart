import 'package:flutter/material.dart';

class StartRoomScreen extends StatefulWidget {
  final String groupName;
  final String major;
  final String building;
  final String room;

  StartRoomScreen({
    required this.groupName,
    required this.major,
    required this.building,
    required this.room,
  });

  @override
  _StartRoomScreenState createState() => _StartRoomScreenState();
}

class _StartRoomScreenState extends State<StartRoomScreen> {
  bool _isTimerRunning = false;
  int _seconds = 0;
  String _subject = '';
  final TextEditingController _subjectController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _subjectController.text = widget.major;
    _subject = widget.major;
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.blue[800],
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    widget.groupName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Group Info
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.groupName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Major: ${widget.major}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Building: ${widget.building}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          'Room: ${widget.room}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  Center(
                    child: Text(
                      'StartRoom',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Subject
                  Text(
                    'Subject:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _subjectController,
                        onChanged: (value) {
                          setState(() {
                            _subject = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter subject for this session',
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Timer Label
                  Text(
                    'setTimer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Timer Display
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue[200]!, width: 2),
                      ),
                      child: Text(
                        _formatTime(_seconds),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 40),
                  
                  // Buttons - CLEANED UP (no text overlay)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Start Button - Only Icon
                      Container(
                        width: 70,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: _isTimerRunning ? null : _startTimer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(12),
                          ),
                          child: Icon(Icons.play_arrow, size: 36),
                        ),
                      ),
                      
                      // Stop Button - Only Icon
                      Container(
                        width: 70,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: _isTimerRunning ? _stopTimer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(12),
                          ),
                          child: Icon(Icons.stop, size: 36),
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Reset Button - Only Icon
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: _resetTimer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(12),
                        ),
                        child: Icon(Icons.refresh, size: 36),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    setState(() {
      _isTimerRunning = true;
    });
    
    // Simulate timer running
    Future.delayed(Duration(seconds: 1), () {
      if (_isTimerRunning && mounted) {
        setState(() {
          _seconds++;
        });
        _startTimer(); // Recursive call to continue timer
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isTimerRunning = false;
    });
  }
}