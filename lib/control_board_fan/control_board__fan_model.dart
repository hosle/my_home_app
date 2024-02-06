class Todo {
  const Todo(
    this.title,
    this.description,
    this.fanEntity,
  );

  final String title;
  final String description;
  final FanEntity fanEntity;
}

class FanEntity {
  const FanEntity(
    this.fanId,
    this.gearLevel,
    this.enableSwingHead,
    this.enableReverseFan,
  );

  final int fanId;
  final int gearLevel;
  final bool enableSwingHead;
  final bool enableReverseFan;
}

  enum LightMode { warm, warmWhite, white }