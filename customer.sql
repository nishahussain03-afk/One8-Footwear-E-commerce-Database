 CREATE TABLE Customer (
  2      Customer_ID NUMBER(5) PRIMARY KEY,
  3      Business_Name VARCHAR2(50) NOT NULL,
  4      Contact_No NUMBER(10) UNIQUE,
  5      Email VARCHAR2(50) UNIQUE,
  6      Country VARCHAR2(30),
  7      Address VARCHAR2(50)
  8  );

Table created.

SQL> INSERT INTO Customer VALUES (101, 'ABC Traders', 9876543210, 'abc@gmail.com', 'India', 'Chennai');

1 row created.

SQL> INSERT INTO Customer VALUES (102, 'Tech Solutions', 9876543211, 'tech@gmail.com', 'India', 'Bangalore');

1 row created.

SQL> INSERT INTO Customer VALUES (103, 'Green Mart', 9876543212, 'green@gmail.com', 'India', 'Hyderabad');

1 row created.

SQL> INSERT INTO Customer VALUES (104, 'Royal Exports', 9876543213, 'royal@gmail.com', 'India', 'Mumbai');

1 row created.

SQL> INSERT INTO Customer VALUES (105, 'Sun Enterprises', 9876543214, 'sun@gmail.com', 'India', 'Delhi');

1 row created.

SQL> INSERT INTO Customer VALUES (106, 'Global Imports', 9876543215, 'global@gmail.com', 'USA', 'New York');

1 row created.

SQL> INSERT INTO Customer VALUES (107, 'City Wholesale', 9876543216, 'city@gmail.com', 'UK', 'London');

1 row created.

SQL> INSERT INTO Customer VALUES (108, 'Prime Suppliers', 9876543217, 'prime@gmail.com', 'Singapore', 'Singapore');

1 row created.

SQL> INSERT INTO Customer VALUES (109, 'Future Electronics', 9876543218, 'future@gmail.com', 'Canada', 'Toronto');

1 row created.

SQL> INSERT INTO Customer VALUES (110, 'Smart Business', 9876543219, 'smart@gmail.com', 'Australia', 'Sydney');

1 row created.

SQL> SELECT * FROM Customer;

CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        101 ABC Traders                                        9876543210
abc@gmail.com
India
Chennai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        102 Tech Solutions                                     9876543211
tech@gmail.com
India
Bangalore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        103 Green Mart                                         9876543212
green@gmail.com
India
Hyderabad


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        104 Royal Exports                                      9876543213
royal@gmail.com
India
Mumbai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        105 Sun Enterprises                                    9876543214
sun@gmail.com
India
Delhi


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        106 Global Imports                                     9876543215
global@gmail.com
USA
New York


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        107 City Wholesale                                     9876543216
city@gmail.com
UK
London


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        108 Prime Suppliers                                    9876543217
prime@gmail.com
Singapore
Singapore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        109 Future Electronics                                 9876543218
future@gmail.com
Canada
Toronto


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        110 Smart Business                                     9876543219
smart@gmail.com
Australia
Sydney


10 rows selected.

SQL> UPDATE Customer
  2  SET Country = 'UAE',
  3      Address = 'Dubai'
  4  WHERE Customer_ID = 105;

1 row updated.

SQL> SELECT * FROM Customer;

CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        101 ABC Traders                                        9876543210
abc@gmail.com
India
Chennai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        102 Tech Solutions                                     9876543211
tech@gmail.com
India
Bangalore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        103 Green Mart                                         9876543212
green@gmail.com
India
Hyderabad


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        104 Royal Exports                                      9876543213
royal@gmail.com
India
Mumbai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        105 Sun Enterprises                                    9876543214
sun@gmail.com
UAE
Dubai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        106 Global Imports                                     9876543215
global@gmail.com
USA
New York


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        107 City Wholesale                                     9876543216
city@gmail.com
UK
London


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        108 Prime Suppliers                                    9876543217
prime@gmail.com
Singapore
Singapore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        109 Future Electronics                                 9876543218
future@gmail.com
Canada
Toronto


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        110 Smart Business                                     9876543219
smart@gmail.com
Australia
Sydney


10 rows selected.

SQL> UPDATE Customer
  2  SET Business_Name = 'Sun Global Enterprises'
  3  WHERE Customer_ID = 105;

1 row updated.

SQL> SELECT * FROM Customer;

CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        101 ABC Traders                                        9876543210
abc@gmail.com
India
Chennai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        102 Tech Solutions                                     9876543211
tech@gmail.com
India
Bangalore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        103 Green Mart                                         9876543212
green@gmail.com
India
Hyderabad


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        104 Royal Exports                                      9876543213
royal@gmail.com
India
Mumbai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        105 Sun Global Enterprises                             9876543214
sun@gmail.com
UAE
Dubai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        106 Global Imports                                     9876543215
global@gmail.com
USA
New York


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        107 City Wholesale                                     9876543216
city@gmail.com
UK
London


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        108 Prime Suppliers                                    9876543217
prime@gmail.com
Singapore
Singapore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        109 Future Electronics                                 9876543218
future@gmail.com
Canada
Toronto


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        110 Smart Business                                     9876543219
smart@gmail.com
Australia
Sydney


10 rows selected.

SQL> UPDATE Customer
  2  SET Business_Name = 'Sun Global Enterprises'
  3  WHERE Customer_ID = 105;

1 row updated.

SQL> SELECT * FROM Customer;

CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        101 ABC Traders                                        9876543210
abc@gmail.com
India
Chennai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        102 Tech Solutions                                     9876543211
tech@gmail.com
India
Bangalore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        103 Green Mart                                         9876543212
green@gmail.com
India
Hyderabad


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        104 Royal Exports                                      9876543213
royal@gmail.com
India
Mumbai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        105 Sun Global Enterprises                             9876543214
sun@gmail.com
UAE
Dubai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        106 Global Imports                                     9876543215
global@gmail.com
USA
New York


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        107 City Wholesale                                     9876543216
city@gmail.com
UK
London


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        108 Prime Suppliers                                    9876543217
prime@gmail.com
Singapore
Singapore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        109 Future Electronics                                 9876543218
future@gmail.com
Canada
Toronto


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        110 Smart Business                                     9876543219
smart@gmail.com
Australia
Sydney


10 rows selected.

SQL> DELETE FROM Customer
  2  WHERE Customer_ID = 110;

1 row deleted.

SQL> SELECT * FROM Customer;

CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        101 ABC Traders                                        9876543210
abc@gmail.com
India
Chennai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        102 Tech Solutions                                     9876543211
tech@gmail.com
India
Bangalore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        103 Green Mart                                         9876543212
green@gmail.com
India
Hyderabad


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        104 Royal Exports                                      9876543213
royal@gmail.com
India
Mumbai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        105 Sun Global Enterprises                             9876543214
sun@gmail.com
UAE
Dubai


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        106 Global Imports                                     9876543215
global@gmail.com
USA
New York


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        107 City Wholesale                                     9876543216
city@gmail.com
UK
London


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        108 Prime Suppliers                                    9876543217
prime@gmail.com
Singapore
Singapore


CUSTOMER_ID BUSINESS_NAME                                      CONTACT_NO
----------- -------------------------------------------------- ----------
EMAIL
--------------------------------------------------
COUNTRY
------------------------------
ADDRESS
--------------------------------------------------
        109 Future Electronics                                 9876543218
future@gmail.com
Canada
Toronto


9 rows selected.
