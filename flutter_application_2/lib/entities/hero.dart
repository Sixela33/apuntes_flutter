final Map <String, dynamic> rawJson = {
  'name': 'tony',
  'power': 'money',
  'isAlive': true
};

class Hero {
  String name;
  String power;
  bool isAlive;
  
  Hero({
    required this.name, 
    required this.power, 
    required this.isAlive
    });

  // constructor secundario que acepta objecto JSON
  Hero.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      power = json['power'],
      isAlive = json['isAlive'];
    
}