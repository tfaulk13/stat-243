#####################################################
# Python code for Spark for PS6
# Todd Faulkenberry
#####################################################

# Directory to wikipedia data
dir = '/global/scratch/paciorek/wikistats_full'

# Read data
lines = sc.textFile(dir + '/' + 'dated')



import re
from operator import add
import numpy as np
import pandas as pd

# Function to find data
def find(line, regex = "Second_Amendment_to_the_United_States_Constitution", language = None):
    vals = line.split(' ')
    if len(vals) < 6:
        return(False)
    tmp = re.search(regex, vals[3])
    if tmp is None or (language != None and vals[2] != language):
        return(False)
    else:
        return(True)

# Filter to sites on interest

second_amd = lines.filter(find)

# Functions to create DataFrame

def remove_partial_lines(line):
    vals = line.split(' ')
    if len(vals) < 6:
        return(False)
    else:
        return(True)

def create_df_row(line):
    p = line.split(' ')
    return(int(p[0]), int(p[1]), p[2], p[3], int(p[4]), int(p[5]))


tmp = second_amd.filter(remove_partial_lines).map(create_df_row)

## Creating dataframe

df = sqlContext.createDataFrame(tmp, schema = ["date", "hour", "lang", "site", "hits", "size"])

## Grouping and printing 100 rows, which I analyzed in R
df.groupBy('date').sum('hits').show(100)
