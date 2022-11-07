select region,
	sum(population)
from "populationdbbrazil"."population"
where region='Sudeste'
group by region;