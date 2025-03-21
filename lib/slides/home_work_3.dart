import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

// Example of a Mixin
mixin LoggerMixin {
  void log(String message) {
    print('LOG: $message');
  }

  void logError(String error) {
    print('ERROR: $error');
  }
}

// Another Mixin example
mixin ValidationMixin {
  bool isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    return password.length >= 8;
  }
}

// Class using mixins
class UserAuthentication with LoggerMixin, ValidationMixin {
  bool login(String email, String password) {
    log('Attempting login for $email');

    if (!isEmailValid(email)) {
      logError('Invalid email format');
      return false;
    }

    if (!isPasswordValid(password)) {
      logError('Password too short');
      return false;
    }

    log('Login successful');
    return true;
  }
}

// Class with static methods
class MathUtils {
  // Static method that works
  static double calculateArea(double radius) {
    return math.pi * radius * radius;
  }

  // Static method that doesn't perform (example of a problematic static method)
  static void printInstanceProperty() {
    // This won't work because static methods can't access instance properties
    // print(this.someProperty); // This would cause an error

    // Static methods can only access static properties
    print('Static methods cannot access instance properties with "this"');
  }

  // Another example of a static method with limitations
  static void updateUI() {
    // Static methods can't directly update UI or access context
    // They can't access instance state or trigger rebuilds
    print('Static methods cannot directly update UI components');
  }
}

// After the MathUtils class, let's add a class with try-catch examples
class ErrorHandlingExamples {
  // Example 1: Basic try-catch
  static void basicTryCatch() {
    try {
      // Attempting to parse an invalid number
      int result = int.parse('not a number');
      print('Result: $result'); // This line won't execute
    } catch (e) {
      print('Error caught: $e');
    }
  }

  // Example 2: Try-catch with specific exception types
  static void specificExceptions() {
    try {
      List<int> numbers = [1, 2, 3];
      print(numbers[10]); // This will throw an RangeError
    } on RangeError catch (e) {
      print('Range error: $e');
    } on FormatException catch (e) {
      print('Format exception: $e');
    } catch (e) {
      print('Some other error: $e');
    }
  }

  // Example 3: Try-catch-finally
  static void tryCatchFinally() {
    try {
      double result = 10 / 0; // Division by zero
      print('Result: $result');
    } catch (e) {
      print('Error in calculation: $e');
    } finally {
      print('This code always executes, regardless of errors');
    }
  }

  // Example 4: Rethrow an exception
  static void rethrowExample() {
    try {
      _methodThatMightFail();
    } catch (e) {
      print('Caught in rethrowExample, but rethrowing: $e');
      rethrow; // Rethrow the exception to be caught by a higher level
    }
  }

  static void _methodThatMightFail() {
    throw Exception('Something went wrong!');
  }
}

// Image Slider with Controllers
class ImageSliderExample extends StatefulWidget {
  const ImageSliderExample({super.key});

  @override
  State<ImageSliderExample> createState() => _ImageSliderExampleState();
}

class _ImageSliderExampleState extends State<ImageSliderExample> {
  // Controller for the page view
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Timer for auto-sliding
  Timer? _autoSlideTimer;

  // List of sample images
  final List<String> imageUrls = [
    'https://picsum.photos/id/1/500/300',
    'https://picsum.photos/id/10/500/300',
    'https://picsum.photos/id/100/500/300',
    'https://picsum.photos/id/1000/500/300',
  ];

  @override
  void initState() {
    super.initState();
    // Start auto-sliding when the widget initializes
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // Cancel the timer when the widget is disposed
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  // Method to start auto-sliding
  void _startAutoSlide() {
    // Cancel any existing timer
    _autoSlideTimer?.cancel();

    // Create a new timer that fires every 5 seconds
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < imageUrls.length - 1) {
        goToNextSlide();
      } else {
        // If we're at the last slide, go back to the first
        goToSlide(0);
      }
    });
  }

  // Method to pause auto-sliding (useful when user is interacting)
  void _pauseAutoSlide() {
    _autoSlideTimer?.cancel();
  }

  // Method to resume auto-sliding
  void _resumeAutoSlide() {
    _startAutoSlide();
  }

  void goToNextSlide() {
    if (_currentPage < imageUrls.length - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToPreviousSlide() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void goToSlide(int index) {
    if (index >= 0 && index < imageUrls.length) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  // Add this new method for safe image loading
  Widget safeLoadImage(String url) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image: $error');
        return Container(
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.error, color: Colors.red, size: 50),
          ),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value:
                loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Magazine-style image carousel
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    // Main carousel
                    PageView.builder(
                      controller: _pageController,
                      itemCount: imageUrls.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTapDown: (_) => _pauseAutoSlide(),
                          onTapUp: (_) => _resumeAutoSlide(),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Image with zoom effect
                              AnimatedScale(
                                scale: _currentPage == index ? 1.0 : 1.1,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOutCubic,
                                child: safeLoadImage(imageUrls[index]),
                              ),

                              // Stylish overlay
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Colors.indigo.withOpacity(0.3),
                                      Colors.black.withOpacity(0.1),
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    // Caption with modern design
                    Positioned(
                      bottom: 24,
                      left: 24,
                      right: 24,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Left side caption
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'FEATURED',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Scenic View ${_currentPage + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Discover the beauty of nature',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Right side indicator
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              '${_currentPage + 1}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Side navigation indicators
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Left navigation area
                          GestureDetector(
                            onTap: goToPreviousSlide,
                            child: Container(
                              width: 60,
                              color: Colors.transparent,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 16),
                              child:
                                  _currentPage > 0
                                      ? Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                      : null,
                            ),
                          ),

                          // Right navigation area
                          GestureDetector(
                            onTap: goToNextSlide,
                            child: Container(
                              width: 60,
                              color: Colors.transparent,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 16),
                              child:
                                  _currentPage < imageUrls.length - 1
                                      ? Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                      : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom controls and indicators
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Progress bar indicator
                LinearProgressIndicator(
                  value: (_currentPage + 1) / imageUrls.length,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                  minHeight: 6,
                ),

                const SizedBox(height: 16),

                // Control buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(
                      icon: Icons.first_page_rounded,
                      onTap: () => goToSlide(0),
                    ),
                    _buildControlButton(
                      icon: Icons.fast_rewind_rounded,
                      onTap: goToPreviousSlide,
                    ),
                    _buildPlayPauseButton(),
                    _buildControlButton(
                      icon: Icons.fast_forward_rounded,
                      onTap: goToNextSlide,
                    ),
                    _buildControlButton(
                      icon: Icons.last_page_rounded,
                      onTap: () => goToSlide(imageUrls.length - 1),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Thumbnail strip
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => goToSlide(index),
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border:
                                _currentPage == index
                                    ? Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 2,
                                    )
                                    : null,
                            boxShadow:
                                _currentPage == index
                                    ? [
                                      BoxShadow(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary.withOpacity(0.3),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                    : null,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                _currentPage == index
                                    ? BorderRadius.circular(6)
                                    : BorderRadius.circular(8),
                            child: Opacity(
                              opacity: _currentPage == index ? 1.0 : 0.6,
                              child: safeLoadImage(imageUrls[index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPlayPauseButton() {
    bool isPlaying = _autoSlideTimer != null && _autoSlideTimer!.isActive;

    return InkWell(
      onTap: isPlaying ? _pauseAutoSlide : _resumeAutoSlide,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 24,
        ),
      ),
    );
  }
}

class HomeWorkExample extends StatelessWidget {
  const HomeWorkExample({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = UserAuthentication();
    auth.login('test@example.com', 'password123');

    final area = MathUtils.calculateArea(5.0);
    print('Area of circle: $area');

    MathUtils.printInstanceProperty();

    // Demonstrate try-catch examples
    try {
      ErrorHandlingExamples.basicTryCatch();
      ErrorHandlingExamples.specificExceptions();
      ErrorHandlingExamples.tryCatchFinally();

      try {
        ErrorHandlingExamples.rethrowExample();
      } catch (e) {
        print('Caught rethrown exception: $e');
      }
    } catch (e) {
      print('Unexpected error in examples: $e');
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Homework Example')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ImageSliderExample(),
      ),
    );
  }
}
