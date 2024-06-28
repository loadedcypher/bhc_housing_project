import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BHC FAQs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          FaqItem(
            question: 'Why do I need a conveyancer to transfer property?',
            answer:
                'Only a conveyancer can transfer property according to the laws of Botswana.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'I am not a citizen of Botswana, am I eligible to buy a BHC house?',
            answer:
                'Only citizens and citizen-controlled companies are eligible to purchase BHC properties. (Citizens controlled companies refer to those with a majority shareholders being Botswana citizens).',
          ),
          FaqItem(
            question:
                'I am not a citizen of Botswana, am I eligible to buy a BHC house?',
            answer:
                'Only citizens and citizen-controlled companies are eligible to purchase BHC properties. (Citizens controlled companies refer to those with a majority shareholders being Botswana citizens).',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'How many houses can my company be allowed to buy?',
            answer:
                'A company can buy one or more houses from BHC depending on availability.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Can I sell the property I am renting from BHC?',
            answer: 'BHC alone has the right to sell its properties.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Since I am only allowed to buy one house from BHC, can my husband buy a house as well?',
            answer:
                'Married couples can only buy one house from BHC, however in some cases a sale to a spouse can be considered. Refer to the question (Can I buy more than one property from BHC?).',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Can I buy more than one property from BHC?',
            answer:
                'An individual or married couple are allowed to buy one house from BHC countrywide. Applicants who have already purchased property from BHC, spouse jointly counted, shall only be considered where there would be no offers from first-time buyers.',
          ),
          SizedBox(height: 20),
          // Add more FAQ items here
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    Key? key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Color(0xFFAC2324),
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
