import 'package:flutter/material.dart';

class BhcProductsPage extends StatelessWidget {
  const BhcProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BHC Products"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Buying Options",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAC2324), // Heading color
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              "Leased Homes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAA21B), // Subheading color
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Tenants submit certified copies of Omang, marriage certificate (if married, with spouse's Omang), financial reference and affidavit declaring whether the applicant has purchased a BHC house before or not.",
            ),
            Text(
              "BHC vets the tenant and allows him/her to complete the application form and pay valuation fee if he/she has passed the vetting.",
            ),
            const Text(
              "BHC value and offer the property to the tenant",
            ),
            Text(
              "The financier brings a letter of undertaking or customer makes payment if self-financing before signing a sale agreement.",
            ),
            Text(
              "The conveyancer transfers the title deed, the buyer bearing the costs.",
            ),
            Text(
              "The financier makes full payment to BHC on behalf of the customer for purchase of the house.",
            ),
            SizedBox(height: 16.0),
            Text(
              "New Homes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAA21B), // Subheading color
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "New housing units.",
            ),
            Text(
              "BHC advertises the housing units earmarked for sale through the media.",
            ),
            Text(
              "Customers view the housing units if they choose to.",
            ),
            Text(
              "Customers submit requirements, same as for tenanted housing units.",
            ),
            Text(
              "BHC vets the applicant, and allows him/her to complete the application form and choose a unit, and then offer on a first come first served basis.",
            ),
            Text(
              "The rest of the process is as per tenanted housing units thereafter.",
            ),
            SizedBox(height: 16.0),
            Text(
              "Homes Available by Tender",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFAA21B), // Subheading color
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "BHC advertises houses available for sale by tender through the media",
            ),
            Text(
              "Customers submit sealed envelopes with requirements same as for tenanted housing units, with completed application form and administration fee payment receipt.",
            ),
            Text(
              "BHC evaluates tenders and offers to the successful and eligible bidders as per the tender terms.",
            ),
            Text(
              "The rest of the process is as per tenanted housing units thereafter.",
            ),
            SizedBox(height: 16.0),
            Text(
              "NB: Customers can be assisted in all the sales processes at all BHC Offices countrywide, save for tender where applicants have to deposit sealed bids at a specific Office.",
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
