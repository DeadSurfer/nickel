import json, httpclient, queues, asyncdispatch, tables

# Все эти типы и поля доступны в других модулях.

type
  LongPollData* = object
    key*: string  ## Ключ сервера 
    server*: string  ## URL сервера
    ts*: BiggestInt  ## Последняя метка времени
  
  Attachment* = tuple[kind, oid, id, token, link: string]

  Flags* {.pure.} = enum  ## Флаги события нового сообщения Long Polling
    Unread, Outbox, Replied, 
    Important, Chat, Friends, 
    Spam, Deleted, Fixed, Media, Hidden
  
  Command* = object
    name*: string  ## Сама команда
    args*: seq[string]  ## Аргументы
  
  ForwardedMessage* = object
    msgId*: string  ## ID сообщения
    userId*: int  ## ID пользователя
  
  # Тип сообщения - из беседы или из ЛС
  MessageKind* = enum msgPriv, msgConf
  Message* = ref object
    case kind*: MessageKind
    # Если это конференция, то добавляем поле с ID пользователя
    of msgConf:
      cid*: int
    else: discard
    id*: int  ## ID сообщения
    pid*: int  ## ID отправителя (беседы или пользователя)
    timestamp*: BiggestInt  ## Дата отправки
    subject*: string  ## Тема 
    cmd*: Command  ## Объект команды для данного сообщения
    body*: string
    fwdMessages*: seq[ForwardedMessage]  ## Пересланные сообщения
    doneAttaches*: seq[Attachment]  ## Приложения к сообщению
  
  BotConfig* = object
    token*, login*, password*: string
    prefixes*: seq[string]
    logMessages*: bool
    logCommands*: bool
    convertText*: bool
    forwardConf*: bool
    errorMessage*: string
    reportErrors*: bool
    logErrors*: bool
    fullReport*: bool
    useCallback*: bool
    confirmationCode*: string
  
  VkApi* = ref object
    token*: string  ## Токен VK API
    fwdConf*: bool
    isGroup*: bool
  
  VkBot* = ref object
    api*: VkApi  ## Объект VK API
    lpData*: LongPollData  ## Информация о сервере Long Pooling
    lpURL*: string  ## URL сервера Long Pooling
    config*: BotConfig  ## Конфигурация бота
    isGroup*: bool
    
  ModuleFunction* = proc(api: VkApi, msg: Message): Future[void]

  OnStartProcedure* = proc(bot: VkBot, config: JsonNode): Future[bool]
  
  ModuleCommand* = ref object
    cmds*: seq[string]
    usages*: seq[string]
    call*: ModuleFunction
  
  Module* = ref object
    name*: string  ## Имя модуля
    cmds*: seq[ModuleCommand] ## Секции команд, которые есть в этом модуле
    anyCommands*: seq[ModuleFunction]  ## Команды, которые реагируют на любой текст
    startProc*: OnStartProcedure  ## Процедура, выполняемая после запуска бота