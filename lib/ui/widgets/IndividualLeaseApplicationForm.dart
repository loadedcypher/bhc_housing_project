import 'package:flutter/material.dart';

void showIndividualLeaseApplicationDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (BuildContext context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: const SingleChildScrollView(child: IndividualLeaseApplicationForm()),
    ),
  );
}

class IndividualLeaseApplicationForm extends StatefulWidget {
  const IndividualLeaseApplicationForm({super.key});

  @override
  _IndividualLeaseApplicationFormState createState() =>
      _IndividualLeaseApplicationFormState();
}

class _IndividualLeaseApplicationFormState
    extends State<IndividualLeaseApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSection('Personal Information', _buildPersonalInfoFields()),
            _buildSection('Contact Information', _buildContactInfoFields()),
            _buildSection('Employment Information', _buildEmploymentInfoFields()),
            _buildSection('Spouse Information', _buildSpouseInfoFields()),
            _buildSection('Home Information', _buildHomeInfoFields()),
            _buildSection('Dependants', _buildDependantsFields()),
            _buildSection('Next of Kin', _buildNextOfKinFields()),
            _buildPreferredHouseType(),
            _buildDocumentUploadInstructions(),
            _buildDocumentUploadButton(),
            _buildTermsCheckbox(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          ...children,
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  List<Widget> _buildPersonalInfoFields() {
    return [
      _buildTextField('Surname'),
      _buildTextField('Forename'),
      _buildTextField('Other Names'),
      _buildTextField('Title'),
      _buildTextField('Maiden Name'),
      _buildTextField('Nationality'),
      _buildTextField('Marital Status'),
      _buildTextField('Omang/ID or Passport Number'),
      _buildTextField('Date of Birth'),
      _buildTextField('Place of Birth'),
    ];
  }

  List<Widget> _buildContactInfoFields() {
    return [
      _buildTextField('Postal Address'),
      _buildTextField('Physical Address'),
      _buildTextField('Telephone (Work)'),
      _buildTextField('Telephone (Home)'),
      _buildTextField('Cellphone'),
      _buildTextField('Fax'),
      _buildTextField('E-mail Address'),
    ];
  }

  List<Widget> _buildEmploymentInfoFields() {
    return [
      _buildTextField("Employer's Name"),
      _buildTextField('Work Station/Branch Location'),
      _buildTextField("Employer's Address"),
      _buildTextField('Occupation'),
      _buildTextField('Telephone (Switchboard)'),
      _buildTextField('Fax'),
      _buildTextField('Source of funds to rent the property'),
      _buildTextField('Previous Employer (last 5 years)'),
      _buildTextField('Position held'),
    ];
  }

  List<Widget> _buildSpouseInfoFields() {
    return [
      _buildTextField("Spouse's Surname"),
      _buildTextField("Spouse's Forename"),
      _buildTextField("Spouse's Other Names"),
      _buildTextField("Spouse's Title"),
      _buildTextField("Spouse's Maiden Name"),
      _buildTextField("Spouse's Nationality"),
      _buildTextField("Spouse's Omang/ID or Passport Number"),
      _buildTextField("Spouse's Date of Birth"),
      _buildTextField("Spouse's Place of Birth"),
      _buildTextField("Spouse's Telephone"),
      _buildTextField("Spouse's Cellphone"),
      _buildTextField("Spouse's E-mail Address"),
      _buildTextField("Spouse's Employer's Name"),
      _buildTextField("Spouse's Work Station/Branch"),
      _buildTextField("Spouse's Employer's Address"),
      _buildTextField("Spouse's Telephone (Switchboard)"),
      _buildTextField("Spouse's Fax"),
      _buildTextField("Spouse's Previous Employer (last 5 years)"),
      _buildTextField("Spouse's Position held"),
    ];
  }

  List<Widget> _buildHomeInfoFields() {
    return [
      _buildTextField('Home Village/Town Name'),
      _buildTextField('Ward'),
      _buildTextField('District'),
      _buildTextField("Chief/Headman's Name"),
    ];
  }

  List<Widget> _buildDependantsFields() {
    return [
      _buildTextField('Dependant 1 Name'),
      _buildTextField('Dependant 1 Relationship'),
      _buildTextField('Dependant 2 Name'),
      _buildTextField('Dependant 2 Relationship'),
      _buildTextField('Dependant 3 Name'),
      _buildTextField('Dependant 3 Relationship'),
      _buildTextField('Dependant 4 Name'),
      _buildTextField('Dependant 4 Relationship'),
    ];
  }

  List<Widget> _buildNextOfKinFields() {
    return [
      _buildTextField('Next of Kin Surname'),
      _buildTextField('Next of Kin Forename'),
      _buildTextField('Next of Kin Relationship'),
      _buildTextField('Next of Kin Postal Address'),
      _buildTextField('Next of Kin Telephone (Work)'),
      _buildTextField('Next of Kin Telephone (Home)'),
      _buildTextField('Next of Kin Cellphone'),
      _buildTextField("Next of Kin Employer's Name"),
      _buildTextField("Next of Kin Employer's Telephone (Switchboard)"),
      _buildTextField('Next of Kin Fax'),
    ];
  }

  Widget _buildPreferredHouseType() {
    return _buildSection(
      'Preferred House Type',
      [
        _buildDropdown('1st Preference'),
        _buildDropdown('2nd Preference'),
      ],
    );
  }

  Widget _buildDocumentUploadInstructions() {
    return _buildSection(
      'Attachments',
      [
        const Text(
          'Please upload the following documents:\n'
          '1. Certified copy of valid Applicant & Spouse\'s Omang/Passports, and Naturalisation Certificates if born outside Botswana\n'
          '2. Certified copy of Marriage Certificate, if married, or Decree Absolute if divorced\n'
          '3. Letter of consent from spouse to apply for accommodation\n'
          '4. All potential applicants are to bring an affidavit to show that neither them nor their spouse rent or own a property obtained directly from BHC\n'
          '5. Latest payslip and six months bank statement',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFAC2324),
          foregroundColor: Colors.white,
          minimumSize: const Size(353, 56),
        ),
        child: const Text('Upload Required Documents'),
        onPressed: () {},
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFAC2324)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFAC2324)),
          ),
        ),
        items: [
          'House type 1',
          'House type 2',
          'House type 3',
          'House type 4',
          'House type 5'
        ]
            .map((String value) =>
                DropdownMenuItem<String>(value: value, child: Text(value)))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: const Text('I accept the terms and conditions.'),
        value: _termsAccepted,
        onChanged: (bool? value) {
          setState(() {
            _termsAccepted = value ?? false;
          });
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFAC2324),
          foregroundColor: Colors.white,
          minimumSize: const Size(353, 56),
        ),
        onPressed: _submitForm,
        child: const Text('Submit Application'),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false && _termsAccepted) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your application has been submitted.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Please make sure all fields are filled out and the terms are accepted.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
