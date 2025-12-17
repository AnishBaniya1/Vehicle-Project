class RegisterResponseModel {
    RegisterResponseModel({
        required this.message,
        required this.userId,
    });

    final String? message;
    final int? userId;

    factory RegisterResponseModel.fromJson(Map<String, dynamic> json){ 
        return RegisterResponseModel(
            message: json["message"],
            userId: json["userId"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "userId": userId,
    };

}
