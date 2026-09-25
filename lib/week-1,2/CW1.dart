double processOrder({
  required String orderId,
  required double itemPrice,
  String? promoCode,
  double? deliveryFee,
}) {
  double price = itemPrice;

  if(promoCode == 'SAVE10'){
    price = price * 0.9;
  }

  double delivery = deliveryFee ?? 500;
  double total = price + delivery;

  print('Order ID: $orderId');
  print('Item price: $itemPrice tg');
  print('Delivery fee: $delivery tg');
  print('Final total: $total tg');
 
 return total;
}

void main(){
  double result = processOrder(orderId: 'ORD001', 
                               itemPrice: 10000,
                               promoCode: 'SAVE10',
                               deliveryFee: null,
                               );

print('Returned total: $result tg');                               
}
