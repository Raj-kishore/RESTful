CREATE TABLE category (
	id IDENTITY,
	name VARCHAR(50),
	description VARCHAR(255),
	image_url VARCHAR(50),
	is_active BOOLEAN,
	CONSTRAINT pk_category_id PRIMARY KEY (id) 

);

CREATE TABLE user_detail (
	id IDENTITY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	role VARCHAR(50),
	enabled BOOLEAN,
	password VARCHAR(60),
	email VARCHAR(100),
	contact_number VARCHAR(15),	
	CONSTRAINT pk_user_id PRIMARY KEY(id)
);


CREATE TABLE product (
	id IDENTITY,
	code VARCHAR(20),
	name VARCHAR(50),
	brand VARCHAR(50),
	description VARCHAR(255),
	unit_price DECIMAL(10,2),
	quantity INT,
	is_active BOOLEAN,
	category_id INT,
	supplier_id INT,
	purchases INT DEFAULT 0,
	views INT DEFAULT 0,
	CONSTRAINT pk_product_id PRIMARY KEY (id),
 	CONSTRAINT fk_product_category_id FOREIGN KEY (category_id) REFERENCES category (id),
	CONSTRAINT fk_product_supplier_id FOREIGN KEY (supplier_id) REFERENCES user_detail(id),	
);	

-- the address table to store the user billing and shipping addresses
CREATE TABLE address (
	id IDENTITY,
	user_id int,
	address_line_one VARCHAR(100),
	address_line_two VARCHAR(100),
	city VARCHAR(20),
	state VARCHAR(20),
	country VARCHAR(20),
	postal_code VARCHAR(10),
	is_billing BOOLEAN,
	is_shipping BOOLEAN,
	CONSTRAINT fk_address_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_address_id PRIMARY KEY (id)
);

-- the cart table to store the user cart top-level details
CREATE TABLE cart (
	id IDENTITY,
	user_id int,
	grand_total DECIMAL(10,2),
	cart_lines int,
	CONSTRAINT fk_cart_user_id FOREIGN KEY (user_id ) REFERENCES user_detail (id),
	CONSTRAINT pk_cart_id PRIMARY KEY (id)
);
-- the cart line table to store the cart details

CREATE TABLE cart_line (
	id IDENTITY,
	cart_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	is_available boolean,
	CONSTRAINT fk_cartline_product_id FOREIGN KEY (product_id ) REFERENCES product (id),
	CONSTRAINT pk_cartline_id PRIMARY KEY (id)
);


-- the order detail table to store the order

CREATE TABLE order_detail (
	id IDENTITY,
	user_id int,
	order_total DECIMAL(10,2),
	order_count int,
	shipping_id int,
	billing_id int,
	order_date date,
	CONSTRAINT fk_order_detail_user_id FOREIGN KEY (user_id) REFERENCES user_detail (id),
	CONSTRAINT fk_order_detail_shipping_id FOREIGN KEY (shipping_id) REFERENCES address (id),
	CONSTRAINT fk_order_detail_billing_id FOREIGN KEY (billing_id) REFERENCES address (id),
	CONSTRAINT pk_order_detail_id PRIMARY KEY (id)
);

-- the order item table to store order items

CREATE TABLE order_item (
	id IDENTITY,
	order_id int,
	total DECIMAL(10,2),
	product_id int,
	product_count int,
	buying_price DECIMAL(10,2),
	CONSTRAINT fk_order_item_product_id FOREIGN KEY (product_id) REFERENCES product (id),
	CONSTRAINT fk_order_item_order_id FOREIGN KEY (order_id) REFERENCES order_detail (id),
	CONSTRAINT pk_order_item_id PRIMARY KEY (id)
);


-- adding three categories
INSERT INTO category (name, description,image_url,is_active) VALUES ('Laptop', 'This is description for Laptop category!', 'CAT_1.png', true);
INSERT INTO category (name, description,image_url,is_active) VALUES ('Television', 'This is description for Television category!', 'CAT_2.png', true);
INSERT INTO category (name, description,image_url,is_active) VALUES ('Mobile', 'This is description for Mobile category!', 'CAT_3.png', true);
-- adding three users 
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Raj', 'Kishor', 'ADMIN', true, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'rj@gmail.com', '8888888888');
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Amiya', 'Pani', 'SUPPLIER', true, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'am@gmail.com', '9999999999');
INSERT INTO user_detail 
(first_name, last_name, role, enabled, password, email, contact_number) 
VALUES ('Bharath', 'Teki', 'USER', true, '$2a$06$4mvvyO0h7vnUiKV57IW3oudNEaKPpH1xVSdbie1k6Ni2jfjwwminq', 'bh@gmail.com', '7777777777');


-- adding five products
INSERT INTO product (code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('PRDABC123DEFX', 'iPhone 5s', 'apple', 'This is one of the best phone available in the market right now!', 18000, 5, true, 3, 2, 0, 0 );
INSERT INTO product (code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('PRDDEF123DEFX', 'Samsung s7', 'samsung', 'A smart phone by samsung!', 32000, 2, true, 3, 3, 0, 0 );
INSERT INTO product (code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('PRDPQR123WGTX', 'Google Pixel', 'google', 'This is one of the best android smart phone available in the market right now!', 57000, 5, true, 3, 2, 0, 0 );
INSERT INTO product (code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('PRDMNO123PQRX', ' Macbook Pro', 'apple', 'This is one of the best laptops available in the market right now!', 54000, 3, true, 1, 2, 0, 0 );
INSERT INTO product (code, name, brand, description, unit_price, quantity, is_active, category_id, supplier_id, purchases, views)
VALUES ('PRDABCXYZDEFX', 'Dell Latitude E6510', 'dell', 'This is one of the best laptop series from dell that can be used!', 48000, 5, true, 1, 3, 0, 0 );
-- adding a supplier correspondece address
INSERT INTO address( user_id, address_line_one, address_line_two, city, state, country, postal_code, is_billing, is_shipping) 
VALUES (4, '102 Sabarmati Society, Mahatma Gandhi Road', 'Near Salt Lake, Gandhi Nagar', 'Ahmedabad', 'Gujarat', 'India', '111111', true, false );
-- adding a cart for testing 
INSERT INTO cart (user_id, grand_total, cart_lines) VALUES (4, 0, 0);


-- Tables created by Amiya
CREATE TABLE MERCHANTS(
	MERCHANTS_ID NUMBER NOT NULL,
	MERCHANTS_NAME VARCHAR2(250) NOT NULL,
	MERCHANTS_CATEGORY VARCHAR2(250) NOT NULL,
	CONSTRAINT MERCHANTS_PK PRIMARY KEY (MERCHANTS_ID)
);


CREATE TABLE ONLINE_OFFER(
	OFFER_ID NUMBER NOT NULL,
	OFFER_NAME VARCHAR2(1000) NOT NULL,
	OFFER_DESCRIPTION CLOB,
	OFFER_LINK CLOB
	OFFER_COUPON_CODE VARCHAR2(100),
	MERCHANTS_ID NUMBER
	CONSTRAINT ONLINE_OFFER_PK PRIMARY KEY (OFFER_ID)
	CONSTRAINT ONLINE_OFFER_FK FOREIGN KEY (MERCHANTS_ID) REFERENCES MERCHANTS(MERCHANTS_ID)
);


CREATE TABLE GIFT_CARD(
	GIFT_CARD_ID NUMBER NOT NULL,
	GIFT_CARD_VALUE NUMBER NOT NULL,
	GIFT_CARD_CASHBACK NUMBER,
	GIFT_CARD_VALIDITY NUMBER NOT NULL,
	MERCHANTS_ID NUMBER,
	CONSTRAINT GIFT_CARD_PK PRIMARY KEY (GIFT_CARD_ID)
	CONSTRAINT GIFT_CARD_FK FOREIGN KEY (MERCHANTS_ID) REFERENCES MERCHANTS(MERCHANTS_ID)
);


CREATE TABLE USER(
	USER_ID NUMBER NOT NULL,
	USER_NAME VARCHAR2 NOT NULL,
	USER_EMAIL VARCHAR2 NOT NULL,
	USER_PASS VARCHAR2 NOT NULL,
	CONSTRAINT USER_PK PRIMARY KEY (USER_ID)
);
CREATE TABLE USERS_CART(
	USER_ID NUMBER NOT NULL,
	USER_NAME VARCHAR2 NOT NULL,
	USER_EMAIL VARCHAR2 NOT NULL,
	USER_PASS VARCHAR2 NOT NULL,
	CONSTRAINT USER_PK PRIMARY KEY (USER_ID)
);

CREATE TABLE PURCHASE_ORDER (
	PURCHASE_ID NUMBER NOT NULL,
    USER_ID NUMBER NOT NULL,
    USER_NAME
    USER_EMAIL
	GIFT_CARD_ID NUMBER NOT NULL,
    TIME_STAMP DATE,
    STATUS
	CONSTRAINT PURCHASE_ORDER_PK PRIMARY KEY (PURCHASE_ID)
);

