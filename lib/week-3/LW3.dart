class Book{
  String title;
  String author;
  int price;
  bool isBorrowed;

  Book(this.title,
       this.author,
       this.price,
       this.isBorrowed);
}

class Library{
  List<Book> books;
  Library(this.books);

  List<Book> getAvailableBooks(){
    return books.where((book)=>book.isBorrowed == false).toList();
  }
  double getTotalValue() {
  return books.fold(0.0, (sum, book) => sum + book.price);
  }
}


void main(){
  Book book = Book(
    'Piter Pen',
    'Barri',
    5400,
    false,
  );
  Book book1 = Book('Piter Pen', 'Barri', 5400, false);
  Book book2 = Book('I, also I', 'Gulnar', 9899, false);

  Library library = Library([book1, book2]);
  print(library.books.length);

  print(book.title);
  print(book.author);
  print(book.price);
  print(book.isBorrowed);

  print(library.getAvailableBooks().length);
  print(library.getTotalValue());
}
