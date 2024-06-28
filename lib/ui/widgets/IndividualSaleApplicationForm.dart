
import 'package:flutter/material.dart';

void showPersonalApplicationFormDialog(BuildContext context) {
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
      child: const SingleChildScrollView(
        child: IndividualApplicationForm(),
      ),
    ),
  );
}

class IndividualApplicationForm extends StatefulWidget {
  const IndividualApplicationForm({super.key});

  @override
  _PersonalApplicationFormState createState() =>
      _PersonalApplicationFormState();
}

class _PersonalApplicationFormState extends State<IndividualApplicationForm> {
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
            _buildSection(
                'Employment and Property Details', _buildEmploymentFields()),
            _buildSection('Spouse\'s Details', _buildSpouseFields()),
            _buildSection('Additional Information and Declarations',
                _buildAdditionalFields()),
            _buildDocumentUpload(),
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
      _buildTextField('Omang/ID Number'),
      _buildTextField('Title'),
      _buildTextField('Date of Birth'),
      _buildTextField('Place of Birth'),
      _buildTextField('Marital Status'),
      _buildTextField('Nationality'),
      _buildTextField('Postal Address'),
      _buildTextField('Physical Address'),
      _buildTextField('Telephone (Work)'),
      _buildTextField('Telephone (Home)'),
      _buildTextField('Cell'),
      _buildTextField('Fax'),
      _buildTextField('E-mail'),
    ];
  }

  List<Widget> _buildEmploymentFields() {
    return [
      _buildTextField('Name of Employer'),
      _buildTextField('Work Station/Branch'),
      _buildTextField('Employer Postal Address'),
      _buildTextField('Applicant\'s Position'),
      _buildTextField('Applicant\'s Gross Income/pm'),
      _buildTextField('Telephone (S/board)'),
      _buildTextField('Telephone (Fax)'),
      _buildTextField('Name of previous employer in the past 5 years'),
      _buildTextField('Previous Position'),
      _buildTextField('BHC Property Details'),
      _buildTextField('Plot/Unit No. rented: present/past'),
      _buildTextField('Town/Village'),
      _buildTextField('Plot/Unit No. purchased'),
      _buildTextField('Town/Village'),
      _buildTextField('Plot/Unit No. applied for'),
      _buildTextField('Town/Village'),
    ];
  }

  List<Widget> _buildSpouseFields() {
    return [
      _buildTextField('Spouse\'s Surname'),
      _buildTextField('Spouse\'s Forename'),
      _buildTextField('Spouse\'s Omang/ID Number'),
      _buildTextField('Spouse\'s Title'),
      _buildTextField('Spouse\'s Date of Birth'),
      _buildTextField('Spouse\'s Place of Birth'),
      _buildTextField('Spouse\'s Nationality'),
      _buildTextField('Spouse\'s Postal Address'),
      _buildTextField('Spouse\'s Physical Address'),
      _buildTextField('Spouse\'s Telephone (Work)'),
      _buildTextField('Spouse\'s Telephone (Home)'),
      _buildTextField('Spouse\'s Cell'),
      _buildTextField('Spouse\'s Fax'),
      _buildTextField('Spouse\'s E-mail'),
      _buildTextField('Spouse\'s Employment Details'),
      _buildTextField('Spouse\'s Name of Employer'),
      _buildTextField('Spouse\'s Work Station/Branch'),
      _buildTextField('Spouse\'s Employer Postal Address'),
      _buildTextField('Spouse\'s Position'),
      _buildTextField('Spouse\'s Gross Income/pm'),
      _buildTextField('Spouse\'s Name of previous employer'),
      _buildTextField('Spouse\'s Previous Position'),
    ];
  }

  List<Widget> _buildAdditionalFields() {
    return [
      _buildTextField('Next of Kin Surname'),
      _buildTextField('Next of Kin Forename'),
      _buildTextField('Next of Kin Postal Address'),
      _buildTextField('Next of Kin Telephone (Work)'),
      _buildTextField('Next of Kin Telephone (Home)'),
      _buildTextField('Next of Kin Cell'),
      _buildTextField('Next of Kin E-mail'),
      _buildTextField('Next of Kin Name of Employer'),
      _buildTextField('Next of Kin S/board'),
      _buildTextField('Children\'s and Dependents\' Details'),
      _buildTextField('Names, Relation, Age (for up to 6 dependents)'),
      _buildTextField('Home Village/Town Details'),
      _buildTextField('Village/Town Name'),
      _buildTextField('Ward'),
      _buildTextField('District'),
      _buildTextField('Chief/Headman\'s Name'),
      _buildTextField('Financing Details'),
      _buildTextField('Financing Institution'),
      _buildTextField('Maximum Loan qualified for'),
      _buildTextField('If self-financing, name source of funds'),
      _buildTextField('Declaration'),
      _buildTextField('Applicant\'s Signature'),
      _buildTextField('Date'),
    ];
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

  Widget _buildDocumentUploadButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
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

  Widget _buildDocumentUpload() {
    return _buildSection(
      'Attachments Upload',
      [
        _buildUploadText('Certified copies of valid Identity Cards (Omang)'),
        _buildUploadText('Certified copy of Naturalisation Certificate'),
        _buildUploadText(
            'Certified copy of Marriage Certificate or Decree Absolute'),
        _buildUploadText(
            'Spouse\'s written consent for BHC property purchase'),
        _buildUploadText('Affidavit declaring previous BHC property purchase'),
        _buildUploadText('Letter from Financier stating maximum loan amount'),
        _buildUploadText('Recent Bank Statements'),
        _buildUploadText('Rent clearance letter'),
      ],
    );
  }

  Widget _buildUploadText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return CheckboxListTile(
      title: const Text(
          'I confirm that the information entered is valid and correct'),
      value: _termsAccepted,
      onChanged: (bool? value) => setState(() => _termsAccepted = value ?? false),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFAA21B),
          minimumSize: const Size(353, 56),
        ),
        onPressed: _submitForm,
        child: const Text('Submit Application'),
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
