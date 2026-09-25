void main(){
  List<int> numbers = [14, 88, 3, 42, 99, 12, 67];  
  
   int max = numbers[0];
   int min = numbers[0];

  for(int i = 0; i < numbers.length; i++){
   if(numbers[i] < min){
      min = numbers[i];
    }
    if (numbers[i] > max){
      max = numbers[i] ;
      }
  
  }
   print('Min = $min');
   print('Max = $max');
 
  

 List<int> numbers1 = [234, 34, 123, 44, 949, 112, 67];

 int max1 = numbers1[0];
 int min1 = numbers1[0];

 for(int j = 0; j < numbers1.length; j++){
     if(numbers1[j] < min1){
      min1 = numbers1[j];
     }
     if(numbers1[j] > max1){
      max1 = numbers1[j];
     }
 }
  print('Min1 = $min1');
  print('Max1 = $max1');







}