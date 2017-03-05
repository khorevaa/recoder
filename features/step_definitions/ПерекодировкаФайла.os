﻿// Реализация шагов BDD-фич/сценариев c помощью фреймворка https://github.com/artbear/1bdd

#Использовать asserts
#Использовать tempfiles
#Использовать logos
#Использовать "..\.."

Перем Лог;

Перем БДД; //контекст фреймворка 1bdd

// Метод выдает список шагов, реализованных в данном файле-шагов
Функция ПолучитьСписокШагов(КонтекстФреймворкаBDD) Экспорт
	БДД = КонтекстФреймворкаBDD;

	ВсеШаги = Новый Массив;

	ВсеШаги.Добавить("ЯСоздаюНовыйОбъектПерекодировщик");
	ВсеШаги.Добавить("ЗаписываюИмяКаталогаРесурсовВКонтекст");
	ВсеШаги.Добавить("СохраняюВКонтекстИмяТестовогоФайла");
	ВсеШаги.Добавить("СохраняюВКонтекстИмяЭталонногоФайла");
	ВсеШаги.Добавить("ЯКопируюТестовыйФайлИзКаталогаРесурсовВоВременныйКаталог");
	ВсеШаги.Добавить("ЯВыполняюПерекодировкуТестовогоФайлаВоВременномКаталоге");
	ВсеШаги.Добавить("ВоВременномКаталогеСуществуетТолькоПерекодированныйФайл");
	ВсеШаги.Добавить("РазмерПерекодированногоФайлаРавенРазмеруЭталонногоФайла");
	ВсеШаги.Добавить("СодержимоеПерекодированногоФайлаСовпадаетССодержимымЭталонногоФайла");

	Возврат ВсеШаги;
КонецФункции

// Реализация шагов

// Процедура выполняется перед запуском каждого сценария
Процедура ПередЗапускомСценария(Знач Узел) Экспорт
	
КонецПроцедуры

// Процедура выполняется после завершения каждого сценария
Процедура ПослеЗапускаСценария(Знач Узел) Экспорт
	
КонецПроцедуры

//Я создаю новый объект Перекодировщик
Процедура ЯСоздаюНовыйОбъектПерекодировщик() Экспорт
    //ПутьКСкрипту = ОбъединитьПути(ТекущийКаталог(), "src", "recoder.os");
	//Перекодировщик = ЗагрузитьСценарий(ПутьКСкрипту);
	//БДД.СохранитьВКонтекст("Перекодировщик", Перекодировщик);
КонецПроцедуры

//записываю имя каталога ресурсов в контекст
Процедура ЗаписываюИмяКаталогаРесурсовВКонтекст() Экспорт
    БДД.СохранитьВКонтекст("КаталогРесурсов", ОбъединитьПути(ТекущийКаталог(), "features", "resources"));	
КонецПроцедуры

//сохраняю в контекст имя тестового файла "example.txt"
Процедура СохраняюВКонтекстИмяТестовогоФайла(Знач ИмяФайла) Экспорт
    БДД.СохранитьВКонтекст("ТестовыйФайл", ИмяФайла);
КонецПроцедуры

//сохраняю в контекст имя эталонного файла "example_UTF8.txt"
Процедура СохраняюВКонтекстИмяЭталонногоФайла(Знач ИмяФайла) Экспорт
	БДД.СохранитьВКонтекст("ЭталонныйФайл", ИмяФайла);
КонецПроцедуры

//я копирую тестовый файл из каталога ресурсов во временный каталог
Процедура ЯКопируюТестовыйФайлИзКаталогаРесурсовВоВременныйКаталог() Экспорт
	
	Лог.Отладка("Временный каталог: " + БДД.ПолучитьИзКонтекста("ВременныйКаталог"));

	ИмяФайлаИсточник = ОбъединитьПути(БДД.ПолучитьИзКонтекста("КаталогРесурсов"), БДД.ПолучитьИзКонтекста("ТестовыйФайл"));
	ИмяФайлаПриемник = ИмяФайлаВоВременномКаталоге();

	ТестовыйФайл = Новый Файл(ИмяФайлаИсточник);
    Ожидаем.Что(ТестовыйФайл.Существует(), "Тестовый файл '" + ИмяФайлаИсточник + "' не найден!").ЭтоИстина();
	
    КопироватьФайл(ИмяФайлаИсточник, ИмяФайлаПриемник);
	
КонецПроцедуры

//Я выполняю перекодировку тестового файла во временном каталоге
Процедура ЯВыполняюПерекодировкуТестовогоФайлаВоВременномКаталоге() Экспорт
	//Перекодировщик = БДД.ПолучитьИзКонтекста("Перекодировщик");
    Перекодировщик.ПерекодироватьФайл(ИмяФайлаВоВременномКаталоге());	
	//КопироватьФайл(ИмяФайлаВоВременномКаталоге(), ОбъединитьПути(БДД.ПолучитьИзКонтекста("КаталогРесурсов"), "encoded.1s"));
КонецПроцедуры

//Во временном каталоге существует только перекодированный файл
Процедура ВоВременномКаталогеСуществуетТолькоПерекодированныйФайл() Экспорт

	Лог.Отладка("Временный каталог: " + БДД.ПолучитьИзКонтекста("ВременныйКаталог"));

	МассивФайлов = НайтиФайлы(БДД.ПолучитьИзКонтекста("ВременныйКаталог"), "*");

	Ожидаем.Что(МассивФайлов.Количество(), "Должен быть только один файл").Равно(1);

	Ожидаем.Что(МассивФайлов[0].ПолноеИмя, "Полное имя файла").Равно(ИмяФайлаВоВременномКаталоге());

КонецПроцедуры

//размер перекодированного файла равен размеру эталонного файла
Процедура РазмерПерекодированногоФайлаРавенРазмеруЭталонногоФайла() Экспорт
	ПодопытныйФайл = ПолучитьПодопытныйФайл();
	ЭталонныйФайл = ПолучитьЭталонныйФайл();
	Ожидаем.Что(ПодопытныйФайл.Размер(), "Размер перекодированного файла").Равно(ЭталонныйФайл.Размер());
КонецПроцедуры

//содержимое перекодированного файла совпадает с содержимым эталонного файла
Процедура СодержимоеПерекодированногоФайлаСовпадаетССодержимымЭталонногоФайла() Экспорт

	ПроверяемыйТекст = ПрочестьТекстФайлаВКодировке(ИмяФайлаВоВременномКаталоге());
	ЭталонныйТекст = ПрочестьТекстФайлаВКодировке(ИмяЭталонногоФайла());

    Ожидаем.Что(ПроверяемыйТекст, "Перекодированный текст не совпадает с эталонным").Равно(ЭталонныйТекст);

КонецПроцедуры

Функция ИмяФайлаВоВременномКаталоге()
    Возврат ОбъединитьПути(БДД.ПолучитьИзКонтекста("ВременныйКаталог"), БДД.ПолучитьИзКонтекста("ТестовыйФайл"));
КонецФункции

Функция ИмяЭталонногоФайла()
	Возврат ОбъединитьПути(БДД.ПолучитьИзКонтекста("КаталогРесурсов"), БДД.ПолучитьИзКонтекста("ЭталонныйФайл"));
КонецФункции // ИмяЭталонногоФайла()

Функция ПолучитьПодопытныйФайл()
	Возврат ПолучитьФайлСПроверкойСуществования( ИмяФайлаВоВременномКаталоге() );
КонецФункции

Функция ПолучитьЭталонныйФайл()
	Возврат ПолучитьФайлСПроверкойСуществования( ИмяЭталонногоФайла() );
КонецФункции

Функция ПолучитьФайлСПроверкойСуществования(пПолноеИмя)
	Файл = Новый Файл(пПолноеИмя);
	Ожидаем.Что(Файл.Существует(), "Запрошенный файл '" + пПолноеИмя + "' не найден!").ЭтоИстина();
	Возврат Файл;
КонецФункции

Функция ПрочестьТекстФайлаВКодировке(пИмяФайла, пКодировкаСтрокой = "UTF-8")

	Перем Читатель;

	Читатель = Новый ЧтениеТекста(пИмяФайла, пКодировкаСтрокой);
    ТекстовоеСодержимое = Читатель.Прочитать();
	Читатель.Закрыть();

	Возврат ТекстовоеСодержимое;

КонецФункции

Лог = Логирование.ПолучитьЛог("oscript.lib.recoder");

//Лог.УстановитьУровень(УровниЛога.Отладка);
//
