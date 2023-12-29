class Cake{
  String _category;
  String _color;
  String _creame;
  String _size;
  int _nb_layers;
  String _image;

  Cake(this._category,this._color,this._creame,this._size,this._nb_layers,this._image);

  String get category => _category;

  set category(String value) {
    _category = value;
  }

  String get color => _color;

  int get nb_layers => _nb_layers;

  String get size => _size;

  set size(String value) {
    _size = value;
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  set nb_layers(int value) {
    _nb_layers = value;
  }

  String get creame => _creame;

  set creame(String value) {
    _creame = value;
  }

  set color(String value) {
    _color = value;
  }
}
List <Cake> cakes =[
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg"),
  Cake("a","pink","mmm","M",2,"https://cdn.pixabay.com/photo/2017/03/02/07/18/wedding-2110546_1280.jpg")

];