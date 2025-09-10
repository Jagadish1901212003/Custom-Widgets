class GetResponseModel {
  D? d;

  GetResponseModel({this.d});

  GetResponseModel.fromJson(Map<String, dynamic> json) {
    d = json['d'] != null ? D.fromJson(json['d']) : null;
  }
}

class D {
  List<GetResponseResult>? results;

  D({this.results});

  D.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <GetResponseResult>[];
      json['results'].forEach((v) {
        //in every API
        v.remove("__metadata");
        //for body parts
        v.remove("UtRfHkcx0nEJhiCM");
        v.remove("Phgfvkcx0nEJhiCM");

        //empolyee data
        v.remove("EMADD");
        v.remove("CNTRY");
        v.remove("LICNM");
        v.remove("ORGNM");

        //  CNTRY TEXT,
        // LICNM TEXT,
        // ORGNM TEXT,

        //for draft
        // v.remove("EH7tHCcx0nEJhiCM");
        // v.remove("IIGz0nJCwaqoHRpj");
        // v.remove("mansC7FYakJKTpDd");
        // v.remove("EeuYgCtOeMl4xfCJ");
        // v.remove("Y1uHdls1PSJSbfCJ");
        // v.remove("TS552Ngd1qq8fuyg");
        // v.remove("H5Xh9V2YIdzKIOX0");
        // v.remove("W2WX8BzOHx7dLcdK");
        // v.remove("dpsypg7rG7ZobbhO");
        // v.remove("fEJmWPFObKIc1Bw5");
        // v.remove("u6LPdHfhOvTlda1E");
        // v.remove("FiwUwrGzPlSnwlEw");
        // v.remove("AwlahRPmU1NJQLRW");
        // v.remove("u0vC6COnRtYUUN5Y");
        // v.remove("zYi0aoNJwN0eEw85");
        // v.remove("sRO9sKpkZJdGYKPO");

        // print(v);
        results!.add(GetResponseResult.fromJson(v));
      });
    }
  }
}

class GetResponseResult {
  final Map<String, dynamic> data;
  GetResponseResult(this.data);
  factory GetResponseResult.fromJson(Map<String, dynamic> json) {
    return GetResponseResult(json);
  }
}
