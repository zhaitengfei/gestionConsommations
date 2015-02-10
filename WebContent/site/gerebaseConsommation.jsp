<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql2"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!--  connexion à la base de données consommation  -->
<sql2:setDataSource var="conn1" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/consommation?user=root" />

<c:if test="${not empty param.enregistrer}">
	<c:forEach var="i" begin="0" end="11">
		<c:set var="mois" value="${i+1}" />
		<c:set var="compteur" value="${param.annee}" />
		<% 
		 int i  = ((Integer)pageContext.getAttribute("i")).intValue();
		 int compteur =  (request.getParameter(String.valueOf(i))!=null)? Integer.parseInt(request.getParameter(String.valueOf(i))):0;
		 pageContext.setAttribute("compteur", compteur);
		 %>
		<c:out value="${compteur}" />
		<c:if test="${compteur >= 0}">
			<sql2:query var="result" dataSource="${conn1}">
		    select id from tableau where annee = ? and mois =? and lieu=? and consommable=?
			<sql2:param value="${param.annee}" />
			<sql2:param value="${mois}" />
			<sql2:param value="${param.lieu}" />
			<sql2:param value="${param.consommable}" />
			</sql2:query>
			<c:set var="row" value="${result.rows}" />
			<c:set var="id" value="${row[0].id}" />
			<c:if test="${id == null}">
				<sql2:update var="result1" dataSource="${conn1}">
	       insert into tableau (lieu, consommable, annee, mois, compteur) 
              values ( "${param.lieu}", "${param.consommable}", "${param.annee}", "${mois}", "${compteur}" )
	   </sql2:update>
			</c:if>
			<c:if test="${id != null}">
				<sql2:update var="result1" dataSource="${conn1}">
	      update tableau set compteur=?  	where id="${id}"
	          <sql2:param value="${compteur}" />
				</sql2:update>
			</c:if>
		</c:if>
	</c:forEach>
</c:if>
<jsp:forward page="conso.jsp" />

