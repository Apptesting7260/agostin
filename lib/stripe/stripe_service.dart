class Pay {
  String? id;
  String? object;
  Card? card;
  String? clientIp;
  int? created;
  bool? livemode;
  String? type;
  bool? used;

  Pay({this.id, this.object, this.card, this.clientIp, this.created, this.livemode, this.type, this.used});

  Pay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    clientIp = json['client_ip'];
    created = json['created'];
    livemode = json['livemode'];
    type = json['type'];
    used = json['used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    if (this.card != null) {
      data['card'] = this.card?.toJson();
    }
    data['client_ip'] = this.clientIp;
    data['created'] = this.created;
    data['livemode'] = this.livemode;
    data['type'] = this.type;
    data['used'] = this.used;
    return data;
  }
}

class Card {
  String? id;
  String? object;
  Null? addressCity;
  Null? addressCountry;
  Null? addressLine1;
  Null? addressLine1Check;
  Null? addressLine2;
  Null? addressState;
  Null? addressZip;
  Null? addressZipCheck;
  String? brand;
  String? country;
  String? cvcCheck;
  Null? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;

  Null? name;
  Null? tokenizationMethod;

  Card({this.id, this.object, this.addressCity, this.addressCountry, this.addressLine1, this.addressLine1Check, this.addressLine2, this.addressState, this.addressZip, this.addressZipCheck, this.brand, this.country, this.cvcCheck, this.dynamicLast4, this.expMonth, this.expYear, this.fingerprint, this.funding, this.last4, this.name, this.tokenizationMethod});

  Card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    addressCity = json['address_city'];
    addressCountry = json['address_country'];
    addressLine1 = json['address_line1'];
    addressLine1Check = json['address_line1_check'];
    addressLine2 = json['address_line2'];
    addressState = json['address_state'];
    addressZip = json['address_zip'];
    addressZipCheck = json['address_zip_check'];
    brand = json['brand'];
    country = json['country'];
    cvcCheck = json['cvc_check'];
    dynamicLast4 = json['dynamic_last4'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    fingerprint = json['fingerprint'];
    funding = json['funding'];
    last4 = json['last4'];

    name = json['name'];
    tokenizationMethod = json['tokenization_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['object'] = this.object;
    data['address_city'] = this.addressCity;
    data['address_country'] = this.addressCountry;
    data['address_line1'] = this.addressLine1;
    data['address_line1_check'] = this.addressLine1Check;
    data['address_line2'] = this.addressLine2;
    data['address_state'] = this.addressState;
    data['address_zip'] = this.addressZip;
    data['address_zip_check'] = this.addressZipCheck;
    data['brand'] = this.brand;
    data['country'] = this.country;
    data['cvc_check'] = this.cvcCheck;
    data['dynamic_last4'] = this.dynamicLast4;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['fingerprint'] = this.fingerprint;
    data['funding'] = this.funding;
    data['last4'] = this.last4;
    data['name'] = this.name;
    data['tokenization_method'] = this.tokenizationMethod;
    return data;
  }
}