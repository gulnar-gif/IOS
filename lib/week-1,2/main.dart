void main(){
  String name = "Gulnar";
  int age = 19;
  double gpa = 3.4;
  bool isStudent = true;

  print("name : $name\n age: $age y.o \n gpa: $gpa\n is Student: ${isStudent}");

  String text1 = "Hello";
  String? text2 = null ;
  print('text1: $text1');
  print('text2: $text2');

  int length1 = text1.length;
  int length2 = text2?.length ?? 0;

  String confirmedText = text2 ?? "default";
  print("confirmed $confirmedText length: ${confirmedText.length}");

  int digit = 3;
  print("MULTIPLICATION TABLE for digit $digit");
  for(int i = 1; i <= 10; i++){
    print("$digit * $i = ${i * digit}");
  }

  for(int i = 10; i > 0; i--){
    if(i % 2 == 0){
      print("$i");
    }else {
      print("${i * 2}");
    }
  }

}

