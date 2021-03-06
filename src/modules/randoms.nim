include base
import sequtils
import macros
import times

template twoChoices(a, b): untyped = 
  if rand(2) == 0: a else: b

module "⚡ Случайные числа":
  command "рандом":
    usage = [
      "рандом <$1> <$2> - случайное число в диапазоне $1-$2", 
      "рандом <$1> - случайное число от 0 до $1"
    ]
    var 
      intArgs = newSeq[int]()
      failMsg = ""
      rndNumber = 0
    
    try:
      # Пытаемся конвертировать аргументы в числа
      intArgs = args.mapIt(it.parseInt())
    except:
      failMsg = "Один из аргументов - не число (или слишком больше число)"
    
    # Если произошла ошибка
    if failMsg != "":
      answer failMsg
      return
    
    # Проверяем, если хоть один аргумент ниже нуля
    if intArgs.anyIt(it < 0):
      answer "Одно из чисел меньше нуля!"
      return
    # Два аргумента - начало и конец диапазона  
    if len(intArgs) == 2:
      let (start, stop) = (intArgs[0], intArgs[1])
      # Если конец диапазона больше начала - всё хорошо
      if abs(stop - start) > 0:
        rndNumber = start + rand(stop - start + 1)
      # Если конец диапазона МЕНЬШЕ начала, делаем наоборот
      # Конец диапазона становится началом, а начало - концом
      else:
        rndNumber = stop + rand(start - stop + 1)
    
    # Только конец диапазона
    elif len(intArgs) == 1:
      rndNumber = rand(intArgs[0])
    
    answer &"Моё число - {rndNumber}"
  
  command "кубик", "кость":
    usage = "кубик - случайное число от 1 до 6, как настоящий игральный кубик"
    answer &"&#127922; Выпал кубик с числом {rand(5) + 1}"
  
  command "монетка", "монета":
    usage = "монетка - подбросить монетку (может выпасть орёл или решка)"
    answer twoChoices("Выпал орёл!", "Выпала решка!")
  
  command "оцени":
    usage = "оцени - оценить что-то по шкале от 1 до 10"
    answer &"{rand(10)+1}/10"
  
  command "когда":
    usage = "когда - узнать, когда произойдёт данное событие"
    const
      Variants = [
        "Не скажу", "Не знаю", "Никогда", "Сегодня",
        "Завтра", "Скоро", "Через несколько дней",
        "На этой неделе", "На следующей неделе", "Через две недели",
        "В этом месяце", "В следующем месяце", 
        "В начале следующего месяца", "В этом году", "В конце года", 
        "В следующем году"
      ]
      
      Months: array[Month, string] = [
        "января", "февраля", "марта", "апреля", "мая", "июня", 
        "июля", "августа", "сентября", "октября", "ноября", "декабря"
      ]
    if args.len < 1:
      answer usage
      return
    # С 35% вероятностью выбираем случайную дату 
    # в диапазоне текущий год - +30 лет
    if rand(100) < 35:
      let 
        now = getTime()
        future = now + initTimeInterval(years=30)
        # Случайная дата
        rdate = (now + rand(future.toUnix.int - now.toUnix.int).seconds).utc
        day = int(rdate.weekday) + 1
        month = Months[rdate.month]
        year = rdate.year
      answer &"Это событие произойдёт {day} {month} {year} года"
    else:
      answer rand(Variants)
  
  command "топ":
    usage = "топ - узнать, топ ли это"
    answer twoChoices("не топ", "топ")
  
  command "да", "нет":
    usage = "да, нет - узнать ответ на вопрос"
    answer twoChoices("Да", "Нет")
  
  command "вероятность", "инфа":
    usage = "инфа <высказывание> - определяет вероятность чего-либо"
    answer &"Вероятность - {rand(100) + 1}%"
  
  command "шар", "правда":
    usage = "шар <высказывание> - правдиво ли данное высказывание"
    const 
      Answers = [
        "Абсолютно точно!", "Да.", 
        "Нет.", "Скорее да, чем нет.", "Не уверен...", "Однозначно нет!",
        "Если ты не фанат аниме, у тебя все получится!",
        "Можешь быть уверен в этом.", "Перспективы не очень хорошие.",
        "А как же иначе?.", "Да, но если только ты не смотришь аниме.",
        "Знаки говорят — «да».", "Не знаю.", "Мой ответ — «нет».", 
        "Весьма сомнительно.", "Не могу дать точный ответ."
      ]
    answer &"🎱 {rand(Answers)}"