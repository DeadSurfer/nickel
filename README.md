NickelVK
======
Чат-бот для ВКонтакте в ранней стадии разработки, написанный на языке Nim.
Пока не подходит для повседневного использования, однако, если вы хотите использовать его в будущем - помогите в поиске багов и крашей!
Я учу язык вместе с разработкой этого бота, так что давайте советы (если вы, конечно, знаете Nim) :)
##ВНИМАНИЕ
Если вы ищете просто рабочего бота, лучше используйте https://github.com/TiberiumN/VBot. Он протестирован в боевых условиях, однако я не оказываю поддержки по проблемам с VBot

## Текущий статус проекта
Этот бот работает **ТОЛЬКО ОТ ГРУППЫ**, поддержка работы от аккаунта пользователя запланирована.

Для работы бота необходим Nim 0.16.1 или выше (очень желательно - devel), с версиями ниже бот **не работает** и поддержка старых версий не планируется.

## Встроенные плагины (многие из них не реализованы, но запланированы)
* Приветствие (Плагин приветствия) - `привет`
* Случайное число (Случайное число в разных диапазонах) - `рандом`
* Случайные мемы - `мемы`
* Случайные мемы с 2ch - `форчан`
* Курс валют (Отображение основных курсов валют) - `курс`
* Шар восьмерка (Решает за вас) - `шар`
* Время (Показывает текущую дату и время) - `время`
* Блокнот (Может запоминать и вспоминать строки) - `напомни` и `запомни`
* Рассказать шутку (рассказывает случайный анекдот) - `пошути`
* Выключение (Выключает бота, если команду послал администратор бота) - `выключись`

######Для того, чтобы узнать ID пользователя или группы, используйте https://vk.com/linkapp

## Создание плагинов
В папке `src/plugins` есть пример плагина в файле example.nim, который отвечает на команду `тест`
Там есть и другие плагины, код которых можно просмотреть для понимания того, что можно сделать с помощью бота.

Плагины могут работать со всеми методами API ВКонтакте, которые доступны для выполнения от имени текущей группы.

#### Связь со мной
Меня можно найти в ВК - https://vk.com/tiberium_1111