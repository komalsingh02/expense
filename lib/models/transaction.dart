class Transaction {
  String _id;
  String _title;
  double _amount;
  DateTime _date;

  String get txnId => _id;
  String get txnTitle => _title;
  double get txnAmount => _amount;
  DateTime get txnDateTime => _date;

  Transaction(
    this._id,
    this._title,
    this._amount,
    this._date,
  );

  // convenience constructor to create a Transaction object
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      map['id'].toString(),
      map['title'],
      map['amount'],
      DateTime.parse(map['date']),
    );
  }

  // convenience method to create a Map from this Transaction object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': int.tryParse(_id),
      'title': _title,
      'amount': _amount,
      'date': _date.toIso8601String()
    };
    if (_id.isNotEmpty) {
      map['id'] = int.tryParse(_id);
    }

    return map;
  }
}
