# Experiment——Hotel System（详见：数据库小实验.docx）

### 表名：

hotel,酒店列表；

room_type,酒店房型列表，每个酒店有不同档次的房型；

room_info,可预订房型列表，各个酒店每种房型的价格和总量均可以不同，并且每天每种房型的价格有可能变化。

Order,订单列表。

### 完成以下查询：
- [x] 1.	查询酒店房型列表，返回酒店名，房型名。
- [x] 2.	查询酒店某天所有房型的平均价格并从低到高排序，返回酒店名，日期，平均价格。
- [x] 3.	指定时间范围和要预定房型的房间数量，查询满足条件（时间，剩余房间数量）的房型及其平均价格，并按房型平均价格从低到高进行排序。查询结果应包含酒店，房型及平均价格信息。
- [x] 4.  预订：根据时间和房间剩余数量去预订，包括更新房型状态和创建订单。
- [x] 5.  从订单表中统计酒店在指定日期的各房型的售出情况，返回酒店名，日期，房型名，预订数量。

### Additional Exercise

- [ ] *6. 在不指定房型的前提下，完成第3题的查询。同时要求显示的平均预订价格是最低的价格。
- [ ] **7. 编写程序完成上述SQL查询。编程语言不限。
- [ ] ***8. 在第7题基础上编写GUI，实现更好的用户交互体验。

### Example Code For Q1 to Q5

(Notes: Some query SQL are not unique)

#### Q1
```sql
SELECT
	hotel_name,
	room_name 
FROM
	hotel
	NATURAL JOIN room_type;
```
```
+--------------+--------------+
| hotel_name   | room_name    |
+--------------+--------------+
| 惠民旅馆     | 大床房       |
| 惠民旅馆     | 双人房       |
| 惠民旅馆     | 三人房       |
| 风景旅馆     | 海景房       |
| 风景旅馆     | 园景房       |
| 风景旅馆     | 山景房       |
| 商务旅馆     | 总统套房     |
| 商务旅馆     | 豪华套房     |
| 商务旅馆     | 33号房       |
+--------------+--------------+
```

#### Q2（date='2018-11-14'）
```sql
SELECT
	hotel_name,
	date,
	AVG( price ) AS avgprice 
FROM
	room_info
	NATURAL JOIN room_type
	NATURAL JOIN hotel 
	WHERE date='2018-11-14'
GROUP BY
	hotel_name,
	date 
ORDER BY
	avgprice;
```
```
+--------------+------------+------------+
| hotel_name   | date       | avgprice   |
+--------------+------------+------------+
| 商务旅馆     | 2018-11-14 | 250.000000 |
| 惠民旅馆     | 2018-11-14 | 333.333333 |
| 风景旅馆     | 2018-11-14 | 383.333333 |
+--------------+------------+------------+
```

#### Q3
```sql
SELECT
	hotel_name,
	room_name,
	avg( price ) AS avgprice 
FROM
	hotel
	NATURAL JOIN room_type
	NATURAL JOIN room_info 
WHERE
	date <= '2018-11-16' AND date >= '2018-11-15' 
GROUP BY
	room_id 
HAVING
	min( remain ) >= 4 
ORDER BY
	avgprice;
```
```
+--------------+-----------+------------+
| hotel_name   | room_name | avgprice   |
+--------------+-----------+------------+
| 商务旅馆     | 33号房    | 150.000000 |
| 惠民旅馆     | 双人房    | 350.000000 |
| 风景旅馆     | 海景房    | 375.000000 |
| 惠民旅馆     | 大床房    | 550.000000 |
+--------------+-----------+------------+
```

#### Q4
```sql
INSERT INTO `order`
VALUES
	( 5, 2, '2018-11-14', '2018-11-15', 3, 666, '2018-11-02' );
UPDATE room_info 
	SET remain = remain - 3 
WHERE
	date <= '2018-11-15' AND date >= '2018-11-14' 
	AND room_id = 2;
```

#### Q5
```sql
SELECT
	hotel_name,
	start_date,
	room_name,
	amount 
FROM
	`order`
	NATURAL JOIN room_type
	NATURAL JOIN hotel 
WHERE
	start_date = '2018-11-14';
```
```
+--------------+------------+--------------+--------+
| hotel_name   | start_date | room_name    | amount |
+--------------+------------+--------------+--------+
| 风景旅馆     | 2018-11-14 | 山景房       |      4 |
| 风景旅馆     | 2018-11-14 | 园景房       |      2 |
| 惠民旅馆     | 2018-11-14 | 大床房       |      5 |
| 商务旅馆     | 2018-11-14 | 豪华套房     |      2 |
| 风景旅馆     | 2018-11-14 | 海景房       |      2 |
+--------------+------------+--------------+--------+
```
