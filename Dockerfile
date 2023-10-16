




2442a9acdcdbd81b07fa2c269f5edfd23dd5a39c

curl -X GET -u admin:admin 'http://192.168.1.59:9000/api/qualitygates/project_status?projectKey=docker'



curl -H "Content-Type: application/json" -X POST -d @project_status.json http://192.168.1.59:9000/api/qualitygates/project_status?projectKey=docker





mvn deploy:deploy-file -Durl=http://192.168.1.59:8081/repository/maven-public/ -DrepositoryId=nexus -Dfile=dependency.jar -DartifactId=dependency -Dversion=1.0 -Dpackaging=jar





mvn deploy:deploy-file -Durl=http://192.168.1.59:8081/repository/maven-public/ -DrepositoryId=nexus -Dfile=/path/to/dependency.jar -DartifactId=dependency -Dpackaging=jar


mvn deploy:deploy-file -Durl=http://192.168.1.59:8081/repository/maven-public/  -DartifactId=backend -Dpackaging=war





mvn deploy:deploy-file -Dfile=target/dependency/ \
                      -DgroupId= \
                      -DartifactId=project-dependencies \
                      -Dversion=1.0 \
                      -Dpackaging=jar \
                      -DrepositoryId=nexus-releases \
                      -Durl=http://192.168.1.59:8081/repository/maven-releases/




                      mvn deploy:deploy-file -Dfile=/target/dependency/*.jar -DgroupId=nexus-dependency -DartifactId=dependency-library -Dversion=1.0.0 -Dpackaging=jar -Durl=http://192.168.1.59:8081/repository/maven-public/ -DrepositoryId=nexus-repo