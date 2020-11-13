class Result {
  final String id;
  final String intent;
  final String state;
  final String cart;
  final Payer payer;
  final Transactions transactions;

  Result(
      {this.id,
      this.intent,
      this.state,
      this.cart,
      this.payer,
      this.transactions});

  factory Result.fromJson(Map<String, dynamic> parsedJson) {
    return Result(
        id: parsedJson['id'],
        intent: parsedJson['intent'],
        state: parsedJson['state'],
        cart: parsedJson['cart'],
        payer: Payer.fromJson(parsedJson['payer']),
        transactions: Transactions.fromJson(parsedJson['transactions']));
  }
}

class Payer {
  final String paymentmethod;
  final String status;
  final PayerInfo payerInfo;

  Payer({this.paymentmethod, this.status, this.payerInfo});

  factory Payer.fromJson(Map<String, dynamic> parsedJson) {
    return Payer(
        paymentmethod: parsedJson['payment_method'],
        status: parsedJson['status'],
        payerInfo: PayerInfo.fromJson(parsedJson['payer_info']));
  }
}

class PayerInfo {
  final String email;
  final String firstname;
  final String lastname;
  final String payerid;
  final String countrycode;

  PayerInfo(
      {this.email,
      this.firstname,
      this.lastname,
      this.payerid,
      this.countrycode});

  factory PayerInfo.fromJson(Map<String, dynamic> parsedJson) {
    return PayerInfo(
        email: parsedJson['email'],
        firstname: parsedJson['first_name'],
        lastname: parsedJson['last_name'],
        payerid: parsedJson['payer_id'],
        countrycode: parsedJson['country_code']);
  }
}

class Transactions {
  final List<TransactionsBody> transactions;

  Transactions({this.transactions});

  factory Transactions.fromJson(List<dynamic> parsedJson) {
    List<TransactionsBody> transactionsList = new List<TransactionsBody>();

    transactionsList =
        parsedJson.map((e) => TransactionsBody.fromJson(e)).toList();

    return Transactions(transactions: transactionsList);
  }
}

class TransactionsBody {
  final Amount amount;
  final Payee payee;
  final ItemList itemList;

  TransactionsBody({this.amount, this.payee, this.itemList});

  factory TransactionsBody.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionsBody(
        amount: Amount.fromJson(parsedJson['amount']),
        payee: Payee.fromJson(parsedJson['payee']),
        itemList: ItemList.fromJson(parsedJson['item_list']));
  }
}

class Amount {
  final double total;
  final String currency;
  final Details details;

  Amount({this.total, this.currency, this.details});
  // Amount({this.total, this.currency});

  factory Amount.fromJson(Map<String, dynamic> parsedJson) {
    return Amount(
        total: parsedJson['total'] as double,
        currency: parsedJson['currency'],
        details: Details.fromJson(parsedJson['details']));//
  }
}

class Details {
  final double subtotal;
  final double shipping;
  final double insurance;
  final double handlingfee;
  final double shippingdiscount;
  final double discount;

  Details(
      {this.subtotal,
      this.shipping,
      this.insurance,
      this.handlingfee,
      this.shippingdiscount,
      this.discount});

  factory Details.fromJson(Map<String, dynamic> parsedJson) {
    return Details(
        subtotal: parsedJson['subtotal'] as double,
        shipping: parsedJson['shipping'] as double,
        insurance: parsedJson['insurance'] as double,
        handlingfee: parsedJson['handling_fee'] as double,
        shippingdiscount: parsedJson['shipping_discount'] as double,
        discount: parsedJson['discount'] as double);
  }
}

class Payee {
  final String merchantid;
  final String email;

  Payee({this.merchantid, this.email});

  factory Payee.fromJson(Map<String, dynamic> parsedJson) {
    return Payee(
        merchantid: parsedJson['merchant_id'], email: parsedJson['email']);
  }
}

class ItemList {
  final List<Items> items;

  ItemList({this.items});

  factory ItemList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<Items> itemsList = list.map((e) => Items.fromJson(e)).toList();

    return ItemList(items: itemsList);
  }
}

class Items {
  final String name;
  final double price;
  final int quantity;

  Items({this.name, this.price, this.quantity});

  factory Items.fromJson(Map<String, dynamic> parsedJson) {
    return Items(
        name: parsedJson['name'],
        price: parsedJson['price'] as double,
        quantity: parsedJson['quantity'] as int);
  }
}

class RelatedResources {
  final Sale sale;
  final String paymentmode;
  final TransactionFee transactionFee;
  final String parentpayment;
  final String createtime;
  final String updatetime;
  final List<Links> links;

  RelatedResources(
      {this.sale,
      this.paymentmode,
      this.transactionFee,
      this.parentpayment,
      this.createtime,
      this.updatetime,
      this.links});

  factory RelatedResources.fromJson(Map<String, dynamic> parsedJson) {
    var _linksList = parsedJson['links'] as List;
    List<Links> linksList = _linksList.map((e) => Links.fromJson(e)).toList();

    return RelatedResources(
        sale: Sale.fromJson(parsedJson['sale']),
        paymentmode: parsedJson['payment_mode'],
        transactionFee: TransactionFee.fromJson(parsedJson['transaction_fee']),
        parentpayment: parsedJson['parent_payment'],
        createtime: parsedJson['create_time'],
        updatetime: parsedJson['update_time'],
        links: linksList);
  }
}

class Sale {
  final String id;
  final String state;

  Sale({this.id, this.state});

  factory Sale.fromJson(Map<String, dynamic> parsedJson) {
    return Sale(id: parsedJson['id'], state: parsedJson['state']);
  }
}

class TransactionFee {
  final double value;
  final String currency;

  TransactionFee({this.value, this.currency});

  factory TransactionFee.fromJson(Map<String, dynamic> parsedJson) {
    return TransactionFee(
        value: parsedJson['value'] as double, currency: parsedJson['currency']);
  }
}

class Links {
  final String href;
  final String rel;
  final String method;

  Links({this.href, this.rel, this.method});

  factory Links.fromJson(Map<String, dynamic> parsedJson) {
    return Links(
        href: parsedJson['href'],
        rel: parsedJson['rel'],
        method: parsedJson['method']);
  }
}
