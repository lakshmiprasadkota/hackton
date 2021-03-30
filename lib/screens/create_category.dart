// import 'package:flutter/cupertino.dart';
//
// class CreateCategory extends StatefulWidget {
//   @override
//   _CreateCategoryState createState() => _CreateCategoryState();
// }
//
// class _CreateCategoryState extends State<CreateCategory> {
//   void createCategory() async {
//     String text = createController.text.trim();
//     try {
//       FormData formData = FormData.fromMap({"name": text ,
//         "image" :  await MultipartFile.fromFile( imageForcreateCategory.path )
//       });
//       Response response = await Dio().post(
//           "http://jayanthigaddameedi.pythonanywhere.com/category/",
//           data: formData);
//       setState(() {
//         createProduct = createCategoryFromMap(jsonEncode(response.data));
//         res = response.data["message"];
//
//         print(res.data["message"]);
//       });
//
//       if(response?.statusCode == 200){
//         Fluttertoast.showToast(msg: res);
//       }
//     } catch (e) {
//       setState(() {
//         print("error ---> $e");
//       });
//       print(e);
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
