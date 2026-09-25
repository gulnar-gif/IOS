main(){
  int num = 3;
  bool prime = true;

  if(num < 2){
    prime = false;
  }
  else{
    for(int i = 2; i < num; i++){
      if(num % i == 0 ){
        prime = false;
        break;
      }
    }
  }
  if(prime){
    print('$num -> prime number');
  }else{
    print('$num -> not prime num');
  }
}