
DROP TABLE IF EXISTS transfers;

create table transfers
(
    id              bigserial primary key,
    request_id      bigserial,
    sender_id       bigint,
    send_account    varchar(16),
    receiver_id     bigint,
    receiv_account  varchar(16),
    amount          numeric(6, 2),
    document_status varchar(16),
    update_date_time timestamp
);


CREATE OR REPLACE FUNCTION RandomStatus(OUT result text) as
$BODY$
BEGIN
    IF random() > 0.3 THEN result := 'COMPLETED';
    ELSEIF random() > 0.1 THEN result := 'CREATED';
    ELSE result := 'ERROR';
    END IF;
    RETURN;
END
$BODY$ language plpgsql;

INSERT INTO transfers (id,request_id, sender_id, send_account,receiver_id,receiv_account,amount,document_status,update_date_time)
SELECT s,
       trunc(random()*10000 + 1),
       trunc(random()*10 + 1),
       trunc(random()*(8999999999999999) + 1000000000000000)::bigint::text::varchar,
       trunc(random()*10 + 1),
       trunc(random()*(8999999999999999) + 1000000000000000)::bigint::text::varchar,
       trunc(random()*(1000))::numeric(6,2),
       RandomStatus(),
       timestamp '2024-01-01 00:00:00' + random() * (timestamp '2024-08-18 20:00:00' - timestamp '2024-01-01 00:00:00')
FROM generate_series(1,100) s;

