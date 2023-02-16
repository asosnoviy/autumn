#Использовать asserts

Перем _Имя;
Перем _ТипЖелудя;
Перем _Характер;
Перем _ПрилепляемыеЧастицы;
Перем _Завязь;
Перем _Прозвища;
Перем _Верховный;
Перем _Порядок;
Перем _ВремениИнициализации;
Перем _РефлекторОбъекта;
Перем _РазворачивательАннотаций;

Перем Свойства;
Перем Методы;

Перем ЭтоПримитивныйТип;

Перем КешМетодовПоАннотациям;
Перем КешПрилепляемыеЧастицы;

Функция Имя() Экспорт
	Возврат _Имя;
КонецФункции

Функция ТипЖелудя() Экспорт
	Возврат _ТипЖелудя;
КонецФункции

Функция Характер() Экспорт
	Возврат _Характер;
КонецФункции

Функция ПрилепляемыеЧастицы() Экспорт
	Если КешПрилепляемыеЧастицы = Неопределено Тогда
		КешПрилепляемыеЧастицы = Новый ФиксированныйМассив(_ПрилепляемыеЧастицы);
	КонецЕсли;

	Возврат КешПрилепляемыеЧастицы;
КонецФункции

Функция Завязь() Экспорт
	Возврат _Завязь;
КонецФункции

Функция Прозвища() Экспорт
	Возврат _Прозвища;
КонецФункции

Функция Порядок() Экспорт
	Возврат _Порядок;
КонецФункции

Функция Верховный() Экспорт
	Возврат _Верховный;
КонецФункции

Функция ВремениИнициализации() Экспорт
	Возврат _ВремениИнициализации;
КонецФункции

Функция Свойства() Экспорт
	Если Свойства = Неопределено Тогда
		Свойства = ?(ЭтоПримитивныйТип, Новый ТаблицаЗначений, _РефлекторОбъекта.ПолучитьТаблицуСвойств(Неопределено, Истина));
		Для Каждого Свойство Из Свойства Цикл
			_РазворачивательАннотаций.РазвернутьАннотацииСвойства(Свойство, ТипЖелудя());
		КонецЦикла;
	КонецЕсли;

	Возврат Свойства;
КонецФункции

Функция Методы() Экспорт
	Если Методы = Неопределено Тогда
		Методы = ?(ЭтоПримитивныйТип, Новый ТаблицаЗначений, _РефлекторОбъекта.ПолучитьТаблицуМетодов());
		Для Каждого Метод Из Методы Цикл
			_РазворачивательАннотаций.РазвернутьАннотацииСвойства(Метод, ТипЖелудя());
		КонецЦикла;
	КонецЕсли;

	Возврат Методы;
КонецФункции

Функция РефлекторОбъекта() Экспорт
	Возврат _РефлекторОбъекта;
КонецФункции

Процедура ПриСозданииОбъекта(
	РазворачивательАннотаций,
	ТипЖелудя,
	Имя,
	Характер,
	ПрилепляемыеЧастицы,
	Завязь,
	Прозвища,
	Порядок,
	Верховный,
	ВремениИнициализации
)
	Ожидаем.Что(РазворачивательАннотаций).ИмеетТип("РазворачивательАннотаций");
	Ожидаем.Что(ТипЖелудя).ИмеетТип("Тип");
	Ожидаем.Что(Имя).ИмеетТип("Строка");
	Ожидаем.Что(СтрДлина(Имя)).Больше(0);
	Ожидаем.Что(Характер).ИмеетТип("Строка");
	Ожидаем.Что(ПрилепляемыеЧастицы).ИмеетТип("Массив");
	Ожидаем.Что(Завязь).ИмеетТип("Завязь");
	Ожидаем.Что(Прозвища).ИмеетТип("Массив");
	Ожидаем.Что(Прозвища.Количество()).Больше(0);
	Ожидаем.Что(Порядок).ИмеетТип("Число");
	Ожидаем.Что(Верховный).ИмеетТип("Булево");
	Ожидаем.Что(ВремениИнициализации).ИмеетТип("Булево");
	
	_Имя = Имя;
	_ТипЖелудя = ТипЖелудя;
	_Характер = Характер;
	_ПрилепляемыеЧастицы = ПрилепляемыеЧастицы;
	_Завязь = Завязь;
	_Прозвища = Прозвища;
	_Порядок = Порядок;
	_Верховный = Верховный;
	_ВремениИнициализации = ВремениИнициализации;
	
	_РазворачивательАннотаций = РазворачивательАннотаций;
	_РефлекторОбъекта = Новый РефлекторОбъекта(ТипЖелудя);

	КешМетодовПоАннотациям = Новый Соответствие();
	ЭтоПримитивныйТип = _ТипЖелудя = Тип("Строка")
		Или _ТипЖелудя = Тип("Дата") 
		Или _ТипЖелудя = Тип("Число") 
		Или _ТипЖелудя = Тип("Булево");

КонецПроцедуры

Функция НайтиМетодыСАннотациями(АннотацияФильтр) Экспорт

	ИзКеша = КешМетодовПоАннотациям[АннотацияФильтр];
	Если НЕ ИзКеша = Неопределено Тогда
		Возврат ИзКеша;
	КонецЕсли;
	
	Результат = РаботаСАннотациями.НайтиМетодыСАннотацией(Методы(), АннотацияФильтр);

	КешМетодовПоАннотациям.Вставить(АннотацияФильтр, Результат);

	Возврат Результат;

КонецФункции
