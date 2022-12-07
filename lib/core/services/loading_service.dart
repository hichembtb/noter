import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingService {
  showLoading() {
    EasyLoading.show(status: 'loading...');
  }

  showSuccess(String status) {
    EasyLoading.showSuccess(status);
  }

  showError(String status) {
    EasyLoading.showError(status);
  }

  dismissLoading() {
    EasyLoading.dismiss();
  }
}
