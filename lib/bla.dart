
Future<String>  http_request() async{
  return await Future.delayed(Duration(seconds:5),()=>"hi");
}

Future call_http() async{
  var response =   http_request();   //response is String
  print("response " + response.toString());
//   database_query(s);
}

void main() {

  call_http().then((v) {print("in then");});
  // http_request().then((v) {print("in then");});
  print("hello");

}