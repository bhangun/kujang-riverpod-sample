import 'dart:convert';
import 'package:equatable/equatable.dart';


class Category extends Equatable{
    
    final double? id; 
    final String? name; 

    const Category ({  
        this.id, 
        this.name, 
    });

    factory Category.fromJson(Map<String, dynamic> json) =>  
        Category(id: json['id'], 
        name: json['name'], 
        
    );

    Map<String, dynamic> toJson() => 
        {"id": id,
        "name": name,
        
    };

    static List<Category> listFromString(String str) => new List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

    static List<Category> listFromJson(List<dynamic> data) {
        return data.map((post) => Category.fromJson(post)).toList();
    }

    static String listCategoryToJson(List<Category> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

    @override
    List<Object> get props => [
        id!, 
        name!, 
    ];
}

class CategoryList {
  final List<Category>? categorys;

  CategoryList({
    this.categorys,
  });

  factory CategoryList.fromJson(List<dynamic> json) {
    List<Category> categorys = [];
    categorys = json.map((post) => Category.fromJson(post)).toList();

    return CategoryList(
      categorys: categorys,
    );
  }
}


