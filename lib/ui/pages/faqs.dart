import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BHC FAQs'),
      ),
      body: ListView(
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
          FaqItem(
            question: 'Does BHC maintain my house after I have purchased it?',
            answer:
                'BHC only maintains structural defects for active TPS/SOS sales as per the sale agreement otherwise the customer maintains all other defects. For outright sale arrangement, the owner is liable for maintenance costs.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Am I allowed to make alterations/fittings to the house I\'ve bought?',
            answer:
                'If you have bought outright, you can make alterations without consulting BHC, however if you have bought through TPS/SOS you have to seek permission in writing from BHC. In both cases the customer has to satisfy council bye-laws on any improvements proposed.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Can I lease out my BHC house while it\'s still on TPS/SOS?',
            answer:
                'Yes, you are allowed to lease out your TPS/SOS house, however the purchaser remains responsible for the obligations of the sale agreement.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Where can I inquire about my TPS/SOS balance?',
            answer:
                'You can get a TPS/SOS statement from any BHC credit control office.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Does BHC have mortgage protection cover for the death of the TPS/SOS Purchasers?',
            answer:
                'No. The Purchaser has to make his/her own arrangement through life cover policies available in the market.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'For those who purchased houses before the introduction of VAT, how does it affect them?',
            answer:
                'Value Added Tax is a Government tax. It affects Purchasers who bought houses through TPS/SOS before the tax was introduced because the administration fees attract VAT. The VAT increased the installments.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Why do I have to pay penalties at Deeds Registry for my TPS/SOS property?',
            answer:
                'Section 6 of the Transfer Duty Act prescribes that such a duty is payable six (6) months from the date of sale of land. It further stipulates that if the duty is not paid within the prescribed time then a penalty shall be levied on the outstanding amount at the rate of 12% per annum. It is important to note however that both the Deeds Registry Act and the Transfer Duty Act are not being administered by BHC.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Why do I have to pay rates when I\'m purchasing under TPS/SOS while BHC still holds the title?',
            answer:
                'Purchasers pay rates as per their obligation in the sale agreements they entered into with BHC. Also, the Township Act qualifies the Purchasers to pay rates as "owners" because of the sale arrangement.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Can I transfer the house I am buying through TPS/SOS to someone else?',
            answer:
                'Yes. Rights can be ceded to family members who have to satisfy BHC\'s eligibility and credit vetting. The parties should however take note that "transfer of land and cessions of real rights therein shall follow the sequence of the successive transactions in pursuance of which they are made…."',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'When will BHC start selling flats and townhouses?',
            answer:
                'BHC has started selling flats and townhouses through Sectional Titles. The implementation started with the 64 flats at Block 9, Gaborone. However, the selling of the same countrywide shall be done on a "roll out" basis.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Can I buy a BHC house I find vacant?',
            answer:
                'No. BHC does not directly allocate any vacant houses for sale. Vacant houses are sometimes sold by tender.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question:
                'Do the BHC prices cover Financiers & Conveyancer\'s fees?',
            answer:
                'he prices consist of the actual BHC selling price and Value Added Tax only. Financier\'s, conveyancer\'s and any other costs, including penalties on title transfer, especially for TPS/SOS sales, shall be borne by the buyer.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'What is a sale agreement?',
            answer:
                'It is a contract between the purchaser and a seller which sets out the terms and conditions of a sale.',
          ),
          SizedBox(height: 20),
          FaqItem(
            question: 'Are BHC prices negotiable?',
            answer:
                'No. The prices are determined by professionals and based on valuation and costs.  Note that no discount shall be made because a tenant has been paying rent for a long time!',
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          color: Color(0xFFAC2324), // Set heading color to #AC2324
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            answer,
            style: const TextStyle(
              color: Color.fromARGB(
                  255, 1, 1, 1), // Set subheading color to #FAA21B
            ),
          ),
        ),
      ],
    );
  }
}
