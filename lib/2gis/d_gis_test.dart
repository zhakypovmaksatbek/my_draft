import 'dart:developer' as log;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DGisTest extends StatefulWidget {
  const DGisTest({super.key});

  @override
  State<DGisTest> createState() => _DGisTestState();
}

class _DGisTestState extends State<DGisTest> {
  static const Color primaryColor = Color(0xff11C775);

  bool _keyFileExists = false;
  String _keyFileStatus = 'Checking...';
  int? _keyFileSize;

  @override
  void initState() {
    super.initState();
    _checkKeyFile();
  }

  Future<void> _checkKeyFile() async {
    try {
      // dgissdk.key dosyasını kontrol et
      final byteData = await rootBundle.load('assets/dgissdk.key');

      setState(() {
        _keyFileExists = true;
        _keyFileSize = byteData.lengthInBytes;
        _keyFileStatus = 'Key file found and loaded successfully!';
      });

      log.log("dgissdk.key file found: ${byteData.lengthInBytes} bytes");
    } catch (e) {
      setState(() {
        _keyFileExists = false;
        _keyFileStatus = 'Key file not found in assets folder';
      });

      log.log("dgissdk.key file not found: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('2GIS Key File Test'),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Key file status card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _keyFileExists ? Icons.check_circle : Icons.error,
                            color: _keyFileExists ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Key File Status',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text('Status: $_keyFileStatus'),
                      if (_keyFileSize != null) ...[
                        const SizedBox(height: 8),
                        Text('File size: $_keyFileSize bytes'),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // App configuration
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Application Configuration',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildConfigRow('App ID', 'com.maksatbek.draft'),
                      _buildConfigRow('Package Name', 'com.maksatbek.draft'),
                      _buildConfigRow('Key File', 'assets/dgissdk.key'),
                      _buildConfigRow('SDK Version', '12.7.2'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Instructions
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Setup Instructions',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInstructionItem(
                        '1',
                        'Copy your dgissdk.key file to assets/ folder',
                        _keyFileExists,
                      ),
                      _buildInstructionItem(
                        '2',
                        'Make sure appId matches: com.maksatbek.draft',
                        true,
                      ),
                      _buildInstructionItem(
                        '3',
                        'Add key to pubspec.yaml assets section',
                        true,
                      ),
                      _buildInstructionItem('4', 'Run flutter pub get', true),
                    ],
                  ),
                ),
              ),

              const Spacer(),

              // Test button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _checkKeyFile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Recheck Key File'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(
    String step,
    String instruction,
    bool completed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: completed ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child:
                  completed
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : Text(
                        step,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(instruction)),
        ],
      ),
    );
  }
}
