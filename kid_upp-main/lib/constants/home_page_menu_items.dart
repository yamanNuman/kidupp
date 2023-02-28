import 'package:kid_upp/constants/pages_constant.dart';

class HomePageMenuItems {
  static List homePageMenuItems() {
    return [
      ["assets/images/schedule.png", "Ders Programı", PageConst.lessonPlan],
      ["assets/images/mealmenu.png", "Yemek Menüsü", PageConst.menuPage],
      ["assets/images/photogalery.png", "Fotoğraf/Video Galeri", ""],
      ["assets/images/medicine.png", "İlaçlar", PageConst.medicinePage],
      ["assets/images/pays.png", "Ödemeler", ""],
      ["assets/images/activity.png", "Etkinlik Programı/Geziler", ""],
      ["assets/images/endofday.png", "Gün Sonu", ""],
      ["assets/images/requirementlist.png", "İhtiyaç Listesi", ""],
      ["assets/images/options.png", "Seçenekler", ""],
      ["assets/images/classinfo.png", "Sınıf Bilgisi", ""]
    ];
  }
}
