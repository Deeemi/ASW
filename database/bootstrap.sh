PASSWORD='asd'

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install postgres
sudo apt-get install -y postgresql postgresql-contrib

POSTGRE_VERSION=9.3

# listen for localhost connections
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$POSTGRE_VERSION/main/postgresql.conf

# identify users via "md5", rather than "ident", allowing us to make postgres
# users separate from system users. "md5" lets us simply use a password
echo "host    all             all             0.0.0.0/0               md5" | sudo tee -a /etc/postgresql/$POSTGRE_VERSION/main/pg_hba.conf
sudo service postgresql start

# create new user "root" with defined password "root" superuser
sudo -u postgres psql -c "CREATE ROLE root LOGIN  PASSWORD '$PASSWORD' SUPERUSER INHERIT CREATEDB CREATEROLE NOREPLICATION;"


# create new database "database"

sudo -u postgres psql -c "CREATE DATABASE database"

sudo service postgresql restart
               
# define privileges for read-only users           
sudo -u postgres psql -c "CREATE USER readonly  WITH ENCRYPTED PASSWORD 'readonly';
                          GRANT USAGE ON SCHEMA public to readonly;
                          ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;"

sudo service postgresql restart

sudo su - root

psql database

# create table squadra
sudo -u postgres psql database -c "CREATE TABLE squadra
								   (idsquadra character varying(3) NOT NULL,
  								    nomesquadra character varying(30),
  								    citta character varying(30),
  								    annofondazione character varying(4),
  								    stadio character varying(30),
  								    CONSTRAINT \"idsquadra\" PRIMARY KEY (idsquadra));"

# create table calciatore                   
sudo -u postgres psql database -c "CREATE TABLE calciatore
  								  (id serial NOT NULL,
  								  nome character varying(20),
  								  cognome character varying(20),
  								  nascita date,
  								  nazione character varying(30),
  								  ruolo character varying(3),
  								  squadra character varying(3),
  								  CONSTRAINT \"id\" PRIMARY KEY (id),
  								  CONSTRAINT \"squadraidquadra\" FOREIGN KEY (squadra)
                    REFERENCES public.squadra (idsquadra) MATCH SIMPLE
                    ON UPDATE NO ACTION ON DELETE NO ACTION);"

# instert of some values in each tables
sudo -u postgres psql database -c "INSERT INTO squadra (idsquadra, nomesquadra, citta, annofondazione, stadio)
VALUES ('mil','A.C. Milan','Milano','1899','San Siro');"

sudo -u postgres psql database -c "INSERT INTO squadra (idsquadra, nomesquadra, citta, annofondazione, stadio)
VALUES ('atl','Athletic Bilbao','Bilbao','1898','San Mames');"

sudo -u postgres psql database -c "INSERT INTO squadra (idsquadra, nomesquadra, citta, annofondazione, stadio)
VALUES ('vic','Vicenza Calcio','Vicenza','1902','Romeo Menti');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Gigio','Donnarumma','1999-02-25','Italia','por','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Philippe','Mexès','1982-03-30','Francia','dif','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Mattia','De Sciglio','1992-10-20','Italia','dif','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Luca','Antonelli','1987-11-02','Italia','dif','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Riccardo','Montolivo','1985-01-18','Italia','cen','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Jeremy','Ménez','1987-05-07','Francia','att','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Carlos','Bacca','1986-09-08','Colombia','att','mil');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Artiz','Aduriz','1981-02-11','Spagna','att','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Iker','Muniain','1992-12-19','Spagna','att','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Ander','Iturraspe','1989-03-08','Spagna','cen','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Markel','Susaeta', '1987-12-14','Spagna','cen','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Gorka','Iraizoz','1981-03-06','Spagna','por','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Xabier','Etxeita', '1987-10-31','Spagna','dif','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Oscar','De Marcos', '1989-04-14','Spagna','cen','atl');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Mario','Sampirisi','1992-10-31','Italia','dif','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Giovanni','Sbrissa','1996-09-25','Italia','cen','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Francesco','Benussi', '1981-10-15','Italia','por','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Osarimen','Ebagua', '1986-06-06','Nigeria','att','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Stefano','Giacomelli', '1990-04-30','Italia','att','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Filip','Raicevic', '1993-07-02','Montenegro','att','vic');"

sudo -u postgres psql database -c "INSERT INTO calciatore (nome, cognome, nascita, nazione, ruolo, squadra)
VALUES ('Nicola','Pozzi', '1986-06-30','Italia','att','vic');"

# define privileges for read-only users
sudo -u postgres psql database -c "GRANT CONNECT ON DATABASE database to readonly;
                                   GRANT USAGE ON SCHEMA public TO readonly; 
                                   GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readonly;
                                   GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;"

sudo service postgresql restart 

# sudo -u postgres psql -c "\q"

# install git
sudo apt-get -y install git