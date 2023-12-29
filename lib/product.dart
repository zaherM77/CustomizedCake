class product{
  int id;
  String name;
  int price;
  String image_url;
  int category_id;

  product(this.id, this.name, this.price, this.image_url, this.category_id);
  String toString(){
    return 'Pid: $id Name: $name price: $price url: $image_url category id: $category_id';
  }
}
List<product> products=[];
