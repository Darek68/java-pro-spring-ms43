
DROP TABLE IF EXISTS transfers;

create table transfers
(
    id              bigserial primary key,
    client_id_from  bigint,
    client_id_to     bigint,
    account_number_from  varchar(16),
    account_number_to  varchar(16),
    transfer_sum          numeric(6, 2),
    status varchar(16),
    created_at timestamp,
    updated_at timestamp
);

CREATE OR REPLACE FUNCTION RandomStatus(OUT result text) as
$BODY$
BEGIN
    IF random() > 0.3 THEN result := 'SUCCESS';
    ELSEIF random() > 0.1 THEN result := 'CREATED';
    ELSE result := 'ERROR';
    END IF;
    RETURN;
END
$BODY$ language plpgsql;

INSERT INTO transfers (id, client_id_from, client_id_to,account_number_from,account_number_to,transfer_sum,status,created_at,updated_at)
SELECT s,
       trunc(random()*10 + 1),
       trunc(random()*10 + 1),
       trunc(random()*(8999999999999999) + 1000000000000000)::bigint::text::varchar,
       trunc(random()*(8999999999999999) + 1000000000000000)::bigint::text::varchar,
       trunc(random()*(1000))::numeric(6,2),
       RandomStatus(),
       timestamp '2024-01-01 00:00:00' + random() * (timestamp '2024-08-18 20:00:00' - timestamp '2024-01-01 00:00:00'),
       timestamp '2024-01-01 00:00:00' + random() * (timestamp '2024-08-18 20:00:00' - timestamp '2024-01-01 00:00:00')
FROM generate_series(1,100) s;

