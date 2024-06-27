class ServiceRequest {
  final String type;
  final String detail;
  final String description;
  final String status;
  final String reference_number;
  final String user_id;

  ServiceRequest(
      {required this.type,
      required this.detail,
      required this.description,
      required this.status,
      required this.reference_number,
      required this.user_id});

  factory ServiceRequest.fromMap(Map<String, dynamic> map) {
    return ServiceRequest(
      type: map['type'],
      detail: map['detail'],
      description: map['description'],
      status: map['status'],
      reference_number: map['referenceNumber'],
      user_id: map['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'detail': detail,
      'description': description,
      'status': status,
      'reference_number': reference_number,
      'user_id': user_id
    };
  }
}
