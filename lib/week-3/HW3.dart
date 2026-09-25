class MediaItem with Downloadable{
  String title;
  int price;



 MediaItem(this.title,
            this.price,
           );
}
mixin Downloadable{
  void download(){
    print('Product is downloading...');
  }
  
}
class ShoppingCart{
  List<MediaItem> items = [];

  void addItem(MediaItem item){
    items.add(item);
  }

  double getTotalPrice(){
    return items.fold(0.0,(sum, item) => sum + item.price);
  }
}
void main(){
  ShoppingCart cart = ShoppingCart();
  MediaItem item1 = MediaItem('Cooking course', 9999);
  MediaItem item2 = MediaItem('SSM course', 19999);
  cart.addItem(item1);
  cart.addItem(item2);

  print('Total price: ${cart.getTotalPrice()}');

  item1.download();
}
