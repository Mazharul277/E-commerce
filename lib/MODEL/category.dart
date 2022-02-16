class Item{
  var item_image, item_name;
  Item({this.item_image, this.item_name});
}

class Category{
  var lists = [
    Item(
      item_image: 'assets/images/design/men.png',
      item_name: 'Men',
    ),

    Item(
      item_image: 'assets/images/design/woman.png',
      item_name: 'Women',
    ),
    Item(
      item_image: 'assets/images/design/devices.png',
      item_name: 'Devices',
    ),
    Item(
      item_image: 'assets/images/design/gadgets.png',
      item_name: 'Gadgets',
    ),
    Item(
      item_image: 'assets/images/design/games.png',
      item_name: 'Games',
    ),

    Item(
      item_image: 'assets/images/design/vehicle.png',
      item_name: 'Vehicle',
    ),

    Item(
      item_image: 'assets/images/design/home.png',
      item_name: 'Home & Living',
    ),

    Item(
      item_image: 'assets/images/design/book.png',
      item_name: 'Education',
    ),
    Item(
      item_image: 'assets/images/design/pets.png',
      item_name: 'Pets & Animal',
    ),
    Item(
      item_image: 'assets/images/design/gadgets.png',
      item_name: 'Agriculture',
    ),

  ];
}