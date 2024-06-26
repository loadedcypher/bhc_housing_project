import 'package:flutter/material.dart';

class HousingDevelopmentsPage extends StatelessWidget {
  const HousingDevelopmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Housing Developments'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property Development Department - Overview',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'The BHC Property Development Department is responsible for the development of the Corporation\'s residential housing and commercial building developments. Projects are developed for the Government, Parastatals, Corporates, and the Public sector through appropriate building designs and systems. The department follows a standard project development cycle that includes project initiation, definition, development, implementation, and commissioning.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Property Development Philosophy',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'Our property design and development philosophy is "To produce appropriate, quality, effective, efficient, and affordable residential and commercial developments for the nation."',
            ),
            SizedBox(height: 16.0),
            Text(
              'Development Code',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'The Property Development Department develops pristine modern high-quality residential estates and commercial building developments as built environments that articulate the customer\'s needs and expectations to ensure high value proposition and return on investment.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Value Proposition',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'We commit to designing and developing built environments that are conscious of the location, market, environment, and value generation.',
            ),
            SizedBox(height: 16.0),
            Text(
              'Planned Developments - Overview',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'The Corporation consistently undertakes effective demand surveys in line with its mandate of providing affordable accommodation to Batswana throughout the country. However, some planned developments have been put on hold mainly due to challenges of portable water supply and unavailability of other services. These developments include:',
            ),
            SizedBox(height: 8.0),
            Text(
              '- Gaborone, Block 7 - 318 Units (Flats)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('- Rakops 30'),
            Text('- Nata 14'),
            Text('- Tsabong 23'),
            Text('- Pilane 200'),
            Text('- Maun 100'),
            Text('- Tati Siding'),
            SizedBox(height: 16.0),
            Text(
              'Third Party Projects',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAC2324)),
            ),
            SizedBox(height: 8.0),
            Text(
              'The Corporation provides consultancy services for third parties and offers a one-stop-shop service with professionals in land acquisition, architecture, engineering, quantity surveying, and building inspection. The services include land preparation, budget preparation, designing, obtaining necessary approvals, tendering, awarding projects, and supervision. Some clients the Corporation has worked with include Botswana Defence Force, Botswana Prison Services, Botswana Unified Revenue Services, Botswana Government, Directorate on Crime and Economic Corruption, Independent Electoral Commission, and various Land Boards. For more information, please contact Urban Ferguson, Manager External, at +267 3646800 or uferguson@bhc.bw.',
            ),
          ],
        ),
      ),
    );
  }
}
