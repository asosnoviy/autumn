#Использовать asserts
#Использовать fluent
#Использовать reflector

#Область ОписаниеПеременных

// Поделка - Управляющий ioc-контейнер.
Перем Поделка;
// РазворачивательАннотаций - разворачиватель аннотаций свойств и методов желудей.
Перем РазворачивательАннотаций;

// Соответствие, в котором хранятся все определения аннотаций.
//  * Ключ - Строка - имя аннотации.
//  * Значение - ОпределениеАннотации - определение аннотации.
Перем ОпределенияАннотаций;

// Соответствие, в котором хранятся все определения желудей.
//  * Ключ - Строка - имя желудя.
//  * Значение - ОпределениеЖелудя - определение желудя.
Перем ОпределенияЖелудейПоИмени;

// Соответствие, в котором хранятся все определения желудей.
//  * Ключ - Строка - прозвище желудя
//  * Значение - Массив из ОпределениеЖелудя - определения желудей с таким прозвищем.
Перем ОпределенияЖелудейПоПрозвищу;

// Массив из ОпределениеЖелудя - Список определений желудей, являющихся напильниками.
Перем КэшОпределенийНапильников;

// Массив из ОпределениеЖелудя - Список инициализируемых в данный момент напильников.
Перем ИнициализируемыеНапильники;

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ПолучитьОпределенияЖелудей() Экспорт
	Возврат Новый ФиксированноеСоответствие(ОпределенияЖелудейПоИмени);
КонецФункции

Функция ПолучитьОпределенияАннотаций() Экспорт
	Возврат Новый ФиксированноеСоответствие(ОпределенияАннотаций);
КонецФункции

Функция ПолучитьОпределениеЖелудя(Имя) Экспорт
	НайденноеОпределение = ОпределенияЖелудейПоИмени.Получить(Имя);
	Если НайденноеОпределение <> Неопределено Тогда
		Возврат НайденноеОпределение;
	КонецЕсли;

	НайденныеОпределения = ОпределенияЖелудейПоПрозвищу.Получить(Имя);
	Если НайденныеОпределения = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;

	Если НайденныеОпределения.Количество() = 1 Тогда
		Возврат НайденныеОпределения[0];
	КонецЕсли;

	НайденноеОпределение = НайтиОпределениеВерховного(НайденныеОпределения);
	
	Если НайденноеОпределение = Неопределено Тогда
		ВызватьИсключение "Найдено несколько желудей с именем/прозвищем """ + Имя + """";
	КонецЕсли;

	Возврат НайденноеОпределение;
КонецФункции

Функция ПолучитьОпределениеАннотации(Имя) Экспорт
	Возврат ОпределенияАннотаций.Получить(НРег(Имя));
КонецФункции

Функция ПолучитьСписокОпределенийЖелудей(Имя) Экспорт

	Результат = Новый Массив;

	НайденноеОпределение = ОпределенияЖелудейПоИмени.Получить(Имя);
	Если НайденноеОпределение <> Неопределено Тогда
		Результат.Добавить(НайденноеОпределение);
		Возврат Новый ФиксированныйМассив(Результат);
	КонецЕсли;

	Результат = Новый ТаблицаЗначений();
	Результат.Колонки.Добавить("Порядок");
	Результат.Колонки.Добавить("ОпределениеЖелудя");

	НайденныеОпределения = ОпределенияЖелудейПоПрозвищу.Получить(Имя);
	
	Если НайденныеОпределения <> Неопределено Тогда
		Для Каждого Определение Из НайденныеОпределения Цикл
			Строка = Результат.Добавить();
			Строка.ОпределениеЖелудя = Определение;
			Строка.Порядок = Определение.Порядок();
		КонецЦикла;
	КонецЕсли;

	Результат.Сортировать("Порядок Возр");
	КопияРезультат = Результат.ВыгрузитьКолонку("ОпределениеЖелудя");

	Возврат Новый ФиксированныйМассив(КопияРезультат);

КонецФункции

Процедура ПроинициализироватьНапильники() Экспорт

	КэшОпределенийНапильников = ПолучитьСписокОпределенийЖелудей("Напильник");
	Для Каждого ОпределениеНапильника Из КэшОпределенийНапильников Цикл
		Поделка.НайтиЖелудь(ОпределениеНапильника.Имя());
	КонецЦикла;

КонецПроцедуры

Функция ДобавитьЖелудь(ТипЖелудя, Имя) Экспорт

	ОпределениеЖелудя = ДобавитьЖителяЛеса(ТипЖелудя, Имя, "Желудь");

	Возврат ОпределениеЖелудя;

КонецФункции

Функция ДобавитьДуб(ТипДуба) Экспорт

	ОпределениеЖелудя = ДобавитьЖителяЛеса(ТипДуба, "", "Дуб");
	МетодыЗавязи = ОпределениеЖелудя.НайтиМетодыСАннотациями("Завязь");

	Для Каждого МетодЗавязи Из МетодыЗавязи Цикл
		
		Аннотации = МетодЗавязи.Аннотации;
		
		ТипЖелудяЗавязи = ПрочитатьТипЖелудя(МетодЗавязи, Аннотации);
		ИмяЖелудяЗавязи = ПрочитатьИмяЖелудя(Аннотации, "Завязь", МетодЗавязи.Имя);
		ХарактерЖелудя = ПрочитатьХарактерЖелудя(Аннотации);
		ПрилепляемыеЧастицы = ПрочитатьПрилепляемыеЧастицыВМетоде(МетодЗавязи, ТипДуба);
		Завязь = СоздатьЗавязьЧерезМетодЗавязи(ТипДуба, МетодЗавязи);
		Прозвища = ПрочитатьПрозвища(Аннотации, ИмяЖелудяЗавязи);
		Порядок = ПрочитатьПорядок(Аннотации);
		Верховный = ПрочитатьПризнакВерховногоЖелудя(Аннотации);
		ВремениИнициализации = Ложь;

		ОпределениеЗавязи = Новый ОпределениеЖелудя(
			РазворачивательАннотаций,
			ТипЖелудяЗавязи,
			ИмяЖелудяЗавязи,
			ХарактерЖелудя,
			ПрилепляемыеЧастицы,
			Завязь,
			Прозвища,
			Порядок,
			Верховный,
			ВремениИнициализации
		);
		СохранитьОпределениеЖелудя(ОпределениеЗавязи);

	КонецЦикла;

	Возврат ОпределениеЖелудя;

КонецФункции

Функция ДобавитьРогатку(ТипРогатки) Экспорт
	ОпределениеРогатки = ДобавитьЖителяЛеса(ТипРогатки, "", "Рогатка");

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипРогатки);
	
	Ожидаем
		.Что(
			РефлекторОбъекта.ЕстьПроцедура("ПриЗапускеПриложения", 0),
			"Рогатка должна иметь процедуру ПриЗапускеПриложения()"
		)
		.ЭтоИстина();

	Возврат ОпределениеРогатки;
КонецФункции

Функция ДобавитьЗаготовку(ТипЗаготовки) Экспорт
	ОпределениеЗаготовки = ДобавитьЖителяЛеса(ТипЗаготовки, "", "Заготовка");

	Для Каждого ПриклепляемаяЧастица Из ОпределениеЗаготовки.ПрилепляемыеЧастицы() Цикл
		Ожидаем
			.Что(ПриклепляемаяЧастица.ТипЧастицы(), "К заготовке могут прилепляться только детальки.")
			.Равно(ТипыПрилепляемыхЧастиц.Деталька());
	КонецЦикла;

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипЗаготовки);
	
	Ожидаем
		.Что(
			РефлекторОбъекта.ЕстьПроцедура("ПриИнициализацииПоделки", 1),
			"Заготовка должна иметь процедуру ПриИнициализацииПоделки(Поделка)"
		)
		.ЭтоИстина();

	Возврат ОпределениеЗаготовки;
КонецФункции

Функция ДобавитьНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ДобавитьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника);

	Возврат ОпределениеНапильника;
КонецФункции

Функция ДобавитьСистемныйНапильник(ТипНапильника) Экспорт
	ОпределениеНапильника = ДобавитьЖителяЛеса(ТипНапильника, "", "Напильник");

	ДобавитьОпределениеНапильника(ОпределениеНапильника, Истина);

	Возврат ОпределениеНапильника;
КонецФункции

Функция ДобавитьАннотацию(ТипАннотации) Экспорт
	
	ИмяТипаАннотации = Строка(ТипАннотации);

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипАннотации);
	Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов("Аннотация", Ложь);
	Ожидаем.Что(
		Методы.Количество(),
		"Класс должен иметь ровно один метод с аннотацией &Аннотация"
	).Равно(1);

	Конструктор = Методы[0];
	ОсновнаяАннотация = РаботаСАннотациями.ПолучитьАннотацию(Конструктор, "Аннотация");
	
	ИмяАннотации = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(ОсновнаяАннотация, , ИмяТипаАннотации);

	Параметры = Конструктор.Параметры;
	КоличествоПараметровСИменемПоУмолчанию = 0;
	Для Каждого Параметр Из Параметры Цикл
		Если ВРег(Параметр.Имя) = ВРег("Значение") Тогда
			КоличествоПараметровСИменемПоУмолчанию = КоличествоПараметровСИменемПоУмолчанию + 1;

			Если КоличествоПараметровСИменемПоУмолчанию > 1 Тогда
				ВызватьИсключение СтрШаблон(
					"Аннотация %1 имеет более одного параметра с именем ""Значение""",
					ИмяАннотации
				);
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Аннотации = Конструктор.Аннотации;

	Для Каждого ВложеннаяАннотация Из Конструктор.Аннотации Цикл
		
		ОпределениеВложеннойАннотации = ОпределенияАннотаций.Получить(ВложеннаяАннотация.Имя);
		Если ОпределениеВложеннойАннотации = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		ОпределениеВложеннойАннотации.Проверить(ВложеннаяАннотация, ИмяАннотации);

	КонецЦикла;

	ОпределениеАннотации = Новый ОпределениеАннотации(ИмяАннотации, ИмяТипаАннотации, Параметры, Аннотации);

	ОпределенияАннотаций.Вставить(НРег(ИмяАннотации), ОпределениеАннотации);

	Возврат ОпределениеАннотации;

КонецФункции

Функция НайтиЖелудь(ИмяЖелудя, ПрилепляемыеЧастицы) Экспорт

	ОпределениеЖелудя = Поделка.ПолучитьОпределениеЖелудя(ИмяЖелудя);

	Если ОпределениеЖелудя = Неопределено Тогда
		ВызватьИсключение СтрШаблон("Не удалось получить определение Желудя по имени Желудя %1", ИмяЖелудя);
	КонецЕсли;

	// TODO: Медленно.
	ЭтоНапильник = ОпределениеЖелудя.Прозвища().Найти("Напильник") <> Неопределено;

	Если ЭтоНапильник Тогда
		Если ИнициализируемыеНапильники.Найти(ОпределениеЖелудя.Имя()) = Неопределено Тогда
			ИнициализируемыеНапильники.Добавить(ОпределениеЖелудя.Имя());
		КонецЕсли;
	КонецЕсли;

	ПереданныеПрилепляемыеЧастицы = ПрилепляемыеЧастицы;
	Если ПереданныеПрилепляемыеЧастицы = Неопределено Тогда
		ПереданныеПрилепляемыеЧастицы = Новый Массив;
	КонецЕсли;

	Если ПереданныеПрилепляемыеЧастицы.Количество() = ОпределениеЖелудя.ПрилепляемыеЧастицы().Количество() Тогда
		ПередаваемыеПрилепляемыеЧастицы = ПереданныеПрилепляемыеЧастицы;
	Иначе
		
		КоличествоБлестяшек = ПосчитатьКоличествоБлестяшек(ОпределениеЖелудя.ПрилепляемыеЧастицы());

		Если КоличествоБлестяшек <> ПереданныеПрилепляемыеЧастицы.Количество() Тогда
			ВызватьИсключение СтрШаблон(
				"При поиске желудя %1 количество переданных произвольных параметров отличается от количества параметров не-желудей/не-деталек.",
				ИмяЖелудя
			);
		КонецЕсли;

		СчетчикИспользованияБлестяшек = 0;
		ПередаваемыеПрилепляемыеЧастицы = Новый Массив;
		Для Каждого ДанныеОПрилепляемойЧастице Из ОпределениеЖелудя.ПрилепляемыеЧастицы() Цикл
			
			Если ДанныеОПрилепляемойЧастице.ТипЧастицы() = ТипыПрилепляемыхЧастиц.Блестяшка() Тогда
				ПрилепляемаяЧастица = ПереданныеПрилепляемыеЧастицы[СчетчикИспользованияБлестяшек];
				СчетчикИспользованияБлестяшек = СчетчикИспользованияБлестяшек + 1;
			Иначе
				ПрилепляемаяЧастица = ПрилеплениеЧастиц.НайтиПрилепляемуюЧастицу(Поделка, ДанныеОПрилепляемойЧастице);
			КонецЕсли;

			ПередаваемыеПрилепляемыеЧастицы.Добавить(ПрилепляемаяЧастица);
		КонецЦикла;
	КонецЕсли;

	Завязь = ОпределениеЖелудя.Завязь();
	
	Действие = Завязь.Действие();
	Если Завязь.ЭтоКонструктор() Тогда
		Желудь = Действие.Выполнить(ОпределениеЖелудя.ТипЖелудя(), ПередаваемыеПрилепляемыеЧастицы);
	Иначе
		Желудь = Действие.Выполнить(Поделка, Завязь.Родитель(), Завязь.ИмяМетода(), ПередаваемыеПрилепляемыеЧастицы);
	КонецЕсли;

	Если ЭтоНапильник Тогда
		ИндексНапильника = ИнициализируемыеНапильники.Найти(ОпределениеЖелудя.Имя());
		ИнициализируемыеНапильники.Удалить(ИндексНапильника);
	Иначе
		Если НЕ ОпределениеЖелудя.ВремениИнициализации() Тогда
			Для Каждого ОпределениеНапильника Из КэшОпределенийНапильников Цикл
				
				Если ОпределениеНапильника.Имя() = ОпределениеЖелудя.Имя() Тогда
					Продолжить;
				КонецЕсли;
				Если ИнициализируемыеНапильники.Найти(ОпределениеНапильника.Имя()) <> Неопределено Тогда
					// TODO: Сообщение о пропуске запуска напильника на желуде из-за циклической зависимости
					Продолжить;
				КонецЕсли;
				
				Напильник = Поделка.НайтиЖелудь(ОпределениеНапильника.Имя());
				Желудь = Напильник.ОбработатьЖелудь(Желудь, ОпределениеЖелудя);
			
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;

	Возврат Желудь;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция НайтиОпределениеВерховного(Коллекция)
	Для Каждого Элемент Из Коллекция Цикл
		Если Элемент.Верховный() = Истина Тогда
			Возврат Элемент; 
		КонецЕсли;
	КонецЦикла;
	Возврат Неопределено;
КонецФункции

Функция ПосчитатьКоличествоБлестяшек(ПрилепляемыеЧастицы)
	Количество = 0;
	Для Каждого Элемент Из ПрилепляемыеЧастицы Цикл
		Если Элемент.ТипЧастицы() = ТипыПрилепляемыхЧастиц.Блестяшка() Тогда
			Количество = Количество + 1;	
		КонецЕсли;
	КонецЦикла;
	Возврат Количество;
КонецФункции

Функция ДобавитьЖителяЛеса(ТипЖителяЛеса, ИмяЖителяЛеса, АннотацияНадКонструктором)

	РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖителяЛеса);
	АннотацияНадКонструкторомКаноническая = НРег(АннотацияНадКонструктором);
	УсловияПоиска = Новый Структура("Имя", АннотацияНадКонструкторомКаноническая);

	Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(Неопределено, Ложь);
	Конструктор = Неопределено;
	Аннотации = Неопределено;
	
	Для Каждого Метод Из Методы Цикл
		РазворачивательАннотаций.РазвернутьАннотацииСвойства(Метод, ТипЖителяЛеса);
		Аннотации = Метод.Аннотации;

		НайденныеСтроки = Аннотации.НайтиСтроки(УсловияПоиска);
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;

		Если НайденныеСтроки.Количество() > 1 Тогда
			ВызватьИсключение СтрШаблон(
				"Над методом ""%1"" жителя леса с типом ""%2"" найдено более одной аннотации ""%3"".",
				Метод.Имя,
				ТипЖителяЛеса,
				АннотацияНадКонструктором
			);
		КонецЕсли;
		
		Конструктор = Метод;
		Прервать;
	КонецЦикла;

	Если Конструктор = Неопределено Тогда
		ВызватьИсключение СтрШаблон(
			"Не найден метод жителя леса типа ""%1"" с аннотацией ""%2"".",
			ТипЖителяЛеса,
			АннотацияНадКонструктором
		);
	КонецЕсли;

	ОпределениеЖелудя = СоздатьОпределениеЖелудя(
		ТипЖителяЛеса,
		Конструктор,
		Аннотации,
		АннотацияНадКонструктором,
		ИмяЖителяЛеса
	);
	СохранитьОпределениеЖелудя(ОпределениеЖелудя);

	Возврат ОпределениеЖелудя;

КонецФункции

Функция СоздатьОпределениеЖелудя(ТипЖелудя, Конструктор, Аннотации, АннотацияНадКонструктором, Знач ИмяЖелудя = "")
	
	Если Не ЗначениеЗаполнено(ИмяЖелудя) Тогда
		ИмяЖелудя = ПрочитатьИмяЖелудя(Аннотации, АннотацияНадКонструктором, Строка(ТипЖелудя));
	КонецЕсли;

	ПрилепляемыеЧастицы = ПрочитатьПрилепляемыеЧастицыВМетоде(Конструктор, ТипЖелудя);
	Характер = ПрочитатьХарактерЖелудя(Аннотации);
	Завязь = СоздатьЗавязьЧерезКонструкторОбъекта(ТипЖелудя, Конструктор);
	Прозвища = ПрочитатьПрозвища(Аннотации, ИмяЖелудя);
	Порядок = ПрочитатьПорядок(Аннотации);
	Верховный = ПрочитатьПризнакВерховногоЖелудя(Аннотации);
	ВремениИнициализации = АннотацияНадКонструктором = "Заготовка";

	ОпределениеЖелудя = Новый ОпределениеЖелудя(
		РазворачивательАннотаций,
		ТипЖелудя,
		ИмяЖелудя,
		Характер,
		ПрилепляемыеЧастицы,
		Завязь,
		Прозвища,
		Порядок,
		Верховный,
		ВремениИнициализации
	);

	Возврат ОпределениеЖелудя;

КонецФункции

Функция СоздатьЗавязьЧерезКонструкторОбъекта(ТипЖелудя, Конструктор)
	
	Действие = Новый Действие(ФабричныеМетоды, "КонструкторОбъекта");
	Завязь = Новый Завязь(Строка(ТипЖелудя), Конструктор.Имя, Конструктор, Действие, Истина);

	Возврат Завязь;

КонецФункции

Функция СоздатьЗавязьЧерезМетодЗавязи(ТипДуба, МетодЗавязи)

	Действие = Новый Действие(ФабричныеМетоды, "МетодЗавязи");
	Завязь = Новый Завязь(Строка(ТипДуба), МетодЗавязи.Имя, МетодЗавязи, Действие, Ложь);

	Возврат Завязь;

КонецФункции

Функция ПрочитатьИмяЖелудя(Аннотации, АннотацияНадМетодом, ЗначениеПоУмолчанию)

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, АннотацияНадМетодом);
	ИмяЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, , ЗначениеПоУмолчанию);

	Возврат ИмяЖелудя;

КонецФункции

Функция ПрочитатьТипЖелудя(Метод, Аннотации)

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Завязь");
	ТипЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
		Аннотация,
		"Тип"
	);

	Если ТипЖелудя = Неопределено Тогда
		ТипЖелудя = Метод.Имя;
	КонецЕсли;

	Попытка
		РеальныйТип = Тип(ТипЖелудя);
	Исключение
		ВызватьИсключение СтрШаблон(
			"Тип желудя в Завязи %1 не известен. Укажите тип желудя в аннотации или переименуйте метод завязи.",
			Метод.Имя
		);
	КонецПопытки;

	Возврат РеальныйТип;
КонецФункции

Функция ПрочитатьПрилепляемыеЧастицыВМетоде(Метод, ТипВладельцаСвойств)

	ПрилепляемыеЧастицы = Новый Массив;
	Для Каждого ПараметрМетода Из Метод.Параметры Цикл

		РазворачивательАннотаций.РазвернутьАннотацииСвойства(ПараметрМетода, ТипВладельцаСвойств);

		ПрилепляемаяЧастица = ПрилеплениеЧастиц.ДанныеОПрилепляемойЧастице(ПараметрМетода);
		ПрилепляемыеЧастицы.Добавить(ПрилепляемаяЧастица);

	КонецЦикла;

	Возврат ПрилепляемыеЧастицы;

КонецФункции

Функция ПрочитатьХарактерЖелудя(Аннотации)
	ЗначениеПоУмолчанию = ХарактерыЖелудей.Одиночка();

	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Характер");
	Если Аннотация = Неопределено Тогда
		Возврат ЗначениеПоУмолчанию;
	КонецЕсли;

	ХарактерЖелудя = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(
		Аннотация,
		,
		ЗначениеПоУмолчанию
	);

	Если НЕ ХарактерыЖелудей.ЭтоХарактерЖелудя(ХарактерЖелудя) Тогда
		ВызватьИсключение "Неизвестный характер желудя " + ХарактерЖелудя;
	КонецЕсли;

	Возврат ХарактерЖелудя;
КонецФункции

Функция ПрочитатьПрозвища(Аннотации, ЗначениеПоУмолчанию)
	
	Результат = Новый Массив;

	Прозвища = РаботаСАннотациями.НайтиАннотации(Аннотации, "Прозвище");
	Если Прозвища.Количество() = 0 Тогда
		Результат.Добавить(ЗначениеПоУмолчанию);
		Возврат Результат;
	КонецЕсли;

	Для Каждого Аннотация Из Прозвища Цикл
		Прозвище = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация);

		Результат.Добавить(Прозвище);
	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция ПрочитатьПорядок(Аннотации)
	
	Аннотация = РаботаСАннотациями.НайтиАннотацию(Аннотации, "Порядок");

	ОпределениеАннотации = Поделка.ПолучитьОпределениеАннотации("Порядок");
	ОбъектАннотации = ОпределениеАннотации.СоздатьОбъектАннотации(Аннотация);

	Возврат ОбъектАннотации.Значение();

КонецФункции

Функция ПрочитатьПризнакВерховногоЖелудя(Аннотации)
	Возврат РаботаСАннотациями.НайтиАннотацию(Аннотации, "Верховный") <> Неопределено;
КонецФункции

Процедура ДобавитьОпределениеНапильника(ОпределениеНапильника, Системный = Ложь)

	Порядок = ОпределениеНапильника.Порядок();

	МинимальныйПорядок = 0;
	Если Порядок < МинимальныйПорядок Тогда
		ВызватьИсключение "Неверное значение параметра ""Порядок"". Порядок не может быть меньше, чем " + МинимальныйПорядок;
	КонецЕсли;

	МаксимальныйПорядок = 999999;
	Если Порядок > МаксимальныйПорядок Тогда
		ВызватьИсключение "Неверное значение параметра ""Порядок"". Порядок не может быть больше, чем " + МаксимальныйПорядок;
	КонецЕсли;

	Если НЕ Системный Тогда
		Если Порядок = МинимальныйПорядок ИЛИ Порядок = МаксимальныйПорядок Тогда
			ВызватьИсключение "Неверное значение параметра ""Порядок"". Использовано зарезервированное значение " + Порядок;
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

Процедура СохранитьОпределениеЖелудя(ОпределениеЖелудя)

	СохраненноеОпределениеЖелудя = ОпределенияЖелудейПоИмени.Получить(ОпределениеЖелудя.Имя());
	Если СохраненноеОпределениеЖелудя <> Неопределено Тогда
		Если ОпределениеЖелудя.Верховный() И СохраненноеОпределениеЖелудя.Верховный() Тогда
			ВызватьИсключение "Определение верховного желудя с именем """ + ОпределениеЖелудя.Имя() + """ уже существует";
		ИначеЕсли ОпределениеЖелудя.Верховный() И НЕ СохраненноеОпределениеЖелудя.Верховный() Тогда
			// no-op: Допустимая ситуация переопределения.
			// todo: Логирование
		ИначеЕсли НЕ ОпределениеЖелудя.Верховный() И СохраненноеОпределениеЖелудя.Верховный() Тогда
			// no-op: Допустимая ситуация непереопределения.
			// todo: Логирование
		Иначе
			ВызватьИсключение "Определение желудя с именем """ + ОпределениеЖелудя.Имя() + """ уже существует";
		КонецЕсли;
	КонецЕсли;

	ОпределенияЖелудейПоИмени.Вставить(ОпределениеЖелудя.Имя(), ОпределениеЖелудя);

	Прозвища = ОпределениеЖелудя.Прозвища();
	Для Каждого Прозвище Из Прозвища Цикл

		СуществующиеИмена = ОпределенияЖелудейПоПрозвищу.Получить(Прозвище);
		Если СуществующиеИмена = Неопределено Тогда
			СуществующиеИмена = Новый Массив;
		КонецЕсли;
		СуществующиеИмена.Добавить(ОпределениеЖелудя);
		ОпределенияЖелудейПоПрозвищу.Вставить(Прозвище, СуществующиеИмена);	

	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область Инициализация

Процедура ПриСозданииОбъекта(пПоделка, пРазворачивательАннотаций)

	Поделка = пПоделка;
	РазворачивательАннотаций = пРазворачивательАннотаций;

	ОпределенияЖелудейПоИмени = Новый Соответствие();
	ОпределенияЖелудейПоПрозвищу = Новый Соответствие();

	ИнициализируемыеНапильники = Новый Массив();
	ОпределенияАннотаций = Новый Соответствие();
КонецПроцедуры

#КонецОбласти
