-- models/messages_transformed.sql
WITH latest_status AS (
    SELECT
        message_uuid,
        status,
        timestamp,
        ROW_NUMBER() OVER (PARTITION BY message_uuid ORDER BY timestamp DESC) AS rn
    FROM public."Noora_Statuses"
)
SELECT
    m.id,
    m.content,
    m.message_type,
    m.masked_addressees,
    m.masked_from_addr,
    m.masked_author,
    m.content,
    m.author_type,
    m.direction,
    m.external_id,
    m.external_timestamp,
    m.is_deleted,
    m.last_status,
    m.last_status_timestamp,
    m.rendered_content,
    m.uuid,
    m.inserted_at,
    m.updated_at,
    ls.status AS latest_status,
    ls.timestamp AS latest_status_timestamp
FROM public."Noora_Messages" m
LEFT JOIN latest_status ls
    ON m.uuid = ls.message_uuid
    AND ls.rn = 1;
