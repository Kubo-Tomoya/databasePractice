-- 問1
-- 国名を全て抽出してください。
    SELECT name FROM countries;

-- 問2
-- ヨーロッパに属する国をすべて抽出してください。

    SELECT name FROM countries WHERE continent='Europe';

-- 問3
-- ヨーロッパ以外に属する国をすべて抽出してください。

    SELECT name FROM countries WHERE continent !='Europe';

-- 問4
-- 人口が10万人以上の国をすべて抽出してください。

    SELECT name FROM countries WHERE population >=100000;

-- 問5
-- 平均寿命が56歳から76歳の国をすべて抽出してください。

    SELECT name FROM countries WHERE life_expectancy BETWEEN 56 AND 76;


-- 問6
-- 国コードがNLB,ALB,DZAのもの市区町村をすべて抽出してください。

    SELECT district FROM cities  WHERE country_code IN ('NLB','ALB','DZA');

-- 問7
-- 独立独立記念日がない国をすべて抽出してください。

    SELECT name FROM countries WHERE indep_year IS NULL;

-- 問8
-- 独立独立記念日がある国をすべて抽出してください。

    SELECT name FROM countries WHERE indep_year IS NOT NULL;

-- 問9
-- 名前の末尾が「ia」で終わる国を抽出してください。

    SELECT name FROM countries WHERE TRIM(name) LIKE '%ia';

-- 問10
-- 名前の中に「st」が含まれる国を抽出してください。

    SELECT name FROM countries WHERE name ILIKE '%st%';

-- 問11
-- 名前が「an」で始まる国を抽出してください。

    SELECT name FROM countries WHERE name ILIKE 'an%';

-- 問12
-- 全国の中から独立記念日が1990年より前または人口が10万人より多い国を全て抽出してください。

    SELECT name  FROM countries WHERE (indep_year < 1990 OR population > 100000)AND indep_year IS NOT NULL;

-- 問13
-- コードがDZAもしくはALBかつ独立記念日が1990年より前の国を全て抽出してください。

    SELECT name FROM countries WHERE code IN ('DZA', 'ALB') AND indep_year < 1990;

-- 問14
-- 全ての地方をグループ化せずに表示してください。

     SELECT region FROM countries;

-- 問15
-- 国名と人口を以下のように表示させてください。シングルクォートに注意してください。
-- 「Arubaの人口は103000人です」

    SELECT CONCAT(name, 'の人口は', population, '人です') AS population FROM countrie
s;

-- 問16
-- 平均寿命が短い順に国名を表示させてください。ただしNULLは表示させないでください。

    SELECT name FROM countries WHERE life_expectancy IS NOT NULL ORDER BY life_expectancy ASC;

-- 問17
-- 平均寿命が長い順に国名を表示させてください。ただしNULLは表示させないでください。

     SELECT name FROM countries WHERE life_expectancy IS NOT NULL ORDER BY life_expectancy DESC;


-- 問18
-- 平均寿命が長い順、独立記念日が新しい順に国を表示させてください。

    SELECT name FROM countries WHERE life_expectancy IS NOT NULL AND indep_year IS NOT
 NULL ORDER BY life_expectancy DESC, indep_year DESC;

-- 問19
-- 全ての国の国コードの一文字目と国名を表示させてください。

    SELECT LEFT(code, 1) AS SUBSTRING, name FROM countries;

-- 問20
-- 国名が長いものから順に国名と国名の長さを出力してください。

    SELECT name, LENGTH(name) AS LENGTH FROM countries ORDER BY LENGTH DESC;

-- 問21
-- 全ての地方の平均寿命、平均人口を表示してください。(NULLも表示)

   SELECT region,
       CASE 
           WHEN COUNT(life_expectancy) = 0 THEN NULL
           ELSE AVG(life_expectancy) 
       END AS avg_life_expectancy,
       CASE 
           WHEN COUNT(population) = 0 THEN NULL
           ELSE AVG(population) 
       END AS avg_population
    FROM countries
    GROUP BY region;
    ORDER BY region ASC;



-- 問22
-- 全ての地方の最長寿命、最大人口を表示してください。(NULLも表示)

     SELECT region,
        CASE  
            WHEN COUNT(life_expectancy) = 0 THEN NULL 
            ELSE MAX(life_expectancy) 
        END AS max_life_expectancy, 

        CASE  
            WHEN COUNT(population) = 0 THEN NULL  
            ELSE MAX(population)  
        END AS max_population 
            
    FROM countries
    GROUP BY region 
    ORDER BY region ASC;

-- 問23
-- アジア大陸の中で最小の表面積を表示してください

    SELECT name, surface_area
    FROM countries
    WHERE continent = 'Asia'
    ORDER BY surface_area ASC
    LIMIT 1;


-- 問24
-- アジア大陸の表面積の合計を表示してください。

    SELECT SUM(surface_area) AS total_surface_area
    FROM countries
    WHERE continent = 'Asia';

-- 問25
-- 全ての国と言語を表示してください。一つの国に複数言語があると思いますので同じ国名を言語数だけ出力してください。

    SELECT c.name AS country_name, cl.language
    FROM countrylanguages cl
    JOIN countries c ON cl.country_code = c.code
    ORDER BY country_name;

-- 問26
-- 全ての国と言語と市区町村を表示してください。

    SELECT 
        c.name AS country_name, 
        ct.name AS city_name,
        cl.language
    FROM countries c 
    LEFT JOIN countrylanguages cl ON c.code = cl.country_code
    LEFT JOIN cities ct ON c.code = ct.country_code 
    ORDER BY country_name, language, city_name;

-- 問27
-- 全ての有名人を出力してください。左側外部結合を使用して国名なし（country_codeがNULL）も表示してください。

    SELECT
    c.name AS celebrity_name,
    co.name AS country_name
    FROM celebrities c
    LEFT JOIN countries co ON c.country_code = co.code
    ORDER BY c.id;

-- 問28
-- 全ての有名人の名前,国名、第一言語を出力してください。

    SELECT 
    c.name AS celebrity_name, 
    co.name AS country_name,
    cl.language AS first_language
    FROM celebrities c
    LEFT JOIN countries co ON c.country_code = co.code 
    LEFT JOIN countrylanguages cl ON co.code = cl.country_code
    WHERE cl.is_official = 'T'   
    ORDER BY c.name;

-- 問29
-- 全ての有名人の名前と国名をに出力してください。 ただしテーブル結合せずサブクエリを使用してください。

    SELECT 
    c.name AS celebrity_name,
    (SELECT co.name 
     FROM countries co  
     WHERE co.code = c.country_code) AS country_name
    FROM celebrities c
    ORDER BY c.id; 

-- 問30
-- 最年長が50歳以上かつ最年少が30歳以下の国を表示させてください。

    SELECT 
    c.country_code, 
    co.name AS country_name
    FROM celebrities c
    JOIN countries co ON c.country_code = co.code 
    GROUP BY c.country_code, co.name
    HAVING 
    MAX(c.age) >= 50  
    AND MIN(c.age) <= 30;   

-- 問31
-- 1991年生まれと、1981年生まれの有名人が何人いるか調べてください。ただし、日付関数は使用せず、UNION句を使用してください。

    SELECT '1991年' AS birth_year, COUNT(*) AS count 
    FROM celebrities
    WHERE EXTRACT(YEAR FROM birth) = 1991

    UNION ALL

    SELECT '1981年' AS birth_year, COUNT(*) AS count 
    FROM celebrities
    WHERE EXTRACT(YEAR FROM birth) = 1981;

-- 問32
-- 有名人の出身国の平均年齢を高い方から順に表示してください。ただし、FROM句はcountriesテーブルとしてください。

    SELECT 
    co.name AS country_name,
    AVG(c.age) AS average_age
    FROM countries co
    INNER JOIN celebrities c ON co.code = c.country_code
    GROUP BY co.name
    ORDER BY average_age DESC;
