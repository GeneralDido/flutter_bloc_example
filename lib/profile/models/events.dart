sealed class ProfileEvent {
  const ProfileEvent();
}

class NameChangedProfileEvent extends ProfileEvent {
  final String name;

  const NameChangedProfileEvent({
    required this.name,
  });
}

class AgeChangedProfileEvent extends ProfileEvent {
  final int age;

  const AgeChangedProfileEvent({
    required this.age,
  });
}

class SaveProfileEvent extends ProfileEvent {
  const SaveProfileEvent();
}

class ClearProfileEvent extends ProfileEvent {
  const ClearProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}