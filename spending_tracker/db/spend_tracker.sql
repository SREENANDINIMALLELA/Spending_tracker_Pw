DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE categories ;

CREATE TABLE categories (
  id serial primary key,
      name varchar(255)
);
CREATE TABLE merchants (
  id serial4 primary key,
      name varchar(255)
);

CREATE TABLE transactions(
  id serial4 primary key,
  category_id INT4 REFERENCES categories(id),
  merchant_id INT4 REFERENCES merchants(id),
  amount INT4 
);
