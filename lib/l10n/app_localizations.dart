class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'My Daily Notes',
      'noNotes': 'No notes yet',
      'newNote': 'New Note',
      'title': 'Title',
      'note': 'Note',
      'cancel': 'Cancel',
      'save': 'Save',
      'edit': 'Edit Note',
      'update': 'Update',
      'error': 'Error',
      'fillAll': 'Please fill all fields',
      'created': 'Created',
      'support': 'Support',
      'selectLanguage': 'Select Language',
      'english': 'English',
      'sinhala': 'සිංහල',
      'tamil': 'தமிழ்',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
    },
    'si': {
      'appName': 'මගේ දින සටහන් පොත',
      'noNotes': 'තවම සටහන් නැත',
      'newNote': 'නව සටහන',
      'title': 'මාතෘකාව',
      'note': 'සටහන',
      'cancel': 'අවලංගු කරන්න',
      'save': 'සුරකින්න',
      'edit': 'සටහන සංස්කරණය කරන්න',
      'update': 'යාවත්කාලීන කරන්න',
      'error': 'දෝෂයකි',
      'fillAll': 'කරුණාකර සියලු තොරතුරු ඇතුළත් කරන්න',
      'created': 'සාදන ලද්දේ',
      'support': 'සහාය',
      'selectLanguage': 'භාෂාව තෝරන්න',
      'english': 'English',
      'sinhala': 'සිංහල',
      'tamil': 'தமிழ்',
      'darkMode': 'අඳුරු තේමාව',
      'lightMode': 'ආලෝක තේමාව',
    },
    'ta': {
      'appName': 'எனது தினசரி குறிப்புகள்',
      'noNotes': 'குறிப்புகள் எதுவும் இல்லை',
      'newNote': 'புதிய குறிப்பு',
      'title': 'தலைப்பு',
      'note': 'குறிப்பு',
      'cancel': 'ரத்து செய்',
      'save': 'சேமி',
      'edit': 'குறிப்பை திருத்து',
      'update': 'புதுப்பி',
      'error': 'பிழை',
      'fillAll': 'அனைத்து விவரங்களையும் பூர்த்தி செய்யவும்',
      'created': 'உருவாக்கப்பட்டது',
      'support': 'ஆதரவு',
      'selectLanguage': 'மொழியை தேர்ந்தெடுக்கவும்',
      'english': 'English',
      'sinhala': 'සිංහල',
      'tamil': 'தமிழ்',
      'darkMode': 'இருண்ட தீம்',
      'lightMode': 'ஒளி தீம்',
    },
  };

  String get(String key) {
    return _localizedValues[languageCode]?[key] ?? _localizedValues['en']![key]!;
  }
}