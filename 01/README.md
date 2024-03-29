# Домашнее задание к занятию «Введение в Terraform»
------

### Чек-лист готовности к домашнему заданию
Файл - HW-1-CheckList 1.5.7 ter.png

------
### Задание 1
Папка TASK 1 - скриншоты выполнения и файлы конфигурации terraform
1. Task1-password.png - конкретный ключ и его значения
2. main.tf и Task1 - ter - docker ps.png - исправленный код и скринштон docker ps
3. Task1 - ter - auto-approve.png - скриншот после применения -auto-approve 
4. Task1 - ter-destroy.png  и (after destroy) terraform.tfstate - скриншот и файл terraform.state после удаления ресурсов
5. Task1-Answers.md - ответы на вопросы из заданаия №1, также приложены ниже.


Ответы на поставленные вопросы в задании:
#### Вопрос: В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?
Ответ:
.tfvars файлы используются для определения переменных, которые могут быть загружены при выполнении Terraform плана или применении.
Файл с именем personal.auto.tfvars исключается из отслеживания Git. 
Это означает, что данный файл не будет добавлен в репозиторий при коммите, что делает его отличным местом для хранения секретной информациию

#### Пометка для себя: 
Файл .terraformrc должен располагаться в корне домашней папки пользователя

#### Вопрос:  В state-файле секретное содержимое созданного ресурса random_password
Ответ: 
Ключ: result Значение: 8uCyNuh7aZD4UMb3


#### Вопрос: Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.
Ответы:
1. Error: Missing name for resource
Ответ: Каждый ресурс в Terraform должен быть идентифицирован типом и именем. В данном случае отсутствует имя ресурса.
Преполагается что будет использоваться образ nginx, тогда исправленная версия будет выглядеть так:
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

2. Error: Invalid resource name
Имя ресурса не может начинаться с цифры. 
Имена ресурсов должны начинаться с буквы или подчеркивания и могут содержать буквы, цифры, подчеркивания.
Дабы измежать путаницы в именах ресурсов предлагаю назвать ресурс так:
resource "docker_container" "nginx_container" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string_FAKE.resulT}"
}

3. Error: Reference to undeclared resource
Ошибка говорит о попытке использования ресурса random_password с именем random_string_FAKE, который не существует в конфигурационном файле.
Правильная ссылка должна быть на атрибут result ресурса random_password с именем random_string:
resource "docker_container" "nginx_container" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"
}

#### Вопрос: Объясните своими словами, в чём может быть опасность применения ключа -auto-approve. Догадайтесь или нагуглите зачем может пригодиться данный ключ?
Ответ: 
Ключ -auto-approve автоматически применяет изменения без предварительного показа плана изменений и запроса на подтверждение от пользователя.
Это может привести к нежелательным изменениям, так как если конфигурация содержит ошибки или непредвиденные изменения, они будут применены без возможности предварительного просмотра и коррекции.
Где это может пригодиться: 
В средах, где изменения тщательно проверяются на предыдущих этапах или в изолированных тестовых средах (где воздействие ошибок миниматльно), 
-auto-approve позволяет автоматизировать процесс применения конфигураций без необходимости ручного вмешательства.
В CI\CD так как обеспечивает бесперебойность процесса деплоя.

#### Вопрос: Объясните, почему при этом не был удалён docker-образ nginx:latest?
Ответ: 
В коде Атрибут keep_locally = true указывает Terraform сохранять образ локально даже после удаления контейнера, который из него создается. 
Это означает, что при выполнении terraform destroy для удаления ресурсов, сам образ nginx:latest не будет удален из локального хранилища Docker из-за явного указания Terraform сохранить его.

Из офф документации: keep_locally (Boolean) If true, then the Docker image wont be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.

------
### Задание 2*
Папка TASK2 - скриншоты выполнения и файлы конфигурации terraform.
1. main.tf - файл конфигурации к облачной ВМ 158.160.150.232, который запускает в контейнере mysql:8
2. terraform.state - файл успешного состояния ресурсов
3. docker exec.png - скришот проверки секретных env в контейнере через команду env
------