
WITH status_ranked AS (
    SELECT
        message_id,
        status,
        timestamp,
        ROW_NUMBER() OVER (PARTITION BY message_id ORDER BY timestamp DESC) AS rn
    FROM public.Noora_Statuses
)
,
status_pivot AS (
    SELECT
        message_id,
        MAX(CASE WHEN rn = 1 THEN status END) AS status_1,
        MAX(CASE WHEN rn = 1 THEN timestamp END) AS timestamp_status_1,
        MAX(CASE WHEN rn = 2 THEN status END) AS status_2,
        MAX(CASE WHEN rn = 2 THEN timestamp END) AS timestamp_status_2,
        MAX(CASE WHEN rn = 3 THEN status END) AS status_3,
        MAX(CASE WHEN rn = 3 THEN timestamp END) AS timestamp_status_3,
        MAX(CASE WHEN rn = 4 THEN status END) AS status_4,
        MAX(CASE WHEN rn = 4 THEN timestamp END) AS timestamp_status_4,
        MAX(CASE WHEN rn = 5 THEN status END) AS status_5,
        MAX(CASE WHEN rn = 5 THEN timestamp END) AS timestamp_status_5,
		 MAX(CASE WHEN rn = 6 THEN status END) AS status_6,
        MAX(CASE WHEN rn = 6 THEN timestamp END) AS timestamp_status_6,
        MAX(CASE WHEN rn = 7 THEN status END) AS status_7,
        MAX(CASE WHEN rn = 7 THEN timestamp END) AS timestamp_status_7,
        MAX(CASE WHEN rn = 8 THEN status END) AS status_8,
        MAX(CASE WHEN rn = 8 THEN timestamp END) AS timestamp_status_8,
        MAX(CASE WHEN rn = 9 THEN status END) AS status_9,
        MAX(CASE WHEN rn = 9 THEN timestamp END) AS timestamp_status_9,
        MAX(CASE WHEN rn = 10 THEN status END) AS status_10,
        MAX(CASE WHEN rn = 10 THEN timestamp END) AS timestamp_status_10
    FROM status_ranked
    GROUP BY message_id
)
SELECT
    m.id as message_id,
    m.content,
    m.message_type,
    m.masked_addressees,
    m.masked_from_addr,
    m.direction,
    m.external_id,
    m.external_timestamp,
    m.is_deleted,
    sp.status_1,
    sp.timestamp_status_1,
    sp.status_2,
    sp.timestamp_status_2,
    sp.status_3,
    sp.timestamp_status_3,
    sp.status_4,
    sp.timestamp_status_4,
    sp.status_5,
    sp.timestamp_status_5,
	sp.status_6,
    sp.timestamp_status_6,
    sp.status_7,
    sp.timestamp_status_7,
    sp.status_8,
    sp.timestamp_status_8,
    sp.status_9,
    sp.timestamp_status_9,
    sp.status_10,
    sp.timestamp_status_10,
    sp.message_id as status_message_id,
    m.rendered_content,
    m.uuid,
    m.inserted_at,
    m.updated_at
FROM public.Noora_Messages m
LEFT JOIN status_pivot sp ON m.id=sp.message_id
