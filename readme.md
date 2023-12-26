# jsp mvc2 model with mybatis

jsp mvc2 model with mybatis


# MyBatis 설정

1. MyBatis를 사용하기 위해서는 총 다섯 개의 .jar 파일이 필요합니다.
* 각각의 .jar 파일 용도는 다음과 같습니다
    * slf4j-api-1.7.36.jar
        * MyBatis가 실행하는 쿼리문을 콘솔에 출력하기 위해 필요합니다
    * lobback-core-1.2.3.jar & logback-classic-1.2.3.jar
        * slf4j-api의 실제 구현체입니다
    * mariadb-java-client-3.2.0.jar
        * MariaDB와 JDBC를 사용해서 Connection을 맺기 위해 사용됩니다
        * MyBatis도 결국 JDBC를 사용해서 데이터베이스를 활용합니다.
    * mybatis-3.5.14.jar
        * MyBatis를 사용하기 위해서 필요합니다.

2. [여기를 클릭하여](https://github.com/jaehyukpyon2/jsp-mvc2/tree/main/src/main/webapp/WEB-INF/lib) jstl 라이브러리를 포함하여 총 여섯 개의 .jar 파일들을 다운로드 받고, webapp/WEB-INF/lib/ 안에 저장합니다.<br>
   ![6](https://github.com/jaehyukpyon2/jsp-mvc2/assets/145942491/b7439b3b-a357-4943-aeb5-9a37deba9c84)

<br />
3. 2번에서 추가한 라이브러리를 클래스패스에 추가합니다<br>
   file -> Project Structure -> Modules > Dependencies <br>

   ![7](https://github.com/jaehyukpyon2/jsp-mvc2/assets/145942491/de3b4f75-3e7b-4a76-a75c-b4abcce1ab93)

4. MyBatis의 기본 설정 방법은 xml 파일을 작성 후, Java 클래스에서 xml 파일을 읽어들이는 것입니다
   먼저, resources 폴더 안에 적당한 directory를 생성한 후 mybatis-config.xml 파일을 생성합니다. <br />
   [여기를 클릭하면](https://github.com/jaehyukpyon2/jsp-mvc2/blob/main/src/main/resources/com/example/jspmvc2/mybatis/config/mybatis-config.xml)  mybatis-config.xml 파일을 확인할 수 있습니다
   * property name="url" 의 value의 값으로 데이터베이스 명을 적어줍니다

<br />

5. 4번에서 작성한 mybatis-config.xml 파일을 실제로 읽어들일 Java 클래스 파일을 src/main/java 폴더 안에 패키지를 하나 만들고, MyBatisConfig.java 파일을 생성합니다

아래 사진에서 MyBatisConfig( ) 생성자를 보면, 지역변수

> String resource

에 경로가 지정되어 있습니다
이 경로는 4번에서 작성했던 mybatis-config.xml 의 경로입니다 <br />
root 경로는 src/main/resource로부터 시작하니, 그 이후부터 적어주면 됩니다
![3](https://github.com/jaehyukpyon2/jsp-mvc2/assets/145942491/3bf4dff4-759d-4847-b65e-6e633ec2e27a)


6. MyBatis를 사용하는 사람마다 다르지만,

> MyBatisSessionFactory 클래스

를 하나 생성해서, 이 클래스의 static method로부터 session (connection)을 하나 얻어오는 방식을 사용합니다 <br />
아래 사진을 보면 5번에서 작성했던 MyBatisConfig 클래스를 MyBatisSessionFactory의 static 초기화 블록에서 생성해주고, static 변수 sqlSessionFactory에 저장합니다 <br />
그 이후 MyBatisSessionFactory.getSqlSession( ) 과 같이 하나의 session (connection) 을 얻어서 사용할 수 있습니다
![8](https://github.com/jaehyukpyon2/jsp-mvc2/assets/145942491/6afe827c-f07e-4a83-a84b-452e30f1e16f)


7. 매퍼 xml 파일 작성 방법
* MyBatis에서는 실제 sql query를 매퍼 xml 파일로 분리시켜 사용합니다 <br />
  이 xml 파일들은 src/main/resource/your-custom-directory 경로에 작성합니다
* 한 개의 매퍼 xml 파일은, 한 개의 interface와 연동되어 사용됩니다
* 매퍼 xml 파일은 src/main/resource/your-custom-directory 에 작성하되, interface 파일은 src/main/java/your-custom-directory 에 작성합니다
* 또한 매퍼 xml 파일의 namespace명은 interface의 패키지명 + interface명과 동일해야 하며, <br /> 매퍼 xml의 query id는 interface의 메서드명과 동일해야 합니다
  ![5](https://github.com/jaehyukpyon2/jsp-mvc2/assets/145942491/b7282510-20bd-4d8e-8e94-4fe0e53a8f24)

8. return type
* &lt;insert&gt;&lt;/insert&gt; query의 실행 결과 : 해당 쿼리로 실제 저장된 행(record)의 개수
* &lt;select&gt;&lt;/select&gt; query의 실행 결과 : 보통 DTO 클래스를 지정해서 그 DTO 의 인스턴스 필드 값을 사용
* &lt;update&gt;&lt;/update&gt; query의 실행 결과 : 해당 쿼리로 실제 update 된 행의 개수
* &lt;delete&gt;&lt;/delete&gt; query의 실행 결과 : 해당 쿼리로 실제 delete 된 행의 개수

9. Java 클래스의 변수명과 데이터베이스 컬럼명의 불일치
    * Java에서는 메서드명, 변수명을 작성할 때 camel case를 사용하고,
    * 데이터베이스에서는 컬럼명을 작성할 때 snake case를 사용합니다.
    * 이에 이 두 개 사이에 불일치가 발생하는데, mybatis-config.xml 파일의 &lt;settings&gt; 태그 안의 &lt;setting&gt; 태그를 보면
      * &lt;setting name="mapUnderscoreToCamelCase" value="true" /&gt;
      * 이와같이 설정되어 있습니다
      * 따라서 Java에서는 camel case를, 데이터베이스에서는 snake case를 문제없이 각각 사용할 수 있습니다
