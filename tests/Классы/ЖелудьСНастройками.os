// BSLLS:ExportVariables-off
// BSLLS:MissingVariablesDescription-off

&Деталька
Перем ПростаяНастройка Экспорт;

&Деталька("Настройки.ОченьХитраяНастройка")
Перем ХитраяНастройка Экспорт;

&Деталька
Перем МассивНастроек Экспорт;

&Деталька(ЗначениеПоУмолчанию = 123)
Перем ЧисловаяНастройка Экспорт;

Перем НеЭкспортнаяЧисловаяНастройка;

Перем ЖелудьНижнегоУровня;
Перем ЖелудьНижнегоУровняЧерезСеттер;
Перем ЖелудьНижнегоУровняЧерезСеттерПоУмолчанию;

Функция ЧисловаяНастройка() Экспорт
	Возврат НеЭкспортнаяЧисловаяНастройка;
КонецФункции

Функция ЖелудьНижнегоУровня() Экспорт
	Возврат ЖелудьНижнегоУровня;
КонецФункции

Функция ЖелудьНижнегоУровняЧерезСеттер() Экспорт
	Возврат ЖелудьНижнегоУровняЧерезСеттер;
КонецФункции

Функция ЖелудьНижнегоУровняЧерезСеттерПоУмолчанию() Экспорт
	Возврат ЖелудьНижнегоУровняЧерезСеттерПоУмолчанию;
КонецФункции

&Пластилин("ЖелудьНижнегоУровня")
Функция УстановитьЖелудьНижнегоУровняЧерезСеттер(Значение) Экспорт
	ЖелудьНижнегоУровняЧерезСеттер = Значение;
КонецФункции

&Пластилин
Функция УстановитьЖелудьНижнегоУровня(Значение) Экспорт
	ЖелудьНижнегоУровняЧерезСеттерПоУмолчанию = Значение;
КонецФункции

&Желудь
Процедура ПриСозданииОбъекта(
	&Деталька(ЗначениеПоУмолчанию = 123) ЧисловаяНастройка,
	&Пластилин("ЖелудьНижнегоУровня") _ЖелудьНижнегоУровня
)
	НеЭкспортнаяЧисловаяНастройка = ЧисловаяНастройка;
	ЖелудьНижнегоУровня = _ЖелудьНижнегоУровня;
КонецПроцедуры