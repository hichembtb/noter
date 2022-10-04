class ClientModel {
  final String name;
  final String surname;
  final String date;
  final String refId;
  final double credit;
  final List payment;

  ClientModel({
    required this.name,
    required this.surname,
    required this.date,
    required this.refId,
    required this.credit,
    required this.payment,
  });
  factory ClientModel.fromMap(Map<String, dynamic> data) {
    return ClientModel(
      name: data["name"],
      surname: data["surname"],
      credit: data['credit'],
      date: data['date'],
      refId: data['refId'],
      payment: data['payment'],
    );
  }
}
