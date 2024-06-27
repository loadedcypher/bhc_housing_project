import 'package:flutter/material.dart';

void showCompanyLeaseApplicationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Company Lease Application'),
      content: SingleChildScrollView(child: CompanyLeaseApplicationForm()),
    ),
  );
}

class CompanyLeaseApplicationForm extends StatefulWidget {
  const CompanyLeaseApplicationForm({Key? key}) : super(key: key);

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
          _buildDocumentUpload(),
          _buildTermsCheckbox(),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ...children,
        const SizedBox(height: 16),
      ],
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

  Widget _buildDocumentUpload() {
    return _buildSection(
      'Upload Documents',
      [
        _buildUploadButton('Company Certificate of Incorporation'),
        _buildUploadButton('Share Certificates'),
        _buildUploadButton('Form 2'),
        _buildUploadButton('Identity Cards'),
        _buildUploadButton('Company Resolution'),
        _buildUploadButton('Bank Statement'),
        _buildUploadButton('Tax Clearance Certificate'),
      ],
    );
  }

  Widget _buildTextField(String label) {
    return TextFormField(decoration: InputDecoration(labelText: label));
  }

  Widget _buildDropdown(String label) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
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
    );
  }

  Widget _buildUploadButton(String label) {
    return ElevatedButton(
      child: Text('Upload $label'),
      onPressed: () {},
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      title: const Text(
          'I confirm that the information entered is valid and correct'),
      value: _termsAccepted,
      onChanged: (bool? value) => setState(() => _termsAccepted = value!),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      child: const Text('Submit Application'),
      onPressed: _submitForm,
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
