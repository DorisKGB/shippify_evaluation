enum TypeActionView { error, success, showLoading, hideLoading }

class MActionView {
  late String? message;
  late TypeActionView type;

  MActionView.messageSuccess(this.message) : type = TypeActionView.success;
  MActionView.messageError(this.message) : type = TypeActionView.error;
  MActionView.showLoading(this.message) : type = TypeActionView.showLoading;
  MActionView.hideLoading() : type = TypeActionView.hideLoading;
}
