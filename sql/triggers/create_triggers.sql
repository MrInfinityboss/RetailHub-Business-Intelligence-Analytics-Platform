CREATE OR REPLACE FUNCTION fn_update_inventory_timestamp()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$

BEGIN

NEW.last_stock_update = CURRENT_DATE;

RETURN NEW;

END;

$$;


CREATE TRIGGER trg_inventory_timestamp

BEFORE UPDATE OF stock_quantity

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_update_inventory_timestamp();


CREATE TABLE inventory_audit (

audit_id SERIAL PRIMARY KEY,

inventory_id INT,

old_quantity INT,

new_quantity INT,

updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE OR REPLACE FUNCTION fn_inventory_audit()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$

BEGIN

INSERT INTO inventory_audit(

inventory_id,
old_quantity,
new_quantity

)

VALUES(

OLD.inventory_id,
OLD.stock_quantity,
NEW.stock_quantity

);

RETURN NEW;

END;

$$;


CREATE TRIGGER trg_inventory_audit

AFTER UPDATE OF stock_quantity

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_inventory_audit();


CREATE TABLE payment_audit (

audit_id SERIAL PRIMARY KEY,

payment_id INT,

old_status VARCHAR(50),

new_status VARCHAR(50),

updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE OR REPLACE FUNCTION fn_payment_audit()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$

BEGIN

INSERT INTO payment_audit(

payment_id,
old_status,
new_status

)

VALUES(

OLD.payment_id,
OLD.payment_status,
NEW.payment_status

);

RETURN NEW;

END;

$$;


CREATE TRIGGER trg_payment_audit

AFTER UPDATE OF payment_status

ON payments

FOR EACH ROW

EXECUTE FUNCTION fn_payment_audit();


CREATE OR REPLACE FUNCTION fn_prevent_negative_inventory()

RETURNS TRIGGER

LANGUAGE plpgsql

AS
$$

BEGIN

IF NEW.stock_quantity < 0 THEN

RAISE EXCEPTION

'Stock quantity cannot be negative';

END IF;

RETURN NEW;

END;

$$;


CREATE TRIGGER trg_negative_inventory

BEFORE UPDATE OF stock_quantity

ON inventory

FOR EACH ROW

EXECUTE FUNCTION fn_prevent_negative_inventory();