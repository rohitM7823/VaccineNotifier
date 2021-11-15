
<%@page language="java" import="rohit.servlet.Implementation" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Vaccination Centers</title>
        <link rel="stylesheet" href="newstyle.css"/>
    </head>
    <body>
        <h1 align="center"> Hurry Up and Enroll or Schedule an Appointment for Yourself and Your Family. </h1>
        <h2 align="center"> Click on This Link - <a href="https://selfregistration.cowin.gov.in/" target="_blank" style="text-decoration: brown;">selfregistration.cowin.gov.in</a></h2>

        <table style="align-items: center;">
            <thead>
                <tr>
                    <th id="header"><center>CENTER DETAILS</center></th>
        <th style="display: inline-flex; margin-top: 18px; width:100%">
            <div style="width: 40%;">Check Other Centers</div>
            <%! Implementation impl;
                int idx;%>

            <form name="btns" method="POST" action="">  
                <input type="submit" name="prev" value="Previous">        
                <input type="submit" name="next" value="Next">
            </form>

            <%
                String prev = request.getParameter("prev");
                String next = request.getParameter("next");

                if (next == null) {
                    idx = 0;
                } else if (next.contains("Next")) {
                    if (idx < (impl.fields.size() - 1)) {
                        idx++;
                    }
                } else if (prev.contains("Previous")) {
                    idx--;
                }


            %>

            <div style="padding-left: 60px"><%= idx + 1%></div>
        </th>
    </tr>
    <thead>

    <tbody>
        <tr>
            <td><center>CENTER ID</center></td>
<td><% try {
        out.print(impl.fields.get(idx).getCenter_id());

    } catch (NullPointerException e) {

    }
    %> </td>

</tr>
<tr>
    <td><center>STATE</center></td>
<td><%
    try {
        out.print(impl.fields.get(idx).getState_name());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>DISTRICT</center> </td>
<td><%
    try {
        out.print(impl.fields.get(idx).getDistrict_name());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>BLOCK</center> </td>
<td><%
    try {
        out.print(impl.fields.get(idx).getBlock_name());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>ADDRESS</center> </td>
<td><%
    try {
        out.print(impl.fields.get(idx).getAddress());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>AVAILABILITY</center></td>
<td>
    <ul>
        <li>1st Dose - <%
            try {
                out.print(impl.fields.get(idx).getAvailable_capacity_dose1());
            } catch (NullPointerException e) {

            }
            %> 
        </li>
        <li>2nd Dose - <%
            try {
                out.print(impl.fields.get(idx).getAvailable_capacity_dose2());
            } catch (NullPointerException e) {

            }
            %> </li>
    </ul>
</td>

</tr>
<tr>
    <td><center>DATE</center></td>
<td><%
    try {
        out.print(impl.fields.get(idx).getDate());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>VACCINE</center></td>
<td><%
    try {
        out.print(impl.fields.get(idx).getVaccine());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>PRICE</center></td>
<td><%
    try {
        out.print(impl.fields.get(idx).getFee());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>MINIMUM AGE</center></td>
<td><%
    try {
        out.print(impl.fields.get(idx).getMin_age_limit());
    } catch (NullPointerException e) {

    }
    %></td>

</tr>
<tr>
    <td><center>SLOTS</center></td>
<td>
    <ul>
        <li>1st Slot - <%
            try {
                out.print(impl.fields.get(idx).getSlots()[0]);
            } catch (NullPointerException e) {
            }
            %> </li>
        <li>2nd Slot - <%
            try {
                out.print(impl.fields.get(idx).getSlots()[1]);
            } catch (NullPointerException e) {
            }
            %> </li>
    </ul>
</td>
</tr>
</tbody>
<table/>

</body>
</html>
