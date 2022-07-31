import 'package:get/get.dart';

import '../../model/getoneuser.dart';
import '../../service/user/user.dart';
import '../../FuctionHelper/shared/shared.dart';

class Dataprofileuserservice extends GetxController {
  Userservice userservice = Userservice();
  var userpoto = "".obs;
  Shared shared = Shared();

  getuserdata() async {
    print("jalan");
    try {
      var username = await shared.getstring("username");
      print(" usersss");
      print(username);
      userservice.getuserby(username).then((v) {
        if (v.data?.poto != null) {
          userpoto(v.data?.poto);
        } else {
          userpoto(
              "https://image.shutterstock.com/image-vector/pictures-vector-icon-image-260nw-536173468.jpg");
        }
        print("=========potoott=========");
        print(v.data?.poto);
      });
    } catch (e) {
      print(e);
    }
  }
}
