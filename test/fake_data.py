import pandas as pd
from scipy.stats import norm

year_min = 1939
year_max = 2017

years = year_max - year_min + 1
df = pd.DataFrame({'year': range(year_min, year_max+1)})
df['high'] = norm(40,10).rvs(size=years)
df['low'] = df.high - norm(20,10).rvs(size=years)

df.to_csv('test.csv', index=False, float_format='%.1f')
