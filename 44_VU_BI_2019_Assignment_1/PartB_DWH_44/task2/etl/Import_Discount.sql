CREATE TABLE `TB_Discount` (
	`ProductCategory` TEXT,
	`MinOrderQty` INT,
	`DiscountRate` INT
);

INSERT INTO TB_Discount VALUES ("Clothing", 5, 5);
INSERT INTO TB_Discount VALUES ("Clothing", 10, 10);
INSERT INTO TB_Discount VALUES ("Accessories", 5, 4);
INSERT INTO TB_Discount VALUES ("Accessories", 10, 11);

INSERT INTO TB_Discount VALUES ("Components", 0, 0);
INSERT INTO TB_Discount VALUES ("Accessories", 0, 0);
INSERT INTO TB_Discount VALUES ("Clothing", 0, 0);
INSERT INTO TB_Discount VALUES ("Bikes", 0, 0);

INSERT INTO TB_Discount VALUES ("Bikes", 5, 0);
INSERT INTO TB_Discount VALUES ("Bikes", 5, 0);
INSERT INTO TB_Discount VALUES ("Components", 10, 0);
INSERT INTO TB_Discount VALUES ("Components", 10, 0);