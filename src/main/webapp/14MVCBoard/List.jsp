<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>List.jsp</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
          rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    
    <style>
        * {
            text-decoration: none;
        }
        .pagination {
            display: block;
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
            text-align: center;
        }
        .pagination a:hover:not(.on) {background-color: #ffff00;}
        .pagination > li {
            display: inline;
        }
        .pagination > li > a,
        .pagination > li > span {
            position: relative;
            float: none;
            padding: 6px 12px;
            margin-left: -1px;
            line-height: 1.42857143;
            color: #0583f5;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }
        .pagination > li:first-child > a,
        .pagination > li:first-child > span {
            margin-left: 0;
            border-top-left-radius: 4px;
            border-bottom-left-radius: 4px;
        }
        .pagination > li:last-child > a,
        .pagination > li:last-child > span {
            border-top-right-radius: 4px;
            border-bottom-right-radius: 4px;
        }
        .pagination > .active > a,
        .pagination > .active > span,
        .pagination > .active > a:hover,
        .pagination > .active > span:hover,
        .pagination > .active > a:focus,
        .pagination > .active > span:focus {
            z-index: 2;
            color: #fff;
            cursor: default;
            background-color: #337ab7;
            border-color: #337ab7;
        }
        .writing {
            text-align: center;
        }
    </style>
</head>
<body>
    <h2>관리자 - 회원 관리 List</h2>
<%--    검색 폼--%>
    <form method="get" id="actionForm" action="${pageContext.request.contextPath}/mvcboard/list.do">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}" />
        <table border="0" width="90%">
            <tr>
                <td align="center">
                    <select name="searchField">
                        <option value="title" ${(not empty map.searchField) and map.searchField == "title" ? "selected" : ""}>닉네임</option>
                        <option value="content" ${(not empty map.searchField) and map.searchField == "content" ? "selected" : ""}>소개</option>
                    </select>
                    <input type="text" name="searchWord" value="${not empty map.searchWord ? map.searchWord : ''}">
                    <input type="button" value="찾기" onclick="handleSubmit()">
                </td>
            </tr>
        </table>
    </form>

<%--목록 테이블--%>
    <table border="5" width="90%">
        <tr bgcolor="black">
            <th width="6%" style="color:white">가입순번</th>
            <th width="10%" style="color:white">닉네임</th>
            <th width="10%" style="color:white">이름</th>
            <th width="6%" style="color:white">관심도</th>
            <th width="12%" style="color:white">가입일</th>
            <th width=10%" style="color:white">공부 인증파일</th>
        </tr>
        <c:choose>
            <c:when test="${empty boardLists}">
                <tr>
                    <td colspan="6" align="center">등록된 회원이 없습니다</td>
                </tr>
            </c:when>
            <c:otherwise>
                <h5>[전체 가입자 수 : ${requestScope.pageMaker.totalCount}명]</h5>
                <c:set var="no" value="${pageMaker.totalCount - ((pageMaker.cri.pageNum - 1) * 10)}" />
                <c:forEach items="${boardLists}" var="row" varStatus="loop">
                    <tr align="center">
                        <td>
                            ${no}
                        </td>
                        <td align="left">
                            <a href="../mvcboard/view.do?idx=${row.idx}">${row.title}</a>
                        </td>
                        <td>${row.name}</td>
                        <td>${row.visitcount}</td>
                        <td>${row.postdate}</td>
                        <td>
<%--                            첨부 파일--%>
                            <c:if test="${not empty row.ofile}">
                                <a href="../mvcboard/download.do?ofile=${row.ofile}&sfile=${row.sfile}&idx=${row.idx}">
                                    [다운로드]</a>
                            </c:if>
                        </td>
                    </tr>
                    <c:set var="no" value="${no - 1}" />
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </table>

    <c:if test="${requestScope.pageMaker.totalCount > 0 and not empty boardLists}">
        <br><br>
        <div class="container" >
            <nav aria-label="Page navigation example">
                <ul class="pagination" >
                    <c:if test="${pageMaker.prev}">
                        <li class="page-item"><a class="page-link" href="${pageMaker.startPage - 1}">이전</a></li>
                    </c:if>
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <c:choose>
                            <c:when test="${pageMaker.cri.pageNum == num}">
                                <li class="page-item active" aria-current="page">
                                    <span class="page-link">${num}</span>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="${num}">${num}</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pageMaker.next}">
                        <li class="page-item"><a class="page-link" href="${pageMaker.endPage + 1}">다음</a></li>
                    </c:if>
                </ul>
            </nav>
        </div>
    </c:if>

    <div class="writing">
        <a href="${pageContext.request.contextPath}/mvcboard/write.do" style="text-decoration:none" text-align:right;>[신규 회원등록]</a>
    </div>

<%--${empty map.notExists ? "이거출력" : "이거아님"}--%>

<script>
    let actionForm = $("#actionForm");

    $("a.page-link").on("click", function(e) {
        e.preventDefault();
        console.log('click');
        actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        actionForm.submit();
    });
    const handleSubmit = (e) => {
        console.log("click!")
        actionForm.find("input[name='pageNum']").val(1);
        actionForm.submit();
    }
    $('input[name="searchWord"]').keydown(function(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            actionForm.find("input[name='pageNum']").val(1);
            actionForm.submit();
        }
    });
</script>
</body>
</html>