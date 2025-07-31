# Table 1
CREATE TABLE Projects (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(100),
  start_date DATE,
  end_date DATE,
  budget DECIMAL(10,2),
  team_id INT
);

INSERT INTO Projects VALUES
(1, 'AI Assistant', '2024-01-01', '2024-12-31', 500000, 1),
(2, 'Website Redesign', '2024-02-15', '2024-09-15', 150000, 2),
(3, 'Mobile App', '2024-03-01', '2024-11-30', 300000, 1),
(4, 'Cloud Migration', '2024-04-10', '2025-01-10', 700000, 3),
(5, 'Cybersecurity Audit', '2024-05-05', '2024-12-05', 250000, 4);

# Table 2
CREATE TABLE Tasks (
  task_id INT PRIMARY KEY,
  task_name VARCHAR(100),
  project_id INT,
  assigned_to VARCHAR(50),
  due_date DATE,
  status VARCHAR(20)
);

INSERT INTO Tasks VALUES
(1, 'Build Model', 1, 'Aine', '2024-08-01', 'Completed'),
(2, 'Train Model', 1, 'Sheena', '2024-08-10', 'Pending'),
(3, 'Design UI', 2, 'Sam', '2024-08-05', 'Completed'),
(4, 'Setup Hosting', 3, 'Don', '2024-07-20', 'Completed'),
(5, 'Security Check', 5, 'Tom', '2024-08-15', 'Pending'),
(6, 'Optimize DB', 4, 'Tony', '2024-08-10', 'Completed'),
(7, 'Final Testing', 1, 'Teena', '2024-08-18', 'Pending');

# Table 3
CREATE TABLE Teams (
  member_id INT PRIMARY KEY,
  member_name VARCHAR(50),
  role VARCHAR(50),
  team_id INT,
  email VARCHAR(100)
);

INSERT INTO Teams VALUES
(1, 'Sam', 'Team Lead', 1, 'sample1@example.com'),
(2, 'Tommy', 'Developer', 1, 'sample2@example.com'),
(3, 'David', 'Designer', 2, 'sample3@example.com'),
(4, 'Elsa', 'DevOps', 1, 'sample4@example.com'),
(5, 'Meena', 'Team Lead', 4, 'sample5@example.com');

#Projects with total and completed task
WITH TaskCounts AS (
  SELECT project_id,
         COUNT(*) AS total_tasks,
         COUNT(CASE WHEN status = 'Completed' THEN 1 END) AS completed_tasks
  FROM Tasks
  GROUP BY project_id
)
SELECT p.project_name, t.total_tasks, t.completed_tasks
FROM Projects p
JOIN TaskCounts t ON p.project_id = t.project_id;

#Team mates with highest task assigned
SELECT assigned_to, task_count
FROM (
  SELECT assigned_to, COUNT(*) AS task_count,
         RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
  FROM Tasks
  GROUP BY assigned_to
) t
WHERE rnk <= 2;

#Tasks with due date earlier than project’s average due date
SELECT task_name, due_date
FROM Tasks t1
WHERE due_date < (
  SELECT AVG(due_date)
  FROM Tasks t2
  WHERE t2.project_id = t1.project_id
);

# Project with maximum budget
SELECT *
FROM Projects
WHERE budget = (
  SELECT MAX(budget) FROM Projects
);

# Percentage of completed tasks per project
SELECT p.project_name,
       ROUND(100.0 * COUNT(CASE WHEN t.status = 'Completed' THEN 1 END) / COUNT(*), 2) AS completion_rate
FROM Projects p
JOIN Tasks t ON p.project_id = t.project_id
GROUP BY p.project_name;

#task count per assigned person
SELECT task_name, assigned_to,
       COUNT(*) OVER (PARTITION BY assigned_to) AS total_tasks_by_user
FROM Tasks
ORDER BY assigned_to;

#Tasks assigned to team leader which not completed and the due date is within next 15 days
SELECT t.*
FROM Tasks t
JOIN Teams te ON t.assigned_to = te.member_name
WHERE te.role = 'Team Lead'
AND t.status != 'Completed'
AND t.due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 15 DAY);

#Projects with zero tasks assigned
SELECT *
FROM Projects
LEFT JOIN Tasks ON Projects.project_id = Tasks.project_id
WHERE Tasks.project_id IS NULL;


