
import 'package:weapp_3/Refresh/Data.dart';

class UserDetail {
    List<Data> data;
    String message;
    bool status;
    int statusCode;

    UserDetail({this.data, this.message, this.status, this.statusCode});


    factory UserDetail.fromJson(Map<String, dynamic> json) {
        return UserDetail(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
            message: json['message'], 
            status: json['status'], 
            statusCode: json['statusCode'], 
        );
    }


    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        data['statusCode'] = this.statusCode;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}




class WallpaperModel{
    String photographer;
    String photographerUrl;
    int photographerId;
    SrcModel src;
    int imageId;

    WallpaperModel({this.photographer,this.photographerId,this.photographerUrl,this.src,this.imageId});

    factory WallpaperModel.fromMap(Map<String,dynamic> jsonData){
        return WallpaperModel(
            src: SrcModel.fromMap(jsonData["src"]),
            photographerUrl: jsonData["photographer_url"],
            photographerId: jsonData["photographer_id"],
            photographer: jsonData["photographer"],
            imageId: jsonData["imageId"]
        );
    }
}

class SrcModel{
    String original;
    String large2x;
    String portrait;
    String medium;
    String small;

    SrcModel({this.original,this.large2x,this.portrait,this.medium,this.small});

    factory SrcModel.fromMap(Map<String,dynamic> jsonData){
        return SrcModel(
            original: jsonData["original"],
            large2x: jsonData["large2x"],
            portrait: jsonData["portrait"],
            medium: jsonData["medium"],
            small: jsonData["small"]
        );
    }
}