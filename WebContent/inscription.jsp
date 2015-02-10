<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>identification utilisateurs</title>
<link type="text/css" href="style/deco.css" rel="stylesheet">
</head>
<body>

	<h3>Service de Gestion des consommations</h3>
	<!-- 
***   Affichage d'un message d'erreur en cas de mauvaise identification (paramètre erreur présent)
--!>
<%
String erreur = request.getParameter("erreur");
if(erreur != null && erreur.equals("inconnu") ){
	out.println("Une mauvaise identification !");
}	
%>

<!-- 
****   Affichage d'un message indiquant la fin de session, identification obligatoire
****  parametre "finsession" present
-->
	<%
String finsession = request.getParameter("finsession");
if(finsession != null){	
 	out.println("Votre session a été fermé, veuillez vous indentifier une nouvelle fois!");
}	
%>
	<!--  Si on n'est pas dans le cas ou on a demandé une inscrption 
***
-->
	<%
String inscrire = request.getParameter("inscrire");
if(inscrire == null){
%>
	<h3>Veuillez vous identifier pour la connexion</h3>
	<form name="commande" method="get" action="verificationIdentite.jsp">
		<table width="400" class="Casebleu1">
			<tr>
				<th>votre nom :</th>
				<td><input name="leNom" type="text"></td>
			</tr>
			<tr>
				<th>votre prenom :</th>
				<td><input name="lePrenom" type="text"></td>
			</tr>
			<tr>
				<th>votre mot de passe :</th>
				<td><input type="password" name="leMotPasse"></td>
			</tr>
			<tr>
				<th colspan="2">
					<button name="connexion" type="submit" value="> se connecter">
						> se connecter</button>
				</th>
			</tr>
		</table>
	</form>
	<!-- 
****   Rajoutez un  bouton d'inscription,   ainsi on peut s'inscrire ou se connecter
****   ce bouton sera  absent si la personne  vient de s'inscrire  ( parametre " inscrit " present )
-->
	<%
String inscrit = request.getParameter("inscrit");
if(inscrit == null){
%>
	<form name="commande" method="get" action="inscription.jsp">
		<button name="demandeInscription" type="submit"
			value="> demande inscription">> demande inscription</button>
		<input type=hidden name=inscrire value="true">
	</form>
	<%
}
%>


	<%
}
%>

	<!--  Si on est dans le cas ou on a demandé une inscription 
***********
-->
	<%
if(inscrire != null){
%>
	<h3>Veuillez remplir la fiche d'inscription suivante</h3>
	<form name="commande" method="get" action="verificationIdentite.jsp">
		<table width="400" class="Casebleu1">
			<tr>
				<th>votre nom :</th>
				<td><input name="leNom" type="text"></td>
			</tr>
			<tr>
				<th>votre prenom :</th>
				<td><input name="lePrenom" type="text"></td>
			</tr>
			<tr>
				<th>votre mot de passe :</th>
				<td><input type="password" name="leMotPasse"></td>
			</tr>
			<tr>
				<th>mail :</th>
				<td><input type="text" name="email"></td>
			</tr>
			<tr>
				<th>votre numero téléphone :</th>
				<td><input type="text" name="telephone"></td>
			</tr>
			<tr>
				<th colspan="2">
					<button name="inscrire" type="submit" value="> inscrire">>
						inscrire</button> <input type=hidden name=inscrit value="true">
				</th>
			</tr>
		</table>
	</form>
	<%
}
%>

	<p>Attention, si vous restez inactifs pendant un certain temps ,
		vous devrez vous reconnecter</p>

	<!--  connexion à la base de données  -->

	<!-- recherche des clients dans la base  -->

	<h3>Ensemble des personnes inscrites :</h3>
	<table border="3" width="500" class="Casebleu1">
		<tr>
			<th>nom</th>
			<th>prénom</th>
			<th>mot de passe</th>
			<th>fonction</th>
		</tr>

		<!-- 
***   parcourt de la table emprunteur pour faire un tableau avec les caractéristiques des personnes
****    nom, prenom, mot de passe, fonction
***    ce parcourt doit se faire avec les balises sql
-->


	</table>
</body>
</html>
