# Project and Task Management SQL Analytics

This SQL-based project showcases how to manage and analyze data from a company handling multiple projects, team members, and associated tasks. It covers core database design and advanced SQL queries using real-world business logic.

---

## Database Schema

### Tables Created:

1. **Projects**
   - Columns: `project_id`, `project_name`, `start_date`, `end_date`, `budget`, `team_id`

2. **Tasks**
   - Columns: `task_id`, `task_name`, `project_id`, `assigned_to`, `due_date`, `status`

3. **Teams**
   - Columns: `member_id`, `member_name`, `role`, `team_id`, `email`

4. **Model_Training** (additional table)
   - Columns: `training_id`, `project_id`, `model_name`, `accuracy`, `training_date`

5. **Data_Sets** (additional table)
   - Columns: `dataset_id`, `project_id`, `dataset_name`, `size_gb`, `last_updated`

---

##  SQL Features Demonstrated

###  Core & Advanced SQL Concepts:

- **CTEs (Common Table Expressions)**
- **Window Functions (`RANK`, `COUNT OVER`, etc.)**
- **Correlated Subqueries**
- **Aggregate Filtering**
- **Subqueries in `WHERE` and `SELECT`**
- **Date-based Conditions (`CURRENT_DATE + INTERVAL`)**
- **LEFT JOIN for NULL checks**

---


### Query Highlights

1. **Project Task Summary using CTE**  
   Shows project name with total and completed task count using a `WITH` clause.

2. **Top 2 Most Assigned Team Members**  
   Uses `RANK()` to identify top performers across all projects.

3. **Tasks Due Earlier than Average Due Date (per project)**  
   Correlated subquery filters tasks before the average deadline of their project.

4. **Project with Highest Budget**  
   Subquery returns project with the maximum budget from the `Projects` table.

5. **Completed Task Percentage per Project**  
   Uses `CASE WHEN` or `FILTER` to calculate the percentage of completed tasks.

6. **Task Count per Assignee (Window Function)**  
   `COUNT() OVER (PARTITION BY assigned_to)` shows total tasks per team member.

7. **Pending Tasks for Team Leads in Next 15 Days**  
   Joins `Tasks` and `Teams`, filters on `role`, `status`, and `due_date`.

8. **Projects with No Tasks Assigned**  
   `LEFT JOIN` + `IS NULL` to detect orphan projects.

9. **Best Performing AI Model per Project**  
   Uses `RANK()` inside a derived table to fetch the model with highest accuracy.

10. **Projects with Large Datasets Updated Recently**  
    Filters datasets >10GB and updated in the last 30 days using `CURRENT_DATE`.

---

## How to Use

1. Open your SQL client (e.g., pgAdmin, MySQL Workbench, SQLite).
2. Run the script `Part1.sql` in the following order:
   - Create and populate: `Projects`, `Tasks`, `Teams`
   - Run queries the 8 queries
   - Create and populate: `Model_Training`, `Data_Sets` or use the `Part2.sql` file
   - Run queries in that file

---

## 📁 Folder Structure

