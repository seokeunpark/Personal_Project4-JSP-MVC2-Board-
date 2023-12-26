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
            <tr class="tr_td">
                <th style="background-color: #fafafa; text-align: center">Chk</th>
                <th style="background-color: #fafafa; text-align: center">id</th>
                <th style="background-color: #fafafa; text-align: center">메뉴명</th>
                <th style="background-color: #fafafa; text-align: center">종류</th>
                <th style="background-color: #fafafa; text-align: center">가격</th>
                <th style="background-color: #fafafa; text-align: center">등록일</th>
            </tr>
        </thead>
        <tbody id="t_body">
        </tbody>
    </table>
</div>
</body>
<script>
    function loadDocArray() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                //document.getElementById("t_body").innerHTML = this.responseText;
                const myAjax = JSON.parse(this.responseText);
                console.log(myAjax);

                let ajaxTD = "";
                for (let i in myAjax.coffee_list) {
                    ajaxTD += "<tr id='tr_loop' className='tr_td'>";
                    ajaxTD += "<td><input type='checkbox' name='coffie_id' value='ID'></td>";
                    ajaxTD += "<td>" + myAjax.coffee_list[i].coffee_id + "</td>";
                    ajaxTD += "<td>" + myAjax.coffee_list[i].name + "</td>";
                    ajaxTD += "<td>" + myAjax.coffee_list[i].kind + "</td>";
                    ajaxTD += "<td>" + myAjax.coffee_list[i].price + "</td>";
                    ajaxTD += "<td>" + myAjax.coffee_list[i].reg_date + "</td>";
                    ajaxTD += "</tr>";
                }
                document.getElementById("t_body").innerHTML = ajaxTD;
            }
        };
        xhttp.open("GET", "/txt/ajax_info.txt", true);
        xhttp.send();
    }
    loadDocArray();
</script>
</html>
