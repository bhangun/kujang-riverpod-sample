import 'dart:convert';
import 'package:equatable/equatable.dart';


class Address extends Equatable{
    
    final String? street; 
    final String? city; 
    final String? state; 
    final String? zip; 

    const Address ({  
        this.street, 
        this.city, 
        this.state, 
        this.zip, 
    });

    factory Address.fromJson(Map<String, dynamic> json) =>  
        Address(street: json['street'], 
        city: json['city'], 
        state: json['state'], 
        zip: json['zip'], 
        
    );

    Map<String, dynamic> toJson() => 
        {"street": street,
        "city": city,
        "state": state,
        "zip": zip,
        
    };

    static List<Address> listFromString(String str) => new List<Address>.from(json.decode(str).map((x) => Address.fromJson(x)));

    static List<Address> listFromJson(List<dynamic> data) {
        return data.map((post) => Address.fromJson(post)).toList();
    }

    static String listAddressToJson(List<Address> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

    @override
    List<Object> get props => [
        street!, 
        city!, 
        state!, 
        zip!, 
    ];
}

class AddressList {
  final List<Address>? addresss;

  AddressList({
    this.addresss,
  });

  factory AddressList.fromJson(List<dynamic> json) {
    List<Address> addresss = [];
    addresss = json.map((post) => Address.fromJson(post)).toList();

    return AddressList(
      addresss: addresss,
    );
  }
}


