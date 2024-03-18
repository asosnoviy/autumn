
#Использовать ".."
#Использовать asserts
#Использовать "./ТестКлассы"
#Использовать "./ОдноименныеЖелуди"

// BSLLS-off: DuplicateStringLiteral

Перем _ТекущийКаталог;

Процедура ПередЗапускомТеста() Экспорт
	_ТекущийКаталог = ТекущийКаталог();
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	УстановитьТекущийКаталог(_ТекущийКаталог);
КонецПроцедуры

&Тест
Процедура ИмяЖелудяАвтоматическиОпределяетсяИзТипа() Экспорт
	// Дано
	Поделка = Новый Поделка();
	
	// Когда
	// Тогда
	ОпределениеЖелудя = Поделка.ПолучитьОпределениеЖелудя("ВерхнеУровневыйЖелудь");
	
	Ожидаем.Что(ОпределениеЖелудя.ТипЖелудя()).Равно(Тип("ВерхнеУровневыйЖелудь"));
	Ожидаем.Что(ОпределениеЖелудя.Имя()).Равно("ВерхнеУровневыйЖелудь");

КонецПроцедуры

&Тест
Процедура СоздаетсяПростойЖелудь() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьНижнегоУровня");

	// Тогда
	Ожидаем.Что(Желудь).Не_().Равно(Неопределено);
КонецПроцедуры

&Тест
Процедура СоздаетсяЖелудьСЗависимостью() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Желудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");

	// Тогда
	Ожидаем.Что(Желудь).Не_().Равно(Неопределено);

	Ожидаем.Что(Желудь.ЖелудьНижнегоУровня()).Не_().Равно(Неопределено);
КонецПроцедуры

&Тест
Процедура ЖелудиИнициализируютсяКакСинглтоны() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	ВерхнеУровневыйЖелудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");
	ЖелудьНижнегоУровня = Поделка.НайтиЖелудь("ЖелудьНижнегоУровня");

	// Тогда
	Ожидаем.Что(ВерхнеУровневыйЖелудь.ЖелудьНижнегоУровня()).Равно(ЖелудьНижнегоУровня);
КонецПроцедуры

&Тест
Процедура ДубСоздаетПростойЖелудь() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Структура = Поделка.НайтиЖелудь("Структура");

	// Тогда
	Ожидаем.Что(Структура).Не_().Равно(Неопределено);
	Ожидаем.Что(Структура.Ключ).Равно(0);

КонецПроцедуры

&Тест
Процедура ДубСоздаетСложныйЖелудь() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Массив = Поделка.НайтиЖелудь("Массив");

	// Тогда
	Ожидаем.Что(Массив).Не_().Равно(Неопределено);
	Ожидаем.Что(Массив[0].Ключ).Равно(0);

	// Когда
	Структура = Поделка.НайтиЖелудь("Структура");
	Структура.Ключ = 1;

	// Тогда
	Ожидаем.Что(Массив[0].Ключ).Равно(1);

КонецПроцедуры

&Тест
Процедура ДубСоздаетЖелудьПримитивногоТипа() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Строка = Поделка.НайтиЖелудь("ЗначениеСтруктуры");

	// Тогда
	Ожидаем.Что(Строка).Не_().Равно(Неопределено);
	Ожидаем.Что(Строка).Равно(0);

КонецПроцедуры

&Тест
Процедура ПластилинВнедряетсяВПоляЖелудя() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	ВерхнеУровневыйЖелудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");

	// Тогда
	Ожидаем.Что(
		ВерхнеУровневыйЖелудь.ВнедряемыйЖелудьНижнегоУровня(),
		"Желудь внедрился в поле"
	).Не_().Равно(Неопределено);

	Ожидаем.Что(
		ВерхнеУровневыйЖелудь.ВнедряемыйЖелудьНижнегоУровняЧерезСеттер(),
		"Желудь внедрился через сеттер"
	).Не_().Равно(Неопределено);

	Ожидаем.Что(
		ВерхнеУровневыйЖелудь.ВнедряемыйЖелудьНижнегоУровняЧерезСеттерСоСтраннымИменем(),
		"Желудь внедрился через сеттер со странным именем"
	).Не_().Равно(Неопределено);
КонецПроцедуры

&Тест
Процедура ПостКонстрактОтрабатывает() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	ВерхнеУровневыйЖелудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");

	// Тогда
	Ожидаем.Что(ВерхнеУровневыйЖелудь.ПеременнаяВИнит(), "Переменная в инит проинициализировалась").Равно(1);
КонецПроцедуры

&Тест
Процедура КомпанейскиеЖелудиРеИнициализируются() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Желудь1 = Поделка.НайтиЖелудь("КомпанейскийЖелудь");
	Желудь2 = Поделка.НайтиЖелудь("КомпанейскийЖелудь");

	// Тогда
	Ожидаем.Что(Желудь1, "Разные экземпляры желудей").Не_().Равно(Желудь2);
КонецПроцедуры

&Тест
Процедура ЖелудьРегистрируетсяПодИменемИзАннотации() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ТестовыйЖелудь");
	
	// Тогда
	Ожидаем.Что(Желудь, "Не удалось получить желудь по имени из аннотации").Не_().Равно(Неопределено);
КонецПроцедуры

&Тест
Процедура ВерховныйЖелудьМожетПереопределитьОбычный() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ТестовыйЖелудь");
	
	// Тогда
	Ожидаем.Что(Желудь, "Верховный желудь не переопределил обычный").ИмеетТип("ВерховныйТестовыйЖелудь");
	
КонецПроцедуры

&Тест
Процедура ВерховныйЖелудьМожетБытьЖелудемПоУмолчаниюДляПрозвища() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("Кругляш");

	// Тогда
	Ожидаем.Что(Желудь, "Верховный желудь не переопределил прозвище обычного").ИмеетТип("ВерховныйКругляш");
	
КонецПроцедуры

&Тест
Процедура ОбычныйЖелудьНеМожетПереопределитьВерховный() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ТестовыйЖелудь");
	
	// Тогда
	Ожидаем.Что(Желудь, "Верховный желудь переопределился обычным").ИмеетТип("ВерховныйТестовыйЖелудь");
	
КонецПроцедуры

&Тест
Процедура ЖелудьМожноПолучитьПоПрозвищу() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("Кругляш");
	
	// Тогда
	Ожидаем.Что(Желудь, "Не удалось получить желудь по прозвищу").Не_().Равно(Неопределено);
	
КонецПроцедуры

&Тест
Процедура УЖелудяМожетБытьНесколькоПрозвищ() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь1 = Поделка.НайтиЖелудь("СуперКругляш");
	Желудь2 = Поделка.НайтиЖелудь("СуперМелкий");
	
	// Тогда
	Ожидаем.Что(Желудь1, "Не удалось получить желудь по прозвищу СуперКругляш").Не_().Равно(Неопределено);
	Ожидаем.Что(Желудь2, "Не удалось получить желудь по прозвищу СуперМелкий").Не_().Равно(Неопределено);

	Ожидаем.Что(Желудь1, "По разным прозвищам вернулись разные желуди").Равно(Желудь2);
	
КонецПроцедуры

&Тест
Процедура МассивЖелудейМожноВнедритьЧерезПластилин() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");
	Желуди = Желудь.ВнедряемыеЖелудиПоПрозвищу;

	// Тогда
	Ожидаем
		.Что(Желуди, "Не удалось внедрить желуди по прозвищу")
		.ИмеетТип("ФиксированныйМассив")
		.ИмеетДлину(2);

	Ожидаем
		.Что(Желуди.Найти(Поделка.НайтиЖелудь("ВерховныйКругляш")), "Не удалось найти ВерховныйКругляш")
		.Не_().Равно(Неопределено);

	Ожидаем
		.Что(Желуди.Найти(Поделка.НайтиЖелудь("Желудь3")), "Не удалось найти Желудь3")
		.Не_().Равно(Неопределено);

КонецПроцедуры

&Тест
Процедура ДваЖелудяСОднимПрозвищемНельзяПолучитьКакОдинЖелудь() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	а = Поделка.НайтиЖелуди("Мелкий");

	// Когда-Тогда
	ПараметрыМетода = Новый Массив();
	ПараметрыМетода.Добавить("Мелкий");
	Ожидаем
		.Что(Поделка)
		.Метод("НайтиЖелудь", ПараметрыМетода)
		.ВыбрасываетИсключение("Найдено несколько желудей с именем/прозвищем ""Мелкий""")
	;

КонецПроцедуры

&Тест
Процедура ДваЖелудяСОднимПрозвищемМожноПолучитьКакМассив() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("Кругляш");

	// Тогда
	Ожидаем
		.Что(Желуди, "Не удалось получить список желудей по прозвищу")
		.ИмеетДлину(2)
	;

	Ожидаем
		.Что(Желуди.Найти(Поделка.НайтиЖелудь("ВерховныйКругляш")), "Не удалось найти ВерховныйКругляш")
		.Не_().Равно(Неопределено);

	Ожидаем
		.Что(Желуди.Найти(Поделка.НайтиЖелудь("Желудь3")), "Не удалось найти Желудь3")
		.Не_().Равно(Неопределено);

КонецПроцедуры

&Тест
Процедура ЖелудьНаполняетсяДетальками() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСНастройками");
	
	// Тогда
	Ожидаем.Что(Желудь.ПростаяНастройка, "Простая настройка не прочиталась").Равно("Значение простой настройки");
	Ожидаем.Что(Желудь.ХитраяНастройка, "Хитрая настройка не прочиталась").Равно("Значение очень хитрой настройки");
	Ожидаем.Что(Желудь.ЧисловаяНастройка, "В настройку не подставилось значение по умолчанию").Равно(123);
	Ожидаем.Что(Желудь.ЧисловаяНастройка(), "Конструктор не принял настройку").Равно(123);
	Ожидаем.Что(Желудь.ЖелудьНижнегоУровня(), "Конструктор не принял пластилин").ИмеетТип("ЖелудьНижнегоУровня");
	Ожидаем.Что(Желудь.ЖелудьНижнегоУровняЧерезСеттер(), "Сеттер не принял пластилин").ИмеетТип("ЖелудьНижнегоУровня");
	Ожидаем.Что(Желудь.ЖелудьНижнегоУровняЧерезСеттерПоУмолчанию(), "Сеттер по умолчанию не принял пластилин").ИмеетТип("ЖелудьНижнегоУровня");
	Ожидаем.Что(Желудь.МассивНастроек, "Массив внедрился корректно").ИмеетТип("Массив");
	Ожидаем.Что(Желудь.МассивНастроек.Количество(), "Массив настроек содержит 3 элемента").Равно(3);
	Ожидаем.Что(Желудь.МассивНастроек[0], "Массив настроек содержит корректное значение 0 элемента").Равно(1);
	Ожидаем.Что(Желудь.МассивНастроек[1], "Массив настроек содержит корректное значение 1 элемента").Равно(2);
	Ожидаем.Что(Желудь.МассивНастроек[2], "Массив настроек содержит корректное значение 2 элемента").Равно(3);

КонецПроцедуры

&Тест
Процедура ЗначениеДеталькиМожноПереопределить() Экспорт

	// Дано
	ЗначенияДеталек = Новый Соответствие();
	Настройки = Новый Соответствие();

	ЗначенияДеталек.Вставить("Моя", Настройки);
	Настройки.Вставить("Настройка", "Переопределенное значение");

	Совет = Новый СоветДругогоМастера();
	Совет.ЗначенияДеталек(ЗначенияДеталек);

	Поделка = Новый Поделка(Совет);
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСДеталькойИзСоответствия");

	// Тогда
	Ожидаем.Что(Желудь.Деталька, "Хитрая настройка не прочиталась").Равно("Переопределенное значение");
	
КонецПроцедуры

&Тест
Процедура НапильникПолучаетЖелудьЧерезКонструктор() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьНижнегоУровня");
	Напильник = Поделка.НайтиЖелудь("НапильникСЖелудемВКонструкторе");
	ЖелудьИзНапильника = Напильник.ПолучитьЖелудьНижнегоУровня();
	
	// Тогда
	Ожидаем.Что(ЖелудьИзНапильника, "Желудь в напильнике не пустой").Не_().Равно(Неопределено);
	Ожидаем.Что(ЖелудьИзНапильника, "Желудь в напильнике корректный").Равно(Желудь);
		
КонецПроцедуры

&Тест
Процедура ЖелудьПолучаетБлестяшкуВКонструктор() Экспорт
	// Дано
	ЗначениеБлестяшки = 1;
	МассивБлестяшек = Новый Массив();
	МассивБлестяшек.Добавить(ЗначениеБлестяшки);
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда-Тогда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСБлестяшкой", МассивБлестяшек);

	// Тогда
	Ожидаем
		.Что(ЗначениеБлестяшки)
		.Равно(Желудь.ПолучитьХранимуюБлестяшку())
	;
	
КонецПроцедуры

&Тест
Процедура ЖелудьПолучаетБлестяшкуПластелинДеталькуВКонструктор() Экспорт
	// Дано
	ЗначениеБлестяшки = 1;
	ЗначениеВторойБлестяшки = 2;
	МассивБлестяшек = Новый Массив();
	МассивБлестяшек.Добавить(ЗначениеБлестяшки);
	МассивБлестяшек.Добавить(ЗначениеВторойБлестяшки);
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда-Тогда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСБлестяшкойПластелиномДеталькой", МассивБлестяшек);

	// Тогда
	Ожидаем
		.Что(ЗначениеБлестяшки)
		.Равно(Желудь.ПолучитьХранимуюБлестяшку())
	;
	Ожидаем
		.Что(ЗначениеВторойБлестяшки)
		.Равно(Желудь.ПолучитьВторуюХранимуюБлестяшку())
	;
КонецПроцедуры

&Тест
Процедура СПомощьюПроизвольнойАннотацииМожноЗарегистрироватьЖелудь() Экспорт

	// Дано
	Поделка = Новый Поделка();

	// Когда
	// Тогда
	ОпределениеЖелудя = Поделка.ПолучитьОпределениеЖелудя("ПользовательскийКонтроллер");
	Ожидаем
		.Что(ОпределениеЖелудя.Имя())
		.Равно("ПользовательскийКонтроллер")
	;

	Ожидаем
		.Что(
			ОпределениеЖелудя.Завязь().ДанныеМетода().Аннотации.Количество(),
			"Аннотации нижнего уровня не добавились в список аннотаций"
		)
		.Равно(4)

КонецПроцедуры

&Тест
Процедура СПомощьюПроизвольнойАннотацииМожноПолучитьЖелудь() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ПользовательскийКонтроллер");

	// Тогда
	Ожидаем
		.Что(Желудь)
		.Не_()
		.Равно(Неопределено)
	;
	
КонецПроцедуры

&Тест
Процедура СПомощьюПроизвольнойАннотацииМожноПолучитьЖелудьПоПрозвищу() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("Контроллер");

	// Тогда
	Ожидаем
		.Что(Желудь)
		.Не_()
		.Равно(Неопределено)
	;
	
КонецПроцедуры

&Тест
Процедура МетаАннотацииНадПроизвольнымиСвойствамиРазворачиваются() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Массив = Поделка.НайтиЖелудь("МетаМассив");

	// Тогда
	Ожидаем
		.Что(Массив, "Не удалось найти желудь, объявленный через мета-аннотацию завязи")
		.ИмеетТип("Массив")
		.ИмеетДлину(1);

	Ожидаем
		.Что(Массив[0])
		.Равно(1);

КонецПроцедуры

&Тест
Процедура АннотацииКонструктораРазворачиваются() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Параметры = Новый Массив;
	Параметры.Добавить(1);
	Желудь = Поделка.НайтиЖелудь("ЖелудьСМетаБлестяшкой", Параметры);

	// Тогда
	Ожидаем
		.Что(Желудь, "Не создать желудь с мета-блестяшкой")
		.Не_()
		.Равно(Неопределено);

	Ожидаем
		.Что(Желудь.СохраненныйПараметр, "Блестяшка не передалась в конструктор желудя")
		.Равно(1);

КонецПроцедуры

&Тест
Процедура БлестяшкиВПластилинеСкладываютсяВПараметрМассив() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ВнедренноеСложноеЧисло");

	// Тогда
	Ожидаем.Что(Желудь).Равно(3);

КонецПроцедуры

&Тест
Процедура ПоискНесколькихЖелудейСБлестяшкамиРаботаетКорректно() Экспорт
	
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("ЧислоСБлестяшками");

	// Тогда
	Ожидаем.Что(Желуди).ИмеетДлину(2);
	
	Для Каждого Желудь Из Желуди Цикл
		Ожидаем.Что(Желудь).Равно(3);
	КонецЦикла;

КонецПроцедуры

&Тест
Процедура ЖелудьВнедряетсяВПриватноеПоле() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Желудь = Поделка.НайтиЖелудь("ВерхнеУровневыйЖелудь");
	ПриватныйЖелудь = Желудь.ПолучитьПриватныйЖелудь();

	// Тогда
	Ожидаем.Что(ПриватныйЖелудь).ИмеетТип("ЖелудьНижнегоУровня");

КонецПроцедуры

&Тест
Процедура РогаткиЗапускаютсяВПравильномПорядке() Экспорт

	// Дано
	Поделка = Новый Поделка;

	// Когда
	Поделка.ЗапуститьПриложение();
	Массив = Поделка.НайтиЖелудь("Массив");

	// Тогда
	Ожидаем.Что(Массив[2]).Равно(1);
	Ожидаем.Что(Массив[3]).Равно(2);
	Ожидаем.Что(Массив[4]).Равно(3);

КонецПроцедуры

&Тест
Процедура ЖелудиНаходятсяКакМассивПоУмолчанию() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("Кругляш");

	// Тогда
	Ожидаем
		.Что(Желуди, "Желуди лежат в массиве")
		.ИмеетТип(Тип("ФиксированныйМассив"));

	Ожидаем
		.Что(Желуди.Количество(), "Количество желудей")
		.Равно(2);
	
КонецПроцедуры

&Тест
Процедура ЖелудиНаходятсяКакМассив() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("Кругляш",, "Массив");

	// Тогда
	Ожидаем
		.Что(Желуди, "Желуди лежат в массиве")
		.ИмеетТип(Тип("ФиксированныйМассив"));

	Ожидаем
		.Что(Желуди.Количество(), "Количество желудей")
		.Равно(2);
	
КонецПроцедуры

&Тест
Процедура ЖелудиНаходятсяКакСоответствие() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("Кругляш",, "Соответствие");

	// Тогда
	Ожидаем
		.Что(Желуди, "Желуди лежат в соответствии")
		.ИмеетТип(Тип("ФиксированноеСоответствие"));

	Ожидаем
		.Что(Желуди.Количество(), "Количество желудей")
		.Равно(2);

	Ожидаем
		.Что(Желуди["ВерховныйКругляш"], "Желудь по имени лежит в соответствии")
		.Равно(Поделка.НайтиЖелудь("ВерховныйКругляш"));

	Ожидаем
		.Что(Желуди["Желудь3"], "Желудь по имени лежит в соответствии")
		.Равно(Поделка.НайтиЖелудь("Желудь3"));
	
КонецПроцедуры

&Тест
Процедура ВыкидываетИсключениеНаНеизвестноеИмяЖелудя() Экспорт

	// Дано
	Поделка = Новый Поделка();

	// Когда
	ИмяЖелудя = "НеСуществующийЖелудь";
	ПараметрыМетода = Новый Массив();
	ПараметрыМетода.Добавить(ИмяЖелудя);

	// Тогда
	Ожидаем.Что(Поделка, "Поиск несуществующего желудя вызывает исключение")
			.Метод("НайтиЖелудь", ПараметрыМетода)
			.ВыбрасываетИсключение("Не удалось получить определение Желудя");

КонецПроцедуры

&Тест
Процедура НеЗапускатьРогатки() Экспорт

	// Дано
	УстановитьТекущийКаталог(ОбъединитьПути(ТекущийКаталог(), "tests/КаталогНастроекСОтключеннымиРогатками"));
	МокАппендера = Новый МокАппендера();
	Лог = Логирование.ПолучитьЛог("oscript.lib.autumn.ЗапускательПриложения");
	Лог.ДобавитьСпособВывода(МокАппендера, УровниЛога.Информация);

	Поделка = Новый Поделка;

	// Когда
	Поделка.ЗапуститьПриложение();
	Сообщения = МокАппендера.Сообщения;
	Массив = Поделка.НайтиЖелудь("Массив");
	
	// Тогда
	Ожидаем.Что(Сообщения.Количество(), "Количество сообщений").Равно(1);
	Ожидаем.Что(Массив.Количество(), "Массив не изменен").Равно(1);
	Ожидаем.Что(Сообщения[0], "Сообщение об ошибке").Содержит("ИНФОРМАЦИЯ - Запуск рогаток отключен.");
	
КонецПроцедуры

&Тест
Процедура ВнедрениеТабакеркиВЖелудь() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	Желудь = Поделка.НайтиЖелудь("ЖелудьСТабакеркой");

	// Когда
	ТестовыйЖелудь = Желудь.ТестовыйЖелудь.Достать();
	ТестовыйЖелудьИзПоделки = Поделка.НайтиЖелудь("ТестовыйЖелудь");

	// Тогда
	Ожидаем.Что(ТестовыйЖелудь, "Табакерка содержит нужный желудь")
		.Равно(ТестовыйЖелудьИзПоделки);

КонецПроцедуры

&Тест
Процедура ВнедрениеТабакеркСБлестяшкой() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	Желудь = Поделка.НайтиЖелудь("ЖелудьСБлестяшкойВТабакерке");

	// Когда
	Параметры = Новый Массив();
	Параметры.Добавить(1);
	ЖелудьСБлестяшкой = Желудь.ЖелудьСБлестяшкой.Достать(Параметры);
	ХранимаяБлестяшка = ЖелудьСБлестяшкой.ПолучитьХранимуюБлестяшку();
	

	// Тогда
	Ожидаем.Что(ХранимаяБлестяшка, "Получили корретно хранимую блестяшку из желудя табакерки")
		.Равно(1);

КонецПроцедуры

&Тест
Процедура ЖелудьСАннотациейСПовторяемымиПараметрами() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();
	
	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСКонструкторомМассива");
	

	// Тогда
	Ожидаем.Что(Желудь.Массив).ИмеетТип("Массив");
	Ожидаем.Что(Желудь.Массив.Количество()).Равно(2);
	Ожидаем.Что(Желудь.Массив[0]).Равно(1);
	Ожидаем.Что(Желудь.Массив[1]).Равно("2");

КонецПроцедуры

&Тест
Процедура ВсеОпределенияЖелудейПолучаютсяКорректно() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	ОпределенияЖелудей = Поделка.ПолучитьОпределенияЖелудей();

	// Тогда
	Ожидаем
		.Что(ОпределенияЖелудей.Количество(), "Не удалось получить список определений желудей")
		.Больше(0);

	Ожидаем
		.Что(ОпределенияЖелудей.Получить("ТестовыйЖелудь"), "Не удалось найти определение ТестовыйЖелудь")
		.Не_().Равно(Неопределено);
		
	Ожидаем
		.Что(ОпределенияЖелудей.Получить("Желудь3"), "Не удалось найти определение Желудь1")
		.Не_().Равно(Неопределено);

КонецПроцедуры

&Тест
Процедура ОпределенияЖелудейПоПрозвищуПолучаютсяКорректно() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	ОпределенияЖелудей = Поделка.ПолучитьОпределенияЖелудей("Кругляш");

	// Тогда
	Ожидаем
		.Что(ОпределенияЖелудей.Количество(), "Не удалось получить список определений желудей")
		.Больше(0);

	Ожидаем
		.Что(ОпределенияЖелудей.Получить("ВерховныйКругляш"), "Не удалось найти определение ВерховныйКругляш")
		.Не_().Равно(Неопределено);
		
	Ожидаем
		.Что(ОпределенияЖелудей.Получить("Желудь3"), "Не удалось найти определение Желудь1")
		.Не_().Равно(Неопределено);

КонецПроцедуры

&Тест
Процедура ЖелудиНаходятсяКакПользовательскаяКоллекция() Экспорт

	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	Желуди = Поделка.НайтиЖелуди("Кругляш",, "Строка");

	// Тогда
	Ожидаем
		.Что(Желуди, "Желуди лежат в Строке")
		.ИмеетТип(Тип("Строка"))
		.Равно("ВерховныйКругляш, Желудь3");

КонецПроцедуры

&Тест
Процедура ПоискКоллекцииЖелудейНекорректногоТипа() Экспорт
	// Дано
	Поделка = Новый Поделка();
	Поделка.ЗапуститьПриложение();

	// Когда
	ПараметрыМетода = Новый Массив();
	ПараметрыМетода.Добавить("Кругляш");
	ПараметрыМетода.Добавить(Неопределено);
	ПараметрыМетода.Добавить("Нечто");

	// Тогда
	Ожидаем.Что(Поделка)
			.Метод("НайтиЖелуди", ПараметрыМетода)
			.ВыбрасываетИсключение("Неизвестная прилепляемая коллекция Нечто");

КонецПроцедуры

&Тест
Процедура ФильтрНапильниковПрименяетсяТолькоНаРаботает() Экспорт
	
	// Дано
	Поделка = Новый Поделка;
	Поделка.ЗапуститьПриложение();

	НапильникПоПрозвищам = Поделка.НайтиЖелудь("НапильникПрименяющийсяТолькоНаКругляшах");
	НапильникПоИмени = Поделка.НайтиЖелудь("НапильникПрименяющийсяТолькоНаКонкретномЖелуде");

	// Когда
	Кругляши = Поделка.НайтиЖелуди("Кругляш");
	Мелкие = Поделка.НайтиЖелуди("Мелкий");
	СлучайныйЖелудьСПрозвищами = Поделка.НайтиЖелудь("МногоимённыйЖелудь");
	СлучайныйОдиночныйЖелудь = Поделка.НайтиЖелудь("КомпанейскийЖелудь");

	// Тогда
	Ожидаем.Что(НапильникПоПрозвищам.СработалоРаз).Равно(Кругляши.Количество());
	Ожидаем.Что(НапильникПоИмени.СработалоРаз).Равно(1);

КонецПроцедуры

&Тест
Процедура ФильтрНапильниковИзЖелудяРаботает() Экспорт

	// Дано
	Поделка = Новый Поделка;
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьИзбирательноПрименяющийНапильники");
	ЖелудьНижнегоУровня = Поделка.НайтиЖелудь("ЖелудьНижнегоУровня");

	// Тогда
	Ожидаем.Что(Желудь.ЖелудьНижнегоУровня, "Желудь должен внедриться в поле")
		.Равно(ЖелудьНижнегоУровня);
	Ожидаем.Что(Желудь.ВторойЖелудьНижнегоУровня, "Желудь не должен инициализироваться в методе ФинальныйШтрих")
		.Равно(Неопределено);

КонецПроцедуры

&Тест
Процедура ОтключениеНапильниковНаЖелудеРаботает() Экспорт

	// Дано
	Поделка = Новый Поделка;
	Поделка.ЗапуститьПриложение();

	// Когда
	Желудь = Поделка.НайтиЖелудь("ЖелудьСОтключеннымиНапильниками");
	
	// Тогда
	Ожидаем.Что(Желудь.ЖелудьНижнегоУровня, "Желудь не должен внедриться в поле")
		.Равно(Неопределено);
	Ожидаем.Что(Желудь.ВторойЖелудьНижнегоУровня, "Желудь не должен инициализироваться в методе ФинальныйШтрих")
		.Равно(Неопределено);

КонецПроцедуры
