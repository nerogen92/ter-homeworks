## Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

#### Задание №1
-Папка TASK1 - решение задания №1, а именно файлы - console.png и curl.png
Ответы на вопросы задания:
- Ошибка service_account_key_file
Не сколь ошибка, сколько потребовалось сгенерировать ключ доступа.
- Ошибка в resource "yandex_compute_instance" "platform", а именно platform_id = "standart-v4"
Из документации яндекса:
```sh
platform_id - (Optional) The type of virtual machine to create. The default is 'standard-v1'.
```
После замены появилась другая ошибка. Ошибка указывает на то, что при создании экземпляра произошла проблема из-за указания недопустимого количества ядер процессора для выбранной платформы "standard-v1". В сообщении об ошибке указано, что на этой платформе допустимы только 2 или 4 ядра, но количество ядер, вероятно, было указано иное.
- Параметр preemptible = true
Preemptible VMs - это ВМ, которые могут быть внезапно завершены по решению облачного провайдера. Они предлагаются по сниженной цене в сравнении с обычными ВМ. Их использование может быть полезным в следующих случаях:
- Параметр core_fraction = 5
Этот параметр определяет долю процессорных ресурсов, выделенных для ВМ в долях от 1 до 100.
___

#### Задание №2
-Папка TASK2:
main.tf - основной файт конфигурации
variable.tf - добавленные новые переменные.
#### Задание № 3-6
-Папка TASK3-6:
vms_platform.tf - новый созданный файл переменных;
Файл Outputs.png  - вывод значений ip-адресов команды terraform output;
В файле locals.tf  описано использование имено каждой ВМ;
В файле variables.tf изменен вид переменных для 6.1 и 6.2 задания
Консоль VM - скриншот консоли яндекс.
Консоль Сети - скриншот консоли яндекс сети.
#### Задание № 7*
Файл консоли - Task7- console.png
```sh 
1. local.test_list[1]
2. length(local.test_list)
3. local.test_map["admin"]
4. ${local.test_map["admin"]} is admin for ${local.test_list[length(local.test_list) - 1]} server based on OS ${local.servers[local.test_list[length(local.test_list) - 1]].image} with ${local.servers[local.test_list[length(local.test_list) - 1]].cpu} vcpu, ${local.servers[local.test_list[length(local.test_list) - 1]].ram} ram and ${length(local.servers[local.test_list[length(local.test_list) - 1]].disks)} virtual disks
```


#### Задание № 8*
Файл Task8.tf
1. Переменная test:
```sh
variable "test" {
type = list(object({
map = map(list(string))
}))
default = [
{
"dev1" = [
"ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
"10.0.1.7",
]
},
{
"dev2" = [
"ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
"10.0.2.29",
]
},
{
"prod1" = [
"ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
"10.0.1.30",
]
},
]
}
```
2. Выражение:
```sh
var.test[0]["dev1"][0]
```
