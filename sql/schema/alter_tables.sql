ALTER TABLE products
ADD CONSTRAINT chk_price
CHECK (selling_price >= cost_price);


ALTER TABLE inventory
ALTER COLUMN stock_quantity
SET DEFAULT 0;


ALTER TABLE customers
ALTER COLUMN registration_date
SET DEFAULT CURRENT_DATE;


ALTER TABLE payments
ALTER COLUMN payment_status
SET DEFAULT 'Pending';


ALTER TABLE reviews
ADD CONSTRAINT chk_rating
CHECK (rating BETWEEN 1 AND 5);