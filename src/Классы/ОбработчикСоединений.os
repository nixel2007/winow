Перем ПарсерСоединений;
Перем Маршрутизатор;
Перем ФабрикаОтветов;
Перем ОтправщикОтветов;
Перем МенеджерСессий;
Перем МенеджерОтображений;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("ПарсерСоединений") _ПарсерСоединений,
							&Пластилин("Маршрутизатор") _Маршрутизатор,
							&Пластилин("ФабрикаОтветов") _ФабрикаОтветов,
							&Пластилин("ОтправщикОтветов") _ОтправщикОтветов,
							&Пластилин("МенеджерСессий") _МенеджерСессий,
							&Пластилин("МенеджерОтображений") _МенеджерОтображений
							)
	ПарсерСоединений = _ПарсерСоединений;
	Маршрутизатор = _Маршрутизатор;
	ФабрикаОтветов = _ФабрикаОтветов;
	ОтправщикОтветов = _ОтправщикОтветов;
	МенеджерСессий = _МенеджерСессий;
	МенеджерОтображений = _МенеджерОтображений;
КонецПроцедуры

Процедура Обработать(Соединение) Экспорт

	Запрос = ПарсерСоединений.ПолучитьЗапрос(Соединение);	

	ОбработчикИПараметры = Маршрутизатор.НайтиОбработчикИПараметрыПоПолномуПути(Запрос.Путь);

	Запрос.ПараметрыПорядковые = ОбработчикИПараметры.Параметры;

	Если ЗначениеЗаполнено(ОбработчикИПараметры.Действие) Тогда

		Сессия = ПолучитьСессию(Запрос.Куки);
		Ответ = ФабрикаОтветов.НовыйОтвет();
		Ответ.Куки.Добавить(ИмяКукаСессии(), Сессия.Идентификатор());

		Отображене = МенеджерОтображений.ПолучитьОтображениеДействия(ОбработчикИПараметры.Действие);
		Если ЗначениеЗаполнено(Отображене) Тогда
			Ответ.Шаблон.ТекстШаблона = Отображене;
		КонецЕсли;

		Попытка
			ОбработчикИПараметры.Действие.Выполнить(Запрос, Ответ, Сессия);	
		Исключение
			ТекстОшибки = ОписаниеОшибки();
			Ответ = ФабрикаОтветов.НовыйОтвет500(ТекстОшибки);
		КонецПопытки;

	Иначе

		Ответ = ФабрикаОтветов.НовыйОтвет404();

	КонецЕсли;

	ОтправщикОтветов.ОтправитьОтвет(Ответ, Соединение);

	Соединение.Закрыть();

КонецПроцедуры

Функция ПолучитьСессию(Куки)
	ИдСессии = Куки.ПолучитьЗначениеПоИмени(ИмяКукаСессии());
	Возврат МенеджерСессий.ПолучитьСессиюПоИдентификатору(ИдСессии);
КонецФункции

Функция ИмяКукаСессии()
	Возврат "SessionID";
КонецФункции