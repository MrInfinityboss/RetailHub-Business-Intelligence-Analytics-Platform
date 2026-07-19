-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: create_functions.sql
-- Description:
-- PostgreSQL User Defined Functions
-- =====================================================

SET search_path TO retailhub;

-- =====================================================
-- Function 1
-- Customer Lifetime Value
-- =====================================================

CREATE OR REPLACE FUNCTION fn_customer_lifetime_value(
    p_customer_id INT
)

RETURNS NUMERIC(12,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    total_value NUMERIC(12,2);

BEGIN

    SELECT COALESCE(SUM(pay.amount),0)

    INTO total_value

    FROM orders o
    JOIN payments pay
    ON o.order_id = pay.order_id

    WHERE o.customer_id = p_customer_id
      AND pay.payment_status='Completed';

    RETURN total_value;

END;
$$;



CREATE OR REPLACE FUNCTION fn_product_profit(
    p_product_id INT
)

RETURNS NUMERIC(12,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    profit NUMERIC(12,2);

BEGIN

    SELECT
        selling_price-cost_price

    INTO profit

    FROM products

    WHERE product_id=p_product_id;

    RETURN profit;

END;
$$;


CREATE OR REPLACE FUNCTION fn_inventory_value(
    p_warehouse_id INT
)

RETURNS NUMERIC(15,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    inventory_value NUMERIC(15,2);

BEGIN

SELECT

COALESCE(SUM(i.stock_quantity*p.cost_price),0)

INTO inventory_value

FROM inventory i

JOIN products p
ON i.product_id=p.product_id

WHERE warehouse_id=p_warehouse_id;

RETURN inventory_value;

END;
$$;



CREATE OR REPLACE FUNCTION fn_average_order_value()

RETURNS NUMERIC(12,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    avg_order NUMERIC(12,2);

BEGIN

SELECT

AVG(amount)

INTO avg_order

FROM payments

WHERE payment_status='Completed';

RETURN avg_order;

END;
$$;


CREATE OR REPLACE FUNCTION fn_monthly_revenue(

p_year INT,

p_month INT

)

RETURNS NUMERIC(15,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    monthly_revenue NUMERIC(15,2);

BEGIN

SELECT

COALESCE(SUM(amount),0)

INTO monthly_revenue

FROM payments

WHERE payment_status='Completed'

AND EXTRACT(YEAR FROM payment_date)=p_year

AND EXTRACT(MONTH FROM payment_date)=p_month;

RETURN monthly_revenue;

END;
$$;


CREATE OR REPLACE FUNCTION fn_profit_margin(

p_product_id INT

)

RETURNS NUMERIC(6,2)

LANGUAGE plpgsql

AS
$$
DECLARE
    margin NUMERIC(6,2);

BEGIN

SELECT

ROUND(
    ((selling_price - cost_price) / NULLIF(cost_price, 0)) * 100,
    2
)

INTO margin

FROM products

WHERE product_id=p_product_id;

RETURN margin;

END;
$$;