import 'package:flutter/material.dart';

class SportsMenTShirtScreen extends StatefulWidget {
  const SportsMenTShirtScreen({Key? key}) : super(key: key);

  @override
  State<SportsMenTShirtScreen> createState() => _SportsMenTShirtScreenState();
}

class _SportsMenTShirtScreenState extends State<SportsMenTShirtScreen> {
  final List<String> sidebarOptions = [
    "Fit",
    "Sleeve",
    "Collar",
    "Pockets",
    "Color"
  ];

  int currentOptionIndex = 0;

  final Map<String, List<String>> subOptions = {
    "Fit": ["Slim", "Regular", "Loose"],
    "Sleeve": ["Short", "Medium"],
    "Collar": ["Round", "Polo"],
    "Pockets": ["Default"],
    "Color": ["Default", "Green"],
  };

  final Map<String, String> selectedOptions = {
    "Fit": "",
    "Sleeve": "",
    "Collar": "",
    "Pockets": "",
    "Color": "",
  };

  String getImagePath() {
    String combinedOptions = sidebarOptions.map((option) {
      return selectedOptions[option]?.isNotEmpty == true
          ? selectedOptions[option]!
          : "Default";
    }).join("_");

    return "assets/images/Sports_Shirts/$combinedOptions.png";
  }

  @override
  Widget build(BuildContext context) {
    final String currentOption = sidebarOptions[currentOptionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Sports Men T-Shirt Customization',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(sidebarOptions.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (index <= currentOptionIndex) {
                        setState(() {
                          currentOptionIndex = index;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: index <= currentOptionIndex
                            ? (currentOptionIndex == index
                                ? Colors.lightBlue.shade300
                                : Colors.white)
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          sidebarOptions[index],
                          style: TextStyle(
                            color: index <= currentOptionIndex
                                ? (currentOptionIndex == index
                                    ? Colors.white
                                    : Colors.black)
                                : Colors.grey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    getImagePath(),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your Selection:",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ...selectedOptions.entries.map((entry) {
                  return Text(
                    "${entry.key}: ${entry.value.isNotEmpty ? entry.value : 'Not Selected'}",
                    style: const TextStyle(fontSize: 14),
                  );
                }).toList(),
                const SizedBox(height: 20),
                Text(
                  "Select $currentOption",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...subOptions[currentOption]!.map((subOption) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedOptions[currentOption] = subOption;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedOptions[currentOption] == subOption
                            ? Colors.blue
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: subOption,
                            groupValue: selectedOptions[currentOption],
                            onChanged: (value) {
                              setState(() {
                                selectedOptions[currentOption] = value!;
                              });
                            },
                          ),
                          Text(
                            subOption,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedOptions[currentOption] == subOption
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  onPressed: () {
                    if (selectedOptions[currentOption]?.isEmpty == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an option to proceed."),
                        ),
                      );
                    } else if (currentOptionIndex < sidebarOptions.length - 1) {
                      setState(() {
                        currentOptionIndex++;
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("All customizations saved! Add to cart."),
                        ),
                      );
                    }
                  },
                  child: const Text("Save & Next"),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Added to cart with: ${selectedOptions.toString()}"),
                    ),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
