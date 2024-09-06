class ExploreCred {
  final TemplateProperties templateProperties;

  ExploreCred({required this.templateProperties});

  factory ExploreCred.fromJson(Map<String, dynamic> json) {
    return ExploreCred(
      templateProperties: TemplateProperties.fromJson(json['template_properties']),
    );
  }
}

class Section {
  final TemplateProperties templateProperties;

  Section({required this.templateProperties});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      templateProperties: TemplateProperties.fromJson(json['template_properties']),
    );
  }
}

class TemplateProperties {
  final Header header;
  final List<Item>? items;

  TemplateProperties({required this.header, this.items});

  factory TemplateProperties.fromJson(Map<String, dynamic> json) {
    return TemplateProperties(
      header: Header.fromJson(json['header']),
      items: json['items'] != null
          ? (json['items'] as List).map((i) => Item.fromJson(i)).toList()
          : null,
    );
  }
}

class Header {
  final String identifier;
  final String title;
  final String? subtitleTitle;

  Header({required this.identifier, required this.title, this.subtitleTitle});

  factory Header.fromJson(Map<String, dynamic> json) {
    return Header(
      identifier: json['identifier'],
      title: json['title'],
      subtitleTitle: json['subtitle_title'],
    );
  }
}

class Item {
  final String identifier;
  final DisplayData displayData;

  Item({required this.identifier, required this.displayData});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      identifier: json['identifier'],
      displayData: DisplayData.fromJson(json['display_data']),
    );
  }
}

class DisplayData {
  final String name;
  final String description;
  final String iconUrl;

  DisplayData({required this.name, required this.description, required this.iconUrl});

  factory DisplayData.fromJson(Map<String, dynamic> json) {
    return DisplayData(
      name: json['name'],
      description: json['description'],
      iconUrl: json['icon_url'],
    );
  }
}
