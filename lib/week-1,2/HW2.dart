void checkBalance({
    required String name,
    required double balance,
}) => print( '$name current balance: $balance ' );


double deposit({
    required double currentBalance,
    double? amount ,
    
}){
    double depositAmount = amount ?? 0.0;
    double newBalance = currentBalance + depositAmount;


    print('Deposit: $depositAmount');
    print('NewBalance: $newBalance');


    return newBalance;
}

double withdrow({
    required String name,
    required double currentBalance,
    double? amount,
    int? pinCode,
}){  
    
    int checnPinCode = pinCode ?? 0000;
    double withdrowAmount = amount ?? 0.0;
    
    if(pinCode != 1234){
        print('Incorre PIN. Transaction declined. ');
        return currentBalance;
    }
    
double newBalance = currentBalance - withdrowAmount;

print('$name withdrew $withdrowAmount tg');
print('Transaction successful.');
print('New balance: $newBalance tg');

return newBalance;
}


void main(){
     checkBalance(name: 'Gulnar',
                  balance: 40000 );
     deposit(
     currentBalance: 400000,
     amount:10000, );             
    
    withdrow(name: 'Gulnar',
            currentBalance: 40000,
            amount: 10000,
            pinCode: 1234);
                  
}
