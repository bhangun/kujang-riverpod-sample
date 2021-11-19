import 'dart:convert';
import 'package:equatable/equatable.dart';


class Customer extends Equatable{
    
    final double? id; 
    final String? username; 
    final List<String>? address; 

    const Customer ({  
        this.id, 
        this.username, 
        this.address, 
    });

    factory Customer.fromJson(Map<String, dynamic> json) =>  
        Customer(id: json['id'], 
        username: json['username'], 
        address: json['address'], 
        
    );

    Map<String, dynamic> toJson() => 
        {"id": id,
        "username": username,
        "address": address,
        
    };

    static List<Customer> listFromString(String str) => new List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));

    static List<Customer> listFromJson(List<dynamic> data) {
        return data.map((post) => Customer.fromJson(post)).toList();
    }

    static String listCustomerToJson(List<Customer> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

    @override
    List<Object> get props => [
        id!, 
        username!, 
        address!, 
    ];
}

class CustomerList {
  final List<Customer>? customers;

  CustomerList({
    this.customers,
  });

  factory CustomerList.fromJson(List<dynamic> json) {
    List<Customer> customers = [];
    customers = json.map((post) => Customer.fromJson(post)).toList();

    return CustomerList(
      customers: customers,
    );
  }
}


