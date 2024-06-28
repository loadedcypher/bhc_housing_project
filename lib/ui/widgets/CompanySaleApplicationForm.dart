import 'package:flutter/material.dart';

void showCompanySalesApplicationFormDialog(BuildContext context) {
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
      child: const SingleChildScrollView(child: CompanySalesApplicationForm()),
    ),
  );
}

class CompanySalesApplicationForm extends StatefulWidget {
  const CompanySalesApplicationForm({super.key});

  @override
  _ApplicationFormState createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<CompanySalesApplicationForm> {
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
            _buildSection('Applicant\'s Particulars', _buildApplicantFields()),
            _buildSection('Particulars of Directors/Shareholders', _buildDirectorsFields()),
            _buildSection('Additional Information', _buildAdditionalInfoFields()),
            _buildSection('Financing Details', _buildFinancingDetailsFields()),
            _buildSection('BHC Property Details', _buildBHCPropertyDetailsFields()),
            _buildSection('Declaration and Attachments', _buildDeclarationFields()),
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

  List<Widget> _buildApplicantFields() {
    return [
      _buildTextField('Name of Company'),
      _buildTextField('Registration Number'),
      _buildTextField('Postal Address'),
      _buildTextField('Physical Address'),
      _buildTextField('Telephone'),
      _buildTextField('Fax'),
      _buildTextField('Cellphone'),
      _buildTextField('E-mail Address'),
    ];
  }

  List<Widget> _buildDirectorsFields() {
    return List.generate(5, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Director/Shareholder ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
          _buildTextField('Full Names'),
          _buildTextField('Omang/Passport No.'),
          _buildTextField('Citizenship'),
          _buildTextField('Position'),
          _buildTextField('% Shares'),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  List<Widget> _buildAdditionalInfoFields() {
    return [
      _buildTextField('% Ratio of Shares: % Citizens of Botswana'),
      _buildTextField('% Ratio of Shares: % Non-Citizens of Botswana'),
    ];
  }

  List<Widget> _buildFinancingDetailsFields() {
    return [
      _buildTextField('Financing Institution'),
      _buildTextField('Maximum Loan qualified for (P)'),
      _buildTextField('If self-financing, name source of funds'),
    ];
  }

  List<Widget> _buildBHCPropertyDetailsFields() {
    return [
      _buildTextField('Plot/Unit No. rented: present/past'),
      _buildTextField('Town/Village'),
      _buildTextField('Plot/Unit No. purchased'),
      _buildTextField('Town/Village'),
      _buildTextField('House type applied for'),
      _buildTextField('Town/Village'),
    ];
  }

  List<Widget> _buildDeclarationFields() {
    return [
      _buildTextField('Representative\'s Name'),
      _buildTextField('Representative\'s Signature'),
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
          'Option 1',
          'Option 2',
          'Option 3',
          'Option 4',
          'Option 5'
        ]
            .map((String value) =>
                DropdownMenuItem<String>(value: value, child: Text(value)))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }

  Widget _buildDocumentUploadInstructions() {
    return _buildSection(
      'Attachments',
      [
        const Text(
          'Please upload the following documents:\n'
          '1. Certified copy of Company Certificate of Incorporation\n'
          '2. Certified copies of Share Certificates\n'
          '3. Form 2\n'
          '4. Certified copies of valid Identity Cards (Omang) for Shareholders, and Naturalisation Certificates if born outside Botswana\n'
          '5. Affidavit declaring if the Applicant has previously purchased property directly from BHC\n'
          '6. Letter from Financier stating the maximum loan amount qualified for or recent Bank Statement if self-financing\n'
          '7. Resolution of Board of Directors to purchase property from BHC\n'
          '8. Rent clearance letter',
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

  Widget _buildTermsCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CheckboxListTile(
        title: const Text('I confirm that the information entered is valid and correct'),
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
