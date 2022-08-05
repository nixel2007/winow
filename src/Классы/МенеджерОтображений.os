Перем ОтображенияДействий;
Перем Отображения;

&Желудь
Процедура ПриСозданииОбъекта()

	ОтображенияДействий = Новый Соответствие();
	Отображения = Новый Соответствие();

КонецПроцедуры

Процедура ДобавитьОтображениеДействия(Действие, ПутьДоФайла) Экспорт

	ДобавитьОтображениеИзФайла(ПутьДоФайла);
	ОтображенияДействий.Вставить(Действие, ПутьДоФайла);
	
КонецПроцедуры

Функция ДобавитьОтображениеИзФайла(ПутьДоФайла) Экспорт

	Текст = ПолучитьОтображениеИзФайла(ПутьДоФайла);
	Отображения.Вставить(ПутьДоФайла, Текст);
	
	Возврат Текст;

КонецФункции

Функция ПолучитьОтображениеДействия(Действие) Экспорт
	
	ПутьДоФайла = ОтображенияДействий.Получить(Действие);

	Если не ЗначениеЗаполнено(ПутьДоФайла) Тогда
		Возврат Неопределено;
	КонецЕсли;

	Возврат Отображения[ПутьДоФайла];

КонецФункции

Функция ПолучитьОтображение(ПутьДоФайла) Экспорт

	Отображение = Отображения[ПутьДоФайла];

	Если Отображение = Неопределено Тогда
		Отображение = ДобавитьОтображениеИзФайла(ПутьДоФайла);
	КонецЕсли;

	Возврат Отображение;

КонецФункции

Функция ПолучитьОтображениеИзФайла(ПутьДоФайла) Экспорт

	Файл = Новый Файл(ПутьДоФайла);	
	Если Файл.Существует() Тогда
		Чтение = Новый ЧтениеТекста();
		Чтение.Открыть(ПутьДоФайла);
		Текст = Чтение.Прочитать();
		Чтение.Закрыть();

		Возврат Текст;
	Иначе
		ВызватьИсключение СтрШаблон("Файл отображения не существует %1", ПутьДоФайла);
	КонецЕсли;	

КонецФункции