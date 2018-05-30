include base

var greetings: seq[string]

module "📞 Приветствие":
  startConfig:
    greetings = config.getStringArray("messages")
  
  command "привет", "ку", "прив", "хей", "хэй", "qq", "халло", "хелло", "hi":
    usage = "привет - поприветствовать пользователя"
    answer rand(greetings)