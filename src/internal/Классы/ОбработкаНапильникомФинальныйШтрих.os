#Использовать reflector

Перем _Рефлектор;

Функция ОбработатьЖелудь(Желудь, ОпределениеЖелудя) Экспорт // BSLLS:UnusedParameters-off
	
	Методы = ОпределениеЖелудя.НайтиМетодыСАннотациями("ФинальныйШтрих");

	Для Каждого Метод Из Методы Цикл
		_Рефлектор.ВызватьМетод(Желудь, Метод.Имя, Новый Массив());
	КонецЦикла;
	
	Возврат Желудь;
КонецФункции

&Напильник
&Порядок(999999)
Процедура ПриСозданииОбъекта()
	_Рефлектор = Новый Рефлектор();
КонецПроцедуры
