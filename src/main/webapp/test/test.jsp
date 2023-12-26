<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Document</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"/>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="form-group row pull-right">
        <div class="col-xs-8">
            <input class="form-control" size="20"/>
        </div>
        <div class="col-xs-2">
            <button class="btn btn-primary" type="button">검색</button>
        </div>
    </div>
    <table class="table" style="text-align: center; border: 1px solid #dddddd">
        <thead>
            <tr>
                <th style="background-color: #fafafa; text-align: center">이름</th>
                <th style="background-color: #fafafa; text-align: center">나이</th>
                <th style="background-color: #fafafa; text-align: center">성별</th>
                <th style="background-color: #fafafa; text-align: center">이메일</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>jaehyuk</td>
                <td>22</td>
                <td>man</td>
                <td>test@test.com</td>
            </tr>
        </tbody>
    </table>
</div>
</body>
</html>
