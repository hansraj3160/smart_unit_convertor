import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_converter/controller/converter_controller.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});
  InputDecoration customInputDecoration(
    BuildContext context,
    String label, {
    IconData? icon,
  }) {
    final theme = Theme.of(context);

    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      filled: true,
      fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ConverterController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Obx(
          () => Text(
            controller.selectedCategory.value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// ====== CONVERTER CARD ======
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  /// FROM
                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.fromUnit.value,
                       menuMaxHeight: 250,
                      decoration: customInputDecoration(context, "From"),
                      items: controller.selectedCategory.value == "Temperature"
                          ? controller.temperatureUnits
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ),
                                )
                                .toList()
                          : controller.currentUnits.keys
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ),
                                )
                                .toList(),
                      onChanged: (value) {
                        controller.fromUnit.value = value!;
                        controller.convert();
                      },
                      
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// SWAP BUTTON
                  Container(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: controller.swapUnits,
                      icon: const Icon(Icons.swap_vert, color: Colors.white),
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// TO
                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.toUnit.value,
                       menuMaxHeight: 250,
                      
                      decoration: customInputDecoration(context, "To"),

                      items: controller.selectedCategory.value == "Temperature"
                          ? controller.temperatureUnits
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ),
                                )
                                .toList()
                          : controller.currentUnits.keys
                                .map(
                                  (unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ),
                                )
                                .toList(),
                      onChanged: (value) {
                        controller.toUnit.value = value!;
                        controller.convert();
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// INPUT
                  TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: customInputDecoration(
                      context,
                      "Enter Value",
                      icon: Icons.edit,
                    ),

                    onChanged: controller.updateInput,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ====== RESULT CARD ======
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor,
                    theme.primaryColor.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Obx(
                () => Column(
                  children: [
                    const Text(
                      "Converted Result",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.formattedResult,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
