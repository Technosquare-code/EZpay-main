class TransactionDetailModel {
  String? id;
  String? agentId;
  String? agentName;
  String? mobileNumber;
  String? amount;
  String? processingFees;
  String? insuranceCompany;
  String? accountNo;
  String? mobileNumber2;
  String? mobileNumber3;
  String? mobileNumber4;
  String? mobileNumber5;
  String? mobileNumber6;
  String? carrier;
  String? planId;
  String? firstName;
  String? lastName;
  String? email;
  String? giftCard;
  String? longDistanceCompany;
  String? country;
  String? network;
  String? simNumber;
  String? iMEI;
  String? zipcode;
  String? state;
  String? city;
  String? customerAddress;
  String? customerAccountNumber;
  String? customerPin;
  String? portNumber;
  String? callBackNumber;
  String? provider;
  String? orderNo;
  String? categoryName;
  String? kioskId;
  String? isInternationalRecharge;
  String? createdDate;
  String? ticketNo;
  String? plate;
  String? passenger;
  String? commercial;
  String? dob;
  String? regNo;
  String? invoiceNo;
  String? license;
  String? licenseState;
  String? agencyFee;

  TransactionDetailModel({
    this.id,
    this.agentId,
    this.agentName,
    this.mobileNumber,
    this.amount,
    this.processingFees,
    this.insuranceCompany,
    this.accountNo,
    this.mobileNumber2,
    this.mobileNumber3,
    this.mobileNumber4,
    this.mobileNumber5,
    this.mobileNumber6,
    this.carrier,
    this.planId,
    this.firstName,
    this.lastName,
    this.email,
    this.giftCard,
    this.longDistanceCompany,
    this.country,
    this.network,
    this.simNumber,
    this.iMEI,
    this.zipcode,
    this.state,
    this.city,
    this.customerAddress,
    this.customerAccountNumber,
    this.customerPin,
    this.portNumber,
    this.callBackNumber,
    this.provider,
    this.orderNo,
    this.categoryName,
    this.kioskId,
    this.isInternationalRecharge,
    this.createdDate,
    this.commercial,
    this.dob,
    this.invoiceNo,
    this.license,
    this.licenseState,
    this.passenger,
    this.plate,
    this.regNo,
    this.ticketNo,
    this.agencyFee,
  });

  TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    agentName = json['agent_name'] ?? "";
    mobileNumber = json['mobile_number'];
    amount = json['amount'];
    processingFees = json['processing_fees'];
    insuranceCompany = json['insurance_company'];
    accountNo = json['account_no'];
    mobileNumber2 = json['mobile_number_2'];
    mobileNumber3 = json['mobile_number_3'];
    mobileNumber4 = json['mobile_number_4'];
    mobileNumber5 = json['mobile_number_5'];
    mobileNumber6 = json['mobile_number_6'];
    carrier = json['carrier'];
    planId = json['plan_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    giftCard = json['gift_Card'];
    longDistanceCompany = json['long_distance_company'];
    country = json['country'];
    network = json['network'];
    simNumber = json['sim_number'];
    iMEI = json['IMEI'];
    zipcode = json['zipcode'];
    state = json['state'];
    city = json['city'];
    customerAddress = json['customer_address'];
    customerAccountNumber = json['customer_account_number'];
    customerPin = json['customer_pin'];
    portNumber = json['port_number'];
    callBackNumber = json['call_back_number'];
    provider = json['provider'];
    orderNo = json['order_no'];
    categoryName = json['category_name'];
    kioskId = json['kiosk_id'];
    isInternationalRecharge = json['is_international_recharge'];
    createdDate = json['created_date'];
    ticketNo = json['ticket_no'];
    plate = json['plate_no'];
    passenger = json['passenger_type'];
    commercial = json['commercial_type'];
    dob = json['dob'];
    regNo = json['license_plate_reg_number'];
    invoiceNo = json['invoice_number'];
    license = json['license_plate'];
    licenseState = json['license_plate_state'];
    agencyFee = json['agency_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['agent_id'] = agentId;
    data['agent_name'] = agentName;
    data['mobile_number'] = mobileNumber;
    data['amount'] = amount;
    data['processing_fees'] = processingFees;
    data['insurance_company'] = insuranceCompany;
    data['account_no'] = accountNo;
    data['mobile_number_2'] = mobileNumber2;
    data['mobile_number_3'] = mobileNumber3;
    data['mobile_number_4'] = mobileNumber4;
    data['mobile_number_5'] = mobileNumber5;
    data['mobile_number_6'] = mobileNumber6;
    data['carrier'] = carrier;
    data['plan_id'] = planId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['gift_Card'] = giftCard;
    data['long_distance_company'] = longDistanceCompany;
    data['country'] = country;
    data['network'] = network;
    data['sim_number'] = simNumber;
    data['IMEI'] = iMEI;
    data['zipcode'] = zipcode;
    data['state'] = state;
    data['city'] = city;
    data['customer_address'] = customerAddress;
    data['customer_account_number'] = customerAccountNumber;
    data['customer_pin'] = customerPin;
    data['port_number'] = portNumber;
    data['call_back_number'] = callBackNumber;
    data['provider'] = provider;
    data['order_no'] = orderNo;
    data['category_name'] = categoryName;
    data['kiosk_id'] = kioskId;
    data['is_international_recharge'] = isInternationalRecharge;
    data['created_date'] = createdDate;
    data['ticket_no'] = ticketNo;
    data['plate_no'] = plate;
    data['passenger_type'] = passenger;
    data['commercial_type'] = commercial;
    data['dob'] = dob;
    data['license_plate_reg_number'] = regNo;
    data['invoice_number'] = invoiceNo;
    data['license_plate'] = license;
    data['license_plate_state'] = licenseState;
    data['agency_fee'] = agencyFee;
    return data;
  }
}
