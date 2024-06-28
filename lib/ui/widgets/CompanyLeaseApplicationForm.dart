import 'package:flutter/material.dart';

void showCompanyLeaseApplicationDialog(BuildContext context) {
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
      child: const SingleChildScrollView(child: CompanyLeaseApplicationForm()),
    ),
  );
}

class CompanyLeaseApplicationForm extends StatefulWidget {
  const CompanyLeaseApplicationForm({super.key});

  @override
  _CompanyLeaseApplicationFormState createState() =>
      _CompanyLeaseApplicationFormState();
}

class _CompanyLeaseApplicationFormState
    extends State<CompanyLeaseApplicationForm> {
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
            _buildSection('Company Information', _buildCompanyInfoFields()),
            _buildSection('Directors Information', _buildDirectorsInfoFields()),
            _buildSection(
                'Major Shareholders Information', _buildShareholdersInfoFields()),
            _buildFundingInfo(),
            _buildPreferredHouseType(),
            _buildSection(
                'Representative Information', _buildRepresentativeInfoFields()),
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

  List<Widget> _buildCompanyInfoFields() {
    return [
      _buildTextField('Name of Company'),
      _buildTextField('Registration Number'),
      _buildTextField('Postal Address'),
      _buildTextField('Physical Address'),
      _buildTextField('Telephone'),
      _buildTextField('Fax'),
      _buildTextField('Cellphone 1'),
      _buildTextField('Cellphone 2'),
      _buildTextField('Email Address'),
      _buildTextField('Contact Person'),
      _buildTextField('Position'),
    ];
  }

  List<Widget> _buildDirectorsInfoFields() {
    return [
      _buildTextField('Name 1'),
      _buildTextField('Name 2'),
      _buildTextField('Residence'),
      _buildTextField('Postal Address'),
      _buildTextField('Telephone'),
      _buildTextField('Cellphone'),
    ];
  }

  List<Widget> _buildShareholdersInfoFields() {
    return [
      _buildTextField('Name 1'),
      _buildTextField('Name 2'),
      _buildTextField('Residence'),
      _buildTextField('Postal Address'),
      _buildTextField('Telephone'),
      _buildTextField('Cellphone'),
      _buildTextField('Number of Shares'),
    ];
  }

  Widget _buildFundingInfo() {
    return _buildTextField('Source of funds for renting the property');
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

  List<Widget> _buildRepresentativeInfoFields() {
    return [
      _buildTextField("Representative's Name"),
      _buildTextField("Representative's Signature"),
      _buildTextField('Date'),
    ];
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

  Widget _buildTermsCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: const Text(
            'I confirm that the information entered is valid and correct'),
        value: _termsAccepted,
        onChanged: (bool? value) => setState(() => _termsAccepted = value!),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFAA21B),
          foregroundColor: Colors.white,
          minimumSize: const Size(353, 56),
        ),
        child: const Text('Submit Application'),
        onPressed: _submitForm,
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Application successfully submitted'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}
