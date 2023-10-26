import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/components/navigation_bar.dart';
import 'package:mini_project/providers/makeup_provider.dart';
import 'package:mini_project/screens/recommendation_screen.dart';
import 'package:provider/provider.dart';

class ChatRecommendation extends StatefulWidget {
  const ChatRecommendation({super.key});

  @override
  State<ChatRecommendation> createState() => _ChatRecommendationState();
}

class _ChatRecommendationState extends State<ChatRecommendation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _skinTypeController = TextEditingController();
  final TextEditingController _skinColorContoller = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final recommendationProvider =
        Provider.of<MakeupRecommendationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Makeup recommendation',
          style: GoogleFonts.poppins(
              fontSize: 23,
              fontWeight: FontWeight.w600,
              color: const Color(0xffEE6BCC)),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Image(
                  image: AssetImage('lib/assets/chat.png'),
                  height: 270,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  controller: _skinTypeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffEED7F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Skin Type',
                    hintText: 'Enter the skin type',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your skin type';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  controller: _skinColorContoller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffEED7F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Skin Color',
                    hintText: 'Enter the skin color',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your skin color';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TextFormField(
                  controller: _budgetController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffEED7F9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    labelText: 'Budget',
                    hintText: 'Enter your budget',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your budget';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(30, 50)),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffEE6BCC)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            await recommendationProvider.getRecommendations(
                              skinTypes: _skinTypeController.text,
                              skinColors: _skinColorContoller.text,
                              budgets: _budgetController.text,
                            );

                            if (recommendationProvider.recommendation != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RecommendationScreen(
                                        responseData: recommendationProvider
                                            .recommendation!);
                                  },
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('An error occurred.'),
                                ),
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Get Recommendations",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 2,
          onItemTapped: (index) {
            if (index == 0) {
              Navigator.pushNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushNamed(context, '/favorite');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          }),
    );
  }
}
