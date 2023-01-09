#Использовать "../internal"
#Использовать configor
#Использовать logos
#Использовать semaphore

#Область ОписаниеПеременных

Перем ИнициализированныеЖелудиОдиночки;
Перем Рогатки;
Перем РазворачивательАннотаций;
Перем ФабрикаЖелудей;
Перем СостояниеПриложения;
Перем НапильникиБылиПроинициализированы;

Перем Лог;
Перем МенеджерПараметров;

#КонецОбласти

#Область ПрограммныйИнтерфейс

#Область РаботаСЖелудями

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределенияЖелудей();
КонецФункции

Функция ПолучитьОпределенияАннотаций() Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределенияАннотаций();
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	Возврат ФабрикаЖелудей.ПолучитьОпределениеЖелудя(Имя);
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

	Если НЕ ОпределениеЖелудя.ВремениИнициализации() Тогда
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

Функция НайтиЖелуди(Имя, ПрилепляемыеЧастицы = Неопределено) Экспорт

	ПроверитьСостояниеВыполнение();

	Результат = Новый Массив();

	Если ВРег(Имя) = ВРег("Поделка") Тогда
		Результат.Добавить(ЭтотОбъект);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	ОпределенияЖелудей = ФабрикаЖелудей.ПолучитьСписокОпределенийЖелудей(Имя);

	Для Каждого ОпределениеЖелудя Из ОпределенияЖелудей Цикл
		Желудь = НайтиЖелудь(ОпределениеЖелудя.Имя(), ПрилепляемыеЧастицы);

		Результат.Добавить(Желудь);
	КонецЦикла;

	Возврат Новый ФиксированныйМассив(Результат);
КонецФункции

Функция НайтиДетальку(ИмяДетальки, ЗначениеПоУмолчанию = Неопределено) Экспорт
	Возврат МенеджерПараметров.Параметр(ИмяДетальки, ЗначениеПоУмолчанию);
КонецФункции

#КонецОбласти

#Область ИнициализацияКонтекста

Функция ДобавитьЖелудь(Тип, Имя = "") Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьЖелудь(Тип, Имя);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьДуб(Тип) Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьДуб(Тип);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьНапильник(Тип) Экспорт
	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьНапильник(Тип);

	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьЗаготовку(Тип) Экспорт
	
	ПроверитьСостояниеИнициализация();

	ОпределениеЗаготовки = ФабрикаЖелудей.ДобавитьЗаготовку(Тип);

	Заготовка = НайтиЖелудь(ОпределениеЗаготовки.Имя());
	Заготовка.ПриИнициализацииПоделки(ЭтотОбъект);

	Возврат ЭтотОбъект;

КонецФункции

Функция ДобавитьРогатку(Тип) Экспорт
	
	ПроверитьСостояниеИнициализация();

	ОпределениеРогатки = ФабрикаЖелудей.ДобавитьРогатку(Тип);
	ИмяРогатки = ОпределениеРогатки.Имя();

	Рогатки.Добавить(ИмяРогатки);

	Возврат ЭтотОбъект;

КонецФункции

Функция ДобавитьАннотацию(Тип) Экспорт

	ПроверитьСостояниеИнициализация();
	ФабрикаЖелудей.ДобавитьАннотацию(Тип);

	Возврат ЭтотОбъект;

КонецФункции

Функция ПросканироватьКаталог(Каталог) Экспорт

	Файлы = НайтиФайлы(Каталог, "*.os", Истина);

	// Двойной проход по файлам для предварительного добавления аннотаций, которые могут быть нужны
	// для добавления остальных типов желудей.
	Для Каждого Файл Из Файлы Цикл

		ТипЖелудя = Неопределено;
		Попытка
			ТипЖелудя = Тип(Файл.ИмяБезРасширения);
		Исключение
			Продолжить;
		КонецПопытки;

		РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖелудя);
		Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(, Ложь);

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Аннотация").Количество() > 0 Тогда
			ДобавитьАннотацию(ТипЖелудя);
		КонецЕсли;

	КонецЦикла;

	Для Каждого Файл Из Файлы Цикл
		ТипЖелудя = Неопределено;
		Попытка
			ТипЖелудя = Тип(Файл.ИмяБезРасширения);
		Исключение
			Продолжить;
		КонецПопытки;

		РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖелудя);
		Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(, Ложь);

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Аннотация").Количество() > 0 Тогда
			Продолжить;
		КонецЕсли;

		РазворачивательАннотаций.РазвернутьАннотацииСвойств(Методы, Строка(ТипЖелудя));

		Если РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Желудь").Количество() > 0 Тогда
			ДобавитьЖелудь(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Дуб").Количество() > 0 Тогда
			ДобавитьДуб(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Напильник").Количество() > 0 Тогда
			ДобавитьНапильник(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Рогатка").Количество() > 0 Тогда
			ДобавитьРогатку(ТипЖелудя);
		ИначеЕсли РаботаСАннотациями.НайтиМетодыСАннотацией(Методы, "Заготовка").Количество() > 0 Тогда
			ДобавитьЗаготовку(ТипЖелудя);
		Иначе // BSLLS:EmptyCodeBlock-off
			// no-op
		КонецЕсли;
	КонецЦикла;

	Возврат ЭтотОбъект;

КонецФункции

#КонецОбласти

Процедура ЗапуститьПриложение() Экспорт

	ПроверитьСостояниеИнициализация();

	СостояниеПриложения = СостоянияПриложения.Выполнение();

	Для Каждого ИмяРогатки Из Рогатки Цикл
		Рогатка = НайтиЖелудь(ИмяРогатки);
		Рогатка.ПриЗапускеПриложения();
	КонецЦикла;

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

Процедура ПриСозданииОбъекта()
	РазворачивательАннотаций = Новый РазворачивательАннотаций(ЭтотОбъект);
	ФабрикаЖелудей = Новый ФабрикаЖелудей(ЭтотОбъект, РазворачивательАннотаций);

	ИнициализированныеЖелудиОдиночки = Новый Соответствие();
	Рогатки = Новый Массив();
	СостояниеПриложения = СостоянияПриложения.Инициализация();
	НапильникиБылиПроинициализированы = Ложь;

	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияАннотация"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияЖелудь"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияДуб"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияЗавязь"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияНапильник"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияЗаготовка"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияРогатка"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияПрозвище"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияВерховный"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияХарактер"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияПластилин"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияДеталька"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияБлестяшка"));
	ФабрикаЖелудей.ДобавитьАннотацию(Тип("АннотацияФинальныйШтрих"));

	ФабрикаЖелудей.ДобавитьСистемныйНапильник(Тип("ОбработкаНапильникомПластилинаНаПолях"));
	ФабрикаЖелудей.ДобавитьСистемныйНапильник(Тип("ОбработкаНапильникомФинальныйШтрих"));

	ФабрикаЖелудей.ДобавитьЖелудь(Тип("РазворачивательАннотаций"), "РазворачивательАннотаций");

	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.application.context");

	МенеджерПараметров = Новый МенеджерПараметров();
	// TODO: Добавить провайдеры для переменных среды и аргументов командной строки
	МенеджерПараметров.ИспользоватьПровайдерJSON();
	МенеджерПараметров.ИспользоватьПровайдерYAML();

	НастройкаФайловогоПровайдера = МенеджерПараметров.НастройкаПоискаФайла();
	
	НастройкаФайловогоПровайдера.УстановитьСтандартныеКаталогиПоиска("src");

	НастройкаФайловогоПровайдера.УстановитьИмяФайла("autumn-properties");

	МенеджерПараметров.Прочитать();

	Заготовки = Осень.ПолучитьЗаготовкиДляАвтоИнициализации();

	Для Каждого ИмяТипаЗаготовки Из Заготовки Цикл
		ДобавитьЗаготовку(Тип(ИмяТипаЗаготовки));
	КонецЦикла;

КонецПроцедуры

#КонецОбласти
