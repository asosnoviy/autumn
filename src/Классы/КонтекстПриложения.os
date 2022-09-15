#Использовать "../internal"
#Использовать configor
#Использовать logos
#Использовать semaphore

Перем ИнициализированныеЖелудиОдиночки;
Перем ФабрикаЖелудей;

Перем Лог;
Перем МенеджерПараметров;

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределенияЖелудей();
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);
КонецФункции

Функция ПолучитьЖелудь(Имя) Экспорт

	Если ВРег(Имя) = ВРег("КонтекстПриложения") Тогда
		Возврат ЭтотОбъект;
	КонецЕсли; 

	ОпределениеЖелудя = ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);

	Если ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Компанейский() Тогда
		Желудь = ИнициализироватьКомпанейскийЖелудь(ОпределениеЖелудя.Имя());
	ИначеЕсли ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Одиночка() Тогда
		Желудь = ИнициализироватьЖелудьОдиночку(ОпределениеЖелудя.Имя());
	Иначе
		ВызватьИсключение "Неизвестный характер желудя " + ОпределениеЖелудя.Характер();
	КонецЕсли;

	Возврат Желудь;
КонецФункции

Функция ПолучитьЖелуди(Имя) Экспорт
	Результат = Новый Массив();

	Если ВРег(Имя) = ВРег("КонтекстПриложения") Тогда
		Результат.Добавить(ЭтотОбъект);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	ОпределенияЖелудей = ФабрикаЖелудей.ПолучитьСписокОпределенийЖелудей(Имя);

	Для Каждого ОпределениеЖелудя Из ОпределенияЖелудей Цикл
		Желудь = ПолучитьЖелудь(ОпределениеЖелудя.Имя());

		Результат.Добавить(Желудь);
	КонецЦикла;

	Возврат Новый ФиксированныйМассив(Результат);
КонецФункции

Функция ПолучитьДетальку(ИмяДетальки, ЗначениеПоУмолчанию = Неопределено) Экспорт
	Возврат МенеджерПараметров.Параметр(ИмяДетальки, ЗначениеПоУмолчанию);
КонецФункции

Процедура ЗарегистрироватьЖелудь(Тип, Имя = "") Экспорт
	ФабрикаЖелудей.ЗарегистрироватьЖелудь(Тип, Имя);
КонецПроцедуры

Процедура ЗарегистрироватьДуб(Тип) Экспорт
	ФабрикаЖелудей.ЗарегистрироватьДуб(Тип);
КонецПроцедуры

Процедура ЗарегистрироватьНапильник(Тип) Экспорт
	ФабрикаЖелудей.ЗарегистрироватьНапильник(Тип);
КонецПроцедуры

Процедура ПросканироватьКаталог(Каталог) Экспорт
	Файлы = НайтиФайлы(Каталог, "*.os", Истина);
	Для Каждого Файл Из Файлы Цикл
		ТипЖелудя = Неопределено;
		Попытка
			ТипЖелудя = Тип(Файл.ИмяБезРасширения);
		Исключение
			Продолжить;
		КонецПопытки;

		РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖелудя);
		Если РефлекторОбъекта.ПолучитьТаблицуМетодов("Желудь", Ложь).Количество() > 0 Тогда
			ЗарегистрироватьЖелудь(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Дуб", Ложь).Количество() > 0 Тогда
			ЗарегистрироватьДуб(ТипЖелудя);
		ИначеЕсли РефлекторОбъекта.ПолучитьТаблицуМетодов("Напильник", Ложь).Количество() > 0 Тогда
			ЗарегистрироватьНапильник(ТипЖелудя);
		Иначе // BSLLS:EmptyCodeBlock-off
			// no-op
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Функция ИнициализироватьКомпанейскийЖелудь(Имя)

	Желудь = Неопределено;

	Попытка
		Желудь = ФабрикаЖелудей.ПолучитьЖелудь(ЭтотОбъект, Имя);
	Исключение
		Лог.Ошибка("Не удалось инициализировать желудь %1", Имя);
		Лог.Ошибка(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;

	Возврат Желудь;

КонецФункции

Функция ИнициализироватьЖелудьОдиночку(Имя)

	Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);

	// double-lock checking
	Если Желудь = Неопределено Тогда
		Попытка
			Семафор = Семафоры.Получить(Имя);
			Семафор.Захватить();
			
			Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);
			Если Желудь = Неопределено Тогда
				Желудь = ФабрикаЖелудей.ПолучитьЖелудь(ЭтотОбъект, Имя);
				ИнициализированныеЖелудиОдиночки.Вставить(Имя, Желудь);
			КонецЕсли;
			
			Семафор.Освободить();
		Исключение
			Лог.Ошибка("Не удалось инициализировать желудь %1", Имя);
			Лог.Ошибка(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
			Семафор.Освободить();
		КонецПопытки;
	КонецЕсли;

	Возврат Желудь;

КонецФункции

Процедура ПриСозданииОбъекта()
	ИнициализированныеЖелудиОдиночки = Новый Соответствие();
	ФабрикаЖелудей = Новый ФабрикаЖелудей();

	ФабрикаЖелудей.ЗарегистрироватьСистемныйНапильник(Тип("ОбработкаНапильникомПластилинаНаПолях"));
	ФабрикаЖелудей.ЗарегистрироватьСистемныйНапильник(Тип("ОбработкаНапильникомФинальныйШтрих"));

	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.application.context");

	МенеджерПараметров = Новый МенеджерПараметров();
	// TODO: Добавить провайдеры для переменных среды и аргументов командной строки
	МенеджерПараметров.ИспользоватьПровайдерJSON();
	МенеджерПараметров.ИспользоватьПровайдерYAML();

	НастройкаФайловогоПровайдера = МенеджерПараметров.НастройкаПоискаФайла();
	
	НастройкаФайловогоПровайдера.УстановитьСтандартныеКаталогиПоиска();
	НастройкаФайловогоПровайдера.УстановитьРасширениеФайла("json");
	НастройкаФайловогоПровайдера.УстановитьРасширениеФайла("yaml");
	НастройкаФайловогоПровайдера.УстановитьРасширениеФайла("yml");
	НастройкаФайловогоПровайдера.УстановитьИмяФайла("autumn-properties");
	
	МенеджерПараметров.Прочитать();
КонецПроцедуры
