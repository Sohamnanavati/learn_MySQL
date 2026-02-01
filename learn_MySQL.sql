-- when talking about MySQL there are 5 types of languages
-- 1 data definition language DDL
-- 2 data manipulation language DML
-- 3 data control language DCL ---> not coverd in this tutorial
-- 4 transaction control language TCL
-- 5 data query language DQL

-- ----------------------------------------------------DATABASE--------------------------------------------------------------------------
-- --------------------------CREATE DATABASE
create database northwind;
create database southwind;
-- if we try to create a new database with name that already exists then error will occur.
-- to solve this use if not exist statement 
create database if not exists northwind;

-- --------------------------READ DATABASE	
show databases; -- verify whether it is created or not
show schemas; --  verify whether it is created or not same result. 
-- we will create new table in other database
use southwind;
create table customersSouth(
CustomerID int primary key auto_increment,
CustomerName varchar(500) not null,
CustomerContactName varchar(500),
CustomerAddress varchar(500),
CustomerCity varchar(500),
CostomerPostalCode varchar(500),-- code and be a string!!
CustomerCountry varchar(500) default "India"
);
use northwind;
show tables; -- this will list down all the tables present in the database northwind. 
/*In MySQL, we use the optional FULL modifier along with the SHOW TABLES command to 
display a second output column that contains additional information about the tables
 present in a database, such as their types: BASE TABLE for a table, VIEW for a view,
 or SYSTEM VIEW for an INFORMATION_SCHEMA table.*/
show full tables;
-- what if we want to view tables  in different database?
show tables from southwind;
show tables in southwind;
-- using wild chards
show tables from southwind like "c%";
show tables in southwind like "c%";
-- look for specific tables 
show tables from northwind where tables_in_northwind = "customers";

-- --------------------------DELETE DATABASE
drop database northwind; 

-- --------------------------ACCESS DATABASE
-- "use" keyword allows us to access northwind database we created earlier.
create database northwind;
use northwind;
-- ----------------------------------------------------------TABLES------------------------------------------------------------------------------------------------
-- ----------------------------------------------------- CRUD WITH TABLES------------------------------------------------------------------------------------------------
-- -------------------------------------------------------- CREATE TABLE-------------------------------------------------------------------
-- A MySQL query to create a table must define the structure of a table. 
-- The structure consists of the name of a table and names of columns in the table with each column's data type. 
-- Note that each table must be uniquely named in a database.
-- name of the table
-- name of the columns 
-- difinition of the tables

create table customers(
CustomerID int primary key auto_increment,
CustomerName varchar(500) not null,
CustomerContactName varchar(500),
CustomerAddress varchar(500),
CustomerCity varchar(500),
CostomerPostalCode varchar(500),-- code and be a string!!
CustomerCountry varchar(500) default "India"
);
/*Another way to create a table is by copying an existing one. After running this, the copyTable will have the same structure as 
the customers table. You can copy all columns or select specific ones, and the data from the source table will be copied into the 
new table. currently it has no data. we can also use where clause to copy sepcific data to the new table*/
create table copyTable as 
select * from customers; -- this table wont have data for now as customers dint have any. will learn about it later.
/* any changes made to the copyTable wont effect the customers table.*/
select * from copyTable; -- verify
-- use "if not exists" if you are not sure whether tables actually exists or not.
create table if not exists customers(
CustomerID int primary key,
CustomerName varchar(500) not null,
CustomerContactName varchar(500),
CustomerAddress varchar(500),
CustomerCity varchar(500),
CostomerPostalCode varchar(500),-- code and be a string!!
CustomerCountry varchar(500) default "India"
);-- this will create the table if the tables does not exists in the database.
drop table copyTable;

-- lets create tables 
CREATE TABLE categories(
    CategoryID int,
    CategoryName varchar(255),
    Description varchar(255)
);

CREATE TABLE employees(
   EmployeeID int,
    LastName varchar(255),
    FirstName varchar(255),
    BirthDate date,
    Photo varchar(255), -- we refer to the path where the image is kept. therefore, varchar.
    Notes varchar(1000)
);
 
CREATE TABLE orderDetails(
    OrderDetailID int,
    OrderID int,
    ProductID int,
    Quantity int
);

CREATE TABLE orders(
   OrderID int,
    CustomerID int,
    EmployeeID int,
    OrderDate date,
    ShipperID int
);

CREATE TABLE products(
    ProductID int,
    ProductName varchar(255),
    SupplierID int,
    CategoryID int,
    Unit varchar(255),
    Price int
);

CREATE TABLE shippers(
 ShipperID int,
    ShipperName varchar(255),
    Phone varchar(255)
);

CREATE TABLE suppliers(
    SupplierID int,
    SupplierName varchar(250),
    ContactName varchar(250),
    Address varchar(500),
    City varchar(250),
    PostalCode varchar(250),
    Country varchar(250),
    Phone varchar(250)
);
-- --------------------------------------------------------READ/SHOW TABLE-------------------------------------------------------------------
describe customers;
describe customers CustomerName;-- specific column

desc customers;
desc customers CustomerName;-- specific column

show columns from customers;
show columns from customers like "%s";-- will explain later what wild character are.

explain customers;
-- we can explain tabels in different formats
explain format =  JSON select * from customers;

-- select specific columns to see
select CustomerID,CustomerName,CustomerCountry from customers;

-- --------------------------------------------------------UPDATE/ALTER TABLE-------------------------------------------------------------------
-- IN "UPDATE TABLE" WE USUALLY WORK WITH COLUMNS AS COLUMNS MAKES UP A TABLE.
-- there are two types of alter we can do with the table. 
-- first on table itself 
-- second on columns of the table. 
-- -------------------------------- PERFORM CRUD on COLUMNS TO UPDATE TABLES-----
-- --------------------------CREATE/ADD COLUMNS
alter table customers
add column age int;
-- add multiple columns
alter table customers
add column abc int,
add column def int;
select * from customers;

-- --------------------------REPOSITIONS COLUMNS
-- by default the age and other columns are added at the end.
-- we can reposition it using "first" to make the column appear first.
-- we can repositon the new column after the specific column using after_column name. lets see
alter table customers
add column ghi date first;-- this will add the ghi column at the beginning of the table
select * from customers; -- verify
alter table customers
add column jkl varchar(500) after CustomerContactName;-- this will add the new column at after CustomerContactName table. 
select * from customers; -- verify

-- we can also change the existing position of the columns already added before.
-- use modify method. 
alter table customers
modify age int first;
select * from customers; -- verify

alter table customers
modify abc int after CustomerContactName,
modify def int after CustomerContactName,
modify ghi date after CustomerContactName,
modify jkl varchar(500) after CustomerContactName;
select * from customers; -- verify look at the placements!!!
-- use change method
alter table customers
change column age age int after CustomerCountry;
select * from customers; -- verify

alter table customers
change column abc abc int after CustomerCountry,
change column def def int after CustomerCountry,
change column ghi ghi date after CustomerCountry,
change column jkl jkl varchar(500) after CustomerCountry;
select * from customers; -- verify

-- --------------------------READ/SHOW/DESCRIBE COLUMNS
-- SHOW
show columns from customers;
show columns in customers;
-- colums = fields
show fields in customers;
-- use regex
show columns from customers like "%y";
-- specify database aswell
show columns from customers from northwind;
show columns in customers from northwind;
show columns from customers in northwind;
show columns in customers in northwind;
-- specify the type of the columns
show columns in customers where type = "int";
-- use full
show full columns from customers;
-- DESCRIBE
describe customers;
describe customers CustomerName;-- specific column
-- DESC
desc customers;
desc customers CustomerName;-- specific column
-- EXPLAIN
explain customers;
-- we can explain tabels in different formats
explain format =  JSON select * from customers;

-- --------------------------UPDATE/CHANGE DEFINITION
alter table customers
modify column ghi int,-- this was changed from date to int
modify column jkl int; -- this was changed from varchar to int
desc customers; -- verify
alter table customers
change column ghi ghi date,-- change this back to date using change command
change column jkl jkl varchar(500); -- change this back to varchar using change command. 
desc customers; -- verify

-- --------------------------UPDATE/ALTERING DEFAULT VALUES
alter table customers
alter column CustomerCountry set default "Mumbai";
-- drop the default constrain
alter table customers 
alter column CustomerCountry drop default;
desc customers; -- verify
alter table customers alter column CustomerCountry set default "India"; -- but for now lets keep default. 

-- -------------------------- UPDATE/RENAMING COLUMN
alter table customers
rename column age to Age,
rename column abc to ABC;-- we can also modify multiple columns by adding coma
desc customers;-- verify
-- different method to rename "rename" and "change".
create table dummyRename as
select * from customers;
-- single rename using "rename"
alter table dummyRename
rename column CustomerID to id;
-- multiple rename using "rename"
alter table dummyRename
rename column CustomerName to names,
rename column CustomerContactName to contactNames;
-- single rename using "change"
alter table dummyRename
change column CustomerAddress address varchar(500);
alter table dummyRename
change column CustomerCity city varchar(500);
-- mutiple rename using "change"
alter table dummyRename
change column CostomerPostalCode postalCode varchar(500),
change column CustomerCountry country varchar(500);

drop table dummyRename;

-- --------------------------DELETE/DROP COLUMN
alter table customers
drop column age;
-- we can drop multiple columns 
alter table customers
drop column abc,
drop column def,
drop column ghi,
drop column jkl;
desc customers;-- verify

/* now the above given commands are confusing therefore i am giving you this table as a reference about when to use modify,
 change, and alter commands with alter statement.*/
 
-- | Operation                                                     | MODIFY | CHANGE | ALTER COLUMN |
-- | ------------------------------------------------------------- ----------------------------------
-- | **Add column**                                                |    ✗   |    ✗   |       ✗      |
-- | **Rename column**                                             |    ✗   |    ✔   |       ✗      |
-- | **Change datatype**                                           |    ✔   |    ✔   |       ✗      |
-- | **Change constraints** (NULL/NOT NULL, AUTO\_INCREMENT, etc.) |    ✔   |    ✔   |       ✗      |
-- | **Change position**                                           |    ✔   |    ✔   |       ✗      |
-- | **Delete column**                                             |    ✗   |    ✗   |       ✗      |
-- | **Change defaults**                                           |    ✗   |    ✗   |       ✔      |
-- --------------------------------------------------------------------------------------------------


-- --------------------------------------------------------DROP/DELETE TABLE-------------------------------------------------------------------
create table dummyDrop1 as 
select * from customers;
create table dummyDrop2 as 
select * from customers;
create table dummyDrop3 as 
select * from customers;

drop table dummyDrop1;
-- we can also drop multiple tables
drop table dummyDrop2,dummyDrop3;
-- if we dont know whether or not table exists in the database or not use if not 
drop table if exists dummyDrop1;

-- --------------------------------------------------------RENAME TALBE-------------------------------------------------------------------
-- we can rename the table using two methods 
-- rename
-- alter rename

-- create dummy table
create table dummy1 as
select * from customers;

create table dummy2 as 
select * from customers;

-- rename them using "rename command" we can rename single or multiple tables at once
rename table dummy1 to cus_dummy1,
             dummy2 to cus_dummy2;
-- rename them using "alter rename command" we can rename single or multiple tables at once
alter table cus_dummy1 rename to dummy1;
alter table cus_dummy2 rename to dummy2;

drop table dummy1,dummy2;

-- ------------------------------------------------INSERT QUERY-------------------------------------------------------------------
-- lets insert data into this tables.
-- METHOD 1
insert into customers -- inserted new data 
(CustomerID, CustomerName,CustomerContactName, CustomerAddress, CustomerCity, CostomerPostalCode, CustomerCountry) -- we can even remove this line and it would still work. 
values
(1," Alfreds Futterkiste  "," Maria Anders  "," Obere Str. 57  "," Berlin  "," 12209  "," Germany  "),(2," Ana Trujillo Emparedados y helados  "," Ana Trujillo  "," Avda. de la Constitución 2222  "," México D.F.  "," 05021  "," Mexico  "),(3," Antonio Moreno Taquería  "," Antonio Moreno  "," Mataderos 2312  "," México D.F.  "," 05023  "," Mexico  "),(4," Around the Horn  "," Thomas Hardy  "," 120 Hanover Sq.  "," London  "," WA1 1DP  "," UK  "),(5," Berglunds snabbköp  "," Christina Berglund  "," Berguvsvägen 8  "," Luleå  "," S-958 22  "," Sweden  "),(6," Blauer See Delikatessen  "," Hanna Moos  "," Forsterstr. 57  "," Mannheim  "," 68306  "," Germany  "),(7," Blondel père et fils  "," Frédérique Citeaux  "," 24, place Kléber  "," Strasbourg  "," 67000  "," France  "),(8," Bólido Comidas preparadas  "," Martín Sommer  "," C/ Araquil, 67  "," Madrid  "," 28023  "," Spain  "),(9," Bon app'  "," Laurence Lebihans  "," 12, rue des Bouchers  "," Marseille  "," 13008  "," France  "),(10," Bottom-Dollar Marketse  "," Elizabeth Lincoln  "," 23 Tsawassen Blvd.  "," Tsawassen  "," T2F 8M4  "," Canada  "),(11," B's Beverages  "," Victoria Ashworth  "," Fauntleroy Circus  "," London  "," EC2 5NT  "," UK  "),(12," Cactus Comidas para llevar  "," Patricio Simpson  "," Cerrito 333  "," Buenos Aires  "," 1010  "," Argentina  "),(13," Centro comercial Moctezuma  "," Francisco Chang  "," Sierras de Granada 9993  "," México D.F.  "," 05022  "," Mexico  "),(14," Chop-suey Chinese  "," Yang Wang  "," Hauptstr. 29  "," Bern  "," 3012  "," Switzerland  "),(15," Comércio Mineiro  "," Pedro Afonso  "," Av. dos Lusíadas, 23  "," São Paulo  "," 05432-043  "," Brazil  "),(16," Consolidated Holdings  "," Elizabeth Brown  "," Berkeley Gardens 12 Brewery   "," London  "," WX1 6LT  "," UK  "),(17," Drachenblut Delikatessend  "," Sven Ottlieb  "," Walserweg 21  "," Aachen  "," 52066  "," Germany  "),(18," Du monde entier  "," Janine Labrune  "," 67, rue des Cinquante Otages  "," Nantes  "," 44000  "," France  "),(19," Eastern Connection  "," Ann Devon  "," 35 King George  "," London  "," WX3 6FW  "," UK  "),(20," Ernst Handel  "," Roland Mendel  "," Kirchgasse 6  "," Graz  "," 8010  "," Austria  "),(21," Familia Arquibaldo  "," Aria Cruz  "," Rua Orós, 92  "," São Paulo  "," 05442-030  "," Brazil  "),(22," FISSA Fabrica Inter. Salchichas S.A.  "," Diego Roel  "," C/ Moralzarzal, 86  "," Madrid  "," 28034  "," Spain  "),(23," Folies gourmandes  "," Martine Rancé  "," 184, chaussée de Tournai  "," Lille  "," 59000  "," France  "),(24," Folk och fä HB  "," Maria Larsson  "," Åkergatan 24  "," Bräcke  "," S-844 67  "," Sweden  "),(25," Frankenversand  "," Peter Franken  "," Berliner Platz 43  "," München  "," 80805  "," Germany  "),(26," France restauration  "," Carine Schmitt  "," 54, rue Royale  "," Nantes  "," 44000  "," France  "),(27," Franchi S.p.A.  "," Paolo Accorti  "," Via Monte Bianco 34  "," Torino  "," 10100  "," Italy  "),(28," Furia Bacalhau e Frutos do Mar  "," Lino Rodriguez   "," Jardim das rosas n. 32  "," Lisboa  "," 1675  "," Portugal  "),(29," Galería del gastrónomo  "," Eduardo Saavedra  "," Rambla de Cataluña, 23  "," Barcelona  "," 08022  "," Spain  "),(30," Godos Cocina Típica  "," José Pedro Freyre  "," C/ Romero, 33  "," Sevilla  "," 41101  "," Spain  "),(31," Gourmet Lanchonetes  "," André Fonseca  "," Av. Brasil, 442  "," Campinas  "," 04876-786  "," Brazil  "),(32," Great Lakes Food Market  "," Howard Snyder  "," 2732 Baker Blvd.  "," Eugene  "," 97403  "," USA  "),(33," GROSELLA-Restaurante  "," Manuel Pereira  "," 5ª Ave. Los Palos Grandes  "," Caracas  "," 1081  "," Venezuela  "),(34," Hanari Carnes  "," Mario Pontes  "," Rua do Paço, 67  "," Rio de Janeiro  "," 05454-876  "," Brazil  "),(35," HILARIÓN-Abastos  "," Carlos Hernández  "," Carrera 22 con Ave. Carlos Soublette #8-35  "," San Cristóbal  "," 5022  "," Venezuela  "),(36," Hungry Coyote Import Store  "," Yoshi Latimer  "," City Center Plaza 516 Main St.  "," Elgin  "," 97827  "," USA  "),(37," Hungry Owl All-Night Grocers  "," Patricia McKenna  "," 8 Johnstown Road  "," Cork  ","  "," Ireland  "),(38," Island Trading  "," Helen Bennett  "," Garden House Crowther Way  "," Cowes  "," PO31 7PJ  "," UK  "),(39," Königlich Essen  "," Philip Cramer  "," Maubelstr. 90  "," Brandenburg  "," 14776  "," Germany  "),(40," La corne d'abondance  "," Daniel Tonini  "," 67, avenue de l'Europe  "," Versailles  "," 78000  "," France  "),(41," La maison d'Asie  "," Annette Roulet  "," 1 rue Alsace-Lorraine  "," Toulouse  "," 31000  "," France  "),(42," Laughing Bacchus Wine Cellars  "," Yoshi Tannamuri  "," 1900 Oak St.  "," Vancouver  "," V3F 2K1  "," Canada  "),(43," Lazy K Kountry Store  "," John Steel  "," 12 Orchestra Terrace  "," Walla Walla  "," 99362  "," USA  "),(44," Lehmanns Marktstand  "," Renate Messner  "," Magazinweg 7  "," Frankfurt a.M.   "," 60528  "," Germany  "),(45," Let's Stop N Shop  "," Jaime Yorres  "," 87 Polk St. Suite 5  "," San Francisco  "," 94117  "," USA  "),(46," LILA-Supermercado  "," Carlos González  "," Carrera 52 con Ave. Bolívar #65-98 Llano Largo  "," Barquisimeto  "," 3508  "," Venezuela  "),(47," LINO-Delicateses  "," Felipe Izquierdo  "," Ave. 5 de Mayo Porlamar  "," I. de Margarita  "," 4980  "," Venezuela  "),(48," Lonesome Pine Restaurant  "," Fran Wilson  "," 89 Chiaroscuro Rd.  "," Portland  "," 97219  "," USA  "),(49," Magazzini Alimentari Riuniti  "," Giovanni Rovelli  "," Via Ludovico il Moro 22  "," Bergamo  "," 24100  "," Italy  "),(50," Maison Dewey  "," Catherine Dewey  "," Rue Joseph-Bens 532  "," Bruxelles  "," B-1180  "," Belgium  "),(51," Mère Paillarde  "," Jean Fresnière  "," 43 rue St. Laurent  "," Montréal  "," H1J 1C3  "," Canada  "),(52," Morgenstern Gesundkost  "," Alexander Feuer  "," Heerstr. 22  "," Leipzig  "," 04179  "," Germany  "),(53," North/South  "," Simon Crowther  "," South House 300 Queensbridge  "," London  "," SW7 1RZ  "," UK  "),(54," Océano Atlántico Ltda.  "," Yvonne Moncada  "," Ing. Gustavo Moncada 8585 Piso 20-A  "," Buenos Aires  "," 1010  "," Argentina  "),(55," Old World Delicatessen  "," Rene Phillips  "," 2743 Bering St.  "," Anchorage  "," 99508  "," USA  "),(56," Ottilies Käseladen  "," Henriette Pfalzheim  "," Mehrheimerstr. 369  "," Köln  "," 50739  "," Germany  "),(57," Paris spécialités  "," Marie Bertrand  "," 265, boulevard Charonne  "," Paris  "," 75012  "," France  "),(58," Pericles Comidas clásicas  "," Guillermo Fernández  "," Calle Dr. Jorge Cash 321  "," México D.F.  "," 05033  "," Mexico  "),(59," Piccolo und mehr  "," Georg Pipps  "," Geislweg 14  "," Salzburg  "," 5020  "," Austria  "),(60," Princesa Isabel Vinhoss  "," Isabel de Castro  "," Estrada da saúde n. 58  "," Lisboa  "," 1756  "," Portugal  "),(61," Que Delícia  "," Bernardo Batista  "," Rua da Panificadora, 12  "," Rio de Janeiro  "," 02389-673  "," Brazil  "),(62," Queen Cozinha  "," Lúcia Carvalho  "," Alameda dos Canàrios, 891  "," São Paulo  "," 05487-020  "," Brazil  "),(63," QUICK-Stop  "," Horst Kloss  "," Taucherstraße 10  "," Cunewalde  "," 01307  "," Germany  "),(64," Rancho grande  "," Sergio Gutiérrez  "," Av. del Libertador 900  "," Buenos Aires  "," 1010  "," Argentina  "),(65," Rattlesnake Canyon Grocery  "," Paula Wilson  "," 2817 Milton Dr.  "," Albuquerque  "," 87110  "," USA  "),(66," Reggiani Caseifici  "," Maurizio Moroni  "," Strada Provinciale 124  "," Reggio Emilia  "," 42100  "," Italy  "),(67," Ricardo Adocicados  "," Janete Limeira  "," Av. Copacabana, 267  "," Rio de Janeiro  "," 02389-890  "," Brazil  "),(68," Richter Supermarkt  "," Michael Holz  "," Grenzacherweg 237  "," Genève  "," 1203  "," Switzerland  "),(69," Romero y tomillo  "," Alejandra Camino  "," Gran Vía, 1  "," Madrid  "," 28001  "," Spain  "),(70," Santé Gourmet  "," Jonas Bergulfsen  "," Erling Skakkes gate 78  "," Stavern  "," 4110  "," Norway  "),(71," Save-a-lot Markets  "," Jose Pavarotti  "," 187 Suffolk Ln.  "," Boise  "," 83720  "," USA  "),(72," Seven Seas Imports  "," Hari Kumar  "," 90 Wadhurst Rd.  "," London  "," OX15 4NB  "," UK  "),(73," Simons bistro  "," Jytte Petersen  "," Vinbæltet 34  "," København  "," 1734  "," Denmark  "),(74," Spécialités du monde  "," Dominique Perrier  "," 25, rue Lauriston  "," Paris  "," 75016  "," France  "),(75," Split Rail Beer & Ale  "," Art Braunschweiger  "," P.O. Box 555  "," Lander  "," 82520  "," USA  "),(76," Suprêmes délices  "," Pascale Cartrain  "," Boulevard Tirou, 255  "," Charleroi  "," B-6000  "," Belgium  "),(77," The Big Cheese  "," Liz Nixon  "," 89 Jefferson Way Suite 2  "," Portland  "," 97201  "," USA  "),(78," The Cracker Box  "," Liu Wong  "," 55 Grizzly Peak Rd.  "," Butte  "," 59801  "," USA  "),(79," Toms Spezialitäten  "," Karin Josephs  "," Luisenstr. 48  "," Münster  "," 44087  "," Germany  "),(80," Tortuga Restaurante  "," Miguel Angel Paolino  "," Avda. Azteca 123  "," México D.F.  "," 05033  "," Mexico  "),(81," Tradição Hipermercados  "," Anabela Domingues  "," Av. Inês de Castro, 414  "," São Paulo  "," 05634-030  "," Brazil  "),(82," Trail's Head Gourmet Provisioners  "," Helvetius Nagy  "," 722 DaVinci Blvd.  "," Kirkland  "," 98034  "," USA  "),(83," Vaffeljernet  "," Palle Ibsen  "," Smagsløget 45  "," Århus  "," 8200  "," Denmark  "),(84," Victuailles en stock  "," Mary Saveley  "," 2, rue du Commerce  "," Lyon  "," 69004  "," France  "),(85," Vins et alcools Chevalier  "," Paul Henriot  "," 59 rue de l'Abbaye  "," Reims  "," 51100  "," France  "),(86," Die Wandernde Kuh  "," Rita Müller  "," Adenauerallee 900  "," Stuttgart  "," 70563  "," Germany  "),(87," Wartian Herkku  "," Pirkko Koskitalo  "," Torikatu 38  "," Oulu  "," 90110  "," Finland  "),(88," Wellington Importadora  "," Paula Parente  "," Rua do Mercado, 12  "," Resende  "," 08737-363  "," Brazil  "),(89," White Clover Markets  "," Karl Jablonski  "," 305 - 14th Ave. S. Suite 3B  "," Seattle  "," 98128  "," USA  "),(90," Wilman Kala  "," Matti Karttunen  "," Keskuskatu 45  "," Helsinki  "," 21240  "," Finland  "),(91," Wolski  "," Zbyszek  "," ul. Filtrowa 68  "," Walla  "," 01-012  "," Poland  ");

INSERT INTO categories
(CategoryID,CategoryName,Description)
VALUES
(1,"Beverages ","Soft drinks, coffees, teas, beers, and ales "),(2,"Condiments ","Sweet and savory sauces, relishes, spreads, and seasonings "),(3,"Confections ","Desserts, candies, and sweet breads "),(4,"Dairy Products ","Cheeses "),(5,"Grains/Cereals ","Breads, crackers, pasta, and cereal "),(6,"Meat/Poultry ","Prepared meats "),(7,"Produce ","Dried fruit and bean curd "),(8,"Seafood ","Seaweed and fish ");

INSERT INTO employees
(EmployeeID,LastName,FirstName,BirthDate,Photo,Notes)
VALUES
(1,"Davolio ","Nancy ","1968-12-08","EmpID1.pic ","Education includes a BA in psychology from Colorado State University. She also completed (The Art of the Cold Call). Nancy is a member of 'Toastmasters International'. "),(2,"Fuller ","Andrew ","1952-02-19","EmpID2.pic ","Andrew received his BTS commercial and a Ph.D. in international marketing from the University of Dallas. He is fluent in French and Italian and reads German. He joined the company as a sales representative, was promoted to sales manager and was then named vice president of sales. Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association. "),(3,"Leverling ","Janet ","1963-08-30","EmpID3.pic ","Janet has a BS degree in chemistry from Boston College). She has also completed a certificate program in food retailing management. Janet was hired as a sales associate and was promoted to sales representative. "),(4,"Peacock ","Margaret ","1958-09-19","EmpID4.pic ","Margaret holds a BA in English literature from Concordia College and an MA from the American Institute of Culinary Arts. She was temporarily assigned to the London office before returning to her permanent post in Seattle. "),(5,"Buchanan ","Steven ","1955-03-04","EmpID5.pic ","Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree. Upon joining the company as a sales representative, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London, where he was promoted to sales manager. Mr. Buchanan has completed the courses 'Successful Telemarketing' and 'International Sales Management'. He is fluent in French. "),(6,"Suyama ","Michael ","1963-07-02","EmpID6.pic ","Michael is a graduate of Sussex University (MA, economics) and the University of California at Los Angeles (MBA, marketing). He has also taken the courses 'Multi-Cultural Selling' and 'Time Management for the Sales Professional'. He is fluent in Japanese and can read and write French, Portuguese, and Spanish. "),(7,"King ","Robert ","1960-05-29","EmpID7.pic ","Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan and then joining the company. After completing a course entitled 'Selling in Europe', he was transferred to the London office. "),(8,"Callahan ","Laura ","1958-01-09","EmpID8.pic ","Laura received a BA in psychology from the University of Washington. She has also completed a course in business French. She reads and writes French. "),(9,"Dodsworth ","Anne ","1969-07-02","EmpID9.pic ","Anne has a BA degree in English from St. Lawrence College. She is fluent in French and German. "),(10,"West ","Adam ","1928-09-19","EmpID10.pic ","An old chum ");

INSERT INTO  orderDetails
(OrderDetailID,OrderID,ProductID,Quantity)
VALUES
(1,10248,11,12 ),(2,10248,42,10 ),(3,10248,72,5 ),(4,10249,14,9 ),(5,10249,51,40 ),(6,10250,41,10 ),(7,10250,51,35 ),(8,10250,65,15 ),(9,10251,22,6 ),(10,10251,57,15 ),(11,10251,65,20 ),(12,10252,20,40 ),(13,10252,33,25 ),(14,10252,60,40 ),(15,10253,31,20 ),(16,10253,39,42 ),(17,10253,49,40 ),(18,10254,24,15 ),(19,10254,55,21 ),(20,10254,74,21 ),(21,10255,2,20 ),(22,10255,16,35 ),(23,10255,36,25 ),(24,10255,59,30 ),(25,10256,53,15 ),(26,10256,77,12 ),(27,10257,27,25 ),(28,10257,39,6 ),(29,10257,77,15 ),(30,10258,2,50 ),(31,10258,5,65 ),(32,10258,32,6 ),(33,10259,21,10 ),(34,10259,37,1 ),(35,10260,41,16 ),(36,10260,57,50 ),(37,10260,62,15 ),(38,10260,70,21 ),(39,10261,21,20 ),(40,10261,35,20 ),(41,10262,5,12 ),(42,10262,7,15 ),(43,10262,56,2 ),(44,10263,16,60 ),(45,10263,24,28 ),(46,10263,30,60 ),(47,10263,74,36 ),(48,10264,2,35 ),(49,10264,41,25 ),(50,10265,17,30 ),(51,10265,70,20 ),(52,10266,12,12 ),(53,10267,40,50 ),(54,10267,59,70 ),(55,10267,76,15 ),(56,10268,29,10 ),(57,10268,72,4 ),(58,10269,33,60 ),(59,10269,72,20 ),(60,10270,36,30 ),(61,10270,43,25 ),(62,10271,33,24 ),(63,10272,20,6 ),(64,10272,31,40 ),(65,10272,72,24 ),(66,10273,10,24 ),(67,10273,31,15 ),(68,10273,33,20 ),(69,10273,40,60 ),(70,10273,76,33 ),(71,10274,71,20 ),(72,10274,72,7 ),(73,10275,24,12 ),(74,10275,59,6 ),(75,10276,10,15 ),(76,10276,13,10 ),(77,10277,28,20 ),(78,10277,62,12 ),(79,10278,44,16 ),(80,10278,59,15 ),(81,10278,63,8 ),(82,10278,73,25 ),(83,10279,17,15 ),(84,10280,24,12 ),(85,10280,55,20 ),(86,10280,75,30 ),(87,10281,19,1 ),(88,10281,24,6 ),(89,10281,35,4 ),(90,10282,30,6 ),(91,10282,57,2 ),(92,10283,15,20 ),(93,10283,19,18 ),(94,10283,60,35 ),(95,10283,72,3 ),(96,10284,27,15 ),(97,10284,44,21 ),(98,10284,60,20 ),(99,10284,67,5 ),(100,10285,1,45 ),(101,10285,40,40 ),(102,10285,53,36 ),(103,10286,35,100 ),(104,10286,62,40 ),(105,10287,16,40 ),(106,10287,34,20 ),(107,10287,46,15 ),(108,10288,54,10 ),(109,10288,68,3 ),(110,10289,3,30 ),(111,10289,64,9 ),(112,10290,5,20 ),(113,10290,29,15 ),(114,10290,49,15 ),(115,10290,77,10 ),(116,10291,13,20 ),(117,10291,44,24 ),(118,10291,51,2 ),(119,10292,20,20 ),(120,10293,18,12 ),(121,10293,24,10 ),(122,10293,63,5 ),(123,10293,75,6 ),(124,10294,1,18 ),(125,10294,17,15 ),(126,10294,43,15 ),(127,10294,60,21 ),(128,10294,75,6 ),(129,10295,56,4 ),(130,10296,11,12 ),(131,10296,16,30 ),(132,10296,69,15 ),(133,10297,39,60 ),(134,10297,72,20 ),(135,10298,2,40 ),(136,10298,36,40 ),(137,10298,59,30 ),(138,10298,62,15 ),(139,10299,19,15 ),(140,10299,70,20 ),(141,10300,66,30 ),(142,10300,68,20 ),(143,10301,40,10 ),(144,10301,56,20 ),(145,10302,17,40 ),(146,10302,28,28 ),(147,10302,43,12 ),(148,10303,40,40 ),(149,10303,65,30 ),(150,10303,68,15 ),(151,10304,49,30 ),(152,10304,59,10 ),(153,10304,71,2 ),(154,10305,18,25 ),(155,10305,29,25 ),(156,10305,39,30 ),(157,10306,30,10 ),(158,10306,53,10 ),(159,10306,54,5 ),(160,10307,62,10 ),(161,10307,68,3 ),(162,10308,69,1 ),(163,10308,70,5 ),(164,10309,4,20 ),(165,10309,6,30 ),(166,10309,42,2 ),(167,10309,43,20 ),(168,10309,71,3 ),(169,10310,16,10 ),(170,10310,62,5 ),(171,10311,42,6 ),(172,10311,69,7 ),(173,10312,28,4 ),(174,10312,43,24 ),(175,10312,53,20 ),(176,10312,75,10 ),(177,10313,36,12 ),(178,10314,32,40 ),(179,10314,58,30 ),(180,10314,62,25 ),(181,10315,34,14 ),(182,10315,70,30 ),(183,10316,41,10 ),(184,10316,62,70 ),(185,10317,1,20 ),(186,10318,41,20 ),(187,10318,76,6 ),(188,10319,17,8 ),(189,10319,28,14 ),(190,10319,76,30 ),(191,10320,71,30 ),(192,10321,35,10 ),(193,10322,52,20 ),(194,10323,15,5 ),(195,10323,25,4 ),(196,10323,39,4 ),(197,10324,16,21 ),(198,10324,35,70 ),(199,10324,46,30 ),(200,10324,59,40 ),(201,10324,63,80 ),(202,10325,6,6 ),(203,10325,13,12 ),(204,10325,14,9 ),(205,10325,31,4 ),(206,10325,72,40 ),(207,10326,4,24 ),(208,10326,57,16 ),(209,10326,75,50 ),(210,10327,2,25 ),(211,10327,11,50 ),(212,10327,30,35 ),(213,10327,58,30 ),(214,10328,59,9 ),(215,10328,65,40 ),(216,10328,68,10 ),(217,10329,19,10 ),(218,10329,30,8 ),(219,10329,38,20 ),(220,10329,56,12 ),(221,10330,26,50 ),(222,10330,72,25 ),(223,10331,54,15 ),(224,10332,18,40 ),(225,10332,42,10 ),(226,10332,47,16 ),(227,10333,14,10 ),(228,10333,21,10 ),(229,10333,71,40 ),(230,10334,52,8 ),(231,10334,68,10 ),(232,10335,2,7 ),(233,10335,31,25 ),(234,10335,32,6 ),(235,10335,51,48 ),(236,10336,4,18 ),(237,10337,23,40 ),(238,10337,26,24 ),(239,10337,36,20 ),(240,10337,37,28 ),(241,10337,72,25 ),(242,10338,17,20 ),(243,10338,30,15 ),(244,10339,4,10 ),(245,10339,17,70 ),(246,10339,62,28 ),(247,10340,18,20 ),(248,10340,41,12 ),(249,10340,43,40 ),(250,10341,33,8 ),(251,10341,59,9 ),(252,10342,2,24 ),(253,10342,31,56 ),(254,10342,36,40 ),(255,10342,55,40 ),(256,10343,64,50 ),(257,10343,68,4 ),(258,10343,76,15 ),(259,10344,4,35 ),(260,10344,8,70 ),(261,10345,8,70 ),(262,10345,19,80 ),(263,10345,42,9 ),(264,10346,17,36 ),(265,10346,56,20 ),(266,10347,25,10 ),(267,10347,39,50 ),(268,10347,40,4 ),(269,10347,75,6 ),(270,10348,1,15 ),(271,10348,23,25 ),(272,10349,54,24 ),(273,10350,50,15 ),(274,10350,69,18 ),(275,10351,38,20 ),(276,10351,41,13 ),(277,10351,44,77 ),(278,10351,65,10 ),(279,10352,24,10 ),(280,10352,54,20 ),(281,10353,11,12 ),(282,10353,38,50 ),(283,10354,1,12 ),(284,10354,29,4 ),(285,10355,24,25 ),(286,10355,57,25 ),(287,10356,31,30 ),(288,10356,55,12 ),(289,10356,69,20 ),(290,10357,10,30 ),(291,10357,26,16 ),(292,10357,60,8 ),(293,10358,24,10 ),(294,10358,34,10 ),(295,10358,36,20 ),(296,10359,16,56 ),(297,10359,31,70 ),(298,10359,60,80 ),(299,10360,28,30 ),(300,10360,29,35 ),(301,10360,38,10 ),(302,10360,49,35 ),(303,10360,54,28 ),(304,10361,39,54 ),(305,10361,60,55 ),(306,10362,25,50 ),(307,10362,51,20 ),(308,10362,54,24 ),(309,10363,31,20 ),(310,10363,75,12 ),(311,10363,76,12 ),(312,10364,69,30 ),(313,10364,71,5 ),(314,10365,11,24 ),(315,10366,65,5 ),(316,10366,77,5 ),(317,10367,34,36 ),(318,10367,54,18 ),(319,10367,65,15 ),(320,10367,77,7 ),(321,10368,21,5 ),(322,10368,28,13 ),(323,10368,57,25 ),(324,10368,64,35 ),(325,10369,29,20 ),(326,10369,56,18 ),(327,10370,1,15 ),(328,10370,64,30 ),(329,10370,74,20 ),(330,10371,36,6 ),(331,10372,20,12 ),(332,10372,38,40 ),(333,10372,60,70 ),(334,10372,72,42 ),(335,10373,58,80 ),(336,10373,71,50 ),(337,10374,31,30 ),(338,10374,58,15 ),(339,10375,14,15 ),(340,10375,54,10 ),(341,10376,31,42 ),(342,10377,28,20 ),(343,10377,39,20 ),(344,10378,71,6 ),(345,10379,41,8 ),(346,10379,63,16 ),(347,10379,65,20 ),(348,10380,30,18 ),(349,10380,53,20 ),(350,10380,60,6 ),(351,10380,70,30 ),(352,10381,74,14 ),(353,10382,5,32 ),(354,10382,18,9 ),(355,10382,29,14 ),(356,10382,33,60 ),(357,10382,74,50 ),(358,10383,13,20 ),(359,10383,50,15 ),(360,10383,56,20 ),(361,10384,20,28 ),(362,10384,60,15 ),(363,10385,7,10 ),(364,10385,60,20 ),(365,10385,68,8 ),(366,10386,24,15 ),(367,10386,34,10 ),(368,10387,24,15 ),(369,10387,28,6 ),(370,10387,59,12 ),(371,10387,71,15 ),(372,10388,45,15 ),(373,10388,52,20 ),(374,10388,53,40 ),(375,10389,10,16 ),(376,10389,55,15 ),(377,10389,62,20 ),(378,10389,70,30 ),(379,10390,31,60 ),(380,10390,35,40 ),(381,10390,46,45 ),(382,10390,72,24 ),(383,10391,13,18 ),(384,10392,69,50 ),(385,10393,2,25 ),(386,10393,14,42 ),(387,10393,25,7 ),(388,10393,26,70 ),(389,10393,31,32 ),(390,10394,13,10 ),(391,10394,62,10 ),(392,10395,46,28 ),(393,10395,53,70 ),(394,10395,69,8 ),(395,10396,23,40 ),(396,10396,71,60 ),(397,10396,72,21 ),(398,10397,21,10 ),(399,10397,51,18 ),(400,10398,35,30 ),(401,10398,55,120 ),(402,10399,68,60 ),(403,10399,71,30 ),(404,10399,76,35 ),(405,10399,77,14 ),(406,10400,29,21 ),(407,10400,35,35 ),(408,10400,49,30 ),(409,10401,30,18 ),(410,10401,56,70 ),(411,10401,65,20 ),(412,10401,71,60 ),(413,10402,23,60 ),(414,10402,63,65 ),(415,10403,16,21 ),(416,10403,48,70 ),(417,10404,26,30 ),(418,10404,42,40 ),(419,10404,49,30 ),(420,10405,3,50 ),(421,10406,1,10 ),(422,10406,21,30 ),(423,10406,28,42 ),(424,10406,36,5 ),(425,10406,40,2 ),(426,10407,11,30 ),(427,10407,69,15 ),(428,10407,71,15 ),(429,10408,37,10 ),(430,10408,54,6 ),(431,10408,62,35 ),(432,10409,14,12 ),(433,10409,21,12 ),(434,10410,33,49 ),(435,10410,59,16 ),(436,10411,41,25 ),(437,10411,44,40 ),(438,10411,59,9 ),(439,10412,14,20 ),(440,10413,1,24 ),(441,10413,62,40 ),(442,10413,76,14 ),(443,10414,19,18 ),(444,10414,33,50 ),(445,10415,17,2 ),(446,10415,33,20 ),(447,10416,19,20 ),(448,10416,53,10 ),(449,10416,57,20 ),(450,10417,38,50 ),(451,10417,46,2 ),(452,10417,68,36 ),(453,10417,77,35 ),(454,10418,2,60 ),(455,10418,47,55 ),(456,10418,61,16 ),(457,10418,74,15 ),(458,10419,60,60 ),(459,10419,69,20 ),(460,10420,9,20 ),(461,10420,13,2 ),(462,10420,70,8 ),(463,10420,73,20 ),(464,10421,19,4 ),(465,10421,26,30 ),(466,10421,53,15 ),(467,10421,77,10 ),(468,10422,26,2 ),(469,10423,31,14 ),(470,10423,59,20 ),(471,10424,35,60 ),(472,10424,38,49 ),(473,10424,68,30 ),(474,10425,55,10 ),(475,10425,76,20 ),(476,10426,56,5 ),(477,10426,64,7 ),(478,10427,14,35 ),(479,10428,46,20 ),(480,10429,50,40 ),(481,10429,63,35 ),(482,10430,17,45 ),(483,10430,21,50 ),(484,10430,56,30 ),(485,10430,59,70 ),(486,10431,17,50 ),(487,10431,40,50 ),(488,10431,47,30 ),(489,10432,26,10 ),(490,10432,54,40 ),(491,10433,56,28 ),(492,10434,11,6 ),(493,10434,76,18 ),(494,10435,2,10 ),(495,10435,22,12 ),(496,10435,72,10 ),(497,10436,46,5 ),(498,10436,56,40 ),(499,10436,64,30 ),(500,10436,75,24 ),(501,10437,53,15 ),(502,10438,19,15 ),(503,10438,34,20 ),(504,10438,57,15 ),(505,10439,12,15 ),(506,10439,16,16 ),(507,10439,64,6 ),(508,10439,74,30 ),(509,10440,2,45 ),(510,10440,16,49 ),(511,10440,29,24 ),(512,10440,61,90 ),(513,10441,27,50 ),(514,10442,11,30 ),(515,10442,54,80 ),(516,10442,66,60 ),(517,10443,11,6 ),(518,10443,28,12 );

INSERT INTO  orders
(OrderID,CustomerID,EmployeeID,OrderDate,ShipperID)
VALUES
(10248,90,5,"1996-07-04",3),(10249,81,6,"1996-07-05",1),(10250,34,4,"1996-07-08",2),(10251,84,3,"1996-07-08",1),(10252,76,4,"1996-07-09",2),(10253,34,3,"1996-07-10",2),(10254,14,5,"1996-07-11",2),(10255,68,9,"1996-07-12",3),(10256,88,3,"1996-07-15",2),(10257,35,4,"1996-07-16",3),(10258,20,1,"1996-07-17",1),(10259,13,4,"1996-07-18",3),(10260,55,4,"1996-07-19",1),(10261,61,4,"1996-07-19",2),(10262,65,8,"1996-07-22",3),(10263,20,9,"1996-07-23",3),(10264,24,6,"1996-07-24",3),(10265,7,2,"1996-07-25",1),(10266,87,3,"1996-07-26",3),(10267,25,4,"1996-07-29",1),(10268,33,8,"1996-07-30",3),(10269,89,5,"1996-07-31",1),(10270,87,1,"1996-08-01",1),(10271,75,6,"1996-08-01",2),(10272,65,6,"1996-08-02",2),(10273,63,3,"1996-08-05",3),(10274,85,6,"1996-08-06",1),(10275,49,1,"1996-08-07",1),(10276,80,8,"1996-08-08",3),(10277,52,2,"1996-08-09",3),(10278,5,8,"1996-08-12",2),(10279,44,8,"1996-08-13",2),(10280,5,2,"1996-08-14",1),(10281,69,4,"1996-08-14",1),(10282,69,4,"1996-08-15",1),(10283,46,3,"1996-08-16",3),(10284,44,4,"1996-08-19",1),(10285,63,1,"1996-08-20",2),(10286,63,8,"1996-08-21",3),(10287,67,8,"1996-08-22",3),(10288,66,4,"1996-08-23",1),(10289,11,7,"1996-08-26",3),(10290,15,8,"1996-08-27",1),(10291,61,6,"1996-08-27",2),(10292,81,1,"1996-08-28",2),(10293,80,1,"1996-08-29",3),(10294,65,4,"1996-08-30",2),(10295,85,2,"1996-09-02",2),(10296,46,6,"1996-09-03",1),(10297,7,5,"1996-09-04",2),(10298,37,6,"1996-09-05",2),(10299,67,4,"1996-09-06",2),(10300,49,2,"1996-09-09",2),(10301,86,8,"1996-09-09",2),(10302,76,4,"1996-09-10",2),(10303,30,7,"1996-09-11",2),(10304,80,1,"1996-09-12",2),(10305,55,8,"1996-09-13",3),(10306,69,1,"1996-09-16",3),(10307,48,2,"1996-09-17",2),(10308,2,7,"1996-09-18",3),(10309,37,3,"1996-09-19",1),(10310,77,8,"1996-09-20",2),(10311,18,1,"1996-09-20",3),(10312,86,2,"1996-09-23",2),(10313,63,2,"1996-09-24",2),(10314,65,1,"1996-09-25",2),(10315,38,4,"1996-09-26",2),(10316,65,1,"1996-09-27",3),(10317,48,6,"1996-09-30",1),(10318,38,8,"1996-10-01",2),(10319,80,7,"1996-10-02",3),(10320,87,5,"1996-10-03",3),(10321,38,3,"1996-10-03",2),(10322,58,7,"1996-10-04",3),(10323,39,4,"1996-10-07",1),(10324,71,9,"1996-10-08",1),(10325,39,1,"1996-10-09",3),(10326,8,4,"1996-10-10",2),(10327,24,2,"1996-10-11",1),(10328,28,4,"1996-10-14",3),(10329,75,4,"1996-10-15",2),(10330,46,3,"1996-10-16",1),(10331,9,9,"1996-10-16",1),(10332,51,3,"1996-10-17",2),(10333,87,5,"1996-10-18",3),(10334,84,8,"1996-10-21",2),(10335,37,7,"1996-10-22",2),(10336,60,7,"1996-10-23",2),(10337,25,4,"1996-10-24",3),(10338,55,4,"1996-10-25",3),(10339,51,2,"1996-10-28",2),(10340,9,1,"1996-10-29",3),(10341,73,7,"1996-10-29",3),(10342,25,4,"1996-10-30",2),(10343,44,4,"1996-10-31",1),(10344,89,4,"1996-11-01",2),(10345,63,2,"1996-11-04",2),(10346,65,3,"1996-11-05",3),(10347,21,4,"1996-11-06",3),(10348,86,4,"1996-11-07",2),(10349,75,7,"1996-11-08",1),(10350,41,6,"1996-11-11",2),(10351,20,1,"1996-11-11",1),(10352,28,3,"1996-11-12",3),(10353,59,7,"1996-11-13",3),(10354,58,8,"1996-11-14",3),(10355,4,6,"1996-11-15",1),(10356,86,6,"1996-11-18",2),(10357,46,1,"1996-11-19",3),(10358,41,5,"1996-11-20",1),(10359,72,5,"1996-11-21",3),(10360,7,4,"1996-11-22",3),(10361,63,1,"1996-11-22",2),(10362,9,3,"1996-11-25",1),(10363,17,4,"1996-11-26",3),(10364,19,1,"1996-11-26",1),(10365,3,3,"1996-11-27",2),(10366,29,8,"1996-11-28",2),(10367,83,7,"1996-11-28",3),(10368,20,2,"1996-11-29",2),(10369,75,8,"1996-12-02",2),(10370,14,6,"1996-12-03",2),(10371,41,1,"1996-12-03",1),(10372,62,5,"1996-12-04",2),(10373,37,4,"1996-12-05",3),(10374,91,1,"1996-12-05",3),(10375,36,3,"1996-12-06",2),(10376,51,1,"1996-12-09",2),(10377,72,1,"1996-12-09",3),(10378,24,5,"1996-12-10",3),(10379,61,2,"1996-12-11",1),(10380,37,8,"1996-12-12",3),(10381,46,3,"1996-12-12",3),(10382,20,4,"1996-12-13",1),(10383,4,8,"1996-12-16",3),(10384,5,3,"1996-12-16",3),(10385,75,1,"1996-12-17",2),(10386,21,9,"1996-12-18",3),(10387,70,1,"1996-12-18",2),(10388,72,2,"1996-12-19",1),(10389,10,4,"1996-12-20",2),(10390,20,6,"1996-12-23",1),(10391,17,3,"1996-12-23",3),(10392,59,2,"1996-12-24",3),(10393,71,1,"1996-12-25",3),(10394,36,1,"1996-12-25",3),(10395,35,6,"1996-12-26",1),(10396,25,1,"1996-12-27",3),(10397,60,5,"1996-12-27",1),(10398,71,2,"1996-12-30",3),(10399,83,8,"1996-12-31",3),(10400,19,1,"1997-01-01",3),(10401,65,1,"1997-01-01",1),(10402,20,8,"1997-01-02",2),(10403,20,4,"1997-01-03",3),(10404,49,2,"1997-01-03",1),(10405,47,1,"1997-01-06",1),(10406,62,7,"1997-01-07",1),(10407,56,2,"1997-01-07",2),(10408,23,8,"1997-01-08",1),(10409,54,3,"1997-01-09",1),(10410,10,3,"1997-01-10",3),(10411,10,9,"1997-01-10",3),(10412,87,8,"1997-01-13",2),(10413,41,3,"1997-01-14",2),(10414,21,2,"1997-01-14",3),(10415,36,3,"1997-01-15",1),(10416,87,8,"1997-01-16",3),(10417,73,4,"1997-01-16",3),(10418,63,4,"1997-01-17",1),(10419,68,4,"1997-01-20",2),(10420,88,3,"1997-01-21",1),(10421,61,8,"1997-01-21",1),(10422,27,2,"1997-01-22",1),(10423,31,6,"1997-01-23",3),(10424,51,7,"1997-01-23",2),(10425,41,6,"1997-01-24",2),(10426,29,4,"1997-01-27",1),(10427,59,4,"1997-01-27",2),(10428,66,7,"1997-01-28",1),(10429,37,3,"1997-01-29",2),(10430,20,4,"1997-01-30",1),(10431,10,4,"1997-01-30",2),(10432,75,3,"1997-01-31",2),(10433,60,3,"1997-02-03",3),(10434,24,3,"1997-02-03",2),(10435,16,8,"1997-02-04",2),(10436,7,3,"1997-02-05",2),(10437,87,8,"1997-02-05",1),(10438,79,3,"1997-02-06",2),(10439,51,6,"1997-02-07",3),(10440,71,4,"1997-02-10",2),(10441,55,3,"1997-02-10",2),(10442,20,3,"1997-02-11",2),(10443,66,8,"1997-02-12",1),(10444,5,3,"1997-02-12",3),(10445,5,3,"1997-02-13",1),(10446,79,6,"1997-02-14",1),(10447,67,4,"1997-02-14",2),(10448,64,4,"1997-02-17",2),(10449,7,3,"1997-02-18",2),(10450,84,8,"1997-02-19",2),(10451,63,4,"1997-02-19",3),(10452,71,8,"1997-02-20",1),(10453,4,1,"1997-02-21",2),(10454,41,4,"1997-02-21",3),(10455,87,8,"1997-02-24",2),(10456,39,8,"1997-02-25",2),(10457,39,2,"1997-02-25",1),(10458,76,7,"1997-02-26",3),(10459,84,4,"1997-02-27",2),(10460,24,8,"1997-02-28",1),(10461,46,1,"1997-02-28",3),(10462,16,2,"1997-03-03",1),(10463,76,5,"1997-03-04",3),(10464,28,4,"1997-03-04",2),(10465,83,1,"1997-03-05",3),(10466,15,4,"1997-03-06",1),(10467,49,8,"1997-03-06",2),(10468,39,3,"1997-03-07",3),(10469,89,1,"1997-03-10",1),(10470,9,4,"1997-03-11",2),(10471,11,2,"1997-03-11",3),(10472,72,8,"1997-03-12",1),(10473,38,1,"1997-03-13",3),(10474,58,5,"1997-03-13",2),(10475,76,9,"1997-03-14",1),(10476,35,8,"1997-03-17",3),(10477,60,5,"1997-03-17",2),(10478,84,2,"1997-03-18",3),(10479,65,3,"1997-03-19",3),(10480,23,6,"1997-03-20",2),(10481,67,8,"1997-03-20",2),(10482,43,1,"1997-03-21",3),(10483,89,7,"1997-03-24",2),(10484,11,3,"1997-03-24",3),(10485,47,4,"1997-03-25",2),(10486,35,1,"1997-03-26",2),(10487,62,2,"1997-03-26",2),(10488,25,8,"1997-03-27",2),(10489,59,6,"1997-03-28",2),(10490,35,7,"1997-03-31",2),(10491,28,8,"1997-03-31",3),(10492,10,3,"1997-04-01",1),(10493,41,4,"1997-04-02",3),(10494,15,4,"1997-04-02",2),(10495,42,3,"1997-04-03",3),(10496,81,7,"1997-04-04",2),(10497,44,7,"1997-04-04",1),(10498,35,8,"1997-04-07",2),(10499,46,4,"1997-04-08",2),(10500,41,6,"1997-04-09",1),(10501,6,9,"1997-04-09",3),(10502,58,2,"1997-04-10",1),(10503,37,6,"1997-04-11",2),(10504,89,4,"1997-04-11",3),(10505,51,3,"1997-04-14",3),(10506,39,9,"1997-04-15",2),(10507,3,7,"1997-04-15",1),(10508,56,1,"1997-04-16",2),(10509,6,4,"1997-04-17",1),(10510,71,6,"1997-04-18",3),(10511,9,4,"1997-04-18",3),(10512,21,7,"1997-04-21",2),(10513,86,7,"1997-04-22",1),(10514,20,3,"1997-04-22",2),(10515,63,2,"1997-04-23",1),(10516,37,2,"1997-04-24",3),(10517,53,3,"1997-04-24",3),(10518,80,4,"1997-04-25",2),(10519,14,6,"1997-04-28",3),(10520,70,7,"1997-04-29",1),(10521,12,8,"1997-04-29",2),(10522,44,4,"1997-04-30",1),(10523,72,7,"1997-05-01",2),(10524,5,1,"1997-05-01",2),(10525,9,1,"1997-05-02",2),(10526,87,4,"1997-05-05",2),(10527,63,7,"1997-05-05",1),(10528,32,6,"1997-05-06",2),(10529,50,5,"1997-05-07",2),(10530,59,3,"1997-05-08",2),(10531,54,7,"1997-05-08",1),(10532,19,7,"1997-05-09",3),(10533,24,8,"1997-05-12",1),(10534,44,8,"1997-05-12",2),(10535,3,4,"1997-05-13",1),(10536,44,3,"1997-05-14",2),(10537,68,1,"1997-05-14",1),(10538,11,9,"1997-05-15",3),(10539,11,6,"1997-05-16",3),(10540,63,3,"1997-05-19",3),(10541,34,2,"1997-05-19",1),(10542,39,1,"1997-05-20",3),(10543,46,8,"1997-05-21",2),(10544,48,4,"1997-05-21",1),(10545,43,8,"1997-05-22",2),(10546,84,1,"1997-05-23",3),(10547,72,3,"1997-05-23",2),(10548,79,3,"1997-05-26",2),(10549,63,5,"1997-05-27",1),(10550,30,7,"1997-05-28",3),(10551,28,4,"1997-05-28",3),(10552,35,2,"1997-05-29",1),(10553,87,2,"1997-05-30",2),(10554,56,4,"1997-05-30",3),(10555,71,6,"1997-06-02",3),(10556,73,2,"1997-06-03",1),(10557,44,9,"1997-06-03",2),(10558,4,1,"1997-06-04",2),(10559,7,6,"1997-06-05",1),(10560,25,8,"1997-06-06",1),(10561,24,2,"1997-06-06",2),(10562,66,1,"1997-06-09",1),(10563,67,2,"1997-06-10",2),(10564,65,4,"1997-06-10",3),(10565,51,8,"1997-06-11",2),(10566,7,9,"1997-06-12",1),(10567,37,1,"1997-06-12",1),(10568,29,3,"1997-06-13",3),(10569,65,5,"1997-06-16",1),(10570,51,3,"1997-06-17",3),(10571,20,8,"1997-06-17",3),(10572,5,3,"1997-06-18",2),(10573,3,7,"1997-06-19",3),(10574,82,4,"1997-06-19",2),(10575,52,5,"1997-06-20",1),(10576,80,3,"1997-06-23",3),(10577,82,9,"1997-06-23",2),(10578,11,4,"1997-06-24",3),(10579,45,1,"1997-06-25",2),(10580,56,4,"1997-06-26",3),(10581,21,3,"1997-06-26",1),(10582,6,3,"1997-06-27",2),(10583,87,2,"1997-06-30",2),(10584,7,4,"1997-06-30",1),(10585,88,7,"1997-07-01",1),(10586,66,9,"1997-07-02",1),(10587,61,1,"1997-07-02",1),(10588,63,2,"1997-07-03",3),(10589,32,8,"1997-07-04",2),(10590,51,4,"1997-07-07",3),(10591,83,1,"1997-07-07",1),(10592,44,3,"1997-07-08",1),(10593,44,7,"1997-07-09",2),(10594,55,3,"1997-07-09",2),(10595,20,2,"1997-07-10",1),(10596,89,8,"1997-07-11",1),(10597,59,7,"1997-07-11",3),(10598,65,1,"1997-07-14",3),(10599,11,6,"1997-07-15",3),(10600,36,4,"1997-07-16",1),(10601,35,7,"1997-07-16",1),(10602,83,8,"1997-07-17",2),(10603,71,8,"1997-07-18",2),(10604,28,1,"1997-07-18",1),(10605,51,1,"1997-07-21",2),(10606,81,4,"1997-07-22",3),(10607,71,5,"1997-07-22",1),(10608,79,4,"1997-07-23",2),(10609,18,7,"1997-07-24",2),(10610,41,8,"1997-07-25",1),(10611,91,6,"1997-07-25",2),(10612,71,1,"1997-07-28",2),(10613,35,4,"1997-07-29",2),(10614,6,8,"1997-07-29",3),(10615,90,2,"1997-07-30",3),(10616,32,1,"1997-07-31",2),(10617,32,4,"1997-07-31",2),(10618,51,1,"1997-08-01",1),(10619,51,3,"1997-08-04",3),(10620,42,2,"1997-08-05",3),(10621,38,4,"1997-08-05",2),(10622,67,4,"1997-08-06",3),(10623,25,8,"1997-08-07",2),(10624,78,4,"1997-08-07",2),(10625,2,3,"1997-08-08",1),(10626,5,1,"1997-08-11",2),(10627,71,8,"1997-08-11",3),(10628,7,4,"1997-08-12",3),(10629,30,4,"1997-08-12",3),(10630,39,1,"1997-08-13",2),(10631,41,8,"1997-08-14",1),(10632,86,8,"1997-08-14",1),(10633,20,7,"1997-08-15",3),(10634,23,4,"1997-08-15",3),(10635,49,8,"1997-08-18",3),(10636,87,4,"1997-08-19",1),(10637,62,6,"1997-08-19",1),(10638,47,3,"1997-08-20",1),(10639,70,7,"1997-08-20",3),(10640,86,4,"1997-08-21",1),(10641,35,4,"1997-08-22",2),(10642,73,7,"1997-08-22",3),(10643,1,6,"1997-08-25",1),(10644,88,3,"1997-08-25",2),(10645,34,4,"1997-08-26",1),(10646,37,9,"1997-08-27",3),(10647,61,4,"1997-08-27",2),(10648,67,5,"1997-08-28",2),(10649,50,5,"1997-08-28",3),(10650,21,5,"1997-08-29",3),(10651,86,8,"1997-09-01",2),(10652,31,4,"1997-09-01",2),(10653,25,1,"1997-09-02",1),(10654,5,5,"1997-09-02",1),(10655,66,1,"1997-09-03",2),(10656,32,6,"1997-09-04",1),(10657,71,2,"1997-09-04",2),(10658,63,4,"1997-09-05",1),(10659,62,7,"1997-09-05",2),(10660,36,8,"1997-09-08",1),(10661,37,7,"1997-09-09",3),(10662,48,3,"1997-09-09",2),(10663,9,2,"1997-09-10",2),(10664,28,1,"1997-09-10",3),(10665,48,1,"1997-09-11",2),(10666,68,7,"1997-09-12",2),(10667,20,7,"1997-09-12",1),(10668,86,1,"1997-09-15",2),(10669,73,2,"1997-09-15",1),(10670,25,4,"1997-09-16",1),(10671,26,1,"1997-09-17",1),(10672,5,9,"1997-09-17",2),(10673,90,2,"1997-09-18",1),(10674,38,4,"1997-09-18",2),(10675,25,5,"1997-09-19",2),(10676,80,2,"1997-09-22",2),(10677,3,1,"1997-09-22",3),(10678,71,7,"1997-09-23",3),(10679,7,8,"1997-09-23",3),(10680,55,1,"1997-09-24",1),(10681,32,3,"1997-09-25",3),(10682,3,3,"1997-09-25",2),(10683,18,2,"1997-09-26",1),(10684,56,3,"1997-09-26",1),(10685,31,4,"1997-09-29",2),(10686,59,2,"1997-09-30",1),(10687,37,9,"1997-09-30",2),(10688,83,4,"1997-10-01",2),(10689,5,1,"1997-10-01",2),(10690,34,1,"1997-10-02",1),(10691,63,2,"1997-10-03",2),(10692,1,4,"1997-10-03",2),(10693,89,3,"1997-10-06",3),(10694,63,8,"1997-10-06",3),(10695,90,7,"1997-10-07",1),(10696,89,8,"1997-10-08",3),(10697,47,3,"1997-10-08",1),(10698,20,4,"1997-10-09",1),(10699,52,3,"1997-10-09",3),(10700,71,3,"1997-10-10",1),(10701,37,6,"1997-10-13",3),(10702,1,4,"1997-10-13",1),(10703,24,6,"1997-10-14",2),(10704,62,6,"1997-10-14",1),(10705,35,9,"1997-10-15",2),(10706,55,8,"1997-10-16",3),(10707,4,4,"1997-10-16",3),(10708,77,6,"1997-10-17",2),(10709,31,1,"1997-10-17",3),(10710,27,1,"1997-10-20",1),(10711,71,5,"1997-10-21",2),(10712,37,3,"1997-10-21",1),(10713,71,1,"1997-10-22",1),(10714,71,5,"1997-10-22",3),(10715,9,3,"1997-10-23",1),(10716,64,4,"1997-10-24",2),(10717,25,1,"1997-10-24",2),(10718,39,1,"1997-10-27",3),(10719,45,8,"1997-10-27",2),(10720,61,8,"1997-10-28",2),(10721,63,5,"1997-10-29",3),(10722,71,8,"1997-10-29",1),(10723,89,3,"1997-10-30",1),(10724,51,8,"1997-10-30",2),(10725,21,4,"1997-10-31",3),(10726,19,4,"1997-11-03",1),(10727,66,2,"1997-11-03",1),(10728,62,4,"1997-11-04",2),(10729,47,8,"1997-11-04",3),(10730,9,5,"1997-11-05",1),(10731,14,7,"1997-11-06",1),(10732,9,3,"1997-11-06",1),(10733,5,1,"1997-11-07",3),(10734,31,2,"1997-11-07",3),(10735,45,6,"1997-11-10",2),(10736,37,9,"1997-11-11",2),(10737,85,2,"1997-11-11",2),(10738,74,2,"1997-11-12",1),(10739,85,3,"1997-11-12",3),(10740,89,4,"1997-11-13",2),(10741,4,4,"1997-11-14",3),(10742,10,3,"1997-11-14",3),(10743,4,1,"1997-11-17",2),(10744,83,6,"1997-11-17",1),(10745,63,9,"1997-11-18",1),(10746,14,1,"1997-11-19",3),(10747,59,6,"1997-11-19",1),(10748,71,3,"1997-11-20",1),(10749,38,4,"1997-11-20",2),(10750,87,9,"1997-11-21",1),(10751,68,3,"1997-11-24",3),(10752,53,2,"1997-11-24",3),(10753,27,3,"1997-11-25",1),(10754,49,6,"1997-11-25",3),(10755,9,4,"1997-11-26",2),(10756,75,8,"1997-11-27",2),(10757,71,6,"1997-11-27",1),(10758,68,3,"1997-11-28",3),(10759,2,3,"1997-11-28",3),(10760,50,4,"1997-12-01",1),(10761,65,5,"1997-12-02",2),(10762,24,3,"1997-12-02",1),(10763,23,3,"1997-12-03",3),(10764,20,6,"1997-12-03",3),(10765,63,3,"1997-12-04",3),(10766,56,4,"1997-12-05",1),(10767,76,4,"1997-12-05",3),(10768,4,3,"1997-12-08",2),(10769,83,3,"1997-12-08",1),(10770,34,8,"1997-12-09",3),(10771,20,9,"1997-12-10",2),(10772,44,3,"1997-12-10",2),(10773,20,1,"1997-12-11",3),(10774,24,4,"1997-12-11",1),(10775,78,7,"1997-12-12",1),(10776,20,1,"1997-12-15",3),(10777,31,7,"1997-12-15",2),(10778,5,3,"1997-12-16",1),(10779,52,3,"1997-12-16",2),(10780,46,2,"1997-12-16",1),(10781,87,2,"1997-12-17",3),(10782,12,9,"1997-12-17",3),(10783,34,4,"1997-12-18",2),(10784,49,4,"1997-12-18",3),(10785,33,1,"1997-12-18",3),(10786,62,8,"1997-12-19",1),(10787,41,2,"1997-12-19",1),(10788,63,1,"1997-12-22",2),(10789,23,1,"1997-12-22",2),(10790,31,6,"1997-12-22",1),(10791,25,6,"1997-12-23",2),(10792,91,1,"1997-12-23",3),(10793,4,3,"1997-12-24",3),(10794,61,6,"1997-12-24",1),(10795,20,8,"1997-12-24",2),(10796,35,3,"1997-12-25",1),(10797,17,7,"1997-12-25",2),(10798,38,2,"1997-12-26",1),(10799,39,9,"1997-12-26",3),(10800,72,1,"1997-12-26",3),(10801,8,4,"1997-12-29",2),(10802,73,4,"1997-12-29",2),(10803,88,4,"1997-12-30",1),(10804,72,6,"1997-12-30",2),(10805,77,2,"1997-12-30",3),(10806,84,3,"1997-12-31",2),(10807,27,4,"1997-12-31",1),(10808,60,2,"1998-01-01",3),(10809,88,7,"1998-01-01",1),(10810,42,2,"1998-01-01",3),(10811,47,8,"1998-01-02",1),(10812,66,5,"1998-01-02",1),(10813,67,1,"1998-01-05",1),(10814,84,3,"1998-01-05",3),(10815,71,2,"1998-01-05",3),(10816,32,4,"1998-01-06",2),(10817,39,3,"1998-01-06",2),(10818,49,7,"1998-01-07",3),(10819,12,2,"1998-01-07",3),(10820,65,3,"1998-01-07",2),(10821,75,1,"1998-01-08",1),(10822,82,6,"1998-01-08",3),(10823,46,5,"1998-01-09",2),(10824,24,8,"1998-01-09",1),(10825,17,1,"1998-01-09",1),(10826,7,6,"1998-01-12",1),(10827,9,1,"1998-01-12",2),(10828,64,9,"1998-01-13",1),(10829,38,9,"1998-01-13",1),(10830,81,4,"1998-01-13",2),(10831,70,3,"1998-01-14",2),(10832,41,2,"1998-01-14",2),(10833,56,6,"1998-01-15",2),(10834,81,1,"1998-01-15",3),(10835,1,1,"1998-01-15",3),(10836,20,7,"1998-01-16",1),(10837,5,9,"1998-01-16",3),(10838,47,3,"1998-01-19",3),(10839,81,3,"1998-01-19",3),(10840,47,4,"1998-01-19",2),(10841,76,5,"1998-01-20",2),(10842,80,1,"1998-01-20",3),(10843,84,4,"1998-01-21",2),(10844,59,8,"1998-01-21",2),(10845,63,8,"1998-01-21",1),(10846,76,2,"1998-01-22",3),(10847,71,4,"1998-01-22",3),(10848,16,7,"1998-01-23",2),(10849,39,9,"1998-01-23",2),(10850,84,1,"1998-01-23",1),(10851,67,5,"1998-01-26",1),(10852,65,8,"1998-01-26",1),(10853,6,9,"1998-01-27",2),(10854,20,3,"1998-01-27",2),(10855,55,3,"1998-01-27",1),(10856,3,3,"1998-01-28",2),(10857,5,8,"1998-01-28",2),(10858,40,2,"1998-01-29",1),(10859,25,1,"1998-01-29",2),(10860,26,3,"1998-01-29",3),(10861,89,4,"1998-01-30",2),(10862,44,8,"1998-01-30",2),(10863,35,4,"1998-02-02",2),(10864,4,4,"1998-02-02",2),(10865,63,2,"1998-02-02",1),(10866,5,5,"1998-02-03",1),(10867,48,6,"1998-02-03",1),(10868,62,7,"1998-02-04",2),(10869,72,5,"1998-02-04",1),(10870,91,5,"1998-02-04",3),(10871,9,9,"1998-02-05",2),(10872,30,5,"1998-02-05",2),(10873,90,4,"1998-02-06",1),(10874,30,5,"1998-02-06",2),(10875,5,4,"1998-02-06",2),(10876,9,7,"1998-02-09",3),(10877,67,1,"1998-02-09",1),(10878,63,4,"1998-02-10",1),(10879,90,3,"1998-02-10",3),(10880,24,7,"1998-02-10",1),(10881,12,4,"1998-02-11",1),(10882,71,4,"1998-02-11",3),(10883,48,8,"1998-02-12",3),(10884,45,4,"1998-02-12",2),(10885,76,6,"1998-02-12",3),(10886,34,1,"1998-02-13",1),(10887,29,8,"1998-02-13",3),(10888,30,1,"1998-02-16",2),(10889,65,9,"1998-02-16",3),(10890,18,7,"1998-02-16",1),(10891,44,7,"1998-02-17",2),(10892,50,4,"1998-02-17",2),(10893,39,9,"1998-02-18",2),(10894,71,1,"1998-02-18",1),(10895,20,3,"1998-02-18",1),(10896,50,7,"1998-02-19",3),(10897,37,3,"1998-02-19",2),(10898,54,4,"1998-02-20",2),(10899,46,5,"1998-02-20",3),(10900,88,1,"1998-02-20",2),(10901,35,4,"1998-02-23",1),(10902,24,1,"1998-02-23",1),(10903,34,3,"1998-02-24",3),(10904,89,3,"1998-02-24",3),(10905,88,9,"1998-02-24",2),(10906,91,4,"1998-02-25",3),(10907,74,6,"1998-02-25",3),(10908,66,4,"1998-02-26",2),(10909,70,1,"1998-02-26",2),(10910,90,1,"1998-02-26",3),(10911,30,3,"1998-02-26",1),(10912,37,2,"1998-02-26",2),(10913,62,4,"1998-02-26",1),(10914,62,6,"1998-02-27",1),(10915,80,2,"1998-02-27",2),(10916,64,1,"1998-02-27",2),(10917,69,4,"1998-03-02",2),(10918,10,3,"1998-03-02",3),(10919,47,2,"1998-03-02",2),(10920,4,4,"1998-03-03",2),(10921,83,1,"1998-03-03",1),(10922,34,5,"1998-03-03",3),(10923,41,7,"1998-03-03",3),(10924,5,3,"1998-03-04",2),(10925,34,3,"1998-03-04",1),(10926,2,4,"1998-03-04",3),(10927,40,4,"1998-03-05",1),(10928,29,1,"1998-03-05",1),(10929,25,6,"1998-03-05",1),(10930,76,4,"1998-03-06",3),(10931,68,4,"1998-03-06",2),(10932,9,8,"1998-03-06",1),(10933,38,6,"1998-03-06",3),(10934,44,3,"1998-03-09",3),(10935,88,4,"1998-03-09",3),(10936,32,3,"1998-03-09",2),(10937,12,7,"1998-03-10",3),(10938,63,3,"1998-03-10",2),(10939,49,2,"1998-03-10",2),(10940,9,8,"1998-03-11",3),(10941,71,7,"1998-03-11",2),(10942,66,9,"1998-03-11",3),(10943,11,4,"1998-03-11",2),(10944,10,6,"1998-03-12",3),(10945,52,4,"1998-03-12",1),(10946,83,1,"1998-03-12",2),(10947,11,3,"1998-03-13",2),(10948,30,3,"1998-03-13",3),(10949,10,2,"1998-03-13",3),(10950,49,1,"1998-03-16",2),(10951,68,9,"1998-03-16",2),(10952,1,1,"1998-03-16",1),(10953,4,9,"1998-03-16",2),(10954,47,5,"1998-03-17",1),(10955,24,8,"1998-03-17",2),(10956,6,6,"1998-03-17",2),(10957,35,8,"1998-03-18",3),(10958,54,7,"1998-03-18",2),(10959,31,6,"1998-03-18",2),(10960,35,3,"1998-03-19",1),(10961,62,8,"1998-03-19",1),(10962,63,8,"1998-03-19",2),(10963,28,9,"1998-03-19",3),(10964,74,3,"1998-03-20",2),(10965,55,6,"1998-03-20",3),(10966,14,4,"1998-03-20",1),(10967,79,2,"1998-03-23",2),(10968,20,1,"1998-03-23",3),(10969,15,1,"1998-03-23",2),(10970,8,9,"1998-03-24",1),(10971,26,2,"1998-03-24",2),(10972,40,4,"1998-03-24",2),(10973,40,6,"1998-03-24",2),(10974,75,3,"1998-03-25",3),(10975,10,1,"1998-03-25",3),(10976,35,1,"1998-03-25",1),(10977,24,8,"1998-03-26",3),(10978,50,9,"1998-03-26",2),(10979,20,8,"1998-03-26",2),(10980,24,4,"1998-03-27",1),(10981,34,1,"1998-03-27",2),(10982,10,2,"1998-03-27",1),(10983,71,2,"1998-03-27",2),(10984,71,1,"1998-03-30",3),(10985,37,2,"1998-03-30",1),(10986,54,8,"1998-03-30",2),(10987,19,8,"1998-03-31",1),(10988,65,3,"1998-03-31",2),(10989,61,2,"1998-03-31",1),(10990,20,2,"1998-04-01",3),(10991,63,1,"1998-04-01",1),(10992,77,1,"1998-04-01",3),(10993,24,7,"1998-04-01",3),(10994,83,2,"1998-04-02",3),(10995,58,1,"1998-04-02",3),(10996,63,4,"1998-04-02",2),(10997,46,8,"1998-04-03",2),(10998,91,8,"1998-04-03",2),(10999,56,6,"1998-04-03",2),(11000,65,2,"1998-04-06",3),(11001,24,2,"1998-04-06",2),(11002,71,4,"1998-04-06",1),(11003,78,3,"1998-04-06",3),(11004,50,3,"1998-04-07",1),(11005,90,2,"1998-04-07",1),(11006,32,3,"1998-04-07",2),(11007,60,8,"1998-04-08",2),(11008,20,7,"1998-04-08",3),(11009,30,2,"1998-04-08",1),(11010,66,2,"1998-04-09",2),(11011,1,3,"1998-04-09",1),(11012,25,1,"1998-04-09",3),(11013,69,2,"1998-04-09",1),(11014,47,2,"1998-04-10",3),(11015,70,2,"1998-04-10",2),(11016,4,9,"1998-04-10",2),(11017,20,9,"1998-04-13",2),(11018,48,4,"1998-04-13",2),(11019,64,6,"1998-04-13",3),(11020,56,2,"1998-04-14",2),(11021,63,3,"1998-04-14",1),(11022,34,9,"1998-04-14",2),(11023,11,1,"1998-04-14",2),(11024,19,4,"1998-04-15",1),(11025,87,6,"1998-04-15",3),(11026,27,4,"1998-04-15",1),(11027,10,1,"1998-04-16",1),(11028,39,2,"1998-04-16",1),(11029,14,4,"1998-04-16",1),(11030,71,7,"1998-04-17",2),(11031,71,6,"1998-04-17",2),(11032,89,2,"1998-04-17",3),(11033,68,7,"1998-04-17",3),(11034,55,8,"1998-04-20",1),(11035,76,2,"1998-04-20",2),(11036,17,8,"1998-04-20",3),(11037,30,7,"1998-04-21",1),(11038,76,1,"1998-04-21",2),(11039,47,1,"1998-04-21",2),(11040,32,4,"1998-04-22",3),(11041,14,3,"1998-04-22",2),(11042,15,2,"1998-04-22",1),(11043,74,5,"1998-04-22",2),(11044,91,4,"1998-04-23",1),(11045,10,6,"1998-04-23",2),(11046,86,8,"1998-04-23",2),(11047,19,7,"1998-04-24",3),(11048,10,7,"1998-04-24",3),(11049,31,3,"1998-04-24",1),(11050,24,8,"1998-04-27",2),(11051,41,7,"1998-04-27",3),(11052,34,3,"1998-04-27",1),(11053,59,2,"1998-04-27",2),(11054,12,8,"1998-04-28",1),(11055,35,7,"1998-04-28",2),(11056,19,8,"1998-04-28",2),(11057,53,3,"1998-04-29",3),(11058,6,9,"1998-04-29",3),(11059,67,2,"1998-04-29",2),(11060,27,2,"1998-04-30",2),(11061,32,4,"1998-04-30",3),(11062,66,4,"1998-04-30",2),(11063,37,3,"1998-04-30",2),(11064,71,1,"1998-05-01",1),(11065,46,8,"1998-05-01",1),(11066,89,7,"1998-05-01",2),(11067,17,1,"1998-05-04",2),(11068,62,8,"1998-05-04",2),(11069,80,1,"1998-05-04",2),(11070,44,2,"1998-05-05",1),(11071,46,1,"1998-05-05",1),(11072,20,4,"1998-05-05",2),(11073,58,2,"1998-05-05",2),(11074,73,7,"1998-05-06",2),(11075,68,8,"1998-05-06",2),(11076,9,4,"1998-05-06",2),(11077,65,1,"1998-05-06",2);

INSERT INTO  products
(ProductID, ProductName, SupplierID, CategoryID,Unit, Price)
VALUES
(1,"Chais ",1,1,"10 boxes x 20 bags ",18 ),(2,"Chang ",1,1,"24 - 12 oz bottles ",19 ),(3,"Aniseed Syrup ",1,2,"12 - 550 ml bottles ",10 ),(4,"Chef Anton's Cajun Seasoning ",2,2,"48 - 6 oz jars ",22 ),(5,"Chef Anton's Gumbo Mix ",2,2,"36 boxes ",21.35 ),(6,"Grandma's Boysenberry Spread ",3,2,"12 - 8 oz jars ",25 ),(7,"Uncle Bob's Organic Dried Pears ",3,7,"12 - 1 lb pkgs. ",30 ),(8,"Northwoods Cranberry Sauce ",3,2,"12 - 12 oz jars ",40 ),(9,"Mishi Kobe Niku ",4,6,"18 - 500 g pkgs. ",97 ),(10,"Ikura ",4,8,"12 - 200 ml jars ",31 ),(11,"Queso Cabrales ",5,4,"1 kg pkg. ",21 ),(12,"Queso Manchego La Pastora ",5,4,"10 - 500 g pkgs. ",38 ),(13,"Konbu ",6,8,"2 kg box ",6 ),(14,"Tofu ",6,7,"40 - 100 g pkgs. ",23.25 ),(15,"Genen Shouyu ",6,2,"24 - 250 ml bottles ",15.5 ),(16,"Pavlova ",7,3,"32 - 500 g boxes ",17.45 ),(17,"Alice Mutton ",7,6,"20 - 1 kg tins ",39 ),(18,"Carnarvon Tigers ",7,8,"16 kg pkg. ",62.5 ),(19,"Teatime Chocolate Biscuits ",8,3,"10 boxes x 12 pieces ",9.2 ),(20,"Sir Rodney's Marmalade ",8,3,"30 gift boxes ",81 ),(21,"Sir Rodney's Scones ",8,3,"24 pkgs. x 4 pieces ",10 ),(22,"Gustaf's Knäckebröd ",9,5,"24 - 500 g pkgs. ",21 ),(23,"Tunnbröd ",9,5,"12 - 250 g pkgs. ",9 ),(24,"Guaraná Fantástica ",10,1,"12 - 355 ml cans ",4.5 ),(25,"NuNuCa Nuß-Nougat-Creme ",11,3,"20 - 450 g glasses ",14 ),(26,"Gumbär Gummibärchen ",11,3,"100 - 250 g bags ",31.23 ),(27,"Schoggi Schokolade ",11,3,"100 - 100 g pieces ",43.9 ),(28,"Rössle Sauerkraut ",12,7,"25 - 825 g cans ",45.6 ),(29,"Thüringer Rostbratwurst ",12,6,"50 bags x 30 sausgs. ",123.79 ),(30,"Nord-Ost Matjeshering ",13,8,"10 - 200 g glasses ",25.89 ),(31,"Gorgonzola Telino ",14,4,"12 - 100 g pkgs ",12.5 ),(32,"Mascarpone Fabioli ",14,4,"24 - 200 g pkgs. ",32 ),(33,"Geitost ",15,4,"500 g ",2.5 ),(34,"Sasquatch Ale ",16,1,"24 - 12 oz bottles ",14 ),(35,"Steeleye Stout ",16,1,"24 - 12 oz bottles ",18 ),(36,"Inlagd Sill ",17,8,"24 - 250 g jars ",19 ),(37,"Gravad lax ",17,8,"12 - 500 g pkgs. ",26 ),(38,"Côte de Blaye ",18,1,"12 - 75 cl bottles ",263.5 ),(39,"Chartreuse verte ",18,1,"750 cc per bottle ",18 ),(40,"Boston Crab Meat ",19,8,"24 - 4 oz tins ",18.4 ),(41,"Jack's New England Clam Chowder ",19,8,"12 - 12 oz cans ",9.65 ),(42,"Singaporean Hokkien Fried Mee ",20,5,"32 - 1 kg pkgs. ",14 ),(43,"Ipoh Coffee ",20,1,"16 - 500 g tins ",46 ),(44,"Gula Malacca ",20,2,"20 - 2 kg bags ",19.45 ),(45,"Røgede sild ",21,8,"1k pkg. ",9.5 ),(46,"Spegesild ",21,8,"4 - 450 g glasses ",12 ),(47,"Zaanse koeken ",22,3,"10 - 4 oz boxes ",9.5 ),(48,"Chocolade ",22,3,"10 pkgs. ",12.75 ),(49,"Maxilaku ",23,3,"24 - 50 g pkgs. ",20 ),(50,"Valkoinen suklaa ",23,3,"12 - 100 g bars ",16.25 ),(51,"Manjimup Dried Apples ",24,7,"50 - 300 g pkgs. ",53 ),(52,"Filo Mix ",24,5,"16 - 2 kg boxes ",7 ),(53,"Perth Pasties ",24,6,"48 pieces ",32.8 ),(54,"Tourtière ",25,6,"16 pies ",7.45 ),(55,"Pâté chinois ",25,6,"24 boxes x 2 pies ",24 ),(56,"Gnocchi di nonna Alice ",26,5,"24 - 250 g pkgs. ",38 ),(57,"Ravioli Angelo ",26,5,"24 - 250 g pkgs. ",19.5 ),(58,"Escargots de Bourgogne ",27,8,"24 pieces ",13.25 ),(59,"Raclette Courdavault ",28,4,"5 kg pkg. ",55 ),(60,"Camembert Pierrot ",28,4,"15 - 300 g rounds ",34 ),(61,"Sirop d'érable ",29,2,"24 - 500 ml bottles ",28.5 ),(62,"Tarte au sucre ",29,3,"48 pies ",49.3 ),(63,"Vegie-spread ",7,2,"15 - 625 g jars ",43.9 ),(64,"Wimmers gute Semmelknödel ",12,5,"20 bags x 4 pieces ",33.25 ),(65,"Louisiana Fiery Hot Pepper Sauce ",2,2,"32 - 8 oz bottles ",21.05 ),(66,"Louisiana Hot Spiced Okra ",2,2,"24 - 8 oz jars ",17 ),(67,"Laughing Lumberjack Lager ",16,1,"24 - 12 oz bottles ",14 ),(68,"Scottish Longbreads ",8,3,"10 boxes x 8 pieces ",12.5 ),(69,"Gudbrandsdalsost ",15,4,"10 kg pkg. ",36 ),(70,"Outback Lager ",7,1,"24 - 355 ml bottles ",15 ),(71,"Fløtemysost ",15,4,"10 - 500 g pkgs. ",21.5 ),(72,"Mozzarella di Giovanni ",14,4,"24 - 200 g pkgs. ",34.8 ),(73,"Röd Kaviar ",17,8,"24 - 150 g jars ",15 ),(74,"Longlife Tofu ",4,7,"5 kg pkg. ",10 ),(75,"Rhönbräu Klosterbier ",12,1,"24 - 0.5 l bottles ",7.75 ),(76,"Lakkalikööri ",23,1,"500 ml  ",18 ),(77,"Original Frankfurter grüne Soße ",12,2,"12 boxes ",13 );

INSERT INTO  shippers
(ShipperID,ShipperName,Phone)
VALUES
(1,"Speedy Express ","(503) 555-9831 "),(2,"United Package ","(503) 555-3199 "),(3,"Federal Shipping ","(503) 555-9931 ");

INSERT INTO  suppliers
(SupplierID,SupplierName,ContactName,Address,City,PostalCode,Country,Phone)
VALUES
(1,"Exotic Liquid ","Charlotte Cooper ","49 Gilbert St. ","Londona ","EC1 4SD ","UK ","(171) 555-2222 "),(2,"New Orleans Cajun Delights ","Shelley Burke ","P.O. Box 78934 ","New Orleans ","70117 ","USA ","(100) 555-4822 "),(3,"Grandma Kelly's Homestead ","Regina Murphy ","707 Oxford Rd. ","Ann Arbor ","48104 ","USA ","(313) 555-5735 "),(4,"Tokyo Traders ","Yoshi Nagase ","9-8 Sekimai Musashino-shi ","Tokyo ","100 ","Japan ","(03) 3555-5011 "),(5,"Cooperativa de Quesos 'Las Cabras' ","Antonio del Valle Saavedra  ","Calle del Rosal 4 ","Oviedo ","33007 ","Spain ","(98) 598 76 54 "),(6,"Mayumi's ","Mayumi Ohno ","92 Setsuko Chuo-ku ","Osaka ","545 ","Japan ","(06) 431-7877 "),(7,"Pavlova, Ltd. ","Ian Devling ","74 Rose St. Moonie Ponds ","Melbourne ","3058 ","Australia ","(03) 444-2343 "),(8,"Specialty Biscuits, Ltd. ","Peter Wilson ","29 King's Way ","Manchester ","M14 GSD ","UK ","(161) 555-4448 "),(9,"PB Knäckebröd AB ","Lars Peterson ","Kaloadagatan 13 ","Göteborg ","S-345 67 ","Sweden  ","031-987 65 43 "),(10,"Refrescos Americanas LTDA ","Carlos Diaz ","Av. das Americanas 12.890 ","São Paulo ","5442 ","Brazil ","(11) 555 4640 "),(11,"Heli Süßwaren GmbH & Co. KG ","Petra Winkler ","Tiergartenstraße 5 ","Berlin ","10785 ","Germany ","(010) 9984510 "),(12,"Plutzer Lebensmittelgroßmärkte AG ","Martin Bein ","Bogenallee 51 ","Frankfurt ","60439 ","Germany ","(069) 992755 "),(13,"Nord-Ost-Fisch Handelsgesellschaft mbH ","Sven Petersen ","Frahmredder 112a ","Cuxhaven ","27478 ","Germany ","(04721) 8713 "),(14,"Formaggi Fortini s.r.l. ","Elio Rossi ","Viale Dante, 75 ","Ravenna ","48100 ","Italy ","(0544) 60323 "),(15,"Norske Meierier ","Beate Vileid ","Hatlevegen 5 ","Sandvika ","1320 ","Norway ","(0)2-953010 "),(16,"Bigfoot Breweries ","Cheryl Saylor ","3400 - 8th Avenue Suite 210 ","Bend ","97101 ","USA ","(503) 555-9931 "),(17,"Svensk Sjöföda AB ","Michael Björn ","Brovallavägen 231 ","Stockholm ","S-123 45 ","Sweden ","08-123 45 67 "),(18,"Aux joyeux ecclésiastiques ","Guylène Nodier ","203, Rue des Francs-Bourgeois ","Paris ","75004 ","France ","(1) 03.83.00.68 "),(19,"New England Seafood Cannery ","Robb Merchant ","Order Processing Dept. 2100 Paul Revere Blvd. ","Boston ","02134 ","USA ","(617) 555-3267 "),(20,"Leka Trading ","Chandra Leka ","471 Serangoon Loop, Suite #402 ","Singapore ","0512 ","Singapore ","555-8787 "),(21,"Lyngbysild ","Niels Petersen ","Lyngbysild Fiskebakken 10 ","Lyngby ","2800 ","Denmark ","43844108 "),(22,"Zaanse Snoepfabriek ","Dirk Luchte ","Verkoop Rijnweg 22 ","Zaandam ","9999 ZZ ","Netherlands ","(12345) 1212 "),(23,"Karkki Oy ","Anne Heikkonen ","Valtakatu 12 ","Lappeenranta ","53120 ","Finland ","(953) 10956 "),(24,"G'day, Mate ","Wendy Mackenzie ","170 Prince Edward Parade Hunter's Hill ","Sydney ","2042 ","Australia ","(02) 555-5914 "),(25,"Ma Maison ","Jean-Guy Lauzon ","2960 Rue St. Laurent ","Montréal ","H1J 1C3 ","Canada ","(514) 555-9022 "),(26,"Pasta Buttini s.r.l. ","Giovanni Giudici ","Via dei Gelsomini, 153 ","Salerno ","84100 ","Italy ","(089) 6547665 "),(27,"Escargots Nouveaux ","Marie Delamare ","22, rue H. Voiron ","Montceau ","71300 ","France ","85.57.00.07 "),(28,"Gai pâturage ","Eliane Noz ","Bat. B 3, rue des Alpes ","Annecy ","74000 ","France ","38.76.98.06 "),(29,"Forêts d'érables ","Chantal Goulet ","148 rue Chasseur ","Ste-Hyacinthe ","J2S 7S8 ","Canada ","(514) 555-2955 ");
-- specify the column and currosponding data. 
insert into customers
(CustomerID, CustomerName, CustomerCity, CustomerCountry)
values
(92, "Subhash Chandra Bose", "Cuttack", "India"); 
/* Here, the order of the values must match the order of the columns specified in the insert statement.
columns that were not specified will have null values. */

-- METHOD 2 ====> INSERT INTO SELECT
-- previously we saw how to make new table out of existing one. now we are going to add new data to the existing table using insert into select command.
-- the INSERT INTO SELECT statement requires that the data types in source and target tables matches.
-- first we will create new dummy table 

create table dummyTable(
dummyID int,
dummyName varchar(500),
dummyContactName varchar(500),
dummyAddress varchar(500),
dummyCity varchar(500),
dummyPostalCode varchar(500),
dummyCountry varchar(500)
);
 -- lets insert dummy data
 insert into dummyTable
 (dummyID, dummyName, dummyContactName, dummyAddress, dummyCity, dummyPostalCode, dummyCountry)
 values
(1, 'Bhagat Singh', 'Bhagat Singh', 'Kotwali Bagh', 'Banga', '143505', 'India'),
(2, 'Rani Lakshmibai', 'Rani Lakshmibai', 'Jhansi Fort', 'Jhansi', '284001', 'India'),
(3, 'Subhas Chandra Bose', 'Subhas Chandra Bose', 'Cuttack House', 'Cuttack', '753001', 'India'),
(4, 'Chandra Shekhar Azad', 'Chandra Shekhar Azad', 'Alirajpur Street', 'Jaipur', '302001', 'India'),
(5, 'Veerapandiya Kattabomman', 'Veerapandiya Kattabomman', 'Panchalankurichi', 'Tamil Nadu', '627851', 'India'),
(6, 'Tantia Tope', 'Tantia Tope', 'Gwalior Fort', 'Gwalior', '474002', 'India'),
(7, 'Mangal Pandey', 'Mangal Pandey', 'Bihar Military Camp', 'Bihar', '800001', 'India'),
(8, 'Rash Behari Bose', 'Rash Behari Bose', 'Kalighat', 'Kolkata', '700026', 'India'),
(9, 'Alluri Sitarama Raju', 'Alluri Sitarama Raju', 'Rampa Forest', 'Andhra Pradesh', '533101', 'India'),
(10, 'Birsa Munda', 'Birsa Munda', 'Ulihatu', 'Jharkhand', '835201', 'India');

select * from dummyTable;-- there are 10 entries so far. 

insert into dummyTable  
select * from customers;
select * from dummyTable;  -- We’re not worrying about IDs yet; the focus is to practice SQL concepts. Later, we will learn about constrains.
truncate table dummyTable;-- this will empty the table

-- you can specify the target columns in the insert into statement:
insert into dummyTable (dummyID, dummyName,dummyCountry)
select SupplierID, SupplierName, Country from suppliers;
select * from dummyTable; -- the other columns (dummycontactname, dummyaddress, etc.) will automatically be null for these new rows.
truncate table dummyTable;-- this will empty the table

insert into dummyTable (dummyID, dummyName,dummyCountry)
select SupplierID, SupplierName, Country from suppliers 
where SupplierID > 10; -- using a where clause allows you to filter which rows to copy. only suppliers with supplierid > 10 are inserted.
select * from dummyTable;
truncate table dummyTable;-- this will empty the table

-- METHOD 3 ===> INSERT INTO TABLE
-- this is another method for inserting values in the table
insert into dummyTable table customers; -- returns same result as above. 
select * from dummyTable; 
truncate table dummyTable;-- this will empty the table

-- METHOD 4 ===? SET METHOD
insert into dummyTable 
set CustomerID = 101, CustomerName= "soham",CustomerContactName="soham", CustomerAddress="33-sukhdev", 
CustomerCity="surat",CostomerPostalCode="000021",CustomerCountry="india";
select * from dummyTable; 
truncate table dummyTable;-- this will empty the table

drop table dummyTable;-- this will drop the dummyTable. 

-- METHOD 5 ===> INSERT IGNORE
-- normally, if we try to insert a duplicate value into a column 
-- that has a unique or primary key constraint, mysql will throw an error.

-- to prevent this error, we can use the insert ignore statement.
-- in this case:
--   - if there is no conflict, the row is inserted as usual.
--   - if a conflict occurs (duplicate primary key or unique value), 
--     the new row is ignored and the existing row remains unchanged.

CREATE TABLE categoriesDUMMY(
    CategoryID int unique,
    CategoryName varchar(255),
    Description varchar(255)
);

insert into categoriesDUMMY (CategoryID, CategoryName, Description)
values
(1, 'Beverages', 'Soft drinks, coffees, teas, beers, and ales'),
(2, 'Condiments', 'Sweet and savory sauces, relishes, spreads, and seasonings'),
(3, 'Confections', 'Desserts, candies, and sweet breads'),
(4, 'Dairy Products', 'Cheeses and other dairy items'),
(5, 'Grains/Cereals', 'Breads, crackers, pasta, and cereal'),
(6, 'Meat/Poultry', 'Prepared meats'),
(7, 'Produce', 'Dried fruit and bean curd'),
(8, 'Seafood', 'Seaweed and fish');

insert into categoriesDUMMY
values
(1, 'xyz', 'abc');-- this will throw an erro because it violates the unique constaint.

insert ignore into categoriesDUMMY
values
(1, 'xyz', 'abc');-- this will give us warning.

select * from categoriesDUMMY;
drop table categoriesDUMMY;

-- ------------------------------------------ SKIP THIS LEARNING, BUT RUN IT -----------------------------------------------------------------------------------------------
-- This statement is used to clean the tables. You don’t need to study it now, but make sure to run it though.
SET SQL_SAFE_UPDATES = 0;
update customers
set 
CustomerID = trim(CustomerID),
CustomerName = trim(CustomerName),
CustomerContactName = trim(CustomerContactName),
CustomerAddress = trim(CustomerAddress),
CustomerCity = trim(CustomerCity),
CostomerPostalCode = trim(CostomerPostalCode),
CustomerCountry = trim(CustomerCountry);

update categories
set 
CategoryID = trim(CategoryID),
CategoryName = trim(CategoryName),
Description = trim(Description);

update employees
set
EmployeeID = trim(EmployeeID),
LastName = trim(LastName),
FirstName = trim(FirstName),
BirthDate = trim(BirthDate),
Photo = trim(Photo),
Notes = trim(Notes);

update orderDetails
set
OrderDetailID = trim(OrderDetailID),
OrderID = trim(OrderID),
ProductID = trim(ProductID),
Quantity = trim(Quantity);

update orders
set
OrderID = trim(OrderID),
CustomerID = trim(CustomerID),
EmployeeID = trim(EmployeeID),
OrderDate = trim(OrderDate),
ShipperID = trim(ShipperID);

update products
set
ProductID = trim(ProductID),
ProductName = trim(ProductName),
SupplierID = trim(SupplierID),
CategoryID = trim(CategoryID),
Unit = trim(Unit),
Price = trim(Price);

update shippers
set
ShipperID = trim(ShipperID),
ShipperName = trim(ShipperName),
Phone = trim(Phone);

update suppliers
set
SupplierID = trim(SupplierID),
SupplierName = trim(SupplierName),
ContactName = trim(ContactName),
Address = trim(Address),
City = trim(City),
PostalCode = trim(PostalCode),
Country = trim(Country),
Phone = trim(Phone);

SET SQL_SAFE_UPDATES = 1;
-- ------------------------------------------------------- START HERE -----------------------------------------------------------------------------------------------

-- --------------------------------------------------------UPDATE QUERY-------------------------------------------------------------------
update customers
set CustomerName = "Vinayak Damodar Savarkar"
where CustomerID = 1;
-- If we don’t specify a WHERE clause, the UPDATE statement will modify every row in the table.
select * from customers where customerID =1;
select * from customers;
-- ------------------------------------------------------REPLACE DATA------------------------------------------------------------------------------------------------------------------------------------------
-- MySQL looks for conflicts on PRIMARY KEY or UNIQUE columns when inserting a new row.
-- If no conflict is found, the row is inserted normally.
-- If a conflict is found, the conflicting row is removed and the new row is inserted in its place.

select * from customers;-- check the table

replace into customers
values
(4,"nathuram godse", "nathuram godse", "c-801", "surat", "009921", "India");-- replaces the existind data.
select * from customers;
select * from customers;-- verify

replace into customers
values
(95,"nathuram godse", "nathuram godse", "c-801", "surat", "009921", "India");-- new CustomerID(primary key), no conflict, adds new record.
select * from customers;-- verify


-- ------------------------------------------------------DELETE QUERY ------------------------------------------------------------------------------------------
-- this statement is used to delete the existing data in the row.
delete from customers
where customerID = 92;
-- If we don’t specify a WHERE clause, the DELETE statement will remove every row in the table.

-- it is possible to delete all rows without deleting the table itself.
-- first, we create a dummy table by copying the customers table.
create table dummytable as 
select * from customers;  -- the dummy table now has the same structure and data as the customers table.
select * from dummytable;  -- verify the table; it contains all the copied data.
delete from dummytable;  -- delete all rows from the dummy table.
select * from dummytable;  -- the table still exists, but it is now empty.
drop table dummyTable; -- we will now remove the table itself. this will delete the table. 

-- --------------------------------------------------------CLONE TABLE-------------------------------------------------------------------
insert into customers
values
(1, 'Bhagat Singh', 'Bhagat Singh', 'Kotwali Bagh', 'Banga', '143505', 'India'),
(2, 'Rani Lakshmibai', 'Rani Lakshmibai', 'Jhansi Fort', 'Jhansi', '284001', 'India'),
(3, 'Subhas Chandra Bose', 'Subhas Chandra Bose', 'Cuttack House', 'Cuttack', '753001', 'India'),
(4, 'Chandra Shekhar Azad', 'Chandra Shekhar Azad', 'Alirajpur Street', 'Jaipur', '302001', 'India'),
(5, 'Veerapandiya Kattabomman', 'Veerapandiya Kattabomman', 'Panchalankurichi', 'Tamil Nadu', '627851', 'India'),
(6, 'Tantia Tope', 'Tantia Tope', 'Gwalior Fort', 'Gwalior', '474002', 'India'),
(7, 'Mangal Pandey', 'Mangal Pandey', 'Bihar Military Camp', 'Bihar', '800001', 'India'),
(8, 'Rash Behari Bose', 'Rash Behari Bose', 'Kalighat', 'Kolkata', '700026', 'India'),
(9, 'Alluri Sitarama Raju', 'Alluri Sitarama Raju', 'Rampa Forest', 'Andhra Pradesh', '533101', 'India'),
(10, 'Birsa Munda', 'Birsa Munda', 'Ulihatu', 'Jharkhand', '835201', 'India');
desc customers;

-- there are three types of cloning possible in mySQL
-- Simple cloning: creates a new table with the data from an existing one, but excludes constraints and indexes.
-- Shallow cloning: creates an empty table that has the same structure as an existing table.
-- Deep cloning: creates a new table that duplicates both the structure and the data of an existing table.
-- we will learn later what constrains are dont worry.

-- method 1 => simple cloning
create table SimpleCloning as 
select * from customers;
desc SimpleCloning; -- this does not show primary key and auto_increment
desc customers; -- this table gives all the values including primary key and auto_increment. 
select * from SimpleCloning;
drop table SimpleCloning;

-- method 2 => shallow cloning
create table shallowCloning like customers;
select * from shallowCloning;
desc shallowCloning;-- this statement copies structure as well as the constrains form customers table.
select * from ShallowCloning;
drop table shallowCloning;

-- method 3 => deep cloning
create table deepCloning like customers; -- this will copy all the structure and constrains
insert into deepCloning 
select * from customers;--  this will copy data. we will study about this statement in more detail later.
desc deepCloning;
select * from deepCloning;


-- --------------------------------------------------------TRUNCATE TABLE-------------------------------------------------------------------
truncate table deepCloning;-- this works like delete statement. 
select * from deepCloning;
desc deepCloning;-- data is gone but it has retained the structure and constrains.
drop table deepCloning;
-- difference
-- The truncate command is used to remove all of the rows from a table, regardless of whether or not any conditions are met.
-- It is a DDL
-- There is no necessity of using a where Clause.
-- committed automatically. will study about this later.

-- --------------------------------------------------------TABLE LOCKING-------------------------------------------------------------------
/*MySQL database provides a multi-user environment, that allows multiple clients to access the database at the same time.
 To run this environment smoothly, MySQL introduced the concept of locks.*/
 
-- | Lock Type | You (locker)       | Others (all other sessions) |
-- | --------- | ------------------ | --------------------------- |
-- | **READ**  | Read ✅, Write ❌  | Read ✅, Write ❌          |
-- | **WRITE** | Read ✅, Write ✅  | Read ❌, Write ❌          |

-- case 1
lock table customers read;
-- => You (the one who locked the table):
--          Can read (SELECT)
--          Cannot write (INSERT, UPDATE, DELETE)

-- => Others (other sessions):
--          Can read (SELECT)
--          Cannot write

update customers
set CustomerName = "mangal panday"
where CustomerID = 1;-- this will throw error. 

-- case 2
lock table customers write;
-- => You (the one who locked the table):
--          Can read (SELECT)
--          Can write (INSERT, UPDATE, DELETE)

-- => Others (other sessions):
--          Cannot read
--          Cannot write
unlock tables; -- this will release all the locks created earlier. 
select * from customers;

-- --------------------------------------------------------DERIVE TABLE-------------------------------------------------------------------
-- A derived table is just a temporary table that MySQL makes from another query. It doesn’t exist in the database
-- It’s created when you place a SELECT query inside the FROM clause of another SELECT.

select * from (select EmployeeID,FirstName,BirthDate from employees) as derivedTable;
-- how this worked?
-- Step 1: The inner query runs first:
--   select EmployeeID, FirstName, BirthDate from employees;
--   This creates a temporary table (exists only while the query runs). lets name it "derivedTable"

-- Step 2: The outer query then runs:
--   select * from (that temporary table);
--   This just selects everything (*) from the temporary table.
--   We can use a "derivedTable" just like a normal table and perform all the usual tasks on it.

-- In short:
--   The inner query builds the table.
--   The outer query shows the table.

-- this way we can create multiple tables without having to store it in our database.

-- --------------------------------------------------------TEMPORARY TABLE-------------------------------------------------------------------

/*The Temporary Tables are the tables that are created in a database to store data temporarily. 
These tables will be automatically deleted once the current client session is terminated or ends. 
In addition to that, these tables can be deleted explicitly if the users decide to drop them manually. 
You can perform various SQL operations on temporary tables, just like you would with permanent tables, 
including CREATE, UPDATE, DELETE, INSERT, JOIN, etc.*/
-- Creating a temporary table in MySQL is very similar to creating a regular database table. 
-- temporary table wont be detected in "show tables" statement.

create temporary table tempCustomers(
CustomerID int primary key auto_increment,
CustomerName varchar(500) not null,
CustomerContactName varchar(500),
CustomerAddress varchar(500),
CustomerCity varchar(500),
CostomerPostalCode varchar(500),-- code and be a string!!
CustomerCountry varchar(500) default "India"
);
-- like regular insert operation we can insert the data here too.
insert into tempCustomers
(CustomerID, CustomerName, CustomerContactName, CustomerAddress, CustomerCity, CostomerPostalCode, CustomerCountry)
values
(1, 'Bhagat Singh', 'Bhagat Singh', 'Kotwali Bagh', 'Banga', '143505', 'India'),
(2, 'Rani Lakshmibai', 'Rani Lakshmibai', 'Jhansi Fort', 'Jhansi', '284001', 'India'),
(3, 'Subhas Chandra Bose', 'Subhas Chandra Bose', 'Cuttack House', 'Cuttack', '753001', 'India'),
(4, 'Chandra Shekhar Azad', 'Chandra Shekhar Azad', 'Alirajpur Street', 'Jaipur', '302001', 'India'),
(5, 'Veerapandiya Kattabomman', 'Veerapandiya Kattabomman', 'Panchalankurichi', 'Tamil Nadu', '627851', 'India'),
(6, 'Tantia Tope', 'Tantia Tope', 'Gwalior Fort', 'Gwalior', '474002', 'India'),
(7, 'Mangal Pandey', 'Mangal Pandey', 'Bihar Military Camp', 'Bihar', '800001', 'India'),
(8, 'Rash Behari Bose', 'Rash Behari Bose', 'Kalighat', 'Kolkata', '700026', 'India'),
(9, 'Alluri Sitarama Raju', 'Alluri Sitarama Raju', 'Rampa Forest', 'Andhra Pradesh', '533101', 'India'),
(10, 'Birsa Munda', 'Birsa Munda', 'Ulihatu', 'Jharkhand', '835201', 'India');
select * from tempCustomers;-- verify

-- drop temporary tables
drop temporary table tempCustomers;
select * from tempCustomers; -- verify


-- ------------------------------------------------------------WHERE---------------------------------------------------------------------------------------
-- The WHERE clause is used to filter the query results. It can also be used with other statements and clauses. we will see that later. 

select * from customers
where CustomerCountry = "Mexico";

select * from customers
where CustomerID = 1;

select * from products
where Price >= 50; -- we can use operators too like <, >, >=, <=, <> or !=, = and more.

-- --------------------------------------------------------AND OR NOT------------------------------------------------------------------------------------------------
select * from customers
where CustomerCountry = "France" and CustomerCity= "Paris";

select * from customers
where CustomerCountry = "Mexico" or CustomerCountry = "France";

select * from customers
where not CustomerCountry = "France"; -- see the placement of the NOT.
-- NOT could also be written as <>
select * from customers
where CustomerCountry <> "France";

-- we can also use these in combination with each other
select * from customers
where CustomerCountry = "Germany" and (CustomerCity = "Berlin" or CustomerCity = "Stuttgart");

select * from customers
where CustomerCountry = "Germany"  and not (CustomerCity = "Berlin" or CustomerCity = "Stuttgart");


-- ----------------------------------------------------------ORDER BY--------------------------------------------------------------------------------------------------------
-- order by keyword is used to sort the order of the result.
select * from products
order by Price asc; -- ascending order this is bydefault.

select * from products
order by Price desc; -- descending order

-- If we want to sort by multiple columns, we can do that as well.
select * from customers
order by customerCountry asc, customerCity desc; 
-- This will sort the results in ascending order by country, and within each country, the cities will be sorted in descending order.

-- ----------------------------------------------------IS NULL & IS NOT NULL------------------------------------------------------------------------------------------------
select * from customers
where CustomerAddress is null;

select * from customers
where CustomerAddress is not null;

-- ------------------------------------------------------------LIMIT------------------------------------------------------------------------------------------
select * from customers
limit 10;  -- this limits the number of rows returned. sometimes we may not want to retrieve a large amount of data at once, so we use limit.

-- what if we want data from id number 11 to 20;
select * from customers
limit 10 offset 10; --  this says return 10 records, starting from 11(offset 10)

-- we can also use it with where clause 
select * from customers
where CustomerCountry = "Germany"
limit 3;

-- we can also add order by. 
select * from customers
where CustomerCountry = "Germany"
order by CustomerName desc
limit 3;

-- ---------------------------------------------------------AGGREGATE FUNCTION----------------------------------------------------------------------------
-- min()
select min(Price) from products;
-- max()
select max(Price) from products;
-- sum()
select sum(Price) from products;
-- count()
select count(ProductID) from products;
-- ave();
select avg(Price) from products;
-- we can also use where clause to narrow down the search.


-- --------------------------------------------------------------GROUP BY----------------------------------------------------------------------------------------
-- the group by statement collects rows with the same values and summarizes them into one row per group.
-- the group by statement is often used with aggregate functions (count(), max(), min(), sum(), avg()) to group the results. 
select CustomerCountry, count(CustomerID) from customers 
group by customerCountry;
-- the typical sequence of clauses in a select statement SO FAR is: select > from > where > group by > order by > limit.

-- ---------------------------------------------------------------LIKE--------------------------------------------------------------------------------------------------
-- the like operator is used in a where clause to find values that match a specific pattern in a column.
-- there are wildcards
-- The percent sign (%) represents zero, one, or multiple characters
-- The underscore sign (_) represents one, single character

-- WHERE CustomerName LIKE 'a%'	    Finds any values that start with "a"
-- WHERE CustomerName LIKE '%a'	    Finds any values that end with "a"
-- WHERE CustomerName LIKE '%or%'	Finds any values that have "or" in any position
-- WHERE CustomerName LIKE '_r%'	Finds any values that have "r" in the second position
-- WHERE CustomerName LIKE 'a_%'	Finds any values that start with "a" and are at least 2 characters in length
-- WHERE CustomerName LIKE 'a__%'	Finds any values that start with "a" and are at least 3 characters in length
-- WHERE ContactName LIKE 'a%o'	    Finds any values that start with "a" and ends with "o"


-- example
select * from customers
where CustomerName like "a%"; -- Finds any values that start with "a"

select * from customers
where CustomerName like '%or%'; -- Finds any values that have "or" in any position
-- you can try it with all the examples given above.



-- -----------------------------------------------------------------IN----------------------------------------------------------------------------------------
-- in operator allows you to mention multiple 
-- the in operator lets you check for multiple values in a where clause and is a shortcut for using multiple OR conditions.
select * from customers
where CustomerID in(1,4,5);

select * from customers
where CustomerID in (
       select CustomerID from customers 
       where CustomerName like "a%" or CustomerName like  "b%"
       );
                     
-- think of it this way: the subquery runs first:
select CustomerID from customers 
where CustomerName like 'a%' or CustomerName like 'b%';
-- the output of the subquery (for example, 2,3,4,5,6,7,8,...) is then used by the in operator.
-- the in operator checks each row in the customers table against these values.
-- if a match is found, the row is returned; otherwise, it is ignored.


select * from customers
where CustomerCountry in (
    select distinct(Country) from suppliers
    ); 
-- here, distinct returns all unique country values from the suppliers table.
-- the process works like this:
-- the subquery runs first.
-- the in operator then checks each customer row to see if customerCountry matches any value returned by the subquery.
-- if a match is found, the row is returned; otherwise, it is ignored.


-- ----------------------------------------------------------BETWEEN-----------------------------------------------------------------------------------------------
-- the between operator selects values within a specified range. it works with numbers, text, or dates.
-- between is inclusive, so the start and end values are included.

select * from products
where Price between 25 and 50;-- numbers

select * from customers
where CustomerName between "a" and "f";-- letters

select * from orders
where OrderDate between "1996-07-01" and "1996-08-01"; -- dates

select * from products
where Price not between 25 and 50; -- not logical operator is applied here.

select * from products
where (Price not between 25 and 50) and (CategoryID not in(1,2,3));


-- -----------------------------------------------------------ALIASES--------------------------------------------------------------------------------
-- it is used to give temporary names to the table or columns
-- An alias only exists for the duration of that query.
-- An alias is created with the AS keyword.
 
select CustomerID as ID, CustomerName as name, CustomerAddress as address 
from customers;
-- we will how to use ALIASES in table later.

-- ----------------------------------------------------------HAVING------------------------------------------------------------------------------------------------
-- the having clause was added to sql because the where keyword cannot be used with aggregate functions.
select CustomerCountry, count(CustomerID) as count
from customers
group by CustomerCountry
having count >=5;
-- the having clause is used to filter the results produced by the group by clause.
select CustomerCountry, count(CustomerID) as count
from customers
where CustomerID > 10
group by CustomerCountry
having count >= 5
order by count desc
limit 3;  
-- explanation:
-- 1. where filters rows where customerID is greater than 10.
-- 2. group by groups the remaining rows by customerCountry.
-- 3. count(customerID) counts customers in each country, and we gave it the alias 'count'.
-- 4. having filters groups where the count is at least 5.
-- 5. order by sorts the results in descending order of count.
-- 6. limit 3 restricts the output to the top 3 countries.

-- syntax so far
-- SELECT column_name(s)
-- FROM table_name
-- WHERE condition
-- GROUP BY column_name(s)
-- HAVING condition
-- ORDER BY column_name(s);
-- or 
-- select>from>where>groupby>having>orderby>limit;

-- ---------------------------------------------------------EXISTS--------------------------------------------------------------------------------------------------------------
-- EXISTS is a logical operator used in a WHERE clause.
-- It checks whether a subquery returns any rows.
-- Returns:
-- TRUE =>  if the subquery returns at least one row. 
-- FALSE => if the subquery returns no rows.
-- The EXISTS operator does not care about the actual columns returned.
-- It only checks whether the subquery returns at least one row.
-- If the subquery returns any row, EXISTS is true; if it returns no rows, EXISTS is false.

select SupplierName from suppliers as s
where exists (select ProductID from products as p where p.SupplierID = s.SupplierID and (Price>20));

-- Explanation (paraphrased):
-- We assign aliases to the tables to make the query easier to read: s for Suppliers and p for Products.
-- The outer query goes through each supplier in the Suppliers table, one by one.
-- For the current supplier, the subquery checks if there is any product belonging to that supplier (p.SupplierID = s.SupplierID) with a price greater than 20.
-- The subquery does not return data to the outer query; it only checks if at least one row exists.
-- If the subquery finds such a product, EXISTS returns TRUE, and the supplier is included in the final result.
-- This process repeats for every supplier, so only suppliers with at least one product priced above 20 appear in the result

-- -----------------------------------------------------ALL & ANY-----------------------------------------------------------------------------------------------
-- The ANY operator:
-- returns a boolean value as a result.
-- returns TRUE if any of the subquery values meet the condition.
-- The operator must be a standard comparison operator (=, <>, !=, >, >=, <, or <=).
select * from products
where ProductID = any (select ProductID from orderDetails
                      where Quantity=10);

-- Explanation (paraphrased):
-- The subquery runs first and returns a list of ProductIDs from OrderDetails where the quantity is 10.
-- The outer query then goes through the Products table and checks each product to see if its ProductID matches any value from the subquery result.
-- If there is a match, the product’s full data is included in the final result.
-- = ANY acts like a check against a list of values.
-- Only products whose ProductID appears in the subquery result are returned.

select * from products
where ProductID = any (select ProductID from orderDetails
                      where Quantity > 99);


-- all => (Note: I don’t have a query example to demonstrate this concept right now.)
-- Intuition of ALL:
-- ALL works similarly to ANY in that it compares a value from the outer query against a list of values returned by a subquery.
-- The difference is:
-- ANY returns true if the outer value matches at least one value in the list.
-- ALL returns true only if the outer value satisfies the condition for every value in the list.

-- -------------------------------------------------------CASES----------------------------------------------------------------------------------------------------
select distinct(e.EmployeeID) as employee,
 count(case when month(o.OrderDate) = 1 then 1 end) as jan,
 count(case when month(o.OrderDate) = 2 then 1 end) as feb,
 count(case when month(o.OrderDate) = 3 then 1 end) as mar,
 count(case when month(o.OrderDate) = 4 then 1 end) as apr,
 count(case when month(o.OrderDate) = 5 then 1 end) as may,
 count(case when month(o.OrderDate) = 6 then 1 end) as jun,
 count(case when month(o.OrderDate) = 7 then 1 end) as jul,
 count(case when month(o.OrderDate) = 8 then 1 end) as aug,
 count( case when month(o.OrderDate) = 9 then 1 end) as sep,
 count( case when month(o.OrderDate) = 10 then 1 end) as oct,
 count( case when month(o.OrderDate) = 11 then 1 end) as nov,
 count( case when month(o.OrderDate) = 12 then 1 end) as dece
from orders as o, employees as e
where e.EmployeeID = o.EmployeeID
group by employee
order by employee; -- this is just to showcase the power of case command

select OrderID, 
Quantity, 
case when Quantity > 30 then "more than 30"
	 when Quantity < 30 then "less than 30"
     else "equal to 30"
end as statement
from orderDetails;
/*The CASE statement can be used with the SELECT clause, WHERE clause, HAVING clause, GROUP BY clause, ORDER BY clause, and generally 
in any part of SQL where an expression is allowed.*/

-- ------------------------------------------union and union all and intersection----------------------------------------------------------------------------
-- The UNION operator returns only distinct rows, eliminating duplicates from the result set.
-- Each SELECT statement in a UNION must return the same number of columns.
-- The corresponding columns must have compatible data types.
-- The columns in each SELECT must appear in the same order.

select CustomerCity as city from customers
union
select City as city from suppliers
order by city;

-- union all
select CustomerCity as city from customers
union all
select City as city from suppliers
order by city;-- allows duplicates look at berlin


--  this may not be supported in all sql versions. 
-- SELECT CustomerCity AS city FROM customers
-- INTERSECT 
-- SELECT City AS city FROM suppliers;

-- -----------------------------------------------------------JOINS----------------------------------------------------------------------------
-- there are many types of joins
-- we will study 
-- 1 inner join => a intersection b, Returns records that have matching values in both tables
-- 2 left join => only a,  Returns all records from the left table, and the matched records from the right table
-- 3 right join => only b, Returns all records from the right table, and the matched records from the left table
-- 4 cross join => a union b, Returns all records from both tables
-- 5 self join 
-- 6 delete join
-- 7 update join

--  JOIN clause is used to combine rows from two or more tables, based on a related column between them.
-- look at the orders and customers talbe. notice that both the tables have customerID. the relationship between them is customerID. 
-- --------------------------INNER JOIN
-- join will clubs two tables for eg
select * from customers as c
inner join orders as o
on c.CustomerID = o.CustomerID;
-- notice that after the customer tables end, order table start.
-- you can also use "where" command
select * from customers as c
inner join orders as o
where c.CustomerID = o.CustomerID;
-- we can also write it as 
select * from customers as c, orders as o
where c.CustomerID = o.CustomerID;
-- we can also join more tables
select * from customers as c
inner join orders as o on c.CustomerID = o.CustomerID
inner join employees as e on o.EmployeeID = e.EmployeeID;

-- --------------------------LEFT JOIN
-- The LEFT JOIN keyword returns all records from the left table (table1 - customers), and the matching records (if any) from the right table (table2 - orders).
select distinct(c.CustomerID) as ID,
       c.CustomerName as name,
       count(o.OrderID)  as quantity
from customers as c
left join orders as o on c.CustomerID = o.CustomerID
group by ID,name -- a GROUP BY query, all columns in the SELECT list must be included in the GROUP BY clause, except those wrapped in aggregate functions (like COUNT, SUM, etc.).
order by ID;
-- Note that customers like FISSA Fabrica Inter. Salchichas S.A. (ID 22) and Paris spécialités (ID 57) are included in the results. 
-- This query lists all customers along with their order details, even for those who have not placed any orders.

-- --------------------------RIGHT JOIN
-- The RIGHT JOIN keyword returns all records from the right table (table2-employees ), and the matching records (if any) from the left table (table1- orders).
select e.EmployeeID as ID,
	   e.FirstName as name,
       count(OrderID) as quantitySold
from orders as o
right join employees as e on o.EmployeeID = e.EmployeeID
group by e.EmployeeID,  e.FirstName
order by e.EmployeeID;

-- --------------------------CROSS JOIN
-- The CROSS JOIN keyword returns all records from both tables (table1 and table2).
select * from orders as o
cross join shippers as s;
-- using where clause will make this clause behave like a inner join
select * from orders as o
cross join shippers as s
where s.ShipperID = o.ShipperID;

-- --------------------------SELF JOIN
-- A self join is a regular join, but the table is joined with itself.
select c1.CustomerName, c2.CustomerName from customers as c1, customers as c2
where c1.CustomerID <> c2.CustomerID and c1.CustomerCity = c2.CustomerCity;
-- --------------------------DELETE JOIN
-- --------------------------UPDATE JOIN

-- -------------------------------CONSTRAINS --- it is always better to give contraint a name.----------------------------------------------------------------------------
/*Constraints can be specified when the table is created with the CREATE TABLE statement, 
or after the table is created with the ALTER TABLE statement.*/
-- there are two types of constrain
-- table level
-- column level
-- Types of constrain
-- primary key
-- foreign key
-- unique
-- not null
-- default
-- auto_increment
-- check
-- index

-- --------------------------NOT NULL
create table dummyTable(
ID int not null,
name varchar(500) not null,
age int not null,
address varchar(500),
city varchar(500),
country varchar(500)
);

insert into dummyTable
(ID, name, age)
values
(1, "subhash chandra bose", 23);
select * from dummyTable;
-- This insert will not cause an error since it does not violate any constraints. both name and age have values (not null).  
-- However, the below insert will result in an error.
insert into dummyTable
(address, city, country)
values 
("b-102 green arcade","surat", "india");-- this will throw error.

-- how do we define constrain once the table has been made?
alter table dummyTable
modify address varchar(500)not null;

drop table dummyTable;

-- --------------------------UNIQUE
create table dummyTable(
ID int unique,
name varchar(500),
age int,
address varchar(500),
city varchar(500),
country varchar(500)
);

-- different ways to define unique while creating a table!!!!!!!!
-- create table dummyTable(
-- ID int,
-- name varchar(500),
-- age int,
-- address varchar(500),
-- city varchar(500),
-- country varchar(500),
-- unique(ID)
-- );

-- create table dummyTable(
-- ID int,
-- name varchar(500),
-- age int,
-- address varchar(500),
-- city varchar(500),
-- country varchar(500),
-- constraint MultiUnique unique(ID, name)
-- );

insert into dummyTable
(ID, name, age, address, city, country)
values
(1, "subhash chandra bose", 23, "b-102 green arcade","surat", "india");

insert into dummyTable
(ID, name, age, address, city, country)
values
(1, "bhagat singh", 24, "b-103 green arcade","surat", "india"); 
-- This will cause an error because the ID column is defined as unique. 
-- Attempting to insert another row with ID = 1 will violate the uniqueness constraint.

insert into dummyTable
(ID, name, age, address, city, country)
values
(null, "bhagat singh", 24, "b-103 green arcade","surat", "india"); -- unique accepts null values!!!!

-- how to add this constrain if we have already constructed table?????????????
alter table dummyTable
add unique(name); -- now we will have unique name in our table.

alter table dummyTable
add constraint MultiUnique unique(age, address);-- this will make combination of age and address unique. pair (age, address) cannot repeat.

drop table dummyTable;

-- --------------------------PRIMARY KEY
-- The PRIMARY KEY constraint uniquely identifies each record in a table.
-- Primary keys must contain UNIQUE values, and cannot contain NULL values.
-- A table can have only ONE primary key; and in the table, this primary key can consist of single or multiple columns (fields).

create table dummyTable(
ID int primary key,
name varchar(500),
age int,
address varchar(500),
city varchar(500),
country varchar(500)
);
-- different ways to define primary key while creating a table!!!!!!!!

-- create table dummyTable(
-- ID int,
-- name varchar(500),
-- age int,
-- address varchar(500),
-- city varchar(500),
-- country varchar(500),
-- primary key(ID)
-- );
-- create table dummyTable(
-- ID int,
-- name varchar(500),
-- age int,
-- address varchar(500),
-- city varchar(500),
-- country varchar(500),
-- constraint MultiPK primary key(ID, name) -- the pair must be PK.
-- );

insert into dummyTable
(ID, name, age, address, city, country)
values
(1, "subhash chandra bose", 23, "b-102 green arcade","surat", "india");

insert into dummyTable
(ID, name, age, address, city, country)
values
(1, "bhagat singh", 24, "b-103 green arcade","surat", "india"); 
-- This will cause an error because the ID column is defined as primary key. 
-- Attempting to insert another row with ID = 1 will violate the constraint.

insert into dummyTable
(ID, name, age, address, city, country)
values
(null, "bhagat singh", 24, "b-103 green arcade","surat", "india"); -- primary key does not accepts null values while unique can!!!!

-- how to add this constrain if we have already constructed table?????????????
alter table dummyTable
add primary key(name); -- this will make name as a primary key

alter table dummyTable
add constraint multiPK primary key(age,address); -- the pair is PK.

-- remove primary key
alter table dummyTable
drop primary key;

drop table dummyTable;
-- --------------------------FOREIGN KEY
alter table employees
add primary key(EmployeeID); 

alter table customers
add primary key(CustomerID);

alter table shippers
add primary key(ShipperID); 

-- create table dummyOrderTable(
-- OrderID int primary key,
-- CustomerID int,
-- EmployeeID int,
-- OrderDate date,
-- ShipperID int,
-- foreign key (CustomerID) references customers.CustomerID
-- );
-- OR
create table dummyOrderTable(
OrderID int primary key,
CustomerID int,
EmployeeID int,
OrderDate date,
ShipperID int,
constraint FK1 foreign key (CustomerID) references customers(CustomerID),
constraint FK2 foreign key (EmployeeID) references employees(EmployeeID)
); -- define multiple FK and name them(FK1 and KF2).


-- how to add this constrain if we have already constructed table?????????????
alter table dummyOrderTable
add constraint FK3 foreign key (ShipperID) references shippers(ShipperID);

-- delete Fk
alter table dummyOrderTable
drop foreign key FK1;
alter table dummyOrderTable
drop foreign key FK2;
alter table dummyOrderTable
drop foreign key FK3;

drop table dummyOrderTable;
-- --------------------------CHECK
-- The CHECK constraint is used to limit the value range that can be placed in a column.
create table dummyTable(
ID int primary key,
name varchar(500),
age int,
address varchar(500),
city varchar(500),
country varchar(500),
constraint age check (age > 18) -- this will check if the new data's age > 18 and is that person from india.
);

insert into dummyTable
(ID, name, age, address, city, country)
value
(1, "bhagat singh", 23, "green arcade", "surat", "India");

insert into dummyTable
(ID, name, age, address, city, country)
value
(2, "chhatrapati shivaji maharaj ", 10, "raigad", "mumbai", "India");-- this will throw and error.

-- how to add this constrain if we have already constructed table?????????????
alter table dummyTable
add constraint country check(country = "India");

-- drop constraint
alter table dummyTable
drop  check age;
alter table dummyTable
drop  check country;

drop table dummyTable;

-- --------------------------DEFAULT
create table dummyTable(
ID int primary key,
name varchar(500),
age int,
address varchar(500),
city varchar(500),
country varchar(500) default "India"
);

insert into dummyTable
(ID, name, age, address, city)
value
(2, "chhatrapati shivaji maharaj ", 10, "raigad", "mumbai");
select * from dummyTable;-- we can see SQL has already assigned India to the new entry eventhough we dint mention it.

-- how to add this constrain if we have already constructed table?????????????
alter table dummyTable
modify column city varchar(500) default "surat";
-- OR
alter table dummyTable
alter column city set default "surat";

-- drop 
alter table dummyTable
alter column city drop default;

drop table dummyTable;

-- --------------------------AUTO INCREMENT
create table dummyTable(
ID int primary key auto_increment, -- it must be defined as a key.
name varchar(500),
age int,
address varchar(500),
city varchar(500),
country varchar(500)
);

insert into dummyTable
(name, age, address, city, country)
values
("subhash chandra bose", 23, "b-102 green arcade","surat", "india"),
("chhatrapati shivaji maharaj ", 55, "raigad", "mumbai", "India");
select * from dummyTable;-- we can see that IDs have been inserted automatically.

alter table dummyTable auto_increment = 100;

insert into dummyTable
(name, age, address, city, country)
values
("chhatrapati sambaji maharaj ", 55, "raigad", "mumbai", "India");
select * from dummyTable;

drop table dummyTable;

-- --------------------------INDEX
-- there are few types of index like simple, unique, primary key, fulltext and descending. 
/* An index is a data structure that improves the speed of operations on a database table. 
They are a special type of lookup tables pointing to the data. Indexes can be created on one or more columns, 
providing the basis for both rapid random lookups and efficient ordering of access to records.*/
-- good practice is not to create index on primary key and unique columns. 

-- create an index
create table IndexPrac(
CustomerID int primary key auto_increment,
CustomerName varchar(500) not null,
CustomerContactName varchar(500),
CustomerAddress varchar(500),
CustomerCity varchar(500),
CostomerPostalCode varchar(500),-- code and be a string!!
CustomerCountry varchar(500) default "India",
index(CustomerID)
);
desc IndexPrac;

-- creating index on already existing table
create index indexName on IndexPrac(CustomerName);
desc IndexPrac;

-- or use alter method to do so. 
alter table IndexPrac
add index indexContact (CustomerContactName);
desc IndexPrac;

alter table IndexPrac
drop index indexName;-- this removes the index
alter table IndexPrac
drop index indexContact;-- this removes the index

-- create unique index
create unique index uniIndex on IndexPrac(CustomerCity);
drop index uniIndex 
on IndexPrac;-- another way to drop index

-- create composite index 
CREATE INDEX compIndex
ON IndexPrac(CustomerName(100), CustomerCity(100));-- 500 wont work. there is an issue. 
drop index compIndex
on IndexPrac;-- another way to drop index

-- show index 
show index from IndexPrac;
show index in IndexPrac;
-- specify column
show index from IndexPrac where column_name = "CustomerCity";-- there wont be anything. 

drop table IndexPrac;

-- -------------------------------------------------------------VIEW TABLE---------------------------------------------------------------------------------
-- a view is a virtual table based on the result set of an SQL statement.
-- A view contains rows and columns, just like a real table. The fields in a view are fields from one or more real tables in the database.
-- You can add SQL statements and functions to a view and present the data as if the data were coming from one single table.

create view quantity_sold as 
select * from (select o.EmployeeID as EmpID, count(od.Quantity)
               from orders as o
               inner join orderDetails as od on o.OrderID = od.OrderID
               group by EmpID
               order by EmpID) as ViewTable;
select * from quantity_sold;--

-- lets view everthing at the same time

select * from customers as c
inner join orders as o on c.CustomerID = o.CustomerID
inner join employees as e on e.EmployeeID = o.EmployeeID
inner join shippers as s on s.ShipperID=o.ShipperID
inner join orderDetails as od on od.OrderID = o.OrderID
inner join products as p on p.ProductID = od.ProductID
inner join categories as ct on ct.CategoryID = p.CategoryID
inner join suppliers as sup on sup.SupplierID = p.SupplierID;

-- CREATE view
create view customers_from_Brazil as
select * from customers
where CustomerCountry = "Brazil";
select * from customers_from_Brazil;
-- This is a virtual table. it doesn’t get stored in the database like the customers table but behaves as if it were one.

show full tables;-- view tables
show full tables where table_type = "VIEW";-- capital

-- UPDATE views
-- since views behave just like a regular table the method of update is also same
update customers_from_Brazil
set CustomerName = "subhash chandra bose"
where CustomerID = 15;
select * from customers_from_Brazil;
-- this will also update the original table 
select * from customers; -- check id 15. 

-- RENAME view
rename table quantity_sold to Qty_sold;
show full tables;-- view tables
show full tables where table_type = "VIEW";-- capital

-- DROP view
drop view customers_from_Brazil;
drop view if exists customers_from_Brazil;


-- ---------------------------------------------------------------TRIGGERS--------------------------------------------------------------------------------
-- CREATE trigger
-- syntax 
-- delimiter //
-- create trigger [trigger name]
-- [before|after] [insert|update|delete] on [table name]
-- on each row
-- begin
-- ------code to be executed when the trigger fires
-- end //
-- delimiter ; 

/*1. DELIMITER //
MySQL by default ends a command at ";". Since the trigger body (BEGIN ... END) itself contains ";", 
you temporarily change the delimiter (e.g. //) so MySQL knows where the trigger really ends.
Later, you reset it back with DELIMITER ;.*/

/*2. CREATE TRIGGER [trigger_name]
Defines a trigger. The name (trigger_name) must be unique in the database.*/

/* 3. [BEFORE | AFTER] [INSERT | UPDATE | DELETE]
Decides when and why the trigger runs:
BEFORE INSERT → before inserting a new row.
AFTER INSERT → after inserting a new row.
BEFORE UPDATE → before updating a row.
AFTER UPDATE → after updating a row.
BEFORE DELETE → before deleting a row.
AFTER DELETE → after deleting a row.*/

/*4. ON [table_name]
The table on which the trigger is applied.*/

/*5. FOR EACH ROW
Tells MySQL to execute the trigger once for every row affected.
If you insert 10 rows, the trigger runs 10 times.*/

/*6. BEGIN ... END
Block of code to execute.
Inside, you can use:
NEW.column → the value being inserted/updated.
OLD.column → the value before update/delete.*/

/* 7. END // and DELIMITER ;
END // → marks the end of the trigger (using //).
DELIMITER ; → reset delimiter back to normal.*/

create table deletedCustomers like customers;
desc deletedCustomers;
delimiter //
create trigger after_delete_customer
before delete on customers 
for each row
begin 
insert into deletedCustomers
(CustomerID, CustomerName, CustomerContactName, CustomerAddress, CustomerCity, CostomerPostalCode, CustomerCountry)
values 
(old.CustomerID, old.CustomerName, old.CustomerContactName, old.CustomerAddress, old.CustomerCity, old.CostomerPostalCode, old.CustomerCountry);
end //
delimiter ; 

select * from customers; -- here wolski should be added in deletedCustomers table.
delete from customers
where CustomerID = 91;
select * from deletedCustomers;-- here the customer with id 91 was added to the deletedcustomers table.
-- you can make many more tiggers(things that you want to do [after|before] [insert|update|delete]). this was just one example.

-- READ triggers
show triggers;
show triggers in northwind;
show triggers from northwind;
show triggers from northwind where event = "DELETE";-- has to be capital

-- DROP triggers
drop trigger after_delete_customer;
drop trigger if exists  after_delete_customer;

-- ---------------------------------------------------------------PROCEDURE--------------------------------------------------------------------------------
-- create
-- syntax
-- DELIMITER //
-- CREATE PROCEDURE procedure_name ([parameter_list])
-- BEGIN
--    -- SQL statements
-- END //
-- DELIMITER ;

-- the only thing new here is [parameter list] => [in|out|inout]
-- in (default) => Used to pass a value into the procedure. Acts like a read-only variable. Value cannot be changed and returned.
-- out => Used to return a value from the procedure to the caller. Caller must provide a session variable (@var) to capture the result.
-- inout => Works as both input and output. Caller passes a value, procedure can modify it, and return the modified value.

-- IN EXAMPLE
delimiter //
create procedure getCustomer(in ID int)
begin
select * from customers
where CustomerID = ID;
end //
delimiter ;
-- CALL procedure
call getCustomer(1); 

-- OUT EXAMPLE
delimiter //
create procedure getProduct(in id int,
							   out name varchar(255),
                            out category int,
                            out price decimal(10,2))
begin 
select ProductName,CategoryID,Price
into name, category, price
from products
where ProductID = id;
end //
delimiter ;
-- CALL procedure
CALL getProduct(5, @name, @category, @price);
SELECT @name, @category, @price; -- there is null value in price. idk why?
-- DROP procedure
drop procedure getProduct;
-- SHOW procedure
show procedure status;


-- ------------------------------------------------------------------FUNCTIONS--------------------------------------------------------------------------------
-- DELIMITER //
-- CREATE FUNCTION function_name(parameter_name datatype, ...)
-- RETURNS return_datatype
-- [DETERMINISTIC | NOT DETERMINISTIC]
-- BEGIN
--     -- declare local variables (optional)
--     -- SQL statements
--     RETURN value;   -- mandatory
-- END //

-- FUNCTION in MySQL
-- CREATE FUNCTION function_name(...)
-- Creates a new function with the given name.

-- PARAMETERS:
-- Functions only allow IN parameters (no OUT or INOUT).
-- Example: (num1 INT, num2 INT).

-- RETURNS return_datatype
-- Mandatory. Specifies the data type of the value the function will return.
-- Example: RETURNS INT, RETURNS DECIMAL(10,2), RETURNS VARCHAR(100).

-- DETERMINISTIC / NOT DETERMINISTIC
-- DETERMINISTIC - always gives the same result for the same input.
-- NOT DETERMINISTIC -  may return different results for the same input 
-- Best practice: always use DETERMINISTIC if possible.

-- BEGIN … END
-- Function body where you write your logic.

-- RETURN value;
-- Mandatory. Every function must return a single value.
-- Without it, MySQL will throw an error.

-- DELIMITER
-- Changes the delimiter from ";" to something else (like //) so MySQL doesn’t confuse statements inside the function with the end of the function.
-- After defining, reset it back with "DELIMITER ;"
-- CREATE function
DELIMITER ;
delimiter //
create function percentageChange(newValue decimal(10,2), oldValue decimal(10,2))
returns decimal(10,2) 
deterministic
begin
return (((newValue-oldValue)/oldValue)*100);
end//
delimiter ;
-- PRINT answer
select percentageChange(100,70);
-- show function
show function status where name like "percentageChange";
-- drop function
drop function percentageChange;

-- --------------------------------------------------TRANSACTION CONTROL LANGUAGE-------------------------------------------------------------------------
-- COMMIT
-- ROLLBACK
-- SAVEPOINT
create table  dummyTransaction as 
select * from customers;

SET autocommit = 0;
SET SQL_SAFE_UPDATES = 0;

-- ROLLBACK
-- By default, a ROLLBACK undoes all the changes made in the transaction.  
-- For example, if we have made 3 entries and then run ROLLBACK, all 3 entries will be undone.

delete from dummyTransaction
where CustomerID = 3;

select * from dummyTransaction;-- there won't be customer with id = 3 here. 
rollback;-- this helped us get back the customer data, it will rollback all previous transaction. 
select * from dummyTransaction;

-- COMMIT
delete from dummyTransaction
where CustomerID = 3;

COMMIT;-- In a way, the above statement has been permanently saved (committed).

select * from dummyTransaction; -- customer with id = 3 will not be found here  
rollback; -- this rollback won’t restore the previous state in this case  
select * from dummyTransaction; -- customer with id = 3 will still not be present here  

-- SAVEPOINT 
-- This works like a checkpoint that allows us to roll back only up to the marked point using a savepoint.
insert into dummyTransaction
values 
(100, 'Bhagat Singh', 'Bhagat Singh', 'Kotwali Bagh', 'Banga', '143505', 'India');
savepoint point1;

insert into dummyTransaction
values 
(101, 'Rani Lakshmibai', 'Rani Lakshmibai', 'Jhansi Fort', 'Jhansi', '284001', 'India');
savepoint point2;
select * from dummyTransaction; -- both entries (100 & 101) are visible here  

rollback to point1; -- defines how far back the rollback should go (up to point1)  

select * from dummyTransaction;
-- now only CustomerID = 101 is removed, while 100 remains 
-- because rollback only goes back to point1  

commit; -- commit the transaction so far, so CustomerID = 100 is saved permanently  

rollback;
select * from dummyTransaction; -- CustomerID = 100 is still present because it was already committed  
