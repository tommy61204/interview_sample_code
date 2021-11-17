-- 1. A common question asked by a manager would be: "What are the process adherence % and cycle time for each experiment started in Q4 to date?
 -- The following query outputs an "Experiment_ID" for each experiment and KPI metrics such as "process adherence" and "cycle time" from the "experiments" table and their respective KPI targets from the "targets" table
SELECT e.exp_id AS Experiment_ID, e.start_date, e.process_adherence, e.cycle_time, t.process_adherence_target, t.cycle_time_target 
FROM experiments AS e
LEFT JOIN targets AS t 
 -- A left join is used because we want to display all records in the experiments table, regardless if there are respective targets or not as certain programs may not have targets yet.
ON e.program_id = t.program_id
WHERE e.start_date > '2021-10-01';

-- 2. Another question would be: "What are the average process adherence % and cycle time for each team last month? 
SELECT team, AVG(process_adherence), AVG(cycle_time)
FROM experiments
WHERE start_date BETWEEN '2021-10-01' AND '2021-10-31'
GROUP BY team
ORDER BY process_adherence DESC;

-- 3. A follow up question would be: "What are the experiments started this month that came out below the average process adherence % from last month?
  -- A subquery is used here to first calculate the average process adherence from last month
SELECT team, exp_id, process_adherence
FROM experiments
WHERE process_adherence < (SELECT AVG(process_adherece)
	FROM experiments 
	WHERE start_date BETWEEN '2021-10-01' AND '2021-10-31')
AND start_date > '2021-11-01'
GROUP BY team;
