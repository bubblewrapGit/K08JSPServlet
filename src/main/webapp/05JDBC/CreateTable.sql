
/* Drop Tables */

DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE board
(
	num number NOT NULL,
	title varchar2(200) NOT NULL,
	content varchar2(2000) NOT NULL,
	id varchar2(10) NOT NULL,
	postdate date DEFAULT SYSDATE NOT NULL,
	visitcount number(6),
	PRIMARY KEY (num)
);


CREATE TABLE member
(
	id varchar2(10) NOT NULL,
	pass varchar2(10) NOT NULL,
	name varchar2(30) NOT NULL,
	regidate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE board
	ADD constraint board_mem_fk
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
;



