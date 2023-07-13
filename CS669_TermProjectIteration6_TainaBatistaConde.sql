--DROP TABLES TO MAKE SCRIPT RE-RUNNABLE
DROP TABLE IF EXISTS Gift_price_change;
DROP TABLE IF EXISTS Purchase_store;
DROP TABLE IF EXISTS Gift_purchase;
DROP TABLE IF EXISTS Purchase;
DROP TABLE IF EXISTS Gift_store;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS Registry_Gift;
DROP TABLE IF EXISTS Gift;
DROP TABLE IF EXISTS Registry;
DROP TABLE IF EXISTS Party_guest;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS Baby_shower;
DROP TABLE IF EXISTS Gender;
DROP TABLE IF EXISTS Birthday;
DROP TABLE IF EXISTS Theme;
DROP TABLE IF EXISTS Wedding;
DROP TABLE IF EXISTS Party;
DROP TABLE IF EXISTS Party_type;
DROP TABLE IF EXISTS Dress_code;
DROP TABLE IF EXISTS Account;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS State;
--DROP SEQUENCES TO MAKE SCRIPT RE-RUNNABLE
DROP SEQUENCE IF EXISTS state_seq;
DROP SEQUENCE IF EXISTS address_seq;
DROP SEQUENCE IF EXISTS account_seq ;
DROP SEQUENCE IF EXISTS dress_code_seq ;
DROP SEQUENCE IF EXISTS party_seq ;
DROP SEQUENCE IF EXISTS theme_seq ;
DROP SEQUENCE IF EXISTS gender_seq ;
DROP SEQUENCE IF EXISTS guest_seq ;
DROP SEQUENCE IF EXISTS registry_seq ;
DROP SEQUENCE IF EXISTS gift_seq ;
DROP SEQUENCE IF EXISTS store_seq ;
DROP SEQUENCE IF EXISTS purchase_seq ;
DROP SEQUENCE IF EXISTS price_seq;
DROP SEQUENCE IF EXISTS party_type_seq;
--TABLES
--Replace this with your table creations (including the history table).
CREATE TABLE State(
state_id DECIMAL(12) NOT NULL,
state_name VARCHAR(64) NOT NULL,
PRIMARY KEY (state_id));

CREATE TABLE Address(
address_id DECIMAL(12) NOT NULL,
address_name VARCHAR(64) NOT NULL,
street_address VARCHAR(255) NOT NULL,
city_name VARCHAR(64) NOT NULL,
state_id DECIMAL(12) NOT NULL,
zip_code DECIMAL(5) NOT NULL,
PRIMARY KEY (address_id),
FOREIGN KEY(state_id) REFERENCES State);

CREATE TABLE Account(
account_id DECIMAL(12) NOT NULL,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL,
username VARCHAR(64) NOT NULL,
email VARCHAR(255) NOT NULL,
password_encrypted VARCHAR(255) NOT NULL,
date_of_birth DATE NOT NULL,
address_id DECIMAL(12) NOT NULL,
PRIMARY KEY (account_id),
FOREIGN KEY(address_id) REFERENCES Address
);
CREATE TABLE Dress_Code(
dress_code_id DECIMAL(12) NOT NULL,
dress_code_name VARCHAR(32) NOT NULL,
dress_code_description VARCHAR(1024) NOT NULL,
PRIMARY KEY (dress_code_id)
);
CREATE TABLE Party_type(
type_id DECIMAL(12) NOT NULL,
type_name VARCHAR(32) NOT NULL,
type_abr CHAR(2) NOT NULL,
PRIMARY KEY (type_id)
);
CREATE TABLE Party(
party_id DECIMAL(12) NOT NULL,
account_id DECIMAL(12) NOT NULL,
address_id DECIMAL(12) NOT NULL,
party_name VARCHAR(255) NOT NULL,
start_date_time TIMESTAMP NOT NULL,
end_date_time TIMESTAMP NOT NULL,
number_allowed DECIMAL(12) NOT NULL,
dress_code_id DECIMAL(12),
created_at DATE NOT NULL,
type_id DECIMAL(12) NOT NULL,
PRIMARY KEY (party_id),
FOREIGN KEY(account_id) REFERENCES Account,
FOREIGN KEY(dress_code_id) REFERENCES Dress_code,
FOREIGN KEY(type_id) REFERENCES Party_type
);
CREATE TABLE Wedding(
party_id DECIMAL(12) NOT NULL,
bride_first_name VARCHAR(64) NOT NULL,
bride_last_name VARCHAR(64) NOT NULL,
groom_first_name VARCHAR(64) NOT NULL,
groom_last_name VARCHAR(64) NOT NULL,
PRIMARY KEY (party_id),
FOREIGN KEY (party_id) REFERENCES Party);

CREATE TABLE Theme(
theme_id DECIMAL(12) NOT NULL,
theme_name VARCHAR(64) NOT NULL,
theme_description VARCHAR(400),
PRIMARY KEY (theme_id)
);
CREATE TABLE Birthday(
party_id DECIMAL(12) NOT NULL,
theme_id DECIMAL(12) NOT NULL,
birthday_age DECIMAL(3) NOT NULL,
birthday_person_first_name VARCHAR(64) NOT NULL,
birthday_person_last_name VARCHAR(64) NOT NULL,
PRIMARY KEY (party_id),
FOREIGN KEY (party_id) REFERENCES Party,
FOREIGN KEY (theme_id) REFERENCES Theme);

CREATE TABLE Gender(
gender_id DECIMAL(12) NOT NULL,
gender_name VARCHAR(32) NOT NULL,
PRIMARY KEY (gender_id));

CREATE TABLE Baby_shower(
party_id DECIMAL(12) NOT NULL,
gender_id DECIMAL(12) NOT NULL,
mother_first_name VARCHAR(64) NOT NULL,
mother_last_name VARCHAR(64) NOT NULL,
father_first_name VARCHAR(64) NOT NULL,
father_last_name VARCHAR(64) NOT NULL,
baby_name VARCHAR(64) NOT NULL,
PRIMARY KEY (party_id),
FOREIGN KEY (party_id) REFERENCES Party,
FOREIGN KEY (gender_id) REFERENCES Gender
);
CREATE TABLE Guest(
guest_id DECIMAL(12) NOT NULL,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL,
email VARCHAR(255),
phone_number DECIMAL(10),
PRIMARY KEY (guest_id));

CREATE TABLE Party_guest(
guest_id DECIMAL(12) NOT NULL,
party_id DECIMAL(12) NOT NULL,
confirmation_date DATE,
number_companions_allowed DECIMAL(2) NOT NULL,
companion_to_id DECIMAL(12),
FOREIGN KEY (guest_id) REFERENCES Guest,
FOREIGN KEY (companion_to_id) REFERENCES Guest,
FOREIGN KEY (party_id) REFERENCES Party
);
CREATE TABLE Registry(
registry_id DECIMAL(12) NOT NULL,
party_id DECIMAL(12) NOT NULL,
created_at DATE NOT NULL,
description VARCHAR(400),
PRIMARY KEY (registry_id),
FOREIGN KEY (party_id) REFERENCES Party);

CREATE TABLE Gift(
gift_id DECIMAL(12) NOT NULL,
item_name VARCHAR(64) NOT NULL,
description VARCHAR(1024),
PRIMARY KEY (gift_id));

CREATE TABLE Registry_gift(
registry_id DECIMAL(12) NOT NULL,
gift_id DECIMAL(12) NOT NULL,
quantity DECIMAL(2) NOT NULL,
purchased DECIMAL(2) NOT NULL,
FOREIGN KEY (registry_id) REFERENCES Registry,
FOREIGN KEY(gift_id) REFERENCES Gift);

CREATE TABLE Store(
store_id DECIMAL(12) NOT NULL,
store_name VARCHAR(64) NOT NULL,
store_url VARCHAR(255) NOT NULL,
PRIMARY KEY (store_id));

CREATE TABLE Gift_store(
gift_store_id DECIMAL(12) NOT NULL,
store_id DECIMAL(12) NOT NULL,
gift_id DECIMAL(12) NOT NULL,
price DECIMAL(8,2) NOT NULL,
item_url VARCHAR(1024) NOT NULL,
PRIMARY KEY (gift_store_id),
FOREIGN KEY (store_id) REFERENCES Store,
FOREIGN KEY (gift_id) REFERENCES Gift);

CREATE TABLE Purchase(
purchase_id DECIMAL(12) NOT NULL,
guest_id DECIMAL(12) NOT NULL,
purchase_date DATE NOT NULL,
total_price DECIMAL(8,2) NOT NULL,
PRIMARY KEY (purchase_id),
FOREIGN KEY (guest_id) REFERENCES Guest);

CREATE TABLE Gift_purchase(
purchase_id DECIMAL(12) NOT NULL,
gift_id DECIMAL(12) NOT NULL,
quantity DECIMAL(2) NOT NULL,
purchase_price DECIMAL(8,2) NOT NULL,
FOREIGN KEY (purchase_id) REFERENCES Purchase,
FOREIGN KEY (gift_id) REFERENCES Gift);

CREATE TABLE Purchase_store(
purchase_id DECIMAL(12) NOT NULL,
store_id DECIMAL(12) NOT NULL,
FOREIGN KEY(purchase_id) REFERENCES Purchase,
FOREIGN KEY(store_id) REFERENCES Store);

CREATE TABLE Gift_price_change(
price_change_id DECIMAL(12) NOT NULL,
gift_store_id DECIMAL(12) NOT NULL,
old_price DECIMAL(8,2) NOT NULL,
new_price DECIMAL(8,2) NOT NULL,
updated_at TIMESTAMP NOT NULL,
PRIMARY KEY (price_change_id),
FOREIGN KEY(gift_store_id) REFERENCES Gift_store);

--SEQUENCES
--Replace this with your sequence creations (including the one for the history table).
CREATE SEQUENCE state_seq START WITH 1;
CREATE SEQUENCE address_seq START WITH 1;
CREATE SEQUENCE account_seq START WITH 1;
CREATE SEQUENCE dress_code_seq START WITH 1;
CREATE SEQUENCE party_seq START WITH 1;
CREATE SEQUENCE theme_seq START WITH 1;
CREATE SEQUENCE gender_seq START WITH 1;
CREATE SEQUENCE guest_seq START WITH 1;
CREATE SEQUENCE registry_seq START WITH 1;
CREATE SEQUENCE gift_seq START WITH 1;
CREATE SEQUENCE store_seq START WITH 1;
CREATE SEQUENCE purchase_seq START WITH 1;
CREATE SEQUENCE gift_store_seq START WITH 1;
CREATE SEQUENCE price_change_seq START WITH 1;
CREATE SEQUENCE party_type_seq START WITH 1;

--INDEXES
--Replace this with your index creations.
CREATE UNIQUE INDEX Account_address_idx
ON Account(address_id);
CREATE INDEX Address_state_idx
ON Address(state_id);
CREATE INDEX Party_account_idx
ON Party(account_id);
CREATE INDEX Party_dress_idx
ON Party(dress_code_id);
CREATE INDEX Party_address_idx
ON Party(address_id);
CREATE UNIQUE INDEX Wedding_party_idx
ON Wedding(party_id);
CREATE UNIQUE INDEX Birthday_party_idx
ON Birthday(party_id);
CREATE INDEX Birthday_theme_idx
ON Birthday(theme_id);
CREATE UNIQUE INDEX Baby_shower_party_idx
ON Baby_Shower(party_id);
CREATE INDEX Baby_shower_gender_idx
ON Baby_Shower(gender_id);
CREATE UNIQUE INDEX Registry_party_idx
ON Registry(party_id);
CREATE INDEX Registry_gift_registry_idx
ON Registry_gift(registry_id);
CREATE INDEX Registry_gift_gift_idx
ON Registry_gift(gift_id);
CREATE INDEX Party_guest_party_idx
ON Party_guest(party_id);
CREATE INDEX Party_guest_guest_idx
ON Party_guest(guest_id);
CREATE INDEX Purchase_guest_idx
ON Purchase(guest_id);
CREATE INDEX Gift_Purchase_purchase_idx
ON Gift_Purchase(purchase_id);
CREATE INDEX Gift_Purchase_gift_idx
ON Gift_Purchase(gift_id);
CREATE INDEX Gift_store_gift_idx
ON Gift_store(gift_id);
CREATE INDEX Gift_store_store_idx
ON Gift_store(store_id);
CREATE INDEX Purchase_store_store_idx
ON Purchase_store(store_id);
CREATE INDEX Purchase_store_purchase_idx
ON Purchase_store(purchase_id);
CREATE INDEX Party_guest_confirmation_idx
ON Party_guest(confirmation_date);
CREATE INDEX Gift_store_price_idx
ON Gift_store(price);

CREATE INDEX Account_first_name_idx
ON Account(first_name);
CREATE INDEX Account_last_name_idx
ON Account(last_name);
CREATE INDEX Birthday_first_name_idx
ON Birthday(birthday_person_first_name);
CREATE INDEX Birthday_last_name_idx
ON Birthday(birthday_person_last_name);
--STORED PROCEDURES
--Replace this with your stored procedure definitions.
CREATE OR REPLACE FUNCTION invalid_state_func()
	RETURNS TRIGGER LANGUAGE plpgsql
	AS
	$$
		BEGIN
			RAISE EXCEPTION USING MESSAGE = 'Invalid state name. State name should not contain numbers',
			ERRCODE = 22000;
		END;
	$$;
CREATE OR REPLACE TRIGGER invalid_state_trg
BEFORE UPDATE OR INSERT ON State
FOR EACH ROW WHEN(NEW.state_name ~ '[0-9]+')
EXECUTE PROCEDURE invalid_state_func();

CREATE OR REPLACE FUNCTION invalid_name_func()
	RETURNS TRIGGER LANGUAGE plpgsql
	AS
	$$
		BEGIN
			RAISE EXCEPTION USING MESSAGE = 'Invalid name. First and last names should not contain numbers',
			ERRCODE = 22000;
		END;
	$$;
CREATE OR REPLACE TRIGGER invalid_name_trg
BEFORE UPDATE OR INSERT ON Account
FOR EACH ROW WHEN(NEW.first_name ~ '[0-9]+' OR NEW.last_name ~ '[0-9]+')
EXECUTE PROCEDURE invalid_name_func();

CREATE OR REPLACE PROCEDURE ADD_STATE(state_name_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO State(state_id, state_name)
		VALUES(nextval('state_seq'), state_name_arg);
	END;
$proc$ LANGUAGE plpgsql;
CREATE OR REPLACE PROCEDURE ADD_THEME(theme_name_arg IN VARCHAR, theme_description_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Theme(theme_id, theme_name, theme_description)
		VALUES(nextval('theme_seq'), theme_name_arg, theme_description_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_PARTY_TYPE(type_name_arg IN VARCHAR, type_abr_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Party_type(type_id, type_name, type_abr)
		VALUES(nextval('party_type_seq'), type_name_arg, type_abr_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_ACCOUNT(
	first_name_arg IN  VARCHAR,
	last_name_arg IN VARCHAR,
	username_arg IN VARCHAR,
	email_arg IN VARCHAR,
	password_encrypted_arg IN VARCHAR,
	date_of_birth_arg IN VARCHAR,
	address_name_arg IN VARCHAR,
	street_address_arg IN VARCHAR,
	city_name_arg IN VARCHAR,
	state_name_arg IN VARCHAR,
	zip_code_arg IN DECIMAL)
AS
$proc$
	BEGIN
		INSERT INTO Address(address_id, address_name, street_address, city_name, state_id, zip_code)
		VALUES(nextval('address_seq'), address_name_arg, street_address_arg, city_name_arg, (
			SELECT state_id
			FROM State
			WHERE state_name = state_name_arg
		) , zip_code_arg);
		
		INSERT INTO Account(account_id, first_name, last_name, username, email, password_encrypted, date_of_birth, address_id)
		VALUES(nextval('account_seq'), first_name_arg, last_name_arg, username_arg, email_arg, password_encrypted_arg, 
			   CAST(date_of_birth_arg AS DATE), 
			   currval('address_seq'));
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_DRESS_CODE(dress_code_name_arg IN VARCHAR, dress_code_description_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Dress_code(dress_code_id, dress_code_name, dress_code_description)
		VALUES(nextval('dress_code_seq'), dress_code_name_arg, dress_code_description_arg );
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_WEDDING(
	account_username_arg IN VARCHAR, party_name_arg IN VARCHAR, start_date_time_arg IN VARCHAR, end_date_time_arg IN VARCHAR, 
	number_allowed_arg IN DECIMAL, dress_code_name_arg IN VARCHAR, bride_first_name_arg IN VARCHAR, bride_last_name_arg IN VARCHAR, 
	groom_first_name_arg IN VARCHAR, groom_last_name_arg IN VARCHAR, address_name_arg IN VARCHAR, street_address_arg IN VARCHAR, 
	city_name_arg IN VARCHAR, state_name_arg IN VARCHAR, zip_code_arg IN DECIMAL
) AS
$proc$ 
	BEGIN
		INSERT INTO Address(address_id, address_name, street_address, city_name, state_id, zip_code)
		VALUES(nextval('address_seq'), address_name_arg, street_address_arg, city_name_arg, (
			SELECT state_id
			FROM State
			WHERE state_name = state_name_arg
		) , zip_code_arg);
		INSERT INTO Party(party_id, account_id, address_id, party_name, start_date_time, end_date_time, number_allowed, 
						  dress_code_id, created_at, type_id)
		VALUES(nextval('party_seq'), (
			SELECT account_id
			FROM Account
			WHERE username = account_username_arg
		), currval('address_seq'), party_name_arg, CAST(start_date_time_arg AS TIMESTAMP), CAST(end_date_time_arg AS TIMESTAMP), number_allowed_arg,
		(SELECT dress_code_id
		FROM Dress_code
		WHERE dress_code_name = dress_code_name_arg
		), CURRENT_DATE, (
			SELECT type_id
			FROM Party_type
			WHERE type_abr = 'WE'
		) );
		INSERT INTO Wedding(party_id, bride_first_name, bride_last_name, groom_first_name, groom_last_name)
		VALUES(currval('party_seq'), bride_first_name_arg, bride_last_name_arg, groom_first_name_arg, groom_last_name_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_BIRTHDAY(
	account_username_arg IN VARCHAR, party_name_arg IN VARCHAR, start_date_time_arg IN VARCHAR, end_date_time_arg IN VARCHAR, 
	number_allowed_arg IN DECIMAL, dress_code_name_arg IN VARCHAR, theme_name_arg IN VARCHAR, birthday_person_first_name_arg IN VARCHAR, 
	birthday_person_last_name_arg IN VARCHAR, birthday_age_arg IN DECIMAL, address_name_arg IN VARCHAR, street_address_arg IN VARCHAR, 
	city_name_arg IN VARCHAR, state_name_arg IN VARCHAR, zip_code_arg IN DECIMAL
)
AS
$proc$
	BEGIN
		INSERT INTO Address(address_id, address_name, street_address, city_name, state_id, zip_code)
		VALUES(nextval('address_seq'), address_name_arg, street_address_arg, city_name_arg, (
			SELECT state_id
			FROM State
			WHERE state_name = state_name_arg
		) , zip_code_arg);
		INSERT INTO Party(party_id, account_id, address_id, party_name, start_date_time, end_date_time, number_allowed, dress_code_id, created_at, type_id)
		VALUES(nextval('party_seq'), (
			SELECT account_id
			FROM Account
			WHERE username = account_username_arg
		), currval('address_seq'), party_name_arg, CAST(start_date_time_arg AS TIMESTAMP), CAST(end_date_time_arg AS TIMESTAMP), number_allowed_arg,
		(
			SELECT dress_code_id
			FROM Dress_code
			WHERE dress_code_name = dress_code_name_arg
		), CURRENT_DATE, (
			SELECT type_id
			FROM Party_type
			WHERE type_abr = 'BI'
		));
		INSERT INTO Birthday(party_id, theme_id, birthday_age, birthday_person_first_name, birthday_person_last_name)
		VALUES(currval('party_seq'), (
			SELECT theme_id
			FROM Theme
			WHERE theme_name = theme_name_arg
		), birthday_age_arg, birthday_person_first_name_arg, birthday_person_last_name_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_GENDER(gender_name_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Gender(gender_id, gender_name)
		VALUES(nextval('gender_seq'), gender_name_arg );
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_BABY_SHOWER(
	account_username_arg IN VARCHAR, party_name_arg IN VARCHAR, start_date_time_arg IN VARCHAR, end_date_time_arg IN VARCHAR, 
	number_allowed_arg IN DECIMAL, dress_code_name_arg IN VARCHAR, gender_name_arg IN VARCHAR, mother_first_name_arg IN VARCHAR, 
	mother_last_name_arg IN VARCHAR, father_first_name_arg IN VARCHAR, father_last_name_arg IN VARCHAR, baby_name_arg IN VARCHAR,
	address_name_arg IN VARCHAR, street_address_arg IN VARCHAR, city_name_arg IN VARCHAR, state_name_arg IN VARCHAR, zip_code_arg IN DECIMAL
)
AS
$proc$
	BEGIN
		INSERT INTO Address(address_id, address_name, street_address, city_name, state_id, zip_code)
		VALUES(nextval('address_seq'), address_name_arg, street_address_arg, city_name_arg, (
			SELECT state_id
			FROM State
			WHERE state_name = state_name_arg
		) , zip_code_arg);
		INSERT INTO Party(party_id, account_id, address_id, party_name, start_date_time, end_date_time, number_allowed, dress_code_id, created_at, type_id)
		VALUES(nextval('party_seq'), (
			SELECT account_id
			FROM Account
			WHERE username = account_username_arg
		), currval('address_seq'), party_name_arg, CAST(start_date_time_arg AS TIMESTAMP), CAST(end_date_time_arg AS TIMESTAMP), number_allowed_arg,
		(
			SELECT gender_id
			FROM Gender
			WHERE gender_name = gender_name_arg
		), CURRENT_DATE, (
			SELECT type_id
			FROM Party_type
			WHERE type_abr = 'BS'
		));
		INSERT INTO Baby_shower(party_id, gender_id, mother_first_name, mother_last_name, father_first_name, father_last_name, baby_name)
		VALUES(currval('party_seq'), (
			SELECT gender_id
			FROM Gender
			WHERE gender_name = gender_name_arg
		), mother_first_name_arg, mother_last_name_arg, father_first_name_arg, father_last_name_arg, baby_name_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_GUEST(
	party_name_arg IN VARCHAR, username_arg IN VARCHAR, first_name_arg IN VARCHAR, last_name_arg IN VARCHAR, email_arg IN VARCHAR, 
	phone_number_arg IN DECIMAL, number_companions_allowed_arg IN DECIMAL, companion_to_first_name_arg in VARCHAR, 
	companion_to_last_name_arg IN VARCHAR
)
AS
$proc$
	DECLARE
		companion_to_id_var DECIMAL(12);
	BEGIN
		SELECT guest_id
		INTO companion_to_id_var
		FROM Guest
		WHERE first_name = companion_to_first_name_arg AND last_name = companion_to_last_name_arg;
		
		INSERT INTO Guest(guest_id, first_name, last_name, email, phone_number)
		VALUES(nextval('guest_seq'), first_name_arg, last_name_arg, email_arg, phone_number_arg);
		
		INSERT INTO Party_guest(guest_id, party_id, confirmation_date, number_companions_allowed, companion_to_id)
		VALUES(currval('guest_seq'), (
			SELECT party_id
			FROM Party
			JOIN Account ON Party.account_id = Account.account_id
			WHERE party_name = party_name_arg AND username = username_arg
		), NULL, number_companions_allowed_arg, companion_to_id_var );
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE CONFIRM_GUEST(
	party_name_arg IN VARCHAR, username_arg IN VARCHAR, first_name_arg IN VARCHAR, last_name_arg IN VARCHAR
)
AS
$proc$
	DECLARE
		guest_id_var DECIMAL(12);
		party_id_var DECIMAL(12);
	BEGIN
		SELECT guest_id
		INTO guest_id_var
		FROM Guest
		WHERE first_name = first_name_arg AND last_name = last_name_arg;
		
		SELECT party_id
		INTO party_id_var
		FROM Party
		JOIN Account ON Party.account_id = Account.account_id
		WHERE party_name = party_name_arg AND username = username_arg;
		
		UPDATE Party_guest
		SET confirmation_date = CURRENT_DATE
		WHERE party_id = party_id_var AND guest_id = guest_id_var;
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_REGISTRY( description_arg IN VARCHAR, username_arg IN VARCHAR, party_name_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Registry(registry_id, party_id, created_at, description)
		VALUES(nextval('registry_seq'), (
			SELECT party_id
			FROM Party
			JOIN Account ON Party.account_id = Account.account_id
			WHERE party_name = party_name_arg AND username = username_arg
		), CURRENT_DATE, description_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_GIFT( username_arg IN VARCHAR, party_name_arg IN VARCHAR, item_name_arg IN VARCHAR, description_arg IN VARCHAR, 
									 quantity_arg IN DECIMAL)
AS
$proc$
	DECLARE
		party_id_var DECIMAL(12);
		registry_id_var DECIMAL(12);
	BEGIN
		SELECT party_id
		INTO party_id_var
		FROM Party
		JOIN Account ON Party.account_id = Account.account_id
		WHERE party_name = party_name_arg AND username = username_arg;
		
		SELECT registry_id
		INTO registry_id_var
		FROM Registry
		WHERE party_id = party_id_var;
		
		INSERT INTO Gift(gift_id, item_name, description)
		VALUES( nextval('gift_seq'), item_name_arg , description_arg);
		
		INSERT INTO Registry_gift(registry_id, gift_id, quantity, purchased)
		VALUES(registry_id_var, currval('gift_seq'), quantity_arg, 0 );
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_STORE( store_name_arg IN VARCHAR, store_url_arg IN VARCHAR)
AS
$proc$
	BEGIN
		INSERT INTO Store(store_id, store_name, store_url)
		VALUES(nextval('store_seq'), store_name_arg, store_url_arg);
	END;
$proc$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE ADD_GIFT_TO_STORE( item_name_arg IN VARCHAR, store_url_arg IN VARCHAR, price_arg IN DECIMAL, item_url_arg IN VARCHAR)
AS
$proc$
	DECLARE
		gift_id_var DECIMAL(12);
		store_id_var DECIMAL(12);
	BEGIN
		SELECT gift_id
		INTO gift_id_var
		FROM Gift
		WHERE item_name = item_name_arg;
		
		SELECT store_id
		INTO store_id_var
		FROM Store
		WHERE store_url = store_url_arg;
		
		INSERT INTO Gift_store(gift_store_id, store_id, gift_id, price, item_url)
		VALUES(nextval('gift_store_seq'), store_id_var, gift_id_var, price_arg, item_url_arg);
	END;
$proc$ LANGUAGE plpgsql;
--TRIGGERS
--Replace this with your history table trigger.
CREATE OR REPLACE FUNCTION price_change_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
  BEGIN
   INSERT INTO Gift_price_change( price_change_id, gift_store_id, old_price, new_price, updated_at)
   VALUES(nextval('price_change_seq'),
		  New.gift_store_id,
          OLD.price,
          NEW.price,
          current_date);
	RETURN NEW;
  END;
$$;
CREATE TRIGGER price_change_trig
BEFORE UPDATE OF price ON Gift_store
FOR EACH ROW
EXECUTE PROCEDURE price_change_func();
--INSERTS
--Replace this with the inserts necessary to populate your tables.
--Some of these inserts will come from executing the stored procedures.
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Alabama');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Alaska');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Arizona');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Arkansas');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('California');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Colorado');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Connecticut');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Delaware');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Florida');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Georgia');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Hawaii');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Idaho');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Illinois');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Indiana');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Iowa');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Kansas');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Kentucky');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Louisiana');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Maine');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Maryland');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Massachusetts');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Michigan');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Minnesota');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Mississippi');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Missouri');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Montana');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Nebraska');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Nevada');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('New Hampshire');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('New Jersey');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('New Mexico');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('New York');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('North Carolina');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('North Dakota');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Ohio');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Oklahoma');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Oregon');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Pennsylvania');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Rhode Island');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('South Carolina');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('South Dakota');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Tennessee');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Texas');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Utah');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Vermont');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Virginia');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Washington');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('West Virginia');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Wisconsin');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STATE('Wyoming');
	END$$;
COMMIT TRANSACTION;
--genders
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GENDER('boy');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GENDER('girl');
	END$$;
COMMIT TRANSACTION;

--Dress Codes
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_DRESS_CODE('Casual', 'Casual is a non-dress code, you can wear confortable clothing.');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_DRESS_CODE('Business Casual', 'Business Casual is what people would typically wear to work at the office.');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_DRESS_CODE('Formal', 'Formal dress code includes tuxedos and floor-lengh gowns.');
	END$$;
COMMIT TRANSACTION;

--Birthday themes
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_THEME('Princess', 'Every girl dreams to be a princess...');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_THEME('Pirate', 'Pirates are everywhere looking for the treasure...');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_THEME('Attack on Titans', 'Titans are trying to break the walls...');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_THEME('Las Vegas', 'Glamour, money, elegance...');
	END$$;
COMMIT TRANSACTION;
-- Adding Party types
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_PARTY_TYPE('Wedding', 'WE');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_PARTY_TYPE('Birthday', 'BI');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_PARTY_TYPE('Baby Shower', 'BS');
	END$$;
COMMIT TRANSACTION;

-- adding accounts
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Rebecca', 'Jones', 'rebjones12', 'rebjones@gmail.com', 
					  'BHjbgFtgh7765bJbvGFGHn', '11-SEP-1993', 'Reb NY Home', '9002 Steinway St', 'New York', 'New York', 11103);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Levi', 'Ackerman', 'levi39ackerman', 'leviacke@gmail.com', 
					  'BHjbgFtgh7765bJbvFFFHn', '15-MAR-1989', 'Home', '8976 Johnson Rd.', 'Memphis', 'Tennessee', 20986);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Ana', 'Hickman', 'anaHick998', 'anahickman@gmail.com', 
					  'BHjbgFtghYYY65bJbvFFFHn', '17-MAY-1985', 'Home', '777 History Rd.', 'Denver', 'Colorado', 12345);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Penelope', 'Cruz', 'pepecruz55', 'pepecruz@gmail.com', 
					  'BHjbgFtghYYY65bJbvFFFHn', '16-MAR-1990', 'Home', '123 Castanheira st.', 'Philadelphia', 'Pennsylvania', 56789);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Elias', 'Macedo', 'elimacedo', 'elimacedo@gmail.com', 
					  'BHjbgFtghYYY65bJbvFFFHn', '02-FEB-1992', 'Home', '321 Jackson st.', 'Charleston', 'South Carolina', 66666);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_ACCOUNT('Stephany', 'Brito', 'stebrito', 'stebrito@gmail.com', 
					  'BHjbgFtghYYY65bJbvFFFHn', '07-JUN-1995', 'Home', '456 High Ave.', 'Miami', 'Florida', 33455);
	END$$;
COMMIT TRANSACTION;


--Adding Parties

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_WEDDING('stebrito', 'The Wedding of Ste and Jack','2023-07-18 18:00:00', '2023-07-19 1:00:00', 85, 'Business Casual', 
					  'Stephany', 'Brito', 'Jack', 'Gill', 'The secret garden', '1111 Ocean st.', 'Miami', 'Florida', 33576);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_WEDDING('elimacedo', 'The Wedding of Elias Macedo and Elvira Ferraz','2023-09-25 19:00:00', '2023-09-25 2:00:00', 150, 'Formal', 
					  'Elvira', 'Ferraz', 'Elias', 'Macedo', 'The Lagoon', '1098 Carmelo st.', 'Charleston', 'South Carolina', 66688);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BABY_SHOWER('pepecruz55', 'Mirabel Baby shower', '2023-02-21 13:00:00', '2023-02-21 17:00:00', 20, 'Casual', 
					  'girl', 'Penelope', 'Cruz', 'Antonio', 'Bandeiras', 'Mirabel', 'Vila Giargini', '77 Betomi Dr', 'Philadelphia', 'Pennsylvania', 55555);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_WEDDING('rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris','2023-06-22 19:00:00', '2023-06-23 2:00:00', 90, 'Formal', 
					  'Rebecca', 'Jones', 'Chuck', 'Noris', 'Becca & Chuck Wedding', '44 Park Dr', 'Orlando', 'Florida', 12509);
	END$$;
COMMIT TRANSACTION;


START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BIRTHDAY('rebjones12', 'becca birthday party','2022-12-22 15:00:00', '2022-12-22 19:00:00', 40, 'Formal', 
					  'Las Vegas', 'Rebecca', 'Jones', 29, 'Becca birthday party', '1234 Dunno Dr', 'Philadelphia', 'Pennsylvania', 13245);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BIRTHDAY('levi39ackerman', 'Levi ultimate party','2023-01-08 20:00:00', '2023-01-08 1:00:00', 30, 'Business Casual', 
					  'Attack on Titans', 'Levi', 'Ackerman', 35, 'The Pub', '7614 Polaris St.', 'Memphis', 'Tennessee', 12349);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BIRTHDAY('anaHick998', 'Pietro Birthday','2023-02-08 14:00:00', '2023-02-08 18:00:00', 15, 'Casual', 
					  'Pirate', 'Pietro', 'Hickman', 10, 'Grandma home', '1122 Sheraton St.', 'Denver', 'Colorado', 12346);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BIRTHDAY('anaHick998', 'Ana Birthday','2023-03-14 14:00:00', '2023-03-14 18:00:00', 15, 'Casual', 
					  'Pirate', 'Ana', 'Hickman', 39, 'Paradise Gardens', '123 Cookie Rd.', 'Denver', 'Colorado', 12345);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_BIRTHDAY('anaHick998', 'Marcelo Birthday','2023-02-14 14:00:00', '2023-02-14 18:00:00', 20, 'Casual', 
					  'Attack on Titans', 'Marcelo', 'Hickman', 15, 'Grandma home', '1122 Sheraton St.', 'Denver', 'Colorado', 12346);
	END$$;
COMMIT TRANSACTION;
SELECT * FROM Party;

--Adding Registries
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_REGISTRY( 'We have lived together for a while now and so we have put together a gift 
					   registry of things we need to complete our home and for our new life together.', 'rebjones12', 
					   'The Wedding of Rebecca Jones & Chuck Noris' );
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_REGISTRY( 'Come celebrate my 31st birthday with a lot of food, drinks and...', 'rebjones12', 
					   'becca birthday party' );
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_REGISTRY( 'This party will rock! Here is a gift list if you wish to give me something cool', 'levi39ackerman', 
					   'Levi ultimate party' );
	END$$;
COMMIT TRANSACTION;

SELECT * FROM Registry;

--Adding gifts
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris',
				   '3 Piece cookware set', '1 Fry Pan, 1 Wok, 1 Sauce Pan', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris',
				   'Wine Glass', 'Material: crystal / Made in: Thailand/ Volume: 15 onces', 6);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris',
				   'Kitchen Trash Can', 'Soft close, easy to clean trash can that holds up to 20 gallons', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris',
				   '8 Piece Bed Set', '8 Pieces ReversibleFull Bed in a Bag Full Bed Set with Comforters, Sheets, Pillowcases & Shams', 2);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'The Wedding of Rebecca Jones & Chuck Noris',
				   '8 Piece Bed Set', '8 Pieces ReversibleFull Bed in a Bag Full Bed Set with Comforters, Sheets, Pillowcases & Shams', 2);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Liquid Lipstick', 'Maybelline New York Super Stay Matte Ink Liquid Lipstick, Long Lasting High Impact Color, Up to 16H Wear, Self-Starter, Light Red, 0.17 fl.oz', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Liquid Lipstick', 'Maybelline New York Super Stay Matte Ink Liquid Lipstick, Long Lasting High Impact Color, Up to 16H Wear, Self-Starter, Light Red, 0.17 fl.oz', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Scrub Facial Cleanser', 'Solimo Apricot Scrub Facial Cleanser, 6 Ounce', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Scrub Facial Cleanser', 'Solimo Apricot Scrub Facial Cleanser, 6 Ounce', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Crest 3D Whitestrips', 'Professional Effects Plus, Teeth Whitening Strip Kit, 48 Strips (24 Count Pack)', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Crest 3D Whitestrips', 'Professional Effects Plus, Teeth Whitening Strip Kit, 48 Strips (24 Count Pack)', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'rebjones12', 'becca birthday party',
				   'Rechargeable Electric Toothbrush', 'Oral-B Pro Smart Limited Power Rechargeable Electric Toothbrush with (2) Brush Heads and Travel Case, White', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'Robot Vacuum and Mop', 'roborock E5 Mop Robot Vacuum and Mop, Self-Charging Robotic Vacuum Cleaner, 2500Pa Strong Suction, Wi-Fi Connected, APP Control, Works with Alexa, Ideal for Pet Hair, Carpets, Hard Floors (Black)', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'Airpod Pro', 'Apple AirPods Pro (2nd Generation) Wireless Earbuds', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'Shave Gel', 'Skin Therapy Moisturizing Shave Gel for Dry Skin with Lanolin and Olive Butter, 7 Ounce Pack of 3', 1);
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'External Hard Drive', 'WIOTA External Hard Drive 16TB, Portable Hard Drive 16TB - Ultra High-Speed SSD External Hard Drive with Reading Speeds up to 500Mb/s', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'Dress Shoes', 'Bruno Marc Mens Faux Patent Leather Tuxedo Dress Shoes Classic Lace-up Formal Oxford', 1);
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT( 'levi39ackerman', 'Levi ultimate party',
				   'Power Bank', 'Anker 535 Power Bank (PowerCore 20K) with PD 30W Max Output, Power IQ 3.0 Portable Charger, 20,000mAh Battery Pack for iPhone', 1);
	END$$;
COMMIT TRANSACTION;


--Adding the stores
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STORE( 'Amazon', 'https://www.amazon.com');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STORE( 'E-Bay', 'https://www.ebay.com');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_STORE( 'Simple Human', 'https://www.simplehuman.com');
	END$$;
COMMIT TRANSACTION;

--Adding gifts to stores
--Amazon

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Power Bank', 'https://www.amazon.com', 24.50, 'https://www.amazon.com/power-bank');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Dress Shoes', 'https://www.amazon.com', 34.50, 'https://www.amazon.com/shoes');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'External Hard Drive', 'https://www.amazon.com', 108.50, 'https://www.amazon.com/hard-drive');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Shave Gel', 'https://www.amazon.com', 8.50, 'https://www.amazon.com/shave-gel');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Airpod Pro', 'https://www.amazon.com', 229.50, 'https://www.amazon.com/airpod');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Robot Vacuum and Mop', 'https://www.amazon.com', 199.50, 'https://www.amazon.com/robot');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Rechargeable Electric Toothbrush', 'https://www.amazon.com', 79.50, 'https://www.amazon.com/toothbrush');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '3 Piece cookware set', 'https://www.amazon.com', 99.50, 'https://www.amazon.com/3-piece-cookware-set');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Wine Glass', 'https://www.amazon.com', 9.50, 'https://www.amazon.com/wine-glass');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '8 Piece Bed Set', 'https://www.amazon.com', 67.90, 'https://www.amazon.com/8-piece-bed-set');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Liquid Lipstick', 'https://www.amazon.com', 10.00, 'https://www.amazon.com/liquid-lipstick');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Scrub Facial Cleanser', 'https://www.amazon.com', 5.00, 'https://www.amazon.com/scrub');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Crest 3D Whitestrips', 'https://www.amazon.com', 39.00, 'https://www.amazon.com/whitestrips');
	END$$;
COMMIT TRANSACTION;


--Ebay

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Power Bank', 'https://www.ebay.com', 19.50, 'https://www.ebay.com/power-bank');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Dress Shoes', 'https://www.ebay.com', 35.50, 'https://www.ebay.com/shoes');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'External Hard Drive', 'https://www.ebay.com', 115.50, 'https://www.ebay.com/hard-drive');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Shave Gel', 'https://www.ebay.com', 9.50, 'https://www.ebay.com/shave-gel');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Airpod Pro', 'https://www.ebay.com', 219.50, 'https://www.ebay.com/airpod');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Robot Vacuum and Mop', 'https://www.ebay.com', 200.50, 'https://www.ebay.com/robot');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Rechargeable Electric Toothbrush', 'https://www.ebay.com', 75.50, 'https://www.ebay.com/toothbrush');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Crest 3D Whitestrips', 'https://www.ebay.com', 41.50, 'https://www.ebay.com/whitestrips');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '3 Piece cookware set', 'https://www.ebay.com', 102.50, 'https://www.ebay.com/3-piece-cookware-set');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Kitchen Trash Can', 'https://www.ebay.com', 60.00, 'https://www.ebay.com/kitchen-trash-can');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '8 Piece Bed Set', 'https://www.ebay.com', 68.00, 'https://www.ebay.com/8-piece-bed-set');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '8 Piece Bed Set', 'https://www.ebay.com', 68.00, 'https://www.ebay.com/8-piece-bed-set');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Scrub Facial Cleanser', 'https://www.ebay.com', 7.00, 'https://www.ebay.com/scrub');
	END$$;
COMMIT TRANSACTION;


--Simple human
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Power Bank', 'https://www.simplehuman.com', 22.50, 'https://www.simplehuman.com/power-bank');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Dress Shoes', 'https://www.simplehuman.com', 35.00, 'https://www.simplehuman.com/shoes');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'External Hard Drive', 'https://www.simplehuman.com', 110.50, 'https://www.simplehuman.com/hard-drive');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Shave Gel', 'https://www.simplehuman.com', 7.50, 'https://www.simplehuman.com/shave-gel');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Airpod Pro', 'https://www.simplehuman.com', 228.50, 'https://www.simplehuman.com/airpod');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Robot Vacuum and Mop', 'https://www.simplehuman.com', 210.50, 'https://www.simplehuman.com/robot');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Rechargeable Electric Toothbrush', 'https://www.simplehuman.com', 74.50, 'https://www.simplehuman.com/toothbrush');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Crest 3D Whitestrips', 'https://www.simplehuman.com', 50.50, 'https://www.simplehuman.com/whitestrips');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Kitchen Trash Can', 'https://www.simplehuman.com', 75.00, 'https://www.simplehuman.com/kitchen-trash-can');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( '8 Piece Bed Set', 'https://www.simplehuman.com', 63.00, 'https://www.simplehuman.com/8-piece-bed-set');
	END$$;
COMMIT TRANSACTION;
START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Liquid Lipstick', 'https://www.simplehuman.com', 9.00, 'https://www.simplehuman.com/liquid-lipstick');
	END$$;
COMMIT TRANSACTION;

START TRANSACTION;
DO
	$$ BEGIN
	 CALL ADD_GIFT_TO_STORE( 'Scrub Facial Cleanser', 'https://www.simplehuman.com', 6.00, 'https://www.simplehuman.com/scrub');
	END$$;
COMMIT TRANSACTION;

--QUERIES
--Replace this with your queries (including any queries used for data visualizations).
select * from GIFT_STORE
UPDATE Gift_store
SET price = 30
WHERE gift_store_id = 1;

UPDATE Gift_store
SET price = 120.50
WHERE gift_store_id = 8;

UPDATE Gift_store
SET price = 260.50
WHERE gift_store_id = 5;

UPDATE Gift_store
SET price = 215.90
WHERE gift_store_id = 6;

UPDATE Gift_store
SET price = 85.50
WHERE gift_store_id = 7;

UPDATE Gift_store
SET price = 70.50
WHERE gift_store_id = 10;

UPDATE Gift_store
SET price = 9.00
WHERE gift_store_id = 11;

UPDATE Gift_store
SET price = 5.90
WHERE gift_store_id = 12;

UPDATE Gift_store
SET price = 49.90
WHERE gift_store_id = 13;

UPDATE Gift_store
SET price =22.50
WHERE gift_store_id = 14;

UPDATE Gift_store
SET price = 80.99
WHERE gift_store_id = 20;

UPDATE Gift_store
SET price = 47.50
WHERE gift_store_id = 21;

UPDATE Gift_store
SET price = 115.90
WHERE gift_store_id = 22;

UPDATE Gift_store
SET price = 73.99
WHERE gift_store_id = 24;


UPDATE Gift_store
SET price = 8.00
WHERE gift_store_id = 26;

UPDATE Gift_store
SET price = 26.90
WHERE gift_store_id = 27;


UPDATE Gift_store
SET price = 41.90
WHERE gift_store_id = 28;

UPDATE Gift_store
SET price = 116.90
WHERE gift_store_id = 29;

UPDATE Gift_store
SET price = 40.90
WHERE gift_store_id = 15;

UPDATE Gift_store
SET price = 155.90
WHERE gift_store_id = 16;

UPDATE Gift_store
SET price = 9.99
WHERE gift_store_id = 17;

UPDATE Gift_store
SET price = 8.00
WHERE gift_store_id = 30;

UPDATE Gift_store
SET price = 260.50
WHERE gift_store_id = 31;

UPDATE Gift_store
SET price = 220
WHERE gift_store_id = 32;

UPDATE Gift_store
SET price = 76.55
WHERE gift_store_id = 33;

UPDATE Gift_store
SET price = 55.25
WHERE gift_store_id = 34;


UPDATE Gift_store
SET price = 79.90
WHERE gift_store_id = 35;

UPDATE Gift_store
SET price = 118.90
WHERE gift_store_id = 3;

UPDATE Gift_store
SET price = 66.90
WHERE gift_store_id = 36;

UPDATE Gift_store
SET price = 9.90
WHERE gift_store_id = 37;

UPDATE Gift_store
SET price = 8
WHERE gift_store_id = 38;


--Question 1 - List of confirmed Guests
SELECT (Account.first_name || ' ' || Account.last_name) AS account_holder, party_name, 
(Guest.first_name || ' ' || Guest.last_name) AS guest_name, confirmation_date
FROM Account
JOIN Party ON Account.account_id = Party.account_id
JOIN Party_guest ON Party_guest.party_id = Party.party_id
JOIN Guest ON Party_guest.guest_id = Guest.guest_id
WHERE confirmation_date IS NOT NULL
GROUP BY party_name, account_holder, guest_name, confirmation_date;

SELECT (Account.first_name || ' ' || Account.last_name) AS Account_holder, party_name, 
(Guest.first_name || ' ' || Guest.last_name) AS guest_name, confirmation_date
FROM Account
JOIN Party ON Account.account_id = Party.account_id
JOIN Party_guest ON Party_guest.party_id = Party.party_id
JOIN Guest ON Party_guest.guest_id = Guest.guest_id


-- Question 2 - birthday parties for others
CREATE OR REPLACE VIEW names_party_ids AS
SELECT  Account.first_name, Account.last_name, Party.party_id 
FROM Account
JOIN Party ON Account.account_id = Party.account_id

SELECT COUNT(names_party_ids.party_id) AS num_parties_for_others
FROM names_party_ids
JOIN Birthday ON Birthday.party_id = names_party_ids.party_id
WHERE names_party_ids.first_name <> Birthday.birthday_person_first_name OR names_party_ids.last_name <> Birthday.birthday_person_last_name;

SELECT  first_name, last_name, birthday_person_first_name, birthday_person_last_name 
FROM names_party_ids
JOIN Birthday ON Birthday.party_id = names_party_ids.party_id

--Question 3 - Show  number of gifts by price category
CREATE OR REPLACE VIEW Gift_store_by_category AS
SELECT  Gift_store.gift_id, CASE
			WHEN Gift_store.price <= 25 THEN '$0 - $25'
			WHEN Gift_store.price > 25 AND Gift_store.price <= 50 THEN '$25 - $50'
			WHEN Gift_store.price > 50 AND Gift_store.price <= 100 THEN '$50 - $100'
			ELSE '$100 +'
		END AS category, to_char(Gift_store.price, '$999,999.99') AS price, store_name 
FROM Gift_store
JOIN Store ON Gift_store.store_id = Store.store_id
ORDER BY category;

SELECT category, COUNT(item_name) as num_items
FROM Gift_store_by_category
JOIN Gift ON Gift.gift_id = Gift_store_by_category.gift_id
GROUP BY category;

--data visualizations

SELECT CASE
			WHEN Gift_store.price <= 25 THEN '$0 - $25'
			WHEN Gift_store.price > 25 AND Gift_store.price <= 50 THEN '$25 - $50'
			WHEN Gift_store.price > 50 AND Gift_store.price <= 100 THEN '$50 - $100'
			ELSE '$100 +'
		END AS category, to_char(AVG((new_price - old_price) / old_price)*100, '999.99%' ) as price_increase
FROM Gift_price_change
JOIN Gift_Store ON Gift_Store.gift_store_id = Gift_price_change.gift_store_id
WHERE new_price - old_price > 0 AND Gift_price_change.updated_at >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY category
ORDER BY category;
SELECT * FROM Gift_price_change
SELECT * FROM Gift_store
-- registries
CREATE OR REPLACE VIEW min_price_gift AS
SELECT  Registry_gift.registry_id, Gift_store.gift_id, MIN(price) as min_price, quantity
FROM Gift_store
JOIN Registry_gift ON Registry_gift.gift_id = Gift_store.gift_id
GROUP BY Registry_gift.registry_id, Gift_store.gift_id, quantity

SELECT Party.party_name,  SUM(min_price*quantity)
FROM Registry
JOIN min_price_gift ON Registry.registry_id = min_price_gift.registry_id
JOIN Party ON Registry.party_id = Party.party_id
GROUP BY party_name
ORDER BY party_name

SELECT * FROM Party;
-- average number of guests per party type 
SELECT type_name, FLOOR(AVG(number_allowed)) as avg_num_of_guests
FROM Party
JOIN Party_type ON Party.type_id = Party_type.type_id
GROUP BY type_name

-- favorite party type
SELECT type_name as party_type, COUNT(*) as num_parties
FROM Party
JOIN Party_type on Party.type_id = Party_type.type_id
GROUP BY type_name
ORDER BY num_parties DESC;
