# Database_project 
### **Проектирование базы данных MS SQL Server, 3 курс ВМК**
Тема проекта - ***Система автоматизации для пункта проката видеокассет***


Требуется разработать модель программной системы автоматизации работы пункта
проката видеокассет (далее в тексте - системы). 

Пункт проката содержит каталог кассет, имеющихся в наличии в данный момент
времени. Система поддерживает работу каталога, позволяя служащим проката
добавлять новые наименования кассет, удалять старые и редактировать данные о
кассетах.

Клиент, обратившийся в пункт, выбирает кассету по каталогу, вносит залог и забирает ее
на определенный срок. Срок проката, измеряемый в сутках, оговаривается при
выдаче кассеты. Стоимость проката вычисляется системой исходя из тарифа за сутки и
срока проката. Клиент возвращает кассету и оплачивает прокат. Если кассета не
повреждена, клиенту возвращается залог. Служащий пункта проката регистрирует
сдачу кассеты клиенту и ее возврат в системе. Если клиент повредил кассету, то кассета
удаляется из каталога, а залог остается в кассе проката. При необходимости служащий
может запросить у системы следующие данные:

- имеется ли в наличии кассета с данным названием;
- когда будет возвращена какая-либо кассета из тех, что сданы в прокат;
- является ли данный клиент постоянным клиентом пункта проката
(пользовался ли прокатом 5 или более раз).

Постоянным клиентам предоставляются скидки, а также от них принимаются заявки
на пополнение ассортимента кассет. Заявки регистрируются в системе. По ним
готовится итоговый отчет, руководствуясь которым, служащие пункта проката
обновляют ассортимент кассет.

Необходимо разработать схему базы данных для хранения каталога, учетных записей
о прокате кассет и заявок на пополнение ассортимента.
