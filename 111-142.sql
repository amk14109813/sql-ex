/*Задание: 111 (Serge I: 2003-12-24)
Найти НЕ белые и НЕ черные квадраты, которые окрашены разными цветами в пропорции 1:1:1. Вывод: имя квадрата, количество краски одного цвета*/

Select 
	utQ.Q_NAME,
	utB.B_VOL
From
	utQ
	Join utB On utQ.Q_ID=utB.B_Q_ID


-- ??????????????
/*Задание: 113 
WITH total_paint AS (SELECT utV.V_COLOR, SUM(utB.B_VOL) AS total_color
FROM utB
INNER JOIN utV
ON utB.B_V_ID=utV.V_ID
GROUP BY utV.V_COLOR),
black_squares AS (
SELECT COUNT(DISTINCT utQ.Q_ID)*255 AS black_number
FROM utQ 
LEFT JOIN utB ON utQ.Q_ID = utB.B_Q_ID
WHERE utB.B_Q_ID IS NULL),
total_squares AS (SELECT COUNT(DISTINCT utB.B_Q_ID)*255 AS color_number
FROM utB),
red AS (SELECT (ts.color_number+bs.black_number-tp.total_color) AS red 
FROM total_paint tp, total_squares ts, black_squares bs
WHERE tp.V_COLOR='R'),
blue AS (SELECT (ts.color_number++bs.black_number-tp.total_color) AS blue 
FROM total_paint tp, black_squares bs, total_squares ts 
WHERE tp.V_COLOR='B'),
green AS (SELECT (ts.color_number+bs.black_number-tp.total_color) AS green 
FROM total_paint tp, total_squares ts, black_squares bs 
WHERE tp.V_COLOR='G')
SELECT r.red, g.green, b.blue
FROM red r, green g, blue b


/*Задание: 114 (Serge I: 2003-04-08)
Определить имена разных пассажиров, которым чаще других доводилось лететь на одном и том же месте. Вывод: имя и количество полетов на одном и том же месте.*/

With t1 as 
(	Select 
		ID_psg,
		count(*) numb
	FROM
		Pass_In_Trip
	GROUP BY ID_psg, place),
t2 as 
(	Select DISTINCT
		ID_psg,
		numb
	From t1
	Where numb = (Select max(numb) from t1))
Select name, numb From t2 Join Passenger p On t2.ID_psg=p.ID_psg
