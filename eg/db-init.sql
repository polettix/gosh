PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE actor (
                           id INTEGER PRIMARY KEY,
                  displayname TEXT
               );
INSERT INTO "actor" VALUES(1,'Silvia');
INSERT INTO "actor" VALUES(2,'Flavio');
INSERT INTO "actor" VALUES(3,'Silvia & Flavio');
CREATE TABLE actor_membership (
                   group_id INTEGER references actor(id),
                  member_id INTEGER references actor(id),
                  UNIQUE(group_id, member_id)
               );
INSERT INTO "actor_membership" VALUES(3,1);
INSERT INTO "actor_membership" VALUES(3,2);
CREATE TABLE account (
                           id INTEGER PRIMARY KEY,
                     actor_id INTEGER REFERENCES actor(id),
                     username TEXT UNIQUE,
                     password TEXT,
                  displayname TEXT
               );
INSERT INTO "account" VALUES(1,1,'silvia','silvia','Silvia Nardoni');
INSERT INTO "account" VALUES(2,2,'polettix','flavio','Flavio Poletti');
CREATE TABLE activity (
                           id INTEGER PRIMARY KEY,
                        name TEXT,
                  description TEXT
               );
INSERT INTO "activity" VALUES(1,'lavatrice',NULL);
INSERT INTO "activity" VALUES(2,'stendere lavatrice',NULL);
INSERT INTO "activity" VALUES(3,'piegare panni asciutti',NULL);
INSERT INTO "activity" VALUES(4,'riporre panni nei cassetti',NULL);
INSERT INTO "activity" VALUES(5,'aspirapolvere camera da letto',NULL);
INSERT INTO "activity" VALUES(6,'swiffer camera da letto',NULL);
INSERT INTO "activity" VALUES(7,'mocho camera da letto',NULL);
INSERT INTO "activity" VALUES(8,'aspirapolvere salone',NULL);
INSERT INTO "activity" VALUES(9,'swiffer salone',NULL);
INSERT INTO "activity" VALUES(10,'mocho salone',NULL);
INSERT INTO "activity" VALUES(11,'aspirapolvere corridoio',NULL);
INSERT INTO "activity" VALUES(12,'swiffer corridoio',NULL);
INSERT INTO "activity" VALUES(13,'mocho corridoio',NULL);
INSERT INTO "activity" VALUES(14,'aspirapolvere stanza degli orrori',NULL);
INSERT INTO "activity" VALUES(15,'swiffer stanza degli orrori',NULL);
INSERT INTO "activity" VALUES(16,'mocho stanza degli orrori',NULL);
INSERT INTO "activity" VALUES(17,'aspirapolvere bagno',NULL);
INSERT INTO "activity" VALUES(18,'swiffer bagno',NULL);
INSERT INTO "activity" VALUES(19,'mocho bagno',NULL);
INSERT INTO "activity" VALUES(20,'aspirapolvere cucina',NULL);
INSERT INTO "activity" VALUES(21,'swiffer cucina',NULL);
INSERT INTO "activity" VALUES(22,'mocho cucina',NULL);
INSERT INTO "activity" VALUES(23,'aspirapolvere balcone',NULL);
INSERT INTO "activity" VALUES(24,'mocho balcone',NULL);
INSERT INTO "activity" VALUES(25,'svuotamento iniziale aspirapolvere',NULL);
INSERT INTO "activity" VALUES(26,'svuotamento finale aspirapolvere',NULL);
INSERT INTO "activity" VALUES(27,'pulizia spazzole aspirapolvere',NULL);
INSERT INTO "activity" VALUES(28,'svuotamento roomba',NULL);
INSERT INTO "activity" VALUES(29,'pulizia spazzole roomba',NULL);
INSERT INTO "activity" VALUES(30,'pulizia iniziale mocho (secchio e straccio)',NULL);
INSERT INTO "activity" VALUES(31,'pulizia finale mocho (secchio e straccio)',NULL);
INSERT INTO "activity" VALUES(32,'pulizia water',NULL);
INSERT INTO "activity" VALUES(33,'pulizia bidet',NULL);
INSERT INTO "activity" VALUES(34,'pulizia lavandino bagno',NULL);
INSERT INTO "activity" VALUES(35,'pulizia vasca doccia',NULL);
INSERT INTO "activity" VALUES(36,'pulizia vetri doccia',NULL);
INSERT INTO "activity" VALUES(37,'pulizia specchio bagno',NULL);
INSERT INTO "activity" VALUES(38,'pulizia portaspazzolini',NULL);
INSERT INTO "activity" VALUES(39,'preparazione colazione',NULL);
INSERT INTO "activity" VALUES(40,'preparazione pasto facile',NULL);
INSERT INTO "activity" VALUES(41,'preparazione pasto medio',NULL);
INSERT INTO "activity" VALUES(42,'preparazione pasto impegnativo',NULL);
INSERT INTO "activity" VALUES(43,'apparecchiare per pasto',NULL);
INSERT INTO "activity" VALUES(44,'sparecchiare dopo il pasto',NULL);
INSERT INTO "activity" VALUES(45,'caricare lavastoviglie',NULL);
INSERT INTO "activity" VALUES(46,'scaricare lavastoviglie',NULL);
INSERT INTO "activity" VALUES(47,'pulizia piano lavoro in cucina',NULL);
INSERT INTO "activity" VALUES(48,'pulizia fornelli',NULL);
INSERT INTO "activity" VALUES(49,'pulizia piano snack',NULL);
INSERT INTO "activity" VALUES(50,'sciacquare i piatti subito',NULL);
INSERT INTO "activity" VALUES(51,'sciacquare i piatti dopo (fatto da altro)',NULL);
INSERT INTO "activity" VALUES(52,'pasto e acqua gatti',NULL);
INSERT INTO "activity" VALUES(53,'cambio sabbietta gatti',NULL);
INSERT INTO "activity" VALUES(54,'paletta sabbietta gatti',NULL);
INSERT INTO "activity" VALUES(55,'buttare spazzatura indifferenziata in cucina',NULL);
INSERT INTO "activity" VALUES(56,'pulizia e cambio busta spazzatura indifferenziata in cucina',NULL);
INSERT INTO "activity" VALUES(57,'buttare spazzatura umido',NULL);
INSERT INTO "activity" VALUES(58,'pulizia e cambio busta spazzatura umido',NULL);
INSERT INTO "activity" VALUES(59,'buttare spazzatura carta in cucina',NULL);
INSERT INTO "activity" VALUES(60,'pulizia e cambio busta spazzatura carta in cucina',NULL);
INSERT INTO "activity" VALUES(61,'buttare spazzatura plastica',NULL);
INSERT INTO "activity" VALUES(62,'pulizia e cambio busta spazzatura plastica',NULL);
INSERT INTO "activity" VALUES(63,'buttare spazzatura vetro',NULL);
INSERT INTO "activity" VALUES(64,'pulizia e cambio busta spazzatura vetro',NULL);
INSERT INTO "activity" VALUES(65,'buttare spazzatura indifferenziata in bagno',NULL);
INSERT INTO "activity" VALUES(66,'pulizia e cambio busta spazzatura indifferenziata in bagno',NULL);
INSERT INTO "activity" VALUES(67,'buttare spazzatura carta in bagno',NULL);
INSERT INTO "activity" VALUES(68,'pulizia e cambio busta spazzatura carta in bagno',NULL);
INSERT INTO "activity" VALUES(69,'buttare spazzatura indifferenziata in camera da letto',NULL);
INSERT INTO "activity" VALUES(70,'pulizia e cambio busta spazzatura indifferenziata in camera da letto',NULL);
INSERT INTO "activity" VALUES(71,'spesa facile',NULL);
INSERT INTO "activity" VALUES(72,'spesa media',NULL);
INSERT INTO "activity" VALUES(73,'spesa impegnativa',NULL);
INSERT INTO "activity" VALUES(74,'cambiare le lenzuola',NULL);
INSERT INTO "activity" VALUES(75,'pulire un ripiano del frigo',NULL);
CREATE TABLE catalog (
                   id INTEGER PRIMARY KEY,
                  activity_id INTEGER REFERENCES activity(id),
                     actor_id INTEGER REFERENCES actor(id),
                   date_start TEXT,
                     date_end TEXT,
                       amount INTEGER
               );
INSERT INTO "catalog" VALUES(1,1,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(2,2,3,NULL,NULL,120);
INSERT INTO "catalog" VALUES(3,3,3,NULL,NULL,130);
INSERT INTO "catalog" VALUES(4,4,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(5,5,3,NULL,NULL,50);
INSERT INTO "catalog" VALUES(6,6,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(7,7,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(8,8,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(9,9,3,NULL,NULL,40);
INSERT INTO "catalog" VALUES(10,10,3,NULL,NULL,200);
INSERT INTO "catalog" VALUES(11,11,3,NULL,NULL,70);
INSERT INTO "catalog" VALUES(12,12,3,NULL,NULL,28);
INSERT INTO "catalog" VALUES(13,13,3,NULL,NULL,140);
INSERT INTO "catalog" VALUES(14,14,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(15,15,3,NULL,NULL,32);
INSERT INTO "catalog" VALUES(16,16,3,NULL,NULL,160);
INSERT INTO "catalog" VALUES(17,17,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(18,18,3,NULL,NULL,32);
INSERT INTO "catalog" VALUES(19,19,3,NULL,NULL,160);
INSERT INTO "catalog" VALUES(20,20,3,NULL,NULL,70);
INSERT INTO "catalog" VALUES(21,21,3,NULL,NULL,28);
INSERT INTO "catalog" VALUES(22,22,3,NULL,NULL,140);
INSERT INTO "catalog" VALUES(23,23,3,NULL,NULL,50);
INSERT INTO "catalog" VALUES(24,24,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(25,25,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(26,26,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(27,27,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(28,28,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(29,29,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(30,30,3,NULL,NULL,60);
INSERT INTO "catalog" VALUES(31,31,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(32,32,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(33,33,3,NULL,NULL,60);
INSERT INTO "catalog" VALUES(34,34,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(35,35,3,NULL,NULL,60);
INSERT INTO "catalog" VALUES(36,36,3,NULL,NULL,70);
INSERT INTO "catalog" VALUES(37,37,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(38,38,3,NULL,NULL,40);
INSERT INTO "catalog" VALUES(39,39,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(40,40,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(41,41,3,NULL,NULL,130);
INSERT INTO "catalog" VALUES(42,42,3,NULL,NULL,170);
INSERT INTO "catalog" VALUES(43,43,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(44,44,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(45,45,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(46,46,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(47,47,3,NULL,NULL,70);
INSERT INTO "catalog" VALUES(48,48,3,NULL,NULL,130);
INSERT INTO "catalog" VALUES(49,49,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(50,50,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(51,51,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(52,52,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(53,53,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(54,54,3,NULL,NULL,20);
INSERT INTO "catalog" VALUES(55,55,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(56,56,3,NULL,NULL,15);
INSERT INTO "catalog" VALUES(57,57,3,NULL,NULL,50);
INSERT INTO "catalog" VALUES(58,58,3,NULL,NULL,50);
INSERT INTO "catalog" VALUES(59,59,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(60,60,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(61,61,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(62,62,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(63,63,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(64,64,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(65,65,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(66,66,3,NULL,NULL,15);
INSERT INTO "catalog" VALUES(67,67,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(68,68,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(69,69,3,NULL,NULL,30);
INSERT INTO "catalog" VALUES(70,70,3,NULL,NULL,10);
INSERT INTO "catalog" VALUES(71,71,3,NULL,NULL,40);
INSERT INTO "catalog" VALUES(72,72,3,NULL,NULL,100);
INSERT INTO "catalog" VALUES(73,73,3,NULL,NULL,200);
INSERT INTO "catalog" VALUES(74,74,3,NULL,NULL,80);
INSERT INTO "catalog" VALUES(75,75,3,NULL,NULL,30);
CREATE TABLE register (
                  id INTEGER PRIMARY KEY,
                     actor_id INTEGER REFERENCES actor(id),
                  activity_id INTEGER REFERENCES activity(id),
                      itsdate TEXT,
                       amount INTEGER
               );
COMMIT;
