import 'package:loafer/core/model/user_model.dart';

class MemberModel {
  const MemberModel({
    required this.userModel,
    required this.isActive,
  });

  final UserModel userModel;
  final bool isActive;

  MemberModel copyWith({
    UserModel? userModel,
    bool? isActive,
  }) {
    return MemberModel(
      userModel: userModel ?? this.userModel,
      isActive: isActive ?? this.isActive,
    );
  }
}
