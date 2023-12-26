<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원관리 - 수정</title>
    <script>
        function validateForm(form) {
            if (form.name.value == "") {
                alert("닉네임을 입력하세요.");
                form.name.focus();
                return false;
            }
            if (form.title.value == "") {
                alert("이름을 입력하세요.");
                form.title.focus();
                return false;
            }
            if (form.content.value == "") {
                alert("특이사항을 입력하세요.");
                form.content.focus();
                return false;
            }
        }
    </script>
</head>
<h2>회원 관리 - 수정하기(Edit)</h2>
<form name="writeFrm" method="post" enctype="multipart/form-data" action="../mvcboard/edit.do" onsubmit="return validateForm(this);">
    <input type="hidden" name="idx" value="${dto.idx}"/>
    <input type="hidden" name="prevOfile" value="${dto.ofile}" />
    <input type="hidden" name="prevSfile" value="${dto.sfile}" />

    <table border="1" width="90%">
        <tr>
            <td>가입자</td>
            <td>
                <input type="text" name="name" style="width:150px;" value="${dto.name}" />
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width:90%;" value="${dto.title}" />
            </td>
        </tr>
        <tr>
            <td>소개</td>
            <td>
                <textarea name="content" style="width:90%;height:100px;">${dto.content}</textarea>
            </td>
        </tr>
        <tr>
            <td>공부인증 파일</td>
            <td>
                <input type="file" name="ofile" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">[등록]</button>
                <button type="reset">[재작성]</button>
                <button type="button" onclick="location.href='../mvcboard/list.do';">
                    [목록]
                </button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
