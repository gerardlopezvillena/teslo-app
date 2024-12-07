{pkgs}: {
  channel = "stable-24.05";
  packages = [
    pkgs.jdk17
    pkgs.unzip
  ];
  idx.extensions = [
    "aaron-bond.better-comments"
    "Dart-Code.dart-code"
    "Dart-Code.flutter"
    "dracula-theme.theme-dracula"
    "FelixAngelov.bloc"
    "Gruntfuggly.activitusbar"
    "jeroen-meijer.pubspec-assist"
    "Nash.awesome-flutter-snippets"
    "usernamehw.errorlens"
  ];
  idx.previews = {
    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        manager = "flutter";
      };
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "android"
          "-d"
          "localhost:5555"
        ];
        manager = "flutter";
      };
    };
  };
}