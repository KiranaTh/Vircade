class AvatarList {
  final int id;
  final String imageUrl;
  final String name;

  AvatarList({this.id, this.name, this.imageUrl});
}

final AvatarList paopao =
    AvatarList(id: 0, name: 'PaoPao', imageUrl: 'assets/PaoPao.gif');
final AvatarList iceice =
    AvatarList(id: 1, name: 'IceIce', imageUrl: 'assets/IceIce.gif');
final AvatarList coco =
    AvatarList(id: 2, name: 'CoCo', imageUrl: 'assets/CoCo.gif');
final AvatarList chichi =
    AvatarList(id: 3, name: 'ChiChi', imageUrl: 'assets/ChiChi.gif');
final AvatarList mowmow =
    AvatarList(id: 4, name: 'MowMow', imageUrl: 'assets/MowMow.gif');

List<AvatarList> avatars = [paopao, iceice, coco, chichi, mowmow];
