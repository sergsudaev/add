﻿//начало текста модуля

#Область Служебные_функции_и_процедуры

&НаКлиенте
// контекст фреймворка Vanessa-ADD
Перем Ванесса;

&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;

&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-ADD.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;

	ВсеТесты = Новый Массив;

	// описание шагов
	//пример вызова Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеЯВвожуТекстФичи(Парам01,Парам02)","ВПолеЯВвожуТекстФичи","И     в поле ""СгенерированныйСценарий"" я ввожу текст фичи ""ФичаДляПроверкиРаботСекцииКонтекст_Тег_tree""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеЯВвожуЗаписьДействийПользователя(Парам01)","ВПолеЯВвожуЗаписьДействийПользователя","И     в поле ""СгенерированныйXML"" я ввожу запись действий пользователя");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ВПолеНаходитсяТекстИзМакета(Парам01,Парам02)","ВПолеНаходитсяТекстИзМакета","Тогда в поле ""СгенерированныйСценарий"" находится текст из макета ""СгенерированныйСценарий""");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВыполняюПодготовкуСценарияКВыполнению()","ЯВыполняюПодготовкуСценарияКВыполнению","И     я выполняю подготовку сценария к выполнению");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ТаблицаФормыVanessaADDСИменемСталаРавной(Парам01,ТабПарам)","ТаблицаФормыVanessaADDСИменемСталаРавной","И     таблица формы VanessaADD с именем ""ДеревоТестов"" стала равной:");

	Возврат ВсеТесты;
КонецФункции

&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции

&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

#КонецОбласти



#Область Работа_со_сценариями

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт

КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	//безусловное закрытие формы если она осталась
	Попытка
	    ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
		ОткрытаяФормаVanessaADD.Закрыть();
	Исключение

	КонецПопытки;
КонецПроцедуры

#КонецОбласти


///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И     в поле "СгенерированныйСценарий" я ввожу текст фичи "Issue-461-Обработка временной фичи"
//@ВПолеЯВвожуТекстФичи(Парам01,Парам02)
Процедура ВПолеЯВвожуТекстФичи(ИмяПоля,ИмяФичи) Экспорт

	ПутьКФиче = Ванесса.Объект.КаталогИнструментов + "\features\Support\Templates\" + ИмяФичи + ".feature";
	// прочитать файл
	ФичаФайла = Новый ЧтениеТекста(ПутьКФиче, КодировкаТекста.UTF8);
	ТекстФичи = ФичаФайла.Прочитать();

	ОткрытаяФормаVanessaADD                         = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий = ТекстФичи;
	ОткрытаяФормаVanessaADD.ПодготовитьСценарийКВыполнению();

КонецПроцедуры

//окончание текста модуля

&НаКлиенте
//И     в поле "СгенерированныйXML" я ввожу запись действий пользователя
//@ВПолеЯВвожуЗаписьДействийПользователя(Парам01)
Процедура ВПолеЯВвожуЗаписьДействийПользователя(Парам01) Экспорт

	ТекстЗаписи = ПолучитьМакетСервер("ЗаписьДействийПользователя").ПолучитьТекст();

	ОткрытаяФормаVanessaADD                           = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.Объект.СгенерированныйXML = ТекстЗаписи;
	ОткрытаяФормаVanessaADD.ПреобразоватьИсходныйXML();

КонецПроцедуры

&НаКлиенте
//Тогда в поле "СгенерированныйСценарий" находится текст из макета "СгенерированныйСценарий"
//@ВПолеНаходитсяТекстИзМакета(Парам01,Парам02)
Процедура ВПолеНаходитсяТекстИзМакета(Парам01,Парам02) Экспорт
	ТекстСценария = ПолучитьМакетСервер("СгенерированныйСценарий").ПолучитьТекст();

	ОткрытаяФормаVanessaADD                    = Контекст.ОткрытаяФормаVanessaADD;
	Если СокрЛП(ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий) <> СокрЛП(ТекстСценария) Тогда
		Сообщить("ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий:");
		Сообщить(СокрЛП(ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий));
		Сообщить("ТекстСценария:");
		Сообщить(СокрЛП(ТекстСценария));

		Строка = СокрЛП(ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий);
		ЗаписатьЛогВЖРИнформация("Тесты",
			"ОткрытаяФормаVanessaADD.Объект.СгенерированныйСценарий:
			|кол-во строк " + СтрЧислоСтрок(Строка)+ ",
			|длина " + СтрДлина(Строка)+ ",
			|<" + Строка + ">");

		Строка = СокрЛП(ТекстСценария);
		ЗаписатьЛогВЖРИнформация("Тесты",
			"ТекстСценария:
			|кол-во строк " + СтрЧислоСтрок(Строка)+ ",
			|длина " + СтрДлина(Строка)+ ",
			|<" + Строка + ">");

		ВызватьИсключение "Ошибка генерации сценария из действий пользователя";
	КонецЕсли;

КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаписатьЛогВЖРИнформация(ИмяСобытия, Стр)
	ЗаписьЖурналаРегистрации("VanessaADD." + ИмяСобытия, УровеньЖурналаРегистрации.Информация, , , Стр);
КонецПроцедуры

&НаКлиенте
//И     я выполняю подготовку сценария к выполнению
//@ЯВыполняюПодготовкуСценарияКВыполнению()
Процедура ЯВыполняюПодготовкуСценарияКВыполнению() Экспорт

	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;
	ОткрытаяФормаVanessaADD.ПодготовитьСценарийКВыполнению();

КонецПроцедуры

&НаКлиенте
Процедура ПреобразоватьТекстДереваВМассив(ЭлементыДерева,МассивСтрокДерева)
	Для Каждого Элем Из ЭлементыДерева Цикл
		МассивСтрокДерева.Добавить(Элем.Имя);
		ПреобразоватьТекстДереваВМассив(Элем.ПолучитьЭлементы(),МассивСтрокДерева);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
//И     таблица формы VanessaADD с именем "ДеревоТестов" стала равной:
//@ТаблицаФормыVanessaADDСИменемСталаРавной(Парам01,ТабПарам)
Процедура ТаблицаФормыVanessaADDСИменемСталаРавной(Парам01,ТабПарам) Экспорт

	ОткрытаяФормаVanessaADD = Контекст.ОткрытаяФормаVanessaADD;

	ЭлементыДерева = ОткрытаяФормаVanessaADD.Объект.ДеревоТестов.ПолучитьЭлементы();

	Ванесса.ПроверитьНеРавенство(ЭлементыДерева.Количество(),0,"Должны быть строки в дереве.");

	МассивСтрокДерева = Новый Массив;
	ПреобразоватьТекстДереваВМассив(ЭлементыДерева,МассивСтрокДерева);

	Для н = 1 По ТабПарам.Количество() - 1  Цикл
		Ванесса.ПроверитьРавенство(МассивСтрокДерева[н-1],ТабПарам[н].Кол1,"Значение в строке №" + н + " <" + МассивСтрокДерева[н-1] + "> не равно ожидаемому значению <" + ТабПарам[н].Кол1 + ">");
	КонецЦикла;

КонецПроцедуры
