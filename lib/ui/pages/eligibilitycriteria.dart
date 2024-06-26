import 'package:flutter/material.dart';

class EligibilityCriteriaPage extends StatelessWidget {
  const EligibilityCriteriaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eligibility Criteria"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "General Conditions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Tenants must submit certified copies of their O mang, marriage certificate (if married), financial reference, and affidavit declaring if they have purchased a BHC house before or not.",
              ),
              Text(
                "BHC values and offers the property to the tenant.",
              ),
              Text(
                "The financier brings a letter of undertaking or the tenant pays before signing a sale agreement.",
              ),
              Text(
                "The conveyancer transfers the title deed, and the buyer bears the costs.",
              ),
              SizedBox(height: 16.0),
              Text(
                "Individuals",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Individual applicants must submit certified copies of their O mang and their spouse's if married.",
              ),
              Text(
                "If born outside Botswana, they must submit a certified copy of their Naturalization Certificate.",
              ),
              Text(
                "If married, they must submit a certified copy of their Marriage Certificate.",
              ),
              SizedBox(height: 16.0),
              Text(
                "Companies",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Companies must submit a certified copy of their Certificate of Incorporation.",
              ),
              Text(
                "They must also provide certified copies of their share certificates, Form 2, and shareholders' IDs and naturalization certificates.",
              ),
              SizedBox(height: 16.0),
              Text(
                "BHC Property Purchase Process",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "The financier brings a letter of undertaking or the tenant pays before signing a sale agreement.",
              ),
              Text(
                "The conveyancer transfers the title deed.",
              ),
              Text(
                "The buyer bears the costs.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}