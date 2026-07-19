-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: create_procedures.sql
-- Description:
-- PostgreSQL Stored Procedures
-- =====================================================

SET search_path TO retailhub;


CREATE OR REPLACE PROCEDURE sp_update_inventory(

    p_inventory_id INT,
    p_new_stock INT

)

LANGUAGE plpgsql

AS
$$

BEGIN

UPDATE inventory

SET
    stock_quantity = p_new_stock,
    last_stock_update = CURRENT_DATE

WHERE inventory_id = p_inventory_id;

END;
$$;



CREATE OR REPLACE PROCEDURE sp_update_inventory(

    p_inventory_id INT,
    p_new_stock INT

)

LANGUAGE plpgsql

AS
$$

BEGIN

UPDATE inventory

SET
    stock_quantity = p_new_stock,
    last_stock_update = CURRENT_DATE

WHERE inventory_id = p_inventory_id;

END;
$$;


CREATE OR REPLACE PROCEDURE sp_upgrade_membership(

    p_customer_id INT,
    p_membership VARCHAR(50)

)

LANGUAGE plpgsql

AS
$$

BEGIN

UPDATE customers

SET membership_level = p_membership

WHERE customer_id = p_customer_id;

END;
$$;


CREATE OR REPLACE PROCEDURE sp_apply_discount(

    p_product_id INT,
    p_discount_percent NUMERIC(5,2)

)

LANGUAGE plpgsql

AS
$$

BEGIN

UPDATE products

SET selling_price =
ROUND(
selling_price-(selling_price*p_discount_percent/100),
2
)

WHERE product_id=p_product_id;

END;
$$;


CREATE OR REPLACE PROCEDURE sp_refresh_materialized_views()

LANGUAGE plpgsql

AS
$$

BEGIN

REFRESH MATERIALIZED VIEW mv_monthly_sales;

REFRESH MATERIALIZED VIEW mv_store_performance;

REFRESH MATERIALIZED VIEW mv_customer_ltv;

REFRESH MATERIALIZED VIEW mv_product_performance;

END;
$$;


CREATE OR REPLACE PROCEDURE sp_increase_product_price(

    p_category_id INT,
    p_percentage NUMERIC(5,2)

)

LANGUAGE plpgsql

AS
$$

BEGIN

UPDATE products

SET selling_price =
ROUND(
selling_price+
(selling_price*p_percentage/100),
2
)

WHERE category_id=p_category_id;

END;
$$;


BEGIN;

CALL sp_apply_discount(20, 10);

-- Verify the change
SELECT product_id, selling_price
FROM products
WHERE product_id = 20;

ROLLBACK;