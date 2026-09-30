String getPetAvatarPath(String species, String? photoUrlOrGender) {
  final isFemale = (photoUrlOrGender?.toLowerCase().trim() == 'hembra');
  final suffix = isFemale ? 'female' : 'male';
  switch (species.toLowerCase().trim()) {
    case 'perro':
      return 'assets/images/avatars/dog_$suffix.jpg';
    case 'gato':
      return 'assets/images/avatars/cat_$suffix.jpg';
    case 'ave':
      return 'assets/images/avatars/bird_$suffix.jpg';
    case 'reptil':
      return 'assets/images/avatars/reptile_$suffix.jpg';
    default:
      return 'assets/images/avatars/other_$suffix.jpg';
  }
}
