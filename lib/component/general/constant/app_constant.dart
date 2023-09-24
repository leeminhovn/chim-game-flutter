

class AppConstant {
  static List<Map<String, dynamic>> listLoad = [
    {
      "path": "bird/bird_yellow",
      "type": "array",
      "nameArray": "birdYellow",
      "images": [
        {"name": "null", "image": "yellowbird_downflap.png"},
        {"name": "null", "image": "yellowbird_midflap.png"},
        {"name": "null", "image": "yellowbird_upflap.png"}
      ]
    },
    {
      "path": "number",
      "type": "array",
      "nameArray": "number",
      "images": [
        {"name": "null", "image": "0.png"},
        {"name": "null", "image": "1.png"},
        {"name": "null", "image": "2.png"},
        {"name": "null", "image": "3.png"},
        {"name": "null", "image": "4.png"},
        {"name": "null", "image": "5.png"},
        {"name": "null", "image": "6.png"},
        {"name": "null", "image": "7.png"},
        {"name": "null", "image": "8.png"},
        {"name": "null", "image": "9.png"}
      ]
    },
    {
      "path": "other",
      "type": "normal",
      "images": [
        {"name": "background", "image": "background.png"},
        {"name": "textGameOver", "image": "game_over.png"},
        {"name": "ground", "image": "ground.png"},
        {"name": "textMessageGuidePlay", "image": "message_guide_play.png"},
        {"name": "pipeGreenTop", "image": "pipe_green_top.png"},
        {"name": "pipeGreenBody", "image": "pipe_green_body.png"},
        {"name": "logoHalo", "image": "flappy_logo_halo.png"},
      ]
    }
  ];
  static Map<String, dynamic> audiosLoad = {
    "die": "die.mp3",
    "hit": "hit.mp3",
    "point": "point.mp3",
    "swoosh": "swoosh.mp3",
    "wing": "wing.mp3",
  };
}

class ConfigGame {
  static double speed = 1;
}
