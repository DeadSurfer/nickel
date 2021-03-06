const DefaultBotConfig* = """[Group]
  # Токен группы (только при использовании бота от имени группы!)
  token = ""

[User]
  # Логин/пароль пользователя ВК (конфликтует с токеном группы)
  login = ""
  password = ""

[Bot]
  # Префиксы, на которые будет отзываться бот. Сообщения без префикса бот не
  # будет обрабатывать как команды. Возможен пустой префикс - "".
  # Префиксы должны быть в нижнем регистре
  prefixes = ["бот", "бот,", "!"]
  # Пытаться ли конвертировать русский текст в английской раскладке в русскую
  # Пример: пользователь отправляет "!ghbdtn", бот понимает, что это "!привет"
  try_convert = true
  # Должен ли бот пересылать сообщение, на которое он отвечает, в беседе
  forward_conf = true

[CallbackApi]
  # Использовать ли Callback API?
  enabled = false
  # Код подтверждения Callback API
  code = ""

[Errors]
  # Нужно ли отправлять пользователям сообщение, когда в боте произошла 
  # непредвиденная ошибка
  report = true
  # Нужно ли посылать пользователям полный лог ошибки. Если выключить - будет
  # отправляться только сама ошибка, без stack trace
  complete_log = true

[Messages]
  # Префикс сообщения, которое отправляется пользователю при ошибке
  error = "Произошла непредвиденная ошибка:"

[Logging]
  # Уровень логгирования, может быть одним из:
  # "DEBUG", "INFO", "NOTICE", "WARN", "ERROR", "FATAL".
  # При разработке рекомендуется использовать DEBUG, иначе - INFO
  level = "INFO"
  # Логгирование ошибок
  errors = true
  # Логгирование сообщения
  messages = true
  # Логгирование команд
  commands = true
"""

const DefaultModulesConfig* = """[greeting]
  messages = [
    "Запущен и готов служить!", 
    "У контакта ужасный флуд-контроль :(", 
    "Писать ботов не так-то просто, как кажется!",
    "Привет, странствующий путник!"
  ]

[memes]
  # Группа, из которой брать мемы
  group_id = "-86441049"

[translate]
  # API ключ для Яндекс.Переводчика
  key = ""

[weather]
  # API ключ для сервиса OpenWeather
  key = ""

[admin]
  # Список ID администраторов для модуля администрации
  admins = [170831732]
"""