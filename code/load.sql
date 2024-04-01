INSERT INTO sales.position (id, name)
VALUES
  (1, 'Call-manager'),
  (2, 'Менеджер по новым клиентам'),
  (3, 'Менеджер по действующим клиентам');


INSERT INTO sales.call_result (id, name)
VALUES
  (1, 'Недозвон'),
  (2, 'Отказ'),
  (3, 'Успех');
 
INSERT INTO sales.call_type (id, name)
VALUES
  (1, 'Холодный'),
  (2, 'По заявке'),
  (3, 'По сделке');

INSERT INTO sales.employee ("name", id, phone, email, id_position)
VALUES
  ('Иван Иванов', 1, '+79123456789', 'ivan.ivanov@example.com', 1), -- Call-manager
  ('Мария Петрова', 2, '+79234567890', 'maria.petrova@example.com', 1), -- Call-manager
  ('Алексей Смирнов', 3, '+79345678901', 'alex.smirnov@example.com', 1), -- Call-manager
  ('Елена Козлова', 4, '+79456789012', 'elena.kozlova@example.com', 1), -- Call-manager
  ('Сергей Новиков', 5, '+79567890123', 'sergey.novikov@example.com', 1), -- Call-manager
  ('Анна Кузнецова', 6, '+79678901234', 'anna.kuznetsova@example.com', 2), -- Менеджер по новым клиентам
  ('Павел Соколов', 7, '+79789012345', 'pavel.sokolov@example.com', 2), -- Менеджер по новым клиентам
  ('Ольга Иванова', 8, '+79890123456', 'olga.ivanova@example.com', 2), -- Менеджер по новым клиентам
  ('Дмитрий Петров', 9, '+79901234567', 'dmitry.petrov@example.com', 3), -- Менеджер по действующим клиентам
  ('Наталья Смирнова', 10, '+79012345678', 'natalia.smirnova@example.com', 3), -- Менеджер по действующим клиентам
  ('Артем Козлов', 11, '+79123456789', 'artem.kozlov@example.com', 3); -- Менеджер по действующим клиентам

 
INSERT INTO sales."call" (id_employee, start_at, end_at, path_recorded, comment, rate, id_result, id_type, id)
VALUES
(1, '2024-01-01 09:00:00', '2024-01-01 09:30:00', '/recordings/1.mp3', 'Успешный звонок', 4.5, 3, 2, 1),
(2, '2024-01-01 09:30:00', '2024-01-01 10:00:00', '/recordings/2.mp3', 'Недозвон', 0, 1, 1, 2),
(3, '2024-01-01 10:00:00', '2024-01-01 10:30:00', '/recordings/3.mp3', 'Отказ клиента', 2.5, 2, 3, 3),
(4, '2024-01-01 10:30:00', '2024-01-01 11:00:00', '/recordings/4.mp3', 'Успешный звонок', 4.0, 3, 2, 4),
(5, '2024-01-01 11:00:00', '2024-01-01 11:30:00', '/recordings/5.mp3', 'Холодный звонок', 3.0, 1, 1, 5),
(1, '2024-01-02 09:00:00', '2024-01-02 09:30:00', '/recordings/6.mp3', 'Отказ клиента', 1.5, 2, 3, 6),
(2, '2024-01-02 09:30:00', '2024-01-02 10:00:00', '/recordings/7.mp3', 'По заявке', 3.5, 3, 2, 7),
(3, '2024-01-02 10:00:00', '2024-01-02 10:30:00', '/recordings/8.mp3', 'Успешный звонок', 4.8, 3, 2, 8),
(4, '2024-01-02 10:30:00', '2024-01-02 11:00:00', '/recordings/9.mp3', 'Холодный звонок', 2.5, 1, 1, 9),
(5, '2024-01-02 11:00:00', '2024-01-02 11:30:00', '/recordings/10.mp3', 'По сделке', 4.2, 3, 3, 10),
(1, '2024-01-03 09:00:00', '2024-01-03 09:30:00', '/recordings/11.mp3', 'Холодный звонок', 2.0, 1, 1, 11),
(2, '2024-01-03 09:30:00', '2024-01-03 10:00:00', '/recordings/12.mp3', 'Отказ клиента', 1.0, 2, 3, 12),
(3, '2024-01-03 10:00:00', '2024-01-03 10:30:00', '/recordings/13.mp3', 'Успешный звонок', 4.6, 3, 2, 13),
(4, '2024-01-03 10:30:00', '2024-01-03 11:00:00', '/recordings/14.mp3', 'По сделке', 4.3, 3, 3, 14),
(5, '2024-01-03 11:00:00', '2024-01-03 11:30:00', '/recordings/15.mp3', 'Холодный звонок', 3.2, 1, 1, 15),
(1, '2024-01-04 09:00:00', '2024-01-04 09:30:00', '/recordings/16.mp3', 'По сделке', 4.7, 3, 3, 16),
(2, '2024-01-04 09:30:00', '2024-01-04 10:00:00', '/recordings/17.mp3', 'Холодный звонок', 2.8, 1, 1, 17),
(3, '2024-01-04 10:00:00', '2024-01-04 10:30:00', '/recordings/18.mp3', 'Успешный звонок', 4.9, 3, 2, 18),
(4, '2024-01-04 10:30:00', '2024-01-04 11:00:00', '/recordings/19.mp3', 'По заявке', 3.7, 3, 2, 19),
(5, '2024-01-04 11:00:00', '2024-01-04 11:30:00', '/recordings/20.mp3', 'Отказ клиента', 1.2, 2, 3, 20);

INSERT INTO sales.city (id, name)
VALUES
  (1, 'Москва'),
  (2, 'Санкт-Петербург'),
  (3, 'Екатеринбург'),
  (4, 'Новосибирск');

INSERT INTO sales.partner (id_city, phone, email, director_name, partner_name, created_at, id, id_employee)
VALUES
  (1, '+79101112233', 'mebelgrad_info@example.com', 'Иванов Иван', 'МебельГрад', CURRENT_TIMESTAMP, 1, 1),
  (2, '+79112223344', 'stroymebel_sales@example.com', 'Петров Петр', 'СтройМебель', CURRENT_TIMESTAMP, 2, 2),
  (3, '+79123334455', 'mebelstyle_support@example.com', 'Сидоров Александр', 'МебельСтайл', CURRENT_TIMESTAMP, 3, 3),
  (4, '+79134445566', 'gorodmebel_orders@example.com', 'Николаев Николай', 'ГородМебель', CURRENT_TIMESTAMP, 4, 4),
  (1, '+79145556677', 'eko_mebel_info@example.com', 'Федоров Федор', 'Эко-Мебель', CURRENT_TIMESTAMP, 5, 5),
  (2, '+79156667788', 'line_mebel_sales@example.com', 'Андреев Андрей', 'ЛайнМебель', CURRENT_TIMESTAMP, 6, 6),
  (3, '+79167778899', 'mebel_express_info@example.com', 'Ольгов Олег', 'МебельЭкспресс', CURRENT_TIMESTAMP, 7, 7),
  (4, '+79178889900', 'comfort_mebel_orders@example.com', 'Евгеньев Евгений', 'КомфортМебель', CURRENT_TIMESTAMP, 8, 8),
  (1, '+79189990011', 'lider_mebel_sales@example.com', 'Максимов Максим', 'ЛидерМебель', CURRENT_TIMESTAMP, 9, 9),
  (2, '+79100001122', 'magiya_mebeli_info@example.com', 'Денисов Денис', 'МагияМебели', CURRENT_TIMESTAMP, 10, 10);

INSERT INTO sales.partner_responsible ("name", phone, email, id_partner, id)
VALUES
  ('Александр Петров', '+79101112234', 'alexander_petrov@example.com', 1, 1),
  ('Елена Смирнова', '+79112223345', 'elena_smirnova@example.com', 2, 2),
  ('Сергей Иванов', '+79123334456', NULL, 3, 3),
  ('Ольга Кузнецова', '+79134445567', 'olga_kuznetsova@example.com', 4, 4),
  ('Дмитрий Николаев', '+79145556678', 'dmitry_nikolaev@example.com', 5, 5),
  ('Анастасия Федорова', '+79156667789', NULL, 6, 6),
  ('Артем Сидоров', '+79167778900', 'artem_sidorov@example.com', 7, 7),
  ('Надежда Егорова', '+79178889011', 'nadezhda_egorova@example.com', 8, 8),
  ('Владимир Максимов', '+79189990122', NULL, 9, 9),
  ('Екатерина Денисова', '+79100001233', 'ekaterina_denisova@example.com', 10, 10);
 
INSERT INTO sales.product_type ("name", id)
VALUES
  ('Стулья', 1),
  ('Столы', 2),
  ('Шкафы', 3),
  ('Диваны', 4),
  ('Комоды', 5);

INSERT INTO sales.product
("name", id_product_type, count, description, price_per_piece, id)
VALUES
  ('Стул №1', 1, 50, 'Удобный стул для кухни', 1500, 1),
  ('Стул №2', 1, 30, 'Современный дизайн', 1800, 2),
  ('Стул №3', 1, 20, 'Деревянный стул', 1200, 3),
  ('Стул №4', 1, 40, 'Металлическая рама', 1600, 4),
  ('Стол №1', 2, 15, 'Круглый стол', 5000, 5),
  ('Стол №2', 2, 25, 'Деревянный стол для гостиной', 8000, 6),
  ('Шкаф №1', 3, 10, 'Гардеробный шкаф', 12000, 7),
  ('Шкаф №2', 3, 18, 'Стеклянные дверцы', 15000, 8),
  ('Диван №1', 4, 8, 'Угловой диван', 25000, 9),
  ('Диван №2', 4, 12, 'Мягкий диван для гостиной', 18000, 10),
  ('Комод №1', 5, 22, 'Деревянный комод с выдвижными ящиками', 6000, 11),
  ('Комод №2', 5, 14, 'Металлический комод', 4500, 12);

 INSERT INTO sales.deal_type (id, name)
VALUES
  (1, 'Первичная'),
  (2, 'Повторная');
 
 INSERT INTO sales.deal_source (id, name)
VALUES
  (1, 'Сайт'),
  (2, 'Холодный звонок'),
  (3, 'Реклама');

INSERT INTO sales.deal_status (id, name)
VALUES
  (1, 'Первый контакт'),
  (2, 'Уточнение вопроса'),
  (3, 'Оценка техотдела/Согласование'),
  (4, 'Формирование КП(АК)'),
  (5, 'Заключение договора'),
  (6, 'Закрыта'),
  (7, 'Обработка техотделом'),
  (8, 'Согласование'),
  (9, 'Проиграна');
 
INSERT INTO sales.deal
(created_at, closed_at, id_status, id_type, id_source, id_partner_responsible, id_employee, id)
VALUES
  (CURRENT_TIMESTAMP, NULL, 1, 1, 1, 1, 1, 1),
  (CURRENT_TIMESTAMP, NULL, 2, 1, 2, 2, 3, 2),
  (CURRENT_TIMESTAMP, NULL, 3, 2, 3, 3, 4, 3),
  (CURRENT_TIMESTAMP, NULL, 4, 2, 1, 4, 5, 4),
  (CURRENT_TIMESTAMP, NULL, 5, 1, 2, 5, 6, 5),
  (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 6, 1, 3, 6, 7, 6),
  (CURRENT_TIMESTAMP, NULL, 7, 2, 3, 7, 8, 7);


INSERT INTO sales.deal_detail
(id_deal, id_product, count, id)
VALUES
  (1, 1, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  (1, 4, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (2, 2, 3, nextval('sales.deal_detail_id_seq'::regclass)),
  (2, 5, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (3, 3, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  (3, 6, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (4, 1, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  (4, 4, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (5, 2, 3, nextval('sales.deal_detail_id_seq'::regclass)),
  (5, 5, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (6, 3, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  (6, 6, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  
  (7, 4, 2, nextval('sales.deal_detail_id_seq'::regclass)),
  (7, 5, 1, nextval('sales.deal_detail_id_seq'::regclass)),
  (7, 2, 1, nextval('sales.deal_detail_id_seq'::regclass));

INSERT INTO sales.invoice_status (id, name)
VALUES
  (1, 'Оплачен'),
  (2, 'Частично оплачен'),
  (3, 'Не оплачен');

 INSERT INTO sales.invoice
(id_deal, due, id_status, id)
values(6, '2024-02-01'::date, 2, 1);

INSERT INTO sales.payment
(created_at, amount, id, id_invoice)
values
	(CURRENT_TIMESTAMP, 5500, 1, 1),
	(CURRENT_TIMESTAMP, 2300, 2, 1);