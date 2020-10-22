CREATE TABLE suspicious_names (CREATED_DATE VARCHAR,
                               COMPANY_NAME VARCHAR PRIMARY KEY,
                               COMPANY_ID INT)
    WITH (kafka_topic='suspicious-accounts', partitions=1, value_format='JSON');

CREATE STREAM transactions (TXN_ID BIGINT, USERNAME VARCHAR, RECIPIENT VARCHAR, AMOUNT DOUBLE)
    WITH (kafka_topic='transactions', partitions=1, value_format='JSON');

CREATE STREAM suspicious_transactions
    WITH (kafka_topic='suspicious_transactions', partitions=1, value_format='JSON') AS
    SELECT T.TXN_ID, T.USERNAME, T.RECIPIENT, T.AMOUNT
    FROM transactions T
    INNER JOIN
    suspicious_names S
    ON T.RECIPIENT = S.COMPANY_NAME;

CREATE TABLE accounts_to_monitor
    WITH (kafka_topic='accounts_to_monitor', partitions=1, value_format='JSON') AS
    SELECT TIMESTAMPTOSTRING(WINDOWSTART, 'yyyy-MM-dd HH:mm:ss Z') AS WINDOW_START,
           TIMESTAMPTOSTRING(WINDOWEND, 'yyyy-MM-dd HH:mm:ss Z') AS WINDOW_END,
           USERNAME
    FROM suspicious_transactions
    WINDOW TUMBLING (SIZE 24 HOURS)
    GROUP BY USERNAME
    HAVING COUNT(*) > 3;
