import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_converter/controller/converter_controller.dart';
import 'package:smart_converter/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Future<void> openPrivacyPolicy() async {
    final Uri url = Uri.parse("https://sites.google.com/view/unit-converter--privacy/home");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ConverterController());
    final theme = Theme.of(context);

    final categories = [
      {"title": "Length", "icon": Icons.straighten},
      {"title": "Mass / Weight", "icon": Icons.scale},
      {"title": "Temperature", "icon": Icons.thermostat},
      {"title": "Time", "icon": Icons.access_time},
      {"title": "Area", "icon": Icons.crop_square},
      {"title": "Volume", "icon": Icons.local_drink},
      {"title": "Speed", "icon": Icons.speed},
    ];

    return Scaffold(
    appBar: AppBar(
  elevation: 0,
  centerTitle: true,
  backgroundColor: Colors.transparent,
  title: const Text(
    "SmartConvert",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.primary.withOpacity(0.7),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
),

      body: Column(
        children: [
         
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.3,
                ),
                itemBuilder: (context, index) {
            
                  final category = categories[index];
            
                  return InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      controller.setCategory(category["title"] as String);
                      Get.toNamed(AppRoutes.converter);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
             Image.asset(
            "assets/images/welcome.jpeg",
            fit: BoxFit.cover,
           ),
                          Container(
                            padding: const EdgeInsets.all(13),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              category["icon"] as IconData,
                              size: 28,
                              color: theme.primaryColor,
                            ),
                          ),
            
                          const SizedBox(height: 10),
            
                          Text(
                            category["title"] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
            
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
           /// Footer Section
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                TextButton(
                  onPressed: openPrivacyPolicy,
                  child: const Text("Privacy Policy"),
                ),
                const Text(
                  "Version 1.0.0",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
