#!/usr/bin/python
# -*- coding: utf-8-*-

from grab import Grab
import os

#функция формирования url-адреса
def get_path(task):
    #замена пробелов и символов кириллицы на пустую строку и на латиницу соответственно
    task = task.replace(' ', '')
    task = task.replace('С', 'C')
    task = task.replace('В', 'B')
    task = task.replace('А', 'A')
	
    return "codeforces.ru/problemset/problem/" + task[:len(task)-1] + "/" + task[len(task)-1]

#инициализация рабочего объекта
def get_grabber(url):
    g = Grab()
    return g

#класс данных, извлеченных с ресурса codeforces.ru
class Material():

    #извлечение данных по указанному url, содержащему номер задачи
    def Parse(self, url):
        g = get_grabber(url)
        g.go(url)

        #получение заголовка задачи
        self.header = g.doc.select('//div[@class="title"]')[0].text()
        
	#получение значения ограничения по времени на тест
        self.time_limit = g.doc.select('//div[@class="time-limit"]/div[@class="property-title"]')[0].text() + ": " + g.doc.select('//div[@class="time-limit"]/text()')[0].text()
        
	#получение значения ограничения по русурсам памяти на тест
        self.memory_limit = g.doc.select('//div[@class="memory-limit"]/div[@class="property-title"]')[0].text() + ": " + g.doc.select('//div[@class="memory-limit"]/text()')[0].text()
        
	#получение описания задачи
        self.desc = g.doc.select('//div[@class="problem-statement"]/div[2]')[0].text()
        
	#получение спецификации входных данных
        self.in_spec = g.doc.select('//div[@class="input-specification"]/div[@class="section-title"]')[0].text() + ": " + g.doc.select('//div[@class="input-specification"]/p')[0].text()
        
	#получение спецификации выходных данных
        self.out_spec = g.doc.select('//div[@class="output-specification"]/div[@class="section-title"]')[0].text() + ": " + g.doc.select('//div[@class="output-specification"]/p')[0].text()
        
	#формирование примеров тестов
        self.samples = g.doc.select('//div[@class="sample-tests"]/div[@class="section-title"]')[0].text() + ": "

        #словарь - в качестве ключевого значения содержит входные данные, значение - выходные
        self.tests = {}
        
	#список для хранения примеров всех входных данных
        self.input_keys = []
        
	#строка для формирования одного примера входных данных,
	#в совокупности с остальными(имеющимися) входными данными образует список self.input_keys
        self.input = ''
        
	#список для хранения примеров всех выходных данных
        self.output_values = []
        
	#строка для формирования одного примера выходных данных,
	#в совокупности с остальными(имеющимися) выходными данными образует список self.output_values
        self.output = ''
        
	#список, для хранения 2 элементов:количество строк в одном блоке входных данных
	#и количество строк для соответстующего блока выходных данных
	#эти оба числа рознятся, поэтому для получения соответсвия используется словарь self.kv
        self.arr = []
        self.kv = {}
		
	#стартовая переменная div-элемента входных данных
        self.in_div = 1
        
	#стартовая переменная div-элемента выходных данных
        self.out_div = 2
        
        #инициализация количества примеров входных данных (совпадает с количеством блоков выходных данных)
        self.input_blocks = len(g.doc.select('//div[@class="sample-tests"]/div[@class="sample-test"]/div[@class="input"]'))

        for i in range(self.input_blocks):
            in_rows = len(g.xpath_list('//*[@id="content"]/div[2]/div/div[5]/div[2]/div[' + str(self.in_div) + ']/pre/br'))
            out_rows = len(g.xpath_list('//*[@id="content"]/div[2]/div/div[5]/div[2]/div[' + str(self.out_div) + ']/pre/br'))
            self.arr.append(in_rows)
            self.arr.append(out_rows)
            self.kv[i+1] = self.arr
            self.arr = []
            self.in_div += 2
            self.out_div += 2

        for i in range(self.input_blocks):
            self.in_div = 1
            self.out_div = 2
            for v in self.kv.values():
                self.rows_in_input_block = v[0]
                self.rows_in_output_block = v[1]
                if (self.rows_in_input_block > 1):
                    for j in range(self.rows_in_input_block):
                        self.input = self.input + g.xpath('//*[@id="content"]/div[2]/div/div[5]/div[2]/div[' + str(self.in_div) + ']/pre/text()[' + str(j+1) + ']') + '<br>'
                    self.input_keys.append(self.input)
                    self.input = "" 
                else:
                    self.input = g.xpath('//*[@id="content"]/div[2]/div/div[5]/div[2]/div[' + str(self.in_div) + ']/pre/text()')
                    self.input_keys.append(self.input)
                
                if (self.rows_in_output_block > 1):
                    for k in range(self.rows_in_output_block):
                        self.output = self.output + g.xpath('//div[@class="sample-tests"]/div[@class="sample-test"]/div[' + str(self.out_div) + ']/pre/text()[' + str(k+1) + ']') + '<br>'
                    self.output_values.append(self.output)
                    self.output = ""
                else:
                    self.output = g.xpath('//div[@class="sample-tests"]/div[@class="sample-test"]/div[' + str(self.out_div) + ']/pre/text()')
                    self.output_values.append(self.output)
                self.in_div += 2
                self.out_div += 2
                self.tests[self.input_keys[i]] = self.output_values[i] 
                
    #печать результата отбора данных
    def Print(self, number, path):        
        print ('task number ' + str(number) + ' successfully downloaded to ' + str(path))

    #запись результата отбора данных в html-файл
    #результат - директория записи
    def Write(self, name):    
        
	#формирование html-таблицы для примеров входныых и выходных данных
        table = "<table width='100%' border='1' cellspacing='0'>"
        table += "<tr align='center' valign='middle'>"
        for j in range(2):
            if (j == 0):
                table += "<td><b>входные данные</b></td>"
                table += "<td><b>выходные данные</b></td>"
            else:
                for key in self.tests.keys():
                    table += "<tr align='top' valign='left'>"
                    table += "<td>" + key.encode("utf-8") + "</td>"
                    table += "<td align='top' valign='top'>" + self.tests[key].encode("utf-8") + "</td>"
                    table += "</tr>"
        table += "</tr></table>"
            
	#формирование тела html-файла
        template = "<html><head><title>" + name
        template += "</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'></head><body><h1>"
        template += self.header + "</h1><p>" + self.time_limit + "<br>"
        template += self.memory_limit + "<p>" + self.desc + "<br>"
        template += "<p>" + self.in_spec + "<br>" + self.out_spec + "<p><h2>"
        template += self.samples + "</h2>"
        template += table.decode("utf-8")
        template += "</body></html>"
        
	#создание файла с расширением .html
        basepath = os.path.abspath(os.path.dirname(os.curdir))
        folder = os.path.join(basepath, '../')
        folder = os.path.join(folder, '../')
        folder = os.path.join(folder, './workdir/downloaded_tasks')
        os.chdir(folder)
        name = name + ".html"
        f = open(name, 'w')
        f.write(template.encode("utf-8"))
        f.close()
        return os.path.abspath(os.path.dirname(os.curdir))

#главная функция программы
def main():
    while (int(raw_input('-----Menu-----\n1-input task number\n2-exit\nType command number: ')) != 2):
        #ввод номера задачи с консоли
        no = raw_input('Type task number: ')
	
        #формирование ссылки
        target = get_path(no)
		
        #инициализация объекта данных
        m = Material()
        m.Parse(target)
		
        #запись атрибутов материала в файл с номером задачи - no
        m.Print(no, m.Write(no))

if __name__ == '__main__':
	main()








