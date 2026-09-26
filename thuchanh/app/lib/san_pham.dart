class SanPham {
  String ten;
  int soLuongTon;
  double _gia = 0;

  bool get conHang => soLuongTon > 0;
  
  SanPham({
    required this.ten,
    required this.soLuongTon,
    required double gia,
  }): _gia = gia;

  SanPham.fromJson(Map<String, dynamic> json): 
    ten = json['ten'] as String,
    soLuongTon = json['soLuongTong'] as int;

  SanPham.macDinh(): ten = '', soLuongTon = 0;




  double get gia => _gia;
  set gia(double giaMoi) {
    if (giaMoi < 0) {
      throw new ArgumentError("Giá sản phẩm không được âm");
    }
    _gia = giaMoi;
  }


  // dart ko có interface => Phải dùng toàn bộ abstract

  // Mixin - chia sẻ hành vi nhưng không cần qua kế thừa
  // Thay cho class (cũng có thuộc tính, method)
}
