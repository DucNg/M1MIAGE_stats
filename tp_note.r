# Duc Nguyen M1 MIAGE

# Exercice 1

intervalleConfianceEctype = function(ech,alpha) {
	n = length(ech) # Taille de l'échantillon
	o = sd(ech) # Ecart type échantillon

	q1 = qchisq((1+alpha)/2,n-1)
	q2 = qchisq((1-alpha)/2,n-1)

	ic1 = sqrt((n-1)/q1) * o
	ic2 = sqrt((n-1)/q2) * o

	c(ic1,ic2) # Extrémités de l'intervalle de confiance au niveau alpha
}

ech = rnorm(100) # Loi normale de moyenne 0 et d'écart type 1
> intervalleConfianceEctype(ech,0.95)
[1] 1.189136 2.561558

# 3
pop = rnorm(100000) # Population totale de 100000 pour pouvoir faire 1000 échantillon de taille 100 (1000*100 = 100000)
vraieEcartType = sd(pop) # Vraie valeur de l'écart type sur la population
cpt = 0 # Nombre d'intervalle contenant la vraie valeur
for (i in 1:1000) {
	ech = sample(pop,100) # 1000 échantillons de taille 100 depuis pop
	oEch = intervalleConfianceEctype(ech,0.95) # Estimation d'intervalle de l'écart-type sur l'échantillon

	if (vraieEcartType > oEch[1] && vraieEcartType < oEch[2]) cpt = cpt+1 # On compte le nombre d'intervalle contenant la vraie valeur de l'écart-type
}
> cpt/1000 # Proportion d'intervalle correct sur 1000 échantillons
[1] 0.937
# 93.7% des estimations sont corrects. Avec un niveau de confiance à 95%, ce résultat est cohérent, il est normal de se tromper dans environ 5% des cas.

# Exercice 2

distanceKhi2 = function(vObserve,vTheorique) {
	k = 0 # Somme totale
	for (i in 1:length(vObserve)) { # On considère que les effectifs sont de meme taille
		tmp = ((vObserve[i]-vTheorique[i])^2) / vTheorique[i] # Calcul à i
		k = k + tmp # Somme totale
	}
	k # Distance de Khi2 entre ces deux vecteurs
}

dée1 = sample(seq(1, 6),20,TRUE) # 20 lancés d'un dée à 6 faces
dée2 = sample(seq(1, 6),20,TRUE) # 20 lancés d'un dée à 6 faces
déePipe = sample(seq(5, 6),20,TRUE) # 20 lancés d'un dée pipé ne donnant que des 5 et des 6

> distanceKhi2(dée1,dée2)
[1] 115.6167
> distanceKhi2(dée1,dée1)
[1] 0
> distanceKhi2(dée1,dée2)
[1] 115.6167
> distanceKhi2(dée1,déePipe)
[1] 27.16667

testKhi2 = function(vObserve,vTheorique,alpha,r) {
	# r nombre de paramètres de la loi à estimer
	c = length(vObserve) # Nombre de colonnes
	s = qchisq(alpha,c-1-r) # Calcul du seuil de rejet
	k = distanceKhi2(vObserve,vTheorique) # Calcul de la distance de Khi2 entre les deux vecteurs
	if (k > s) "H1" else "H0" # Si k > s on rejette H0
}

> testKhi2(dée1,dée2,0.95,6) # Un dée a 6 paramètres
[1] "H1"
> testKhi2(dée1,dée1,0.95,6) # Un dée a 6 paramètres
[1] "H0"
> testKhi2(dée1,déePipe,0.95,6) # Un dée a 6 paramètres
[1] "H1"

# 3
# i=1,...,K,T[i]
nbi = function(ech) {
	T = c()
	k=max(ech) # L'échantillon va de 1 à k
	for (i in 1:k) { # Chaque valeur de i de 1 à k
		cpt = 0 # Nombre de fois où i apparrait
		for (value in ech) {
			if (i == value) cpt = cpt+1 # On parcours tout ech pour trouver i
		}
		T = c(T,cpt)
	}
	T
}

> nbi(dée1)
[1] 4 3 3 3 3 4

#4
déeUniforme = round(runif(3000,1,6)) # Dée suivant exactement une loi uniforme (3000 lancés)
pop = sample(seq(1, 6),3000,TRUE) # 3000 lancés d'un dée à 6 faces

cpt = 0 # Somme des tests infructueux
for (i in 1:200) {
	ech = sample(pop,15,TRUE) # On prend 15 éléments dans la pop pour faire 200 tests sur la population, 15*200 = 3000

	result = testKhi2(ech,déeUniforme,0.95,6) # 200 tests du Khi2 à 5%

	if(result != "H0") cpt = cpt+1 # On évalue le nombre de tests ne donnant pas la bonne décision
}
> cpt/200
[1] 0.965
# Sur 200 test 96.5% sont infructueux, les lancés ne sont pas très uniforme...

deeTruc = function(K,e) {
	unquatre = round(runif(4/6*K,min=1,max=6)) # Proba de 1/6 de 1 à 4
	six = rbinom(1/6*K,6,1/6+e) # Proba de 1/6+e pour 6
	cinq = rbinom(1/6*K,5,1/6-e) # Proba de 1/6-e pour 5
	c(unquatre,cinq,six) # Ici il manque une fonction pour mélanger le vecteur final.
}

> deeTruc(20,0.15)
 [1] 5 4 5 6 2 5 5 4 2 4 5 2 6 0 0 0 3 1 2
 # Il y a un soucis

#6
trenteE = seq(1/24, 1/6, length.out=30) # 30 e espacé régulièrement entre 1/24 et 1/6

for (i in 1:200) {

}