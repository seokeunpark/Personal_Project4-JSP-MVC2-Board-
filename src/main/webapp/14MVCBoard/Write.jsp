<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Write.jsp</title>
    <script>
        function validateForm(form) {  // 필수 항목 입력 확인
            if (form.name.value == "") {
                alert("이름을 입력하세요.");
                form.name.focus();
                return false;
            }
            if (form.title.value == "") {
                alert("닉네임을 입력하세요.");
                form.title.focus();
                return false;
            }
            if (form.content.value == "") {
                alert("소개 입력하세요.");
                form.content.focus();
                return false;
            }
            if (form.pass.value == "") {
                alert("비밀번호를 입력하세요.");
                form.pass.focus();
                return false;
            }
        }
    </script>
</head>
<body>
    <form name="writeFrm" method="post" enctype="multipart/form-data"
          action="${pageContext.request.contextPath}/mvcboard/write.do" onsubmit="return validateForm(this);">
        <table border="1" width="90%">
            <tr>
                <td>이름</td>
                <td>
                    <input type="text" name="name" style="width: 150px;">
                </td>
            </tr>
            <tr>
                <td>닉네임</td>
                <td>
                    <input type="text" name="title" style="width: 90%;">
                </td>
            </tr>
            <tr>
                <td>소개(특이사항)</td>
                <td>
                    <textarea name="content" style="width: 90%; height: 100px;"></textarea>
                </td>
            </tr>
            <tr>
                <td>공부 인증파일</td>
                <td>
                    <input type="file" name="ofile">
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" name="pass" style="width: 100px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit">등록</button>
                    <button type="reset">재작성</button>
                    <button type="button" onclick="location.href='../mvcboard/list.do';">목록</button>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
