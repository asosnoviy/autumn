#Использовать reflector

Перем _КонтекстПриложения;

Функция ПриготовитьЖелудь(Желудь, ИмяЖелудя) Экспорт // BSLLS:UnusedParameters-off
	
	ИмяАннотации = "Пластилин";

	Рефлектор = Новый Рефлектор();
	РефлекторОбъекта = Новый РефлекторОбъекта(Желудь);
	
	Свойства = РефлекторОбъекта.ПолучитьТаблицуСвойств();
	Для Каждого Свойство Из Свойства Цикл
		Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Свойство, ИмяАннотации;

		Если Аннотация = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		МаркаПластилина = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, , Свойство.Имя);
		КусокПластилина = _КонтекстПриложения.ПолучитьЖелудь(МаркаПластилина);
		Рефлектор.УстановитьСвойство(Желудь, Свойство.Имя, КусокПластилина);

	КонецЦикла;

	Методы = РефлекторОбъекта.ПолучитьТаблицуМетодов(ИмяАннотации);
	Для Каждого Метод Из Методы Цикл
		Аннотация = РаботаСАннотациями.ПолучитьАннотацию(Метод, ИмяАннотации);

		ПрототипМаркиПластилина = СтрЗаменить(Метод.Имя, "Установить", "");

		МаркаПластилина = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация, , ПрототипМаркиПластилина);
		КусокПластилина = _КонтекстПриложения.ПолучитьЖелудь(МаркаПластилина);

		ПараметрыМетода = Новый Массив();
		ПараметрыМетода.Добавить(КусокПластилина);

		Рефлектор.ВызватьМетод(Желудь, Метод.Имя, ПараметрыМетода);
	КонецЦикла;
	
	Возврат Желудь;
КонецФункции

&Рецепт
Процедура ПриСозданииОбъекта(&Пластилин КонтекстПриложения)
	_КонтекстПриложения = КонтекстПриложения;
КонецПроцедуры
