## Домашнее задание "Продвинутые методы работы с Terraform"
Директория src содержит итоговый исходный код, код коментился походу выполнения заданий 1-6.

Каждый блок подписан.
### Задание 1-3 - директория TASK1-3
Директория содержит исходный код выполнения заданий 1-3.

Подкаталог Task1 содержит скриншоты результата выполнения задания №1
1. nginx -t.png
2. yandex console.png

Подкаталог Task2-3 содержит скриншоты результата выполнения задания №2-3
1. console module .png
2. state list and rm.png
3. terraform import.png
4. terraform plan.png

Файл vpc_dev_docs.md - документация сгененрированная к модулю vpc_dev по заданию №2

### Задание 4 - директория TASK4
Директория содержит исходный код выполнения заданий 4.

Измененый модуль vpc_dev и доработанный main.tf

Скриншоты выполнения terraform plan:
1. 1 plan.png
2. 2 plan.png
3. 3 plan.png
4. 4 plan.png
5. 5 plan.png

Скриншот выполнения terraform apply - ter apply.png
Скриншоты яндекс консоли:
1. ya console network.png - созданные сети
2. ya console vm.png - созданные вм

### Задание 5  - директория TASK5
Директория содержит исходный код выполнения заданий 5.

Добавлены 2 модуля yandex_mysql_cluster/yandex_mysql_db и доработанный main.tf

Скриншот выполнения terraform apply - 0. terraform apply.png

Скриншоты яндекс консоли:
1. ya console cluster.png - созданный кластер
2. console hosts.png - созданные хосты в разных сетях
3. console subnet.png - подсети
4. user cluster.png - созданный пользователь кластера

### Задание 6  - директория TASK6
Директория содержит исходный код выполнения заданий 6.

Доработанный main.tf и доработанный providers.tf

Скриншоты terraform и яндекс консоли:
1. terraform apply.png
2. ya console.png

### Задание 7  - директория TASK7
Директория содержит скриншоты выполненния задания

Скриншоты terraform и vault:
1. terraform plan.png - считывание секрета и вывод его
2. vault.png - добавленный секрет
3. add secret in vault.png - добавленный новый секрет в vault, не пременялось генерация для пароля, а задавался жестко. 
