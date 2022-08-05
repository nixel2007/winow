#Использовать autumn

Перем Маршрутизатор;
Перем МенеджерОтображений;

&Напильник(Порядок = 10)
Процедура ПриСозданииОбъекта()
КонецПроцедуры

Процедура УстановитьМаршрутизатор(_Маршрутизатор) Экспорт
	Маршрутизатор = _Маршрутизатор;
КонецПроцедуры

Процедура УстановитьМенеджерОтображений(_МенеджерОтображений) Экспорт
	МенеджерОтображений = _МенеджерОтображений;
КонецПроцедуры

Функция ОбработатьЖелудь(Желудь, ИмяЖелудя) Экспорт
	
	НайтиИЗарегистрироватьМаршруты(Желудь);
	
	Возврат Желудь;
КонецФункции

Процедура НайтиИЗарегистрироватьМаршруты(Желудь)

	РефлекторОбъекта = РефлекторЖелудя(Желудь);

	МетодыКонтролер = РефлекторОбъекта.ПолучитьТаблицуМетодов("Контроллер", Ложь);

	Если МетодыКонтролер.Количество() > 1 Тогда

		ВызватьИсключение "Не может быть больше одного определения контроллера в классе " + Желудь;

	ИначеЕсли МетодыКонтролер.Количество() = 0 Тогда

		Возврат;

	КонецЕсли;

	Аннотация = РаботаСАннотациями.ПолучитьАннотацию(МетодыКонтролер[0], "Контроллер");

	АдресКонтроллера = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация);

	МетодыТочекМаршрутов = РефлекторОбъекта.ПолучитьТаблицуМетодов("ТочкаМаршрута");

	Если МетодыТочекМаршрутов.Количество() = 0 Тогда
		ВызватьИсключение "Не определено ниодной точки маршрута в контроллере " + Желудь;
	КонецЕсли;

	Для Каждого ТочкаМаршрута из МетодыТочекМаршрутов Цикл
		ЗарегистрироватьМаршрутКОбъекту(АдресКонтроллера, ТочкаМаршрута, Желудь);
	КонецЦикла;

КонецПроцедуры

Процедура ЗарегистрироватьМаршрутКОбъекту(АдресКонтроллера, ТочкаМаршрута, Желудь)

	Аннотация = РаботаСАннотациями.ПолучитьАннотацию(ТочкаМаршрута, "ТочкаМаршрута");
	ИмяТочкиМаршута = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация);
	ПутьКМетоду = ОбъединитьПути(АдресКонтроллера, ИмяТочкиМаршута);

	Действие = Новый Действие(Желудь, ТочкаМаршрута.Имя);

	Маршрутизатор.ДобавитьМаршрут(ПутьКМетоду, Действие);

	Аннотация = РаботаСАннотациями.ПолучитьАннотацию(ТочкаМаршрута, "Отображение");
	Если НЕ Аннотация = Неопределено Тогда
		РасположениеОтображения = РаботаСАннотациями.ПолучитьЗначениеПараметраАннотации(Аннотация);
		МенеджерОтображений.ДобавитьОтображениеДействия(Действие, РасположениеОтображения);
	КонецЕсли;

КонецПроцедуры

Функция РефлекторЖелудя(Желудь)
	Возврат Новый РефлекторОбъекта(ТипЗнч(Желудь));
КонецФункции