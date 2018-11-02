
#####################################################
# Bash for PS6
#####################################################

# Running interactive session
srun -A ic_stat243 -p savio2 --nodes=4 -t 3:00:00 --pty bash
module load java spark/2.1.0 python/3.5
source /global/home/groups/allhands/bin/spark_helper.sh
spark-start


spark-submit --master $SPARK_URL  $SPARK_DIR/examples/src/main/python/pi.py

# PySpark using Python 3.5 (Spark 2.1.0 doesn't support Python 3.6)
pyspark --master $SPARK_URL --executor-memory 60G \
        --conf "spark.executorEnv.PATH=${PATH}" \
        --conf "spark.executorEnv.LD_LIBRARY_PATH=${LD_LIBRARY_PATH}" \
        --conf "spark.executorEnv.PYTHONPATH=${PYTHONPATH}" \
        --conf "spark.executorEnv.PYTHONHASHSEED=321"
