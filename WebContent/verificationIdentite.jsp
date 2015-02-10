<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="utile.GereUtilisateur"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:useBean id="gerelesUtilisateur" class="utile.GereUtilisateur"
	scope="page" />

<!-- 
---   les  3 propriétés du bean leNom, lePrenom, leMotPasse doivent être initialisées par la page
-->

<jsp:setProperty name="gerelesUtilisateur" property="*" />

<%!
	ResultSet rset = null;
	String baseUtilise = "jdbc:mysql://localhost:3306/consommation";
	// redéfinition de la méthodes init
	
	public void jspInit() {
		utile.GereUtilisateur.setBaseUtilise(baseUtilise);
	}
  %>
<%
	gerelesUtilisateur.setConnectionPret();
 %>
<!-- 
***   si le paramètre "connexion" est présent, verification et recherche  des caractéristiques de la personne
***      si elle est connue 
***        "id, nom, prenom, fonction"  sont mis dans les attributs de la session
           une variable JSTL "conn1" identifie la base de données "sql:setDataSource" avec comme portée session
***        appel de la page : site/conso.jsp
***      sinon  rappel de inscription.jsp avec un parametre "erreur"
***
-->
<%
	String connexion = request.getParameter("connexion");
	if(connexion != null ){
		rset = gerelesUtilisateur.recherchePersonne();
		if(rset.next()){
			session.setAttribute("id", rset.getInt("id"));
			session.setAttribute("leNom", rset.getString("nom"));
			session.setAttribute("lePrenom", rset.getString("prenom"));
			session.setAttribute("fonction", rset.getString("fonction"));
%>
<!-- creation de la variable session pour la connexion à la base avec requête JSTL -->
<sql:setDataSource var="conn1" driver="com.mysql.jdbc.Driver"
	url="jdbc:mysql://localhost:3306/consommation?user=root"
	scope="session" />
<%
			response.sendRedirect("site/conso.jsp");
		} else {
			response.sendRedirect("inscription.jsp?erreur=inconnu");
		}
	}
 %>


<!-- -------------------------------------------------  -->
<!-- 
***   sinon si parametre inscrire present
***      inscrire  l'Utilisateur dans la base
***      et rappel de inscription.jsp pour l'identification paramètre "inscrit = vrai"
-->
<%
	String inscrire = request.getParameter("inscrire");
	if(inscrire != null ){
		gerelesUtilisateur.inscrireUtilisateur();
		response.sendRedirect("inscription.jsp?inscrit=vrai");
	}
 %>