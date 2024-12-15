# de-project-sprint-2
Порядок запуска скриптов для создания витрины dwh.customer_report_datamart:
1. DDL_facts_and_meterings_table_completion.sql - Заполнение таблиц-измерений d_craftsman, d_product, d_customer и таблицы фактов f_order из новых источников
2. DDL_facts_and_meterings_table_update.sql - создание таблицы tmp_sources с данными из всех источников, обновление существующих записей и добавление новых в d_craftsman, d_product, d_customer и f_order 
3. DDL_create_table_customer_report_datamart.sql - создание и инкрементальное обновление витрины dwh.customer_report_datamart