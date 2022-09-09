
Процедура ПриЗагрузкеБиблиотеки(Путь, СтандартнаяОбработка, Отказ)

	Если Осень <> Неопределено Тогда
		КаталогЗаготовки = ОбъединитьПути(Путь, "src", "Классы","1ЗаготовкаПриложения.os");
		ДобавитьКласс(КаталогЗаготовки, "ЗаготовкаПриложения");
		Осень.ЗарегистрироватьЗаготовкуДляАвтоИнициализации(Тип("ЗаготовкаПриложения"));
	Иначе
		ВызватьИсключение "Некорректный порядок импорта библиотек. Сначала подключите autumn";	
	КонецЕсли;

КонецПроцедуры