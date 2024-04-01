--недозвон, отказ, успех
--create type sales.call_result as enum('missed', 'failure', 'success', );

--холодный, по заявке, по сделке
--create type sales.call_type as enum('cold', 'request', 'deal');

--первичные продажи, повторные продажи
--create type sales.deal_type as enum('primary', 'repeat');

--оплачен, частично оплачен, не оплачен
--create type sales.invoice_status as enum('paid', 'partially paid', 'not paid');

--sales

CREATE OR REPLACE VIEW sales.employee_position_count_view AS
SELECT
    position.id AS position_id,
    position.name AS position_name,
    COUNT(employee.id) AS employee_count
FROM
    position
LEFT JOIN
    employee ON position.id = employee.id_position
GROUP BY
    position.id, position.name;


   
create table if not exists sales.position (
	name varchar(100) not null,
	id serial2 primary key
);

create table if not exists sales.employee (
	name varchar(100) not null,
	id serial2 primary key,
	phone varchar(20),
	email varchar(50),
	id_position int2 not null references sales.position(id)
);

create table if not exists sales.call_result (
	name varchar(20) not null,
	id serial2 primary key
);

create table if not exists sales.call_type (
	name varchar(20) not null,
	id serial2 primary key
);

create table if not exists sales.call (
	id_employee int2 not null references sales.employee(id),
	start_at date not null,
	end_at date not null,
	path_recorded varchar(255) not null,
	comment text null,
	rate int2 null,
	id_result int2 not null references sales.call_result(id),
	id_type int2 not null references sales.call_type(id),
	id serial2 primary key
);

create table if not exists sales.deal_source (
	name varchar(20) not null,
	id serial2 primary key
);

create table if not exists sales.deal_status (
	name varchar(50) not null,
	id serial2 primary key
);

create table if not exists sales.deal_type (
	name varchar(20) not null,
	id serial2 primary key
);

create table if not exists sales.city (
	name varchar(100) not null,
	id serial2 primary key
);

create table if not exists sales.partner (
	id_city int2 not null references sales.city(id),
	phone varchar(20) null,
	email varchar(50) null,
	director_name varchar(100) null,
	partner_name varchar(100) not null,
	created_at date not null,
	id serial2 primary key,
	id_employee int2 not null references sales.employee(id)
);

create table if not exists sales.partner_responsible (
	name varchar(100) not null,
	phone varchar(20) null,
	email varchar(50) null,
	id_partner int2 not null references sales.partner(id),
	id serial2 primary key
);

create table if not exists sales.deal (
	created_at date not null,
	closed_at date,
	id_status int2 not null references sales.deal_status(id),
	id_type int2 not null references sales.deal_type(id),
	id_source int2 references sales.deal_source(id),
	id_partner_responsible int2 not null references sales.partner_responsible(id),
	id_employee int2 not null references sales.employee(id),
	id serial2 primary key
);

create table if not exists sales.product_type (
	name varchar(20) null,
	id serial2 primary key
);

create table if not exists sales.product (
	name varchar(50) not null,
	id_product_type int2 not null references sales.product_type(id),
	count int2 not null,
	description text null,
	price_per_piece float4 not null,
	id serial2 primary key
);

create table if not exists sales.deal_detail (
	id_deal int2 not null references sales.deal(id),
	id_product int2 not null references sales.product(id),
	count int2 not null,
	id serial2 primary key
);

create table if not exists sales.invoice_status (
	name varchar(20) not null,
	id serial2 primary key
);

create table if not exists sales.invoice (
	id_deal int2 not null references sales.deal(id),
	due date not null,
	id_status int2 not null references sales.invoice_status(id),
	id serial2 primary key
);

create table if not exists sales.payment (
	created_at date not null,
	amount float4 not null,
	id serial2 primary key,
	id_invoice int2 not null references sales.invoice(id)
);

--staging

create table if not exists staging.position (
	name varchar(100),
	id serial2
);

create table if not exists staging.employee (
	name varchar(100),
	id serial2,
	phone varchar(20),
	email varchar(50),
	id_position int2
);

create table if not exists staging.call_result (
	name varchar(20),
	id serial2
);

create table if not exists staging.call_type (
	name varchar(20),
	id serial2
);

create table if not exists staging.call (
	id_employee int2,
	start_at date,
	end_at date,
	path_recorded varchar(255),
	comment text,
	rate int2,
	id_result int2,
	id_type int2,
	id serial2
);

create table if not exists staging.deal_source (
	name varchar(20),
	id serial2
);

create table if not exists staging.deal_status (
	name varchar(50),
	id serial2
);

create table if not exists staging.deal_type (
	name varchar(20),
	id serial2
);

create table if not exists staging.city (
	name varchar(100),
	id serial2,
	lat numeric(9, 6),
	long numeric(9, 6)
);

create table if not exists staging.partner (
	id_city int2,
	phone varchar(20),
	email varchar(50),
	director_name varchar(100),
	partner_name varchar(100),
	created_at date,
	id serial2,
	id_employee int2
);

create table if not exists staging.partner_responsible (
	name varchar(100),
	phone varchar(20),
	email varchar(50),
	id_partner int2,
	id serial2
);

create table if not exists staging.deal (
	created_at date,
	closed_at date,
	id_status int2,
	id_type int2,
	id_source int2,
	id_partner_responsible int2,
	id_employee int2,
	id serial2
);

create table if not exists staging.product_type (
	name varchar(20),
	id serial2
);

create table if not exists staging.product (
	name varchar(50),
	id_product_type int2,
	count int2,
	description text,
	price_per_piece float4,
	id serial2
);

create table if not exists staging.deal_detail (
	id_deal int2,
	id_product int2,
	count int2,
	id serial2
);

create table if not exists staging.invoice_status (
	name varchar(20),
	id serial2
);

create table if not exists staging.invoice (
	id_deal int2,
	due date,
	id_status int2,
	id serial2
);

create table if not exists staging.payment (
	created_at date,
	amount float4,
	id serial2,
	id_invoice int2
);

--load staging

drop procedure if exists staging.position_load();
create procedure staging.position_load()
as $$
	begin
		truncate table staging.position;

        insert into staging.position(id, name)
        select id, name
        from sales.position;
	end;
$$ language plpgsql;

drop procedure if exists staging.employee_load();
create procedure staging.employee_load()
as $$
	begin
		truncate table staging.employee;

        insert into staging.employee(name, id, phone, email, id_position)
        select name, id, phone, email, id_position
        from sales.employee;
	end;
$$ language plpgsql;

drop procedure if exists staging.city_load();
create procedure staging.city_load()
as $$
	begin
		truncate table staging.city;

        insert into staging.city(id, name, lat, long)
        select id, name, lat, long
        from sales.city;
	end;
$$ language plpgsql;

drop procedure if exists staging.partner_load();
create procedure staging.partner_load()
as $$
	begin
		truncate table staging.partner;

        insert into staging.partner(id_city, phone, email, director_name, partner_name, created_at, id, id_employee)
        select id_city, phone, email, director_name, partner_name, created_at, id, id_employee
        from sales.partner;
	end;
$$ language plpgsql;

drop procedure if exists staging.partner_responsible_load();
create procedure staging.partner_responsible_load()
as $$
	begin
		truncate table staging.partner_responsible;

        insert into staging.partner_responsible(name, phone, email, id_partner, id)
        select name, phone, email, id_partner, id
        from sales.partner_responsible;
	end;
$$ language plpgsql;

drop procedure if exists staging.product_type_load();
create procedure staging.product_type_load()
as $$
	begin
		truncate table staging.product_type;

        insert into staging.product_type(id, name)
        select id, name
        from sales.product_type;
	end;
$$ language plpgsql;

drop procedure if exists staging.product_load();
create procedure staging.product_load()
as $$
	begin
		truncate table staging.product;

        insert into staging.product(name, id_product_type, count, description, price_per_piece, id)
        select name, id_product_type, count, description, price_per_piece, id
        from sales.product;
	end;
$$ language plpgsql;

drop procedure if exists staging.deal_source_load();
create procedure staging.deal_source_load()
as $$
	begin
		truncate table staging.deal_source;

        insert into staging.deal_source(id, name)
        select id, name
        from sales.deal_source;
	end;
$$ language plpgsql;

drop procedure if exists staging.deal_status_load();
create procedure staging.deal_status_load()
as $$
	begin
		truncate table staging.deal_status;

        insert into staging.deal_status(id, name)
        select id, name
        from sales.deal_status;
	end;
$$ language plpgsql;

drop procedure if exists staging.deal_type_load();
create procedure staging.deal_type_load()
as $$
	begin
		truncate table staging.deal_type;

        insert into staging.deal_type(id, name)
        select id, name
        from sales.deal_type;
	end;
$$ language plpgsql;

drop procedure if exists staging.deal_load();
create procedure staging.deal_load()
as $$
	begin
		truncate table staging.deal;

        insert into staging.deal(created_at, closed_at, id_status, id_type, id_source, id_partner_responsible, id_employee, id)
        select created_at, closed_at, id_status, id_type, id_source, id_partner_responsible, id_employee, id
        from sales.deal;
	end;
$$ language plpgsql;

drop procedure if exists staging.deal_detail_load();
create procedure staging.deal_detail_load()
as $$
	begin
		truncate table staging.deal_detail;

        insert into staging.deal_detail(id_deal, id_product, count, id)
        select id_deal, id_product, count, id
        from sales.deal_detail;
	end;
$$ language plpgsql;

drop procedure if exists staging.invoice_status_load();
create procedure staging.invoice_status_load()
as $$
	begin
		truncate table staging.invoice_status;

        insert into staging.invoice_status(id, name)
        select id, name
        from sales.invoice_status;
	end;
$$ language plpgsql;

drop procedure if exists staging.invoice_load();
create procedure staging.invoice_load()
as $$
	begin
		truncate table staging.invoice;

        insert into staging.invoice(id_deal, due, id_status, id)
        select id_deal, due, id_status, id
        from sales.invoice;
	end;
$$ language plpgsql;

drop procedure if exists staging.payment_load();
create procedure staging.payment_load()
as $$
	begin
		truncate table staging.payment;

        insert into staging.payment(created_at, amount, id, id_invoice)
        select created_at, amount, id, id_invoice
        from sales.payment;
	end;
$$ language plpgsql;

drop procedure if exists staging.call_result_load();
create procedure staging.call_result_load()
as $$
	begin
		truncate table staging.call_result;

        insert into staging.call_result(id, name)
        select id, name
        from sales.call_result;
	end;
$$ language plpgsql;

drop procedure if exists staging.call_type_load();
create procedure staging.call_type_load()
as $$
	begin
		truncate table staging.call_type;

        insert into staging.call_type(id, name)
        select id, name
        from sales.call_type;
	end;
$$ language plpgsql;


drop procedure if exists staging.call_load();
create procedure staging.call_load()
as $$
	begin
		truncate table staging.call;

        insert into staging.call(id_employee, start_at, end_at, path_recorded, comment, rate, id_result, id_type, id)
        select id_employee, start_at, end_at, path_recorded, comment, rate, id_result, id_type, id
        from sales.call;
	end;
$$ language plpgsql;

--core

create table if not exists core.dim_employee (
	pk_employee serial2 primary key,
	id_employee int2,
	name varchar(100)
);

create table if not exists core.dim_partner_responsible (
	pk_partner_responsible serial2 primary key,
	id_partner_responsible int2,
	name varchar(100),
	city varchar(100),
	lat numeric(9, 6),
	long numeric(9, 6)
);

create table if not exists core.dim_product (
	pk_product serial2 primary key,
	id_product int2,
	type varchar(20),
	name varchar(50),
	price_per_piece float4
);

create table if not exists core.dim_date (
  pk_date int primary key,
  date_actual DATE not null,
  epoch BIGINT not null,
  day_suffix VARCHAR(4) not null,
  day_name VARCHAR(15) not null,
  day_of_week INT not null,
  day_of_month INT not null,
  day_of_quarter INT not null,
  day_of_year INT not null,
  week_of_month INT not null,
  week_of_year INT not null,
  week_of_year_iso CHAR(10) not null,
  month_actual INT not null,
  month_name VARCHAR(10) not null,
  month_name_abbreviated CHAR(3) not null,
  quarter_actual INT not null,
  quarter_name VARCHAR(10) not null,
  year_actual INT not null,
  first_day_of_week DATE not null,
  last_day_of_week DATE not null,
  first_day_of_month DATE not null,
  last_day_of_month DATE not null,
  first_day_of_quarter DATE not null,
  last_day_of_quarter DATE not null,
  first_day_of_year DATE not null,
  last_day_of_year DATE not null,
  mmyyyy CHAR(6) not null,
  mmddyyyy CHAR(10) not null,
  weekend_indr BOOLEAN not null
);

create table if not exists core.fact_call (
	id_call int2,
	pk_call serial2 primary key,
	fk_call_date int4 references core.dim_date(pk_date),
	fk_employee int2 references core.dim_employee(pk_employee),
	type varchar(20),
	result varchar(20),
	rate int2
);

create table if not exists core.fact_deal (
	pk_deal serial2 primary key,
	id_deal int2,
	fk_employee int2 references core.dim_employee(pk_employee),
	fk_partner_responsible int2 references core.dim_partner_responsible(pk_partner_responsible),
	fk_close_date int4 references core.dim_date(pk_date),
	fk_open_date int4 references core.dim_date(pk_date),
	fk_product int2 references core.dim_product(pk_product),
	type varchar(20),
	source varchar(20),
	status varchar(50),
	amount float4
--	invoice_due date,
--	invoice_status varchar(20),
--	paid float4
);

create table if not exists core.fact_partner (
	pk_partner serial2 primary key,
	id_partner int2,
	fk_employee int2 references core.dim_employee(pk_employee),
	fk_creation_date int4 references core.dim_date(pk_date)
);

--create table if not exists core.fact_invoice (
--	pk_invoice serial2 primary key,
--	id_invoice int2,
--	fk_employee int2 references core.dim_employee(pk_employee),
--	invoice_status varchar(20),
--	is_expired boolean,
--	paid float4,
--	debt float4
--);

--load core

create or replace procedure core.load_employee()
as $$
	begin
		truncate table core.dim_employee cascade;
	
		insert into core.dim_employee(id_employee, name)
		select e.id, e.name from staging.employee e;
	end
$$ language plpgsql;

create or replace procedure core.load_partner_responsible()
as $$
	begin
		truncate table core.dim_partner_responsible cascade;
	
		insert into core.dim_partner_responsible(id_partner_responsible, name, city, lat, long)
		select pr.id, pr.name, c.name, c.lat, c.long from staging.partner_responsible pr
		join staging.partner p on p.id = pr.id_partner
		join staging.city c on c.id = p.id_city;
	end
$$ language plpgsql;

create or replace procedure core.load_product()
as $$
	begin
		truncate table core.dim_product cascade;
	
		insert into core.dim_product(id_product, name, type, price_per_piece)
		select p.id, p.name, pt.name, p.price_per_piece from staging.product p
		join staging.product_type pt on pt.id = p.id_product_type;
	end
$$ language plpgsql;

create or replace procedure core.load_date()
as $$
	begin
		set lc_time = 'ru_RU';
		INSERT INTO core.dim_date
		SELECT TO_CHAR(datum, 'yyyymmdd')::INT AS date_pk,
		       datum AS date_actual,
		       EXTRACT(EPOCH FROM datum) AS epoch,
		       TO_CHAR(datum, 'fmDDth') AS day_suffix,
		       TO_CHAR(datum, 'TMDay') AS day_name,
		       EXTRACT(ISODOW FROM datum) AS day_of_week,
		       EXTRACT(DAY FROM datum) AS day_of_month,
		       datum - DATE_TRUNC('quarter', datum)::DATE + 1 AS day_of_quarter,
		       EXTRACT(DOY FROM datum) AS day_of_year,
		       TO_CHAR(datum, 'W')::INT AS week_of_month,
		       EXTRACT(WEEK FROM datum) AS week_of_year,
		       EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) AS week_of_year_iso,
		       EXTRACT(MONTH FROM datum) AS month_actual,
		       TO_CHAR(datum, 'TMMonth') AS month_name,
		       TO_CHAR(datum, 'Mon') AS month_name_abbreviated,
		       EXTRACT(QUARTER FROM datum) AS quarter_actual,
		       CASE
		           WHEN EXTRACT(QUARTER FROM datum) = 1 THEN 'First'
		           WHEN EXTRACT(QUARTER FROM datum) = 2 THEN 'Second'
		           WHEN EXTRACT(QUARTER FROM datum) = 3 THEN 'Third'
		           WHEN EXTRACT(QUARTER FROM datum) = 4 THEN 'Fourth'
		           END AS quarter_name,
		       EXTRACT(YEAR FROM datum) AS year_actual,
		       datum + (1 - EXTRACT(ISODOW FROM datum))::INT AS first_day_of_week,
		       datum + (7 - EXTRACT(ISODOW FROM datum))::INT AS last_day_of_week,
		       datum + (1 - EXTRACT(DAY FROM datum))::INT AS first_day_of_month,
		       (DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE AS last_day_of_month,
		       DATE_TRUNC('quarter', datum)::DATE AS first_day_of_quarter,
		       (DATE_TRUNC('quarter', datum) + INTERVAL '3 MONTH - 1 day')::DATE AS last_day_of_quarter,
		       TO_DATE(EXTRACT(YEAR FROM datum) || '-01-01', 'YYYY-MM-DD') AS first_day_of_year,
		       TO_DATE(EXTRACT(YEAR FROM datum) || '-12-31', 'YYYY-MM-DD') AS last_day_of_year,
		       TO_CHAR(datum, 'mmyyyy') AS mmyyyy,
		       TO_CHAR(datum, 'mmddyyyy') AS mmddyyyy,
		       CASE
		           WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE
		           ELSE FALSE
		           END AS weekend_indr
		FROM (SELECT '2023-01-01'::DATE + SEQUENCE.DAY AS datum
		      FROM GENERATE_SERIES(0, 2000) AS SEQUENCE (DAY)
		      GROUP BY SEQUENCE.DAY) DQ
		ORDER BY 1;
	end
$$ language plpgsql;

create or replace procedure core.load_call()
as $$
	begin
		truncate table core.fact_call;
	
		insert into core.fact_call(id_employee, name)
		select e.id, e.name from staging.employee e;
	end
$$ language plpgsql;

create or replace procedure core.load_product()
as $$
	begin
		truncate table core.dim_product cascade;
	
		insert into core.dim_product(id_product, type, name, price_per_piece)
		select p.id, pt.name, p.name, p.price_per_piece from staging.product p
		join staging.product_type pt on pt.id = p.id_product_type;
	end
$$ language plpgsql;

create or replace procedure core.load_call()
as $$
	begin
		truncate table core.fact_call;
	
		insert into core.fact_call(id_call, fk_call_date, fk_employee, type, result, rate)
		select c.id, dd.pk_date, de.pk_employee, ct.name, cr.name, c.rate from staging.call c
		join staging.call_type ct on ct.id = c.id_type
		join staging.call_result cr on cr.id = c.id_result
		join core.dim_employee de on de.id_employee = c.id_employee
		join core.dim_date dd on dd.date_actual = c.start_at::date;
	end
$$ language plpgsql;

create or replace procedure core.load_deal()
as $$
	begin
		truncate table core.fact_deal;
		
--		create temporary table payment_summary AS
--	    select
--	        i.id_deal,
--	        is2.name as invoice_status,
--	        i.due as due,
--	        COALESCE(SUM(p.amount), 0) as paid
--	    from
--	        staging.invoice i
--	    join
--	        staging.invoice_status is2 on is2.id = i.id_status
--	    left join
--	        staging.payment p on i.id = p.id_invoice
--	    group by
--	        i.id_deal, is2.name, i.due;
--	       
--		insert into core.fact_deal(
--			id_deal, fk_employee, fk_close_date, fk_open_date, fk_product, amount,
--			invoice_due, invoice_status, paid
--		)
--		select 
--			d.id, de.pk_employee, dd_close.pk_date, dd_create.pk_date, dp.pk_product,
--			dd.count * dp.price_per_piece,
--			ps.due, ps.invoice_status, ps.paid
--		from staging.deal d
--		join staging.deal_source ds on ds.id = d.id_source
--		join core.dim_employee de on de.id_employee = d.id_employee
--		left join core.dim_date dd_close on dd_close.date_actual = d.closed_at::date
--		join core.dim_date dd_create on dd_create.date_actual = d.created_at::date
--		join staging.deal_detail dd on dd.id_deal = d.id
--		join core.dim_product dp on dp.id_product = dd.id_product
--		left join payment_summary ps on d.id = ps.id_deal;
		insert into core.fact_deal(
			id_deal, fk_employee, fk_close_date, fk_open_date, fk_product, amount, fk_partner_responsible, type, source, status
		)
		select 
			d.id, de.pk_employee, dd_close.pk_date, dd_create.pk_date, dp.pk_product,
			dd.count * dp.price_per_piece, dpr.pk_partner_responsible, dt.name, ds.name, dst.name
		from staging.deal d
		join staging.deal_source ds on ds.id = d.id_source
		join staging.deal_status dst on dst.id = d.id_status
		join staging.deal_type dt on dt.id = d.id_type
		join core.dim_employee de on de.id_employee = d.id_employee
		join core.dim_partner_responsible dpr on dpr.id_partner_responsible = d.id_partner_responsible
		left join core.dim_date dd_close on dd_close.date_actual = d.closed_at::date
		join core.dim_date dd_create on dd_create.date_actual = d.created_at::date
		join staging.deal_detail dd on dd.id_deal = d.id
		join core.dim_product dp on dp.id_product = dd.id_product;
	end
$$ language plpgsql;

create or replace procedure core.load_partner()
as $$
	begin
		truncate table core.fact_partner;
	
		insert into core.fact_partner(id_partner, fk_employee, fk_creation_date)
		select p.id, de.pk_employee, dd.pk_date from staging.partner p
		join core.dim_employee de on de.id_employee = p.id_employee
		join core.dim_date dd on dd.date_actual = p.created_at::date;
	end
$$ language plpgsql;

--report

create table if not exists report.call (
	employee_name varchar(100),
	call_count int2,
	call_success_count int2,
	avg_rate float4
);

create table if not exists report.partner (
	employee_name varchar(100),
	count int2
);

create table if not exists report.deal_amount (
	employee_name varchar(100),
	amount float4
);

create table if not exists report.deal_status (
	name varchar(100),
	count int2
);

create table if not exists report.deal_source (
	name varchar(20),
	count int2
);

create table if not exists report.deal_product (
	name varchar(50),
	amount float4
);

create table if not exists report.deal_product_type (
	name varchar(20),
	amount float4
);

create table if not exists report.deal_city (
	name varchar(20),
	amount float4,
	lat numeric(9, 6),
	long numeric(9, 6)
);

--load report

create or replace procedure report.call_calc()
as $$
	begin
		truncate report.call;
	
		insert into report.call(employee_name, call_count, call_success_count, avg_rate)
		select de.name, count(*), sum(CASE WHEN fc.result != 'Недозвон' THEN 1 ELSE 0 END), avg(fc.rate)
		from core.fact_call fc
		join core.dim_employee de on de.pk_employee = fc.fk_employee
		group by de.pk_employee;
	end 
$$ language plpgsql;

create or replace procedure report.partner_calc()
as $$
	begin
		truncate report.partner;
	
		insert into report.partner(employee_name, count)
		select de.name, count(*) from core.fact_partner fp
		join core.dim_employee de on de.pk_employee = fp.fk_employee
		group by de.pk_employee;
	end 
$$ language plpgsql;

create or replace procedure report.deal_amount_calc()
as $$
	begin
		truncate report.deal_amount;
	
		insert into report.deal_amount(employee_name, amount)
		select de.name, sum(fd.amount) from core.fact_deal fd
		join core.dim_employee de on de.pk_employee = fd.fk_employee
		group by de.pk_employee;
	end 
$$ language plpgsql;

create or replace procedure report.deal_source_calc()
as $$
	begin
		truncate report.deal_source;
	
		insert into report.deal_source(name, count)
		select fd.source, count(fd.amount) from core.fact_deal fd
		group by fd.source;
	end 
$$ language plpgsql;

create or replace procedure report.deal_status_calc()
as $$
	begin
		truncate report.deal_status;
	
		insert into report.deal_status(name, count)
		select fd.status, count(fd.amount) from core.fact_deal fd
		group by fd.status;
	end 
$$ language plpgsql;

create or replace procedure report.deal_product_type_calc()
as $$
	begin
		truncate report.deal_product_type;
	
		insert into report.deal_product_type(name, amount)
		select dp.type, sum(fd.amount) from core.fact_deal fd
		join core.dim_product dp on dp.pk_product = fd.fk_product
		group by dp.type;
	end 
$$ language plpgsql;

create or replace procedure report.deal_product_calc()
as $$
	begin
		truncate report.deal_product;
	
		insert into report.deal_product(name, amount)
		select dp.name, sum(fd.amount) from core.fact_deal fd
		join core.dim_product dp on dp.pk_product = fd.fk_product
		group by dp.pk_product;
	end 
$$ language plpgsql;

create or replace procedure report.deal_city_calc()
as $$
	begin
		truncate report.deal_city;
	
		insert into report.deal_city(name, amount, lat, long)
		select dpr.city, count(fd.amount), dpr.lat, dpr.long from core.fact_deal fd
		join core.dim_partner_responsible dpr on dpr.pk_partner_responsible = fd.fk_partner_responsible
		group by dpr.city, dpr.lat, dpr.long;
	end 
$$ language plpgsql;

--full load

create or replace procedure core.full_load()
as $$
	begin
		call staging.position_load();
		call staging.employee_load();
		call staging.city_load();
		call staging.partner_load();
		call staging.partner_responsible_load();
		call staging.product_type_load();
		call staging.product_load();
		call staging.deal_source_load();
		call staging.deal_status_load();
		call staging.deal_type_load();
		call staging.deal_load();
		call staging.deal_detail_load();
		call staging.invoice_status_load();
		call staging.invoice_load();
		call staging.payment_load();
		call staging.call_result_load();
		call staging.call_type_load();
		call staging.call_load();
		
		call core.load_date();
		call core.load_employee();
		call core.load_partner_responsible();
		call core.load_product();
		call core.load_call();
		call core.load_deal();
		call core.load_partner();
	
		call report.call_calc();
		call report.partner_calc();
		call report.deal_amount_calc();
		call report.deal_source_calc();
		call report.deal_status_calc();
		call report.deal_product_type_calc();
		call report.deal_product_calc();
		call report.deal_city_calc();
	
	end
$$ language plpgsql;

call core.full_load();
