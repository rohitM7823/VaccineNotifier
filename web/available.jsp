<%@page language="java" import = "rohit.servlet.Implementation" %>

<html>
    <head>
        <title>VaccineNotifier</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Inconsolata:wght@700&display=swap');
        </style>
    </head>
    <body>
        <%! Implementation imp;%>
        <div>
            <h1 align='center' style='margin-top:30vh;'>
                Congratulation! Vaccine Available at Pincode - <%= imp.fields.get(0).getPincode()%>
            </h1>
            <h2 align='center'>- Get Brief Details of Nearest Center -<br><br>
                <a href='table.jsp' target='_blank' style="text-decoration: brown;">>> Get Details <<</a></h2>
        </div>
    </body>
</html>
