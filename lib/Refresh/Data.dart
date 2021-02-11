
class Data {
    String created_at;
    String email;
    String name;
    String profile_pic;
    int user_id;

    Data({this.created_at, this.email, this.name, this.profile_pic, this.user_id});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            created_at: json['created_at'], 
            email: json['email'], 
            name: json['name'], 
            profile_pic: json['profile_pic'], 
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['email'] = this.email;
        data['name'] = this.name;
        data['profile_pic'] = this.profile_pic;
        data['user_id'] = this.user_id;
        return data;
    }
}