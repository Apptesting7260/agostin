class PaymentModel {
  String? status;
  String? message;
  PaymentData? data;
  String? notification;

  PaymentModel({this.status, this.message, this.data, this.notification});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    data = json['data'] != null ? new PaymentData.fromJson(json['data']) : null;
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['notification'] = this.notification;
    return data;
  }
}

class PaymentData {
  String? id;
  String? intent;
  String? state;
  Payer? payer;
  List<Transactions>? transactions;
  String? createTime;
  String? updateTime;
  List<Links>? links;

  PaymentData(
      {this.id,
        this.intent,
        this.state,
        this.payer,
        this.transactions,
        this.createTime,
        this.updateTime,
        this.links});

  PaymentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    intent = json['intent'];
    state = json['state'];
    payer = json['payer'] != null ? new Payer.fromJson(json['payer']) : null;
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    createTime = json['create_time'];
    updateTime = json['update_time'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['intent'] = this.intent;
    data['state'] = this.state;
    if (this.payer != null) {
      data['payer'] = this.payer!.toJson();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payer {
  String? paymentMethod;
  List<FundingInstruments>? fundingInstruments;

  Payer({this.paymentMethod, this.fundingInstruments});

  Payer.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['payment_method'];
    if (json['funding_instruments'] != null) {
      fundingInstruments = <FundingInstruments>[];
      json['funding_instruments'].forEach((v) {
        fundingInstruments!.add(new FundingInstruments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    if (this.fundingInstruments != null) {
      data['funding_instruments'] =
          this.fundingInstruments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FundingInstruments {
  CreditCard? creditCard;

  FundingInstruments({this.creditCard});

  FundingInstruments.fromJson(Map<String, dynamic> json) {
    creditCard = json['credit_card'] != null
        ? new CreditCard.fromJson(json['credit_card'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.creditCard != null) {
      data['credit_card'] = this.creditCard!.toJson();
    }
    return data;
  }
}

class CreditCard {
  String? type;
  String? number;
  String? expireMonth;
  String? expireYear;
  String? firstName;
  String? lastName;

  CreditCard(
      {this.type,
        this.number,
        this.expireMonth,
        this.expireYear,
        this.firstName,
        this.lastName});

  CreditCard.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
    expireMonth = json['expire_month'];
    expireYear = json['expire_year'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['number'] = this.number;
    data['expire_month'] = this.expireMonth;
    data['expire_year'] = this.expireYear;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class Transactions {
  Amount? amount;
  String? description;
  List<RelatedResources>? relatedResources;

  Transactions({this.amount, this.description, this.relatedResources});

  Transactions.fromJson(Map<String, dynamic> json) {
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    description = json['description'];
    if (json['related_resources'] != null) {
      relatedResources = <RelatedResources>[];
      json['related_resources'].forEach((v) {
        relatedResources!.add(new RelatedResources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['description'] = this.description;
    if (this.relatedResources != null) {
      data['related_resources'] =
          this.relatedResources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Amount {
  String? total;
  String? currency;

  Amount({this.total, this.currency});

  Amount.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currency'] = this.currency;
    return data;
  }
}

class RelatedResources {
  Sale? sale;

  RelatedResources({this.sale});

  RelatedResources.fromJson(Map<String, dynamic> json) {
    sale = json['sale'] != null ? new Sale.fromJson(json['sale']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sale != null) {
      data['sale'] = this.sale!.toJson();
    }
    return data;
  }
}

class Sale {
  String? id;
  String? state;
  Amount? amount;
  ProcessorResponse? processorResponse;
  String? parentPayment;
  String? createTime;
  String? updateTime;
  List<Links>? links;

  Sale(
      {this.id,
        this.state,
        this.amount,
        this.processorResponse,
        this.parentPayment,
        this.createTime,
        this.updateTime,
        this.links});

  Sale.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    state = json['state'];
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    processorResponse = json['processor_response'] != null
        ? new ProcessorResponse.fromJson(json['processor_response'])
        : null;
    parentPayment = json['parent_payment'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['state'] = this.state;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    if (this.processorResponse != null) {
      data['processor_response'] = this.processorResponse!.toJson();
    }
    data['parent_payment'] = this.parentPayment;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProcessorResponse {
  String? avsCode;
  String? cvvCode;
  String? responseCode;

  ProcessorResponse({this.avsCode, this.cvvCode, this.responseCode});

  ProcessorResponse.fromJson(Map<String, dynamic> json) {
    avsCode = json['avs_code'];
    cvvCode = json['cvv_code'];
    responseCode = json['response_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avs_code'] = this.avsCode;
    data['cvv_code'] = this.cvvCode;
    data['response_code'] = this.responseCode;
    return data;
  }
}

class Links {
  String? href;
  String? rel;
  String? method;

  Links({this.href, this.rel, this.method});

  Links.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    rel = json['rel'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['rel'] = this.rel;
    data['method'] = this.method;
    return data;
  }
}