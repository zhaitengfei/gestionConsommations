<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql2"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!--  connexion à la base de données consommation  -->
<sql2:setDataSource var="conn1" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/consommation?user=root" />    

<c:if test="${not empty param.nouveauConsommable}">
	<c:set var="consommable" value="${param.nouveauConsommable}" />  
    <sql2:query var="result" dataSource="${conn1}">
		    select id from consommable where nom = ?
			<sql2:param value="${param.nouveauConsommable}" />
			</sql2:query>
			<c:set var="row" value="${result.rows}" />
			<c:set var="id" value="${row[0].id}" />
			<c:if test="${id == null}">
				<sql2:update var="result1" dataSource="${conn1}">
		       	insert into consommable(nom) values ( "${param.nouveauConsommable}" )
		   		</sql2:update>
			</c:if>
</c:if>
<jsp:forward page="conso.jsp" />