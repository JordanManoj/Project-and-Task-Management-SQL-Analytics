#Model training table
CREATE TABLE Model_Training (
  training_id INT PRIMARY KEY,
  project_id INT,
  model_name VARCHAR(100),
  accuracy DECIMAL(5,2),
  training_date DATE
);

INSERT INTO Model_Training VALUES
(1, 1, 'BERT', 89.50, '2024-07-01'),
(2, 1, 'GPT-2', 91.20, '2024-07-05'),
(3, 3, 'MobileNet', 85.00, '2024-07-15'),
(4, 3, 'RoBERTA', 88.00, '2024-07-18');

#Project with highest accuracy model
SELECT p.project_name, mt.model_name, mt.accuracy
FROM Projects p
JOIN (
  SELECT project_id, model_name, accuracy,
         RANK() OVER (PARTITION BY project_id ORDER BY accuracy DESC) AS rnk
  FROM Model_Training
) mt ON p.project_id = mt.project_id
WHERE rnk = 1;

#Dataset table
CREATE TABLE Data_Sets (
  dataset_id INT PRIMARY KEY,
  project_id INT,
  dataset_name VARCHAR(100),
  size_gb DECIMAL(5,2),
  last_updated DATE
);

INSERT INTO Data_Sets VALUES
(1, 1, 'Training Set 1', 12.5, '2024-07-01'),
(2, 2, 'Training Set 2', 8.0, '2024-08-25'),
(3, 4, 'Training Set 3', 15.2, '2023-07-05');


#Projects with large and recently updated datasets
SELECT DISTINCT p.project_name
FROM Projects p
JOIN Data_Sets d ON p.project_id = d.project_id
WHERE d.size_gb > 10
  AND d.last_updated >= CURRENT_DATE - INTERVAL 30 DAY;



