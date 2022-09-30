SHOW search_path;
SELECT current_database();

select *
from scores
order by score desc
fetch first 10 rows only