
-- Use the `ref` function to select from other models

With Combined AS (
select
M.id,M.message_type,M.masked_addressees,M.masked_author,M.content,M.author_type,direction,external_id,external_timestamp,masked_from_addr,is_deleted,last_status,last_status_timestamp	,rendered_content,source_type,M.uuid,M.inserted_at,M.updated_at,S.id,S.status,S.timestamp,S.uuid,S.message_uuid,S.message_id,S.number_id,S.inserted_at,S.updated_at
from public."Noora_Messages" as M
Join
public."Noora_Statuses" as S
ON M.id=S.message_id
)
Select * from combined