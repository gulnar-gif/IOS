void main(){
  String text = "flutter mobile development";
  int count = 0;
  
  for(int i = 0; i < text.length; i++){
    if(text[i] == 'a' ||
       text[i] == 'e' ||
       text[i] == 'i' ||
       text[i] == 'o' ||
       text[i] == 'u' ){
        count++;
       }
  }
  print('$text -> $count');
  
}