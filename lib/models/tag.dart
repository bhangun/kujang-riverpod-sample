import 'dart:convert';
import 'package:equatable/equatable.dart';


class Tag extends Equatable{
    
    final double? id; 
    final String? name; 

    const Tag ({  
        this.id, 
        this.name, 
    });

    factory Tag.fromJson(Map<String, dynamic> json) =>  
        Tag(id: json['id'], 
        name: json['name'], 
        
    );

    Map<String, dynamic> toJson() => 
        {"id": id,
        "name": name,
        
    };

    static List<Tag> listFromString(String str) => new List<Tag>.from(json.decode(str).map((x) => Tag.fromJson(x)));

    static List<Tag> listFromJson(List<dynamic> data) {
        return data.map((post) => Tag.fromJson(post)).toList();
    }

    static String listTagToJson(List<Tag> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

    @override
    List<Object> get props => [
        id!, 
        name!, 
    ];
}

class TagList {
  final List<Tag>? tags;

  TagList({
    this.tags,
  });

  factory TagList.fromJson(List<dynamic> json) {
    List<Tag> tags = [];
    tags = json.map((post) => Tag.fromJson(post)).toList();

    return TagList(
      tags: tags,
    );
  }
}


