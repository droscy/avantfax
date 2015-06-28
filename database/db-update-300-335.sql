-- Database update for 3.0.0

ALTER TABLE UserAccount ADD is_admin       BOOL DEFAULT FALSE;

INSERT INTO UserAccount SET name='AvantFAX Admin', username='admin', password='5f4dcc3b5aa765d61d8327deb882cf99', wasreset=TRUE, email='root@mydomain.com', is_admin = TRUE, acc_enabled = TRUE, superuser = TRUE;

ALTER TABLE UserPasswords DROP adminpwd;

ALTER TABLE FaxArchive change faxnumid faxnumid INT;

DROP TABLE AdminAccount;

-- DROP TABLE UserRubrica;
-- DROP TABLE Rubrica;
-- DROP TABLE FaxNum;

-- AddressBook table
CREATE TABLE IF NOT EXISTS AddressBook (
abook_id       INT auto_increment KEY,
company        VARCHAR(255)
) DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS AddressBookEmail (
abookemail_id  INT auto_increment KEY,
abook_id       INT,
contact_name   VARCHAR(255),
contact_email  VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET utf8;

CREATE TABLE IF NOT EXISTS AddressBookFAX (
abookfax_id    INT auto_increment KEY,
abook_id       INT,
faxnumber      VARCHAR(20) NOT NULL,
email          VARCHAR(100),
description    VARCHAR(30),
to_person      VARCHAR(150),
to_location    VARCHAR(150),
to_voicenumber VARCHAR(150),
faxcatid       INT,
faxfrom        INT DEFAULT 0,
faxto          INT DEFAULT 0
) DEFAULT CHARACTER SET utf8;

-- Database update for 3.0.2

ALTER TABLE FaxArchive add faxcontent  TEXT;

-- Database update for 3.0.6

ALTER TABLE DIDRoute add printer VARCHAR(100);
ALTER TABLE Modems add printer VARCHAR(100);

-- Database update for 3.0.7

-- DynConf table for Blacklisting
CREATE TABLE IF NOT EXISTS DynConf (
dynconf_id      INT auto_increment KEY,
device          VARCHAR(20),
callid          VARCHAR(100)
) DEFAULT CHARACTER SET utf8;


ALTER TABLE UserAccount ADD user_tsi VARCHAR(100);

-- Database update for 3.1.1

-- Barcode Route
CREATE TABLE IF NOT EXISTS BarcodeRoute (
barcode_id      INT auto_increment KEY,
barcode         TEXT,
alias           VARCHAR(40),
contact         VARCHAR(100),
printer		VARCHAR(100),
faxcatid        INT
) DEFAULT CHARACTER SET utf8;


ALTER TABLE DIDRoute ADD faxcatid INT;
ALTER TABLE Modems   ADD faxcatid INT;
ALTER TABLE AddressBookFAX ADD printer VARCHAR(100);

ALTER TABLE UserAccount ADD any_modem BOOL DEFAULT FALSE;

-- Database update for 3.1.5

ALTER TABLE UserAccount change language language VARCHAR(5);

-- Database update for 3.1.6

ALTER TABLE UserAccount change modemdevs modemdevs TEXT;
ALTER TABLE UserAccount change didrouting didrouting TEXT;
ALTER TABLE UserAccount change faxcats faxcats TEXT;

-- Database update for 3.2.0

-- COVER PAGES
CREATE TABLE IF NOT EXISTS CoverPages (
cover_id        INT auto_increment KEY,
title           VARCHAR(64) NOT NULL,
file            VARCHAR(255) NOT NULL
) DEFAULT CHARACTER SET utf8;

INSERT INTO CoverPages SET title='Generic A4', file='cover.ps';
INSERT INTO CoverPages SET title='Generic Letter', file='cover-letter.ps';
INSERT INTO CoverPages SET title='Generic HTML', file='coverpage.html';

ALTER TABLE UserAccount ADD coverpage_id   INT;

-- Database update for 3.3.0

ALTER TABLE UserAccount ADD faxperpageinbox   INT;
ALTER TABLE UserAccount ADD faxperpagearchive INT;

-- Database update for 3.3.4
ALTER TABLE  `AddressBookFAX` 
    ADD `to_address` VARCHAR( 50 ) NOT NULL AFTER  `to_location` ,
    ADD `to_zip` VARCHAR( 6 ) NOT NULL AFTER  `to_address` ,
    ADD `to_city` VARCHAR( 50 ) NOT NULL AFTER  `to_zip`

-- Database update for 3.3.5
ALTER TABLE  `UserAccount` 
    ADD `audiofile` VARCHAR( 50 ) NULL AFTER  `coverpage_id` 

