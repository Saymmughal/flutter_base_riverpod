class LoginModel {
  String? error;
  bool? success;
  String? token;
  LoginData? data;

  LoginModel({
    this.error,
    this.success,
    this.token,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        error: json["error"],
        success: json["success"],
        token: json["token"],
        data: json["data"] == null ? null : LoginData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "success": success,
        "token": token,
        "data": data?.toJson(),
      };
}

class LoginData {
  int? id;
  String? name;
  String? email;
  String? role;
  bool? verified;
  bool? active;
  int? subExpiresAt;
  bool? isAdmin;
  int? cloudBalance;
  int? couponExpiresAt;
  int? createdAt;

  LoginData({
    this.id,
    this.name,
    this.email,
    this.role,
    this.verified,
    this.active,
    this.subExpiresAt,
    this.isAdmin,
    this.cloudBalance,
    this.couponExpiresAt,
    this.createdAt,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        verified: json["verified"],
        active: json["active"],
        subExpiresAt: json["sub_expires_at"],
        isAdmin: json["is_admin"],
        cloudBalance: json["cloud_balance"],
        couponExpiresAt: json["coupon_expires_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "role": role,
        "verified": verified,
        "active": active,
        "sub_expires_at": subExpiresAt,
        "is_admin": isAdmin,
        "cloud_balance": cloudBalance,
        "coupon_expires_at": couponExpiresAt,
        "created_at": createdAt,
      };
}
