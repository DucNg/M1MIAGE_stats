# TP1 statistiques

> Que donne la fonction sum appliquée à un vecteur de booléens ?

Le nombre de valeurs vraies.

> On remarquera que le return n’est pas obligatoire. En son absence, quelle est la valeur retournée ?

La valeur spécifié sans return ou la valeur du calcul.

> Comment écrire plus simplement une fonction ayant les mêmes effets
que mafunc ?

```r
mafunc=function(x) {x+2}
```

> Ecrire une boucle affichant les entiers entre 1 et 20 (on pourra utiliser la fonction print).

```r
for(i in 1:20) { print(i) }
```

> Sans utiliser by, comment construire un vecteur contenant 100 éléments
régulièrement espacés entre -2 et 2 ?

```r
t=c()
j=-2
for(i in 0:99) { j=j+0.04; t[i] = j }
```

ou

```r
seq(-2,2,length.out=100)
```

> Tracer la représentation graphique de la fonction cube sur [−2, 2] en
vert.

```r
cube=function(x) {x^3}
plot(cube,-2,2,col="green")
```

> Utiliser la fonction lines pour superposer, sur le même graphique, la
représentation graphique de la fonction carré sur le même intervalle,
en rouge.

```r
a = seq(-2,2,length.out=100)
lines(a,a^2,col="red")
```
> On peut utiliser la fonction pdf (ou png) pour enregistrer un graphique
dans un fichier PDF (ou PNG). Pour cela, on appelle d’abord la fonc-
tion pdf ou png avec en argument le nom du fichier dans lequel sauveg-
arder le graphique (extension incluse). On effectue ensuite les appels à
plot et éventuellement lines (qui ne doivent rien afficher à l’écran).
On termine par la commande dev.off(), qui effectue l’écriture du
graphique dans le fichier. Tester ceci.

```r
pdf("test_r.pdf")
plot(cube,-2,2,col="green")
lines(a,a^2,col="red")
dev.off()
```

## Exercice 6

1.

```r
a = runif(1000,2,10)
```
2.

```r
hist(a)
mean(a)
```

3.

```r
b = rnorm(10,3,2)
hist(b)
c = rnorm(100,3,2)
hist(c)

> mean(b)
[1] 2.181145
> mean(c)
[1] 3.065012
> sd(b)
[1] 2.225592
> sd(c)
[1] 2.057282
```
Cela illustre la loi des grands nombres.

4.

```r
unifEntier=function(n,k) { runif(n,1,k) }
unifEntier=function(n,k) { round(runif(n,1,k)) }
```

5.

À l'aide du tableau :

* 0.59095
* 1-0.65542 = 0.34458
* 0.52
* 0.84

Avec R :

```r
> pnorm(0.23)
[1] 0.5909541
> pnorm(-0.4)
[1] 0.3445783
> qnorm(0.7)
[1] 0.5244005
> qnorm(0.2)
[1] -0.8416212
```
6.

Avec boucle for

```r
probaInferieurA = function(V,x) { 
	j=0
	for(i in 1:length(V)) {
		if (V[i] < x) {
			j = j+1 
		}
		# print(j)
	}
	print(j)
	return(j/length(V))
}

d = unifEntier(5,99)
probaInferieurA(d,30)
```
Sans boucle

```r
probaInferieurA = function(V,x) {
	sum(V < x) / length(V)
}
```

7.

```r
p = runif(50,1,50)
probaInferieurA(p,25)
[1] 0.54
pnorm(25,mean(p),sd(p))
[1] 0.4920514

p = runif(999,1,50)
probaInferieurA(p,25)
[1] 0.4984985
pnorm(25,mean(p),sd(p))
[1] 0.499909

> p = runif(65535,1,50)
> probaInferieurA(p,25)
[1] 0.4899825
> pnorm(25,mean(p),sd(p))
[1] 0.485926

> probaInferieurA(p,5)
[1] 0.08215457
> pnorm(5,mean(p),sd(p))
[1] 0.07360221

> probaInferieurA(p,45)
[1] 0.897612
> pnorm(45,mean(p),sd(p))
[1] 0.9160381
```

# TP2

## Exerice 1

1.

```r
moyenneNorm = function(n) { 
	t = c()
	for (i in 0:n) {
		t[i] = mean(rnorm((10*i),0,1)) # Moyenne de la loi normal de param 0,1.
	}
	t
}
```

2.

```r
lines(plot(moyenneNorm(5000),type="l"))
```

La limite est 0. Lorsque n tend vers + l'infini, la moyenne tend vers 0. Plus on s'éloigne du centre de la loi normal, plus les valeurs tendent vers 0.

3.

```r
ecartNorm = function(n) { 
	t = c()
	for (i in 0:n) {
		t[i] = sd(rnorm((10*i),0,1)) # Ecart type de la loi normal de param 0,1.
	}
	t
}

lines(plot(ecartNorm(5000),type="l"))
```

La limite est 1. Plus les valeurs sont grande plus l'écart type est proche de 1 pour la loi normal.

4.

```r
moyenneUnif = function(n) { 
	t = c()
	for (i in 0:n) {
		t[i] = mean(runif((10*i),min=2,max=6)) # Moyenne d'une loi uniforme sur [2;6]
	}
	t
}

lines(plot(moyenneUnif(5000),type="l"))
```

La limite est 4. Plus n est grand plus la valeur est proche de la moyenne de 2 et 6.

5.

```r
moyenneCauchy = function(n) { 
	t = c()
	for (i in 0:n) {
		t[i] = mean(rcauchy((10*i))) # Moyenne d'une loi de Cauchy
	}
	t
}

lines(plot(moyenneCauchy(5000),type="l"))
```

La loi de Cauchy n'a pas de limite.

## Exercice 2

```r
rcarrenorm = function(n) {
	t = c()
	#l = c()

	l = rnorm(n) # Loi normal

	for (i in 0:n) {
		t[i] = l[i]^2 # Loi normal au carré
	}
	t
}

moyenneRcarrenorm = function(n) { 
	t = c()
	for (i in 0:n) {
		t[i] = mean(rcarrenorm(n)) # Moyenne de la loi normal de param 0,1.
	}
	t
}

lines(plot(moyenneRcarrenorm(1000),type="l"))

hist(rcarrenorm(1000))
hist(rcauchy(1000))
```

La loi de Cauchy ne suit pas la loi des grands nombres. Les valeurs sont centrés autour de 0 mais ne décroissent pas progressivement aux extrémités.

## Exercice 3

```r
echantillonDeMoyennesNorm = function(n,k) { 
	echantillon = c(c())
	#moyenne = c()

	for (i in 0:k) {
		echantillon[i] = mean(rcarrenorm(n))
		# echantillon[i] = rcarrenorm(n) # k échantillons de carré norm
		# moyenne[i] = mean(echantillon[i]) 
	}
	echantillon # Moyenne de k échantillon
	#moyenne # Moyenne de k échantillon
}

hist(echantillonDeMoyennesNorm(10,100))
hist(echantillonDeMoyennesNorm(10,1000))
hist(echantillonDeMoyennesNorm(30,100))
hist(echantillonDeMoyennesNorm(100,100))
hist(echantillonDeMoyennesNorm(1000,10))
hist(echantillonDeMoyennesNorm(600,3000))
hist(echantillonDeMoyennesNorm(80,780))
```

Les valeurs tendent vers 1 en suivant une loi normal.

```r
echantillonDeMoyennesUnif = function(n,k) { 
	echantillon = c()
	#moyenne = c()

	for (i in 0:k) {
		echantillon[i] = mean(runif(n,min=2,max=6)) # k échantillons de loi uniforme sur [2;6]
		#moyenne[i] = mean(echantillon[i]) 
	}
	#moyenne # Moyenne de k échantillon
	echantillon
}

hist(echantillonDeMoyennesUnif(600,3000))
hist(echantillonDeMoyennesUnif(80,780))
```
Les valeurs tendent vers 4 (la moyenne de 2 et 6) en suivant une loi normale.

```r
echantillonDeMoyennesCauchy = function(n,k) { 
	echantillon = c()
	#moyenne = c()

	for (i in 0:k) {
		echantillon[i] = mean(rcauchy(n)) # k échantillons de cauchy
		#moyenne[i] = mean(echantillon[i]) 
	}
	#moyenne # Moyenne de k échantillon
	echantillon
}

hist(echantillonDeMoyennesCauchy(600,3000))
hist(echantillonDeMoyennesCauchy(80,780))
```

Cauchy ne suit pas la loi normale.

## Exercice 4

```r
estimProportion = function(echantillon,alpha) {
	p = sum(echantillon) / length(echantillon) # Proportion de 1 dans l'échantillon
	# alpha # niveau de confiance
	n = length(echantillon) # taille de l'échantillon
	# On veut [p-f;p+f] avec f =
	f = sqrt(p*(1-p)/n) * qnorm((1+alpha)/2)

	c(p-f,p+f)
}

echantillon = sample(c(0,1),3000,replace = TRUE) # echantillon de {0,1}
# sample prend en paramètre un échantillon et fait un tirage dessus.
# replace défini si le tirage est avec remise ou nan.
# dans notre cas on est obligé de faire une mise (ex : on a une seule pièce)
estimProportion(echantillon,0.95)

echantillonBernoulli = function(n,p) {
	#sample(c(0,1),n,replace = TRUE,prob=p)
	rbinom(n,1,p)
}

testIntervalle = function(k,n,alpha,p0) {
	echan = c()
	vraie = c()
	for (i in 1:k) {
		echan = echantillonBernoulli(n,p0) # On génère k échantillons
		res = estimProportion(echan,alpha) # Intervalle de confiance pour chacun des échantillons
		if (p0 > res[1] && p0 < res[2]) {
			vraie[i] = 1
		}
		else {
			vraie[i] = 0
		}
	}
	estimProportion(vraie,alpha)
}

> testIntervalle(1000,60,0.95,0.4)
[1] 0.9263961 0.9556039
> testIntervalle(11000,60,0.95,0.4)
[1] 0.9294541 0.9387277
> testIntervalle(1000,10,0.95,0.4)
[1] 0.879242 0.916758
> testIntervalle(1000,100,0.95,0.001)
[1] 0.08048908 0.11751092
```

Plus on a de n, plus l'intervalle de confiance est proche de 1. Plus l'échantillon est grand plus on peut avoir de confiance dans notre intervalle.

Cependant si on réduit p0, l'intervalle de confiance diminu énormément, pour une précision très faible, moins de confiance.

## Exercice 5

```r
pop = runif(1000,min=2,max=6) #1.
mean(pop) #2.

tirageRemise = function(n) {
	pop = runif(n,min=2,max=6)
	sample(pop,n,replace=TRUE) # tirage avec remise de nombre d'éléments de la pop
}

estimationMoyenne = function(echantillon,alpha) {
	p = sum(echantillon) / length(echantillon) # Proportion de 1 dans l'échantillon
	# alpha # niveau de confiance
	n = length(echantillon) # taille de l'échantillon
	m = mean(echantillon) # moyenne échantillon
	tmp = echantillon-m # chaque case moins moyenne
	o = sqrt(1/(n-1)) * sum(tmp^2) # écart-type
	# On veut [m-f;m+f] avec f =
	f = o/sqrt(n) * qt((1+alpha)/2,n-1) # Les paramètres sont inversés par rapport au cours. n-1 est le degré de liberté et 1 + alpha / 2 est le vecteur de probabilité
	c(m-f,m+f)
}

echantillon = tirageRemise(10)
estimationMoyenne(echantillon,0.25)

centIntervalesConfiance = function(alpha,n) {
	cpt = 0 # Compteur pour proportion
	for (i in 1:100) {
		echantillon = tirageRemise(n) # On génère 100 échantillons de taille n
		m0 = mean(echantillon) # Calcul de m0, la "vraie valeur m0"
		intervalle = estimationMoyenne(echantillon,alpha) # Calcul d'un intervalle de confiance asymptotique de la moyenne
		if (m0 > intervalle[1] && m0 < intervalle[2]) cpt = cpt + 1 # On incrémente le compteur si m0 est dans l'intervalle
	}
	cpt / 100 # On renvoi la proportion de m0 dans l'intervalle
}

centIntervalesConfiance(0.95,7)
centIntervalesConfiance(0.95,50)
```
Quelque soit la valeur de n on obtient toujours une proportion de 1. L'intervalle est suffisament fiable pour ne jamais se tromper.

## Exercice 6

1 et 2 déjà fait à l'exerice précédent.

```r
centIntervalesNorm = function(alpha) {
	cpt = 0 # Compteur pour proportion
	for (i in 1:100) {
		echantillon = rnorm(1000) # On génère 100 échantillons loi normal de taille 1000
		m0 = mean(echantillon) # Calcul de m0, la "vraie valeur m0"
		intervalle = estimationMoyenne(echantillon,alpha) # Calcul d'un intervalle de confiance asymptotique de la moyenne
		if (m0 > intervalle[1] && m0 < intervalle[2]) cpt = cpt + 1 # On incrémente le compteur si m0 est dans l'intervalle
	}
	cpt / 100 # On renvoi la proportion de m0 dans l'intervalle
}

centIntervalesNorm(0.95)
```

# TP3

## Exercice 1

```r
comparaisonMoyenneRef = function(ech,m0,alpha,h1) {
	n = length(ech) # taille de l'échantillon
	# m0 moyenne de référence
	x = mean(ech) # moyenne de l'échantillon
	tmp = ech-x # chaque case moins moyenne
	o = sqrt(1/(n-1)) * sum(tmp^2) # écart-type
	# alpha risque de 1er espèce

	if (n >= 30) {
	# On considère n >= 30. Pour chaque cas on calcul S ;
		if (h1 == "!="){
			s = o/sqrt(n) * qnorm(1-(alpha/2))
			if (x > m0+s || x < m0-s) "H1" else "H0" # Si la condition est vraie on rejette H0
		}
		else if (h1 == "<"){
			s = o/sqrt(n) * qnorm(1-alpha)
			if (x < m0-s) "H1" else "H0"
		}
		else if (h1 == ">"){
			s = o/sqrt(n) * qnorm(1-alpha)
			if (x > m0+s) "H1" else "H0"
		}
		else{
			paste("Invalid caracter ", h1)
		}
	}
	else {
	# On considère que l'échantillon suit une loi normale.
		"WIP"
	}
}

simuleTestCompaMoyenne = function(pop,k,n,m0,alpha,h1) {
	cpt = 0 # Nombre de test ayant retourné H0
	for (i in 1:k) { # On répète k fois :
		ech = sample(pop,n) # Tirage de n éléments depuis pop
		test = comparaisonMoyenneRef(ech,m0,alpha,h1)
		if (test == "H0") cpt = cpt+1 # Si le test de comparaison renvoi H0 on incrémente
	}
	cpt/k # Proportion de tests ayant retourné H0
}

pop = runif(1000,min=0,max=30)
m = mean(pop) # moyenne sur la population
m

simuleTestCompaMoyenne(pop,10,50,m,0.67,"!=") # m = m0
simuleTestCompaMoyenne(pop,10,50,m,0.67,"<") # m = m0
simuleTestCompaMoyenne(pop,10,50,m,0.67,">") # m = m0
```

4. Pour != on obtient une proportion de 1 et pour les deux autres une proportion de 0. Avec m=m0 il est normal que le test d'égalité soit toujours vrai mais pas les autres.

```r
msample = runif(50,min=0,max=30) # 50 valeurs entre 0 et 30
pop = c()
for (i in msample) { # i prend succéssivement une valeur entre 0 et 30, 50 fois
	popi = rnorm(20,mean=i) # Population de moyenne m entre 0 et 30. n = 20 car au final on veut une population de 1000, 50*20=1000
	pop = c(pop,popi) # On concatène les vecteurs pour obtenir notre population
}
simuleTestCompaMoyenne(pop,200,100,15,0.90,"!=")
simuleTestCompaMoyenne(pop,200,100,15,0.90,">")
simuleTestCompaMoyenne(pop,200,100,15,0.90,"<")
```

Qu'est-ce qu'on fait après j'ai rien compris ?

## Exercice 2

```r
distanceKhi2 = function(vObserve,vTheorique) {
	k = 0 # Somme totale
	for (i in 1:length(vObserve)) { # On considère que les effectifs sont de meme taille
		tmp = ((vObserve[i]-vTheorique[i])^2) / vTheorique[i] # Calcul à i
		k = k + tmp # Somme totale
	}
	k # Distance de Khi2 entre ces deux vecteurs
}

testKhi2 = function(vObserve,vTheorique,alpha) {
	dist = distanceKhi2(vObserve,vTheorique) # Calcul de la distance du khi2
	#seuil = qchisq(alpha,dist) # Calcul du seuil de rejet par les quantiles de la loi du khi2
	seuil = qchisq(alpha,5) # c-1-r | c nb colonnes, r nb paramètres
	if (dist >= seuil) "H1" else "H0" # Si la distance est supérieur au seuil de rejet on rejette H0.
}

dée = sample(seq(1,6),100,TRUE) # Dée normal non pipé ppr
déePipé = sample(seq(5,6),100,TRUE) # Dée méga pipé qui donne que des 5 et des 6
> testKhi2(dée,déePipé,0.95)
[1] "H1"
> testKhi2(dée,dée,0.95) # Les dés sont identique donc pas de distance
[1] "H0"

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

déeUniforme = round(runif(3000,1,6)) # Dée suivant exactement une loi uniforme (3000 lancés)
pop = sample(seq(1, 6),3000,TRUE) # 3000 lancés d'un dée à 6 faces

cpt = 0 # Somme des tests infructueux
for (i in 1:200) {
	ech = sample(pop,15,TRUE) # On prend 15 éléments dans la pop pour faire 200 tests sur la population, 15*200 = 3000

	result = testKhi2(ech,déeUniforme,0.95) # 200 tests du Khi2 à 5%

	if(result != "H0") cpt = cpt+1 # On évalue le nombre de tests ne donnant pas la bonne décision
}
cpt/200
```

96,5% des tests ne donnent pas la bonne décision, les lancés de dées ne sont pas très uniforme.

### 5 et 6
```r
deeTruc = function(K,e) {
	dee = seq(1, 6)
	prob = c(1/6,1/6,1/6,1/6,(1/6)-e,(1/6)+e) # Proba de chaque face du dée de la 1 à la 6
	sample(dee,K,TRUE,prob) # K tirage avec remise du dée avec les probabilités spécifiés
}

deeTruc(200,0.05)

trenteE = seq(1/24, 1/6, length.out=30) # 30 e espacé régulièrement entre 1/24 et 1/6
déeUniforme = round(runif(200,1,6)) # Dée suivant exactement une loi uniforme
tabRes = c()
for (i in trenteE) { # différentes valeurs de e
	cpt=0
	for (j in 1:200) { # 200 tests pour chaque e
		tirage = deeTruc(200,i)
		result = testKhi2(tirage,déeUniforme,0.95) # test du Khi2 à 5%
		print(result)
		if(result != "H0") cpt = cpt+1 # On évalue le nombre de tests ne donnant pas la bonne décision
	}
	tabRes = c(tabRes,cpt/200) # Sur 200 tests, x ne sont pas la bonne décision
}
```

La proportion est toujours 1, il doit y avoir un soucis avec testKhi2.

## Exercice 3

```r
effectifsSiIndep = function(x,y) {
	# TODO: les effectifs sont-ils indépendants ?

	v = matrix(x,length(x),1) # Matrice colonne de x
	w = matrix(y,length(y),1) # Matrice colonne de y
	n = sum(x) # taille totale de l'effectif

	t((v%*%t(w)) / n) # Produit de la matrice v avec la transposé de la matrice w divisé par l'effectif total. Donne la matrice contenant le tableau des effectifs théoriques
}

v = c(69,66,65)
w = c(109,55,36)
effectifsSiIndep(v,w)

testKhi2Indep = function(tab,alpha) {
	# tab # effectif normal
	x = colSums(tab) # Somme des lignes
	y = rowSums(tab) # Somme des colonnes
	theorique = effectifsSiIndep(x,y) # Tableau des effectifs théoriques

	# Calcul de la distance entre l'effectif théorique et normal
	dist = 0
	for (i in nrow(tab)) {
		dist = dist + distanceKhi2(tab[i,],theorique[i,]) # distance de Khi2 ligne à ligne
	}
	# Calcul du seuil de rejet
	s = qchisq(1-alpha,(length(x)-1)*(length(y)-1))

	if(dist >= s) "H1" else "H0" # Si K >= s on rejette H0
}

a = matrix(c(v,w),3,2)
testKhi2Indep(a,0.5)

binom3 = function(N) {
	X = round(runif(N,1,3)) # Loi X uniforme sur 1,2,3
	Y = rbinom(N,4,1/4) # Loi Y suit une loi binomiale (4,1/4)

	T = c(X,Y) # Concaténation des tableaux. T[i] suit la loi X, T[i+N] suit une loi de Y. Le tableau a une taille de 2N
	T
}

binom3matrix = function(ech) {
	N = length(ech)
	t = matrix(0,3,5,TRUE)

	for (i in 1:3) {
		for(j in 0:4) {
			couple1 = c(i,j)
			cpt = 0 # Nombre de couple de i égaux
			for (k in 1:N) {
				couple2 = c(ech[k],ech[k+N]) # Prend succéssivement la valeur de chaque case du tableau
				condition = sum(couple1 == couple2)
				print(couple1)
				print(couple2)
				if(condition >= 2) { # On s'attends à avoir le résultat TRUE TRUE si les couples sont égaux. sum(TRUE TRUE) donne 2.
					cpt = cpt + 1
				}
			}
			t[i,j] = cpt # Le couple (i,j) tombe cpt fois
		}
	}
}
```