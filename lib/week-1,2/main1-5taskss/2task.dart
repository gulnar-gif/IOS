void main(){
  print('Task 2');

  int day = 31; 
  int month = 12;
  int year = 2024;

  print('$day.$month.$year');


  bool leapYear = false;

  if(year % 400 == 0){
    leapYear = true;
  }else if (year % 100 == 0){
    leapYear = false;
  } else if (year % 4 == 0){
    leapYear = true;
  } 

  int daysInMonth = 31;

  if(month == 2){
    if(leapYear){
      daysInMonth = 29;
    }else{
      daysInMonth = 29;
    }
  }else if (month == 4 || month == 6 || month == 9 || month == 11){
    daysInMonth = 30;
  }
  if (day < 1 || day > daysInMonth){
    print('Invaled date');
  } else if (day < daysInMonth){
    day++;
  } else{
    day = 1;

    if (month == 12){
      month = 1;
      year++;
    }else{
      month++;
    } 
  }
  print('next day -> $day.$month.$year');
}