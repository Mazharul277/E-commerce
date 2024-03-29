import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUserService{
  String uid;
  DataBaseUserService({this.uid});
  
  final CollectionReference user = Firestore.instance.collection('E-Commerce');

  Future UpdateUserData(String _name, _address, _mobile, _email) async{
    return await user.document(uid).setData({
      'First_Name': _name,
      'Address': _address,
      'Mobile': _mobile,
      'E-Mail': _email,
    });
  }
 Future updateuserimage(String image) async{
    return await user.document(uid).updateData({
      'Image': image,
    });
  }
}

class DataBaseProductService{
  String uid;
  DataBaseProductService({this.uid});

  final CollectionReference user = Firestore.instance.collection('E-Commerce');

  Future UpdateUserData(String _product_Name, _product_price,_category) async{
    return await user.document(uid).collection('product').add({
      'Product_Name': _product_Name,
      'Product_Price': _product_price,
      'Product_Category': _category
    });
  }
}