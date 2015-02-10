<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql2"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://jakarta.apache.org/taglibs/dbtags" prefix="sql"%>
 
  <% 
    String couleur = ";background:#c0ebe7";
    String leConsommable = (String)pageContext.getAttribute("consommable");
    String leLieu = (String)pageContext.getAttribute("lieu");
 %>
 
 <table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
	<tr>
	
		<%@ include file="accesmenuBarreSup.jsp"%>
		<td>
			<table class="Casebleu" style="border: 0px; margin: 0; padding: 0px;">
				<tr>
					<td><b> Gestion des consommations </b></td>
						<sql2:setDataSource var="conn1" driver="com.mysql.jdbc.Driver"
							url="jdbc:mysql://localhost:3306/consommation?user=root" />  
						<sql2:query var="result" dataSource="${conn1}">
						   	select nom from consommable
						</sql2:query>
						<c:forEach var="row" items="${result.rows}">
						<td>
						<c:set var="nom" value="${row.nom}" />
						<% String theNom = (String)pageContext.getAttribute("nom");%>
						<button name="choix"
							onClick="self.location.href='conso.jsp?consommable=${row.nom}&lieu=<%=leLieu%>'"
							type="button" style="width: 130px <%= (leConsommable.equals(theNom))?couleur:" " %>">
							${row.nom}</button>
						</td>						
						</c:forEach>
						<%	
							if (session.getAttribute("fonction").equals("administrateur")) {
						%>
							<td>
								<button name="gestionConsommations" type="submit" onClick="self.location.href='ajoutConsommable.jsp'"
								style="height: 20px; width: 200px">> gestion des consommations</button>
							</td>
						<%
							}
						%>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		 <td>
    <table class="Casebleu" style="border: 0px; margin:0 ; padding:0px;" >
      <tr> 
         <td  style="width:100px;" >
       <b><%=leConsommable%></b>
	      <td>
				<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Centre_Technique&consommable=<%=leConsommable%>'" type="button"  style="width:80px; height:40px <%= (leLieu.equals("Centre_Technique"))?couleur:" " %>"> Centre Technique </button>	
         </td> 	 <td>
        		<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Ecole&consommable=<%=leConsommable%>'" type="button"  style="width:60px; height:40px <%= (leLieu.equals("Ecole"))?couleur:" " %>"> Ecole </button>	
		</td> 	 <td>
        		<button  name="choix" onClick="self.location.href='conso.jsp?lieu=Mairie&consommable=<%=leConsommable%>'" type="button"  style="width:60px; height:40px <%= (leLieu.equals("Mairie"))?couleur:" " %>"> Mairie </button>	
  		</td> 	  
	  </tr> 
    </table>
    </td>
	</tr>
</table>


