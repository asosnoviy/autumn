#Использовать "../internal"
#Использовать annotations
#Использовать configor
#Использовать logos
#Использовать semaphore

#Область ОписаниеПеременных

Перем ИнициализированныеЖелудиОдиночки;
Перем КонтейнерАннотаций;
Перем ФабрикаЖелудей;
Перем СостояниеПриложения;
Перем НапильникиБылиПроинициализированы;
Перем Осенизатор;

Перем Лог;
Перем МенеджерПараметров;

#КонецОбласти

#Область ПрограммныйИнтерфейс

#Область РаботаСЖелудями

Функция ПолучитьОпределенияЖелудей(Имя = Неопределено) Экспорт
	Если Имя = Неопределено Тогда
		Возврат ФабрикаЖелудей.ПолучитьОпределенияЖелудей();
	Иначе
		ОпределенияЖелудей = Новый Соответствие();
		СписокОпределенийЖелудей = ФабрикаЖелудей.ПолучитьСписокОпределенийЖелудей(Имя);
		Для Каждого ОпределениеЖелудя Из СписокОпределенийЖелудей Цикл
			ОпределенияЖелудей.Вставить(ОпределениеЖелудя.Имя(), ОпределениеЖелудя);
		КонецЦикла;

		Возврат Новый ФиксированноеСоответствие(ОпределенияЖелудей);
	КонецЕсли;
КонецФункции

Функция ПолучитьОпределенияАннотаций() Экспорт
	Возврат КонтейнерАннотаций.ПолучитьОпределенияАннотаций();
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);
КонецФункции

Функция ПолучитьОпределениеАннотации(Имя) Экспорт
	Возврат КонтейнерАннотаций.ПолучитьОпределениеАннотации(Имя);
КонецФункции

Функция НайтиЖелудь(Имя, ПрилепляемыеЧастицы = Неопределено) Экспорт
	
	Если ВРег(Имя) = ВРег("Поделка") Тогда
		ПроверитьСостояниеВыполнение();
		Возврат ЭтотОбъект;
	КонецЕсли;

	ОпределениеЖелудя = ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);

	Если ОпределениеЖелудя = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось получить определение Желудя по имени Желудя %1", Имя);
	КонецЕсли;

	Если НЕ ОпределениеЖелудя.Спецификация() = СостоянияПриложения.Инициализация() Тогда
		ПроверитьСостояниеВыполнение();

		Если НЕ НапильникиБылиПроинициализированы Тогда
			НапильникиБылиПроинициализированы = Истина;
			ФабрикаЖелудей.ПроинициализироватьНапильники();
		КонецЕсли;
	КонецЕсли;

	Если ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Компанейский() Тогда
		Желудь = ИнициализироватьКомпанейскийЖелудь(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);
	ИначеЕсли ОпределениеЖелудя.Характер() = ХарактерыЖелудей.Одиночка() Тогда
		Желудь = ИнициализироватьЖелудьОдиночку(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);
	Иначе
		ВызватьИсключение "Неизвестный характер желудя " + ОпределениеЖелудя.Характер();
	КонецЕсли;

	Возврат Желудь;

КонецФункции

Функция НайтиЖелуди(Имя, ПрилепляемыеЧастицы = Неопределено, ТипЖелудя = "Массив") Экспорт

	ПроверитьСостояниеВыполнение();

	Если ВРег(Имя) = ВРег("Поделка") Тогда

		Если ТипЖелудя <> ТипыПрилепляемыхЖелудей.Массив() Тогда
			ВызватьИсключение "Прилепление Поделки возможно только в виде массива";
		КонецЕсли;

		Результат = Новый Массив();
		Результат.Добавить(ЭтотОбъект);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	// todo: вынести в функции-хэлперы, чтобы на этом уровне не проверять тип желудя каждый раз.
	Если ТипЖелудя = ТипыПрилепляемыхЖелудей.Массив() Тогда
		Результат = Новый Массив();
	ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.Соответствие() Тогда
		Результат = Новый Соответствие();
	ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.ТаблицаЗначений() Тогда
		Результат = Новый ТаблицаЗначений();
		Результат.Колонки.Добавить("Имя");
		Результат.Колонки.Добавить("Желудь");
		Результат.Колонки.Добавить("ОпределениеЖелудя");

		Результат.Индексы.Добавить("Имя");
	Иначе
		ВызватьИсключение "Неизвестный тип желудя " + ТипЖелудя;
	КонецЕсли;

	ОпределенияЖелудей = ФабрикаЖелудей.ПолучитьСписокОпределенийЖелудей(Имя);

	Для Каждого ОпределениеЖелудя Из ОпределенияЖелудей Цикл
		Желудь = НайтиЖелудь(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);

		Если ТипЖелудя = ТипыПрилепляемыхЖелудей.Соответствие() Тогда
			Результат.Вставить(ОпределениеЖелудя.Имя(), Желудь);
		ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.ТаблицаЗначений() Тогда
			Строка = Результат.Добавить();
			Строка.Имя = ОпределениеЖелудя.Имя();
			Строка.Желудь = Желудь;
			Строка.ОпределениеЖелудя = ОпределениеЖелудя;
		ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.Массив() Тогда
			Результат.Добавить(Желудь);
		Иначе
			ВызватьИсключение "Неизвестный тип желудя " + ТипЖелудя;
		КонецЕсли;
	КонецЦикла;

	Если ТипЖелудя = ТипыПрилепляемыхЖелудей.Массив() Тогда
		Возврат Новый ФиксированныйМассив(Результат);
	ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.Соответствие() Тогда
		Возврат Новый ФиксированноеСоответствие(Результат);
	ИначеЕсли ТипЖелудя = ТипыПрилепляемыхЖелудей.ТаблицаЗначений() Тогда
		Возврат Результат.Скопировать();
	Иначе
		ВызватьИсключение "Неизвестный тип желудя " + ТипЖелудя;
	КонецЕсли;

КонецФункции

Функция НайтиДетальку(ИмяДетальки, ЗначениеПоУмолчанию = Неопределено) Экспорт
	Возврат МенеджерПараметров.Параметр(ИмяДетальки, ЗначениеПоУмолчанию);
КонецФункции

#КонецОбласти

#Область ИнициализацияКонтекста

Функция ДобавитьЖелудь(Тип, Имя = "") Экспорт
	Лог.Отладка("Метод ДобавитьЖелудь устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьДуб(Тип) Экспорт
	Лог.Отладка("Метод ДобавитьДуб устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьНапильник(Тип) Экспорт
	Лог.Отладка("Метод ДобавитьНапильник устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьЗаготовку(Тип) Экспорт
	Лог.Отладка("Метод ДобавитьЗаготовку устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьРогатку(Тип) Экспорт
	Лог.Отладка("Метод ДобавитьРогатку устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьАннотацию(Тип) Экспорт
	Лог.Отладка("Метод ДобавитьАннотацию устарел");
	Возврат ЭтотОбъект;
КонецФункции

Функция ПросканироватьКаталог(Каталог) Экспорт
	Лог.Отладка("Метод ПросканироватьКаталог устарел");
	Возврат ЭтотОбъект;
КонецФункции

#КонецОбласти

Процедура ЗапуститьПриложение() Экспорт

	ПроверитьСостояниеИнициализация();
	СостояниеПриложения = СостоянияПриложения.Выполнение();

	ЗапускательПриложения = НайтиЖелудь("ЗапускательПриложения");
	ЗапускательПриложения.ЗапуститьПриложение();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИнициализироватьКомпанейскийЖелудь(Имя, ПрилепляемыеЧастицы)

	Желудь = Неопределено;

	Попытка
		Желудь = ФабрикаЖелудей.НайтиЖелудь(Имя, ПрилепляемыеЧастицы);
	Исключение
		Лог.Ошибка("Не удалось инициализировать желудь %1", Имя);
		Лог.Ошибка(ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;

	Возврат Желудь;

КонецФункции

Функция ИнициализироватьЖелудьОдиночку(Имя, ПрилепляемыеЧастицы)

	Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);

	// double-lock checking
	Если Желудь = Неопределено Тогда
		Попытка
			Семафор = Семафоры.Получить(Имя);
			Семафор.Захватить();
			
			Желудь = ИнициализированныеЖелудиОдиночки.Получить(Имя);
			Если Желудь = Неопределено Тогда
				Желудь = ФабрикаЖелудей.НайтиЖелудь(Имя, ПрилепляемыеЧастицы);
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

Процедура ПроверитьСостояниеИнициализация()

	Если НЕ СостояниеПриложения = СостоянияПриложения.Инициализация() Тогда
		ВызватьИсключение "Приложение не находится в состоянии инициализации. Операция запрещена.";
	КонецЕсли;

КонецПроцедуры

Процедура ПроверитьСостояниеВыполнение()

	Если НЕ СостояниеПриложения = СостоянияПриложения.Выполнение() Тогда
		ВызватьИсключение "Приложение не находится в состоянии выполнения. Операция запрещена.";
	КонецЕсли;

КонецПроцедуры

Процедура ИнициализироватьМенеджерПараметров(СоветДругогоМастера)

	МенеджерПараметров = Новый МенеджерПараметров();

	// TODO: Добавить провайдер аргументов командной строки
	ПровайдерПараметровINI = Новый ПровайдерПараметровINI();
	ПровайдерПараметровENV = Новый ПровайдерПараметровENV(
		СоветДругогоМастера.ПрефиксПеременныхСреды()
	);
	ПровайдерПараметровСоответствие = Новый ПровайдерПараметровСоответствие(
		СоветДругогоМастера.ЗначенияДеталек()
	);

	МенеджерПараметров.ИспользоватьПровайдерJSON(1);
	МенеджерПараметров.ИспользоватьПровайдерYAML(1);
	МенеджерПараметров.ДобавитьПровайдерПараметров(ПровайдерПараметровINI, 1);
	МенеджерПараметров.ДобавитьПровайдерПараметров(ПровайдерПараметровENV, 2);
	МенеджерПараметров.ДобавитьПровайдерПараметров(ПровайдерПараметровСоответствие, 3);

	НастройкаФайловогоПровайдера = МенеджерПараметров.НастройкаПоискаФайла();

	НастройкаФайловогоПровайдера.УстановитьСтандартныеКаталогиПоиска(
		СоветДругогоМастера.ДополнительныйКаталогПоискаФайлаСоЗначениямиДеталек()
	);

	НастройкаФайловогоПровайдера.УстановитьИмяФайла(
		СоветДругогоМастера.ИмяФайлаСоЗначениямиДеталек()
	);

	МенеджерПараметров.Прочитать();

КонецПроцедуры

Процедура ПриСозданииОбъекта(Знач СоветДругогоМастера = Неопределено)

	Если СоветДругогоМастера = Неопределено Тогда
		СоветДругогоМастера = Новый СоветДругогоМастера();
	КонецЕсли;

	КонтейнерАннотаций = Новый КонтейнерАннотаций();
	РазворачивательАннотаций = КонтейнерАннотаций.ПолучитьРазворачивательАннотаций();
	ФабрикаЖелудей = Новый ФабрикаЖелудей(ЭтотОбъект, РазворачивательАннотаций);

	ИнициализированныеЖелудиОдиночки = Новый Соответствие();
	СостояниеПриложения = СостоянияПриложения.Инициализация();
	НапильникиБылиПроинициализированы = Ложь;

	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.application.context");

	ИнициализироватьМенеджерПараметров(СоветДругогоМастера);

	Осенизатор = Новый Осенизатор(ЭтотОбъект, ФабрикаЖелудей, КонтейнерАннотаций);

	Осенизатор.ПросканироватьИзвестныеТипы();

КонецПроцедуры

#КонецОбласти
