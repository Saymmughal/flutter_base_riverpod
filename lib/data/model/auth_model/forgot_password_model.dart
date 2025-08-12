class ForgotPasswordModel {
  String? error;
  bool? success;
  String? token;
  ForgotPasswordData? data;

  ForgotPasswordModel({
    this.error,
    this.success,
    this.token,
    this.data,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
        error: json["error"],
        success: json["success"],
        token: json["token"],
        data: json["data"] == null ? null : ForgotPasswordData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "success": success,
        "token": token,
        "data": data?.toJson(),
      };
}

class ForgotPasswordData {
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

  ForgotPasswordData({
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

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) => ForgotPasswordData(
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
