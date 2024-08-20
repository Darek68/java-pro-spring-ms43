Для начала работы с проектом:
Проинсталировать Docker.
Запустить \dev\docker\docker-compose.yml
В Docker-клиенте убедится что запустился Postgres и Wiremock-service.
Подключиться любым клиентом к БД Postgres запущенной из Docker'a.
Выполнить скрипт \dev\init-transfers-history.sql для заполнения БД историей переводов.
Убедится что таблица transfers заполнилась 100 записями.
