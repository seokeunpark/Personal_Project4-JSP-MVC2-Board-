<%@ page import="com.example.jspmvc2.mybatis.factory.MyBatisSessionFactory" %>
<%@ page import="org.apache.ibatis.session.SqlSession" %>
<%@ page import="com.example.jspmvc2.mybatis.mapper.MVCBoardMapper" %>
<%@ page import="com.example.jspmvc2.dto.MVCBoardDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    SqlSession sqlSession = MyBatisSessionFactory.getSqlSession();
    MVCBoardMapper mapper = sqlSession.getMapper(MVCBoardMapper.class);
    for (int i = 1; i <= 150; i++) {
        MVCBoardDTO dto = new MVCBoardDTO();
        dto.setName("name-" + i);
        dto.setTitle("title-" + i);
        dto.setContent("content-" + i);
        dto.setPass("1234");
        mapper.insertWrite(dto);
    }
    sqlSession.commit();
%>
</body>
</html>
