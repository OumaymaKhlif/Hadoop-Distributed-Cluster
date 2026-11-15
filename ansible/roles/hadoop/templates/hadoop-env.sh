# configure l’environnement spécifique de Hadoop lorsqu’il démarre ses services ou exécute ses commandes.

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# Ajoute le fichier JAR nécessaire à certaines applications MapReduce au classpath de Hadoop
export HADOOP_CLASSPATH=$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduceclient-app-*.jar:$HADOOP_CLASSPATH