WITH CityRegionFreq AS (
    SELECT city, region, COUNT(*) AS region_count
    FROM sales_data
    WHERE region IS NOT NULL
    GROUP BY city, region
),
MostFrequentRegion AS (
    SELECT city, region
    FROM (
        SELECT city, region, ROW_NUMBER() OVER (PARTITION BY city ORDER BY region_count DESC) AS rn
        FROM CityRegionFreq
    ) AS RankedRegions
    WHERE rn = 1
)
UPDATE sales_data
SET region = (SELECT region FROM MostFrequentRegion WHERE MostFrequentRegion.city = sales_data.city)
WHERE region IS NULL;
