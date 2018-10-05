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
	p = sum(echantillon) / length(echantillon) # Proportion de 1 dans tab
	# alpha # niveau de confiance
	n = length(echantillon) # taille de l'échantillon
	# On veut [p-f;p+f] avec f =
	f = sqrt(p*(1-p)/n) * qnorm((1+alpha)/2)

	c(p-f,p+f)
}

echantillon = sample(c(0,1),3000,replace = TRUE) # echantillon de {0,1}
estimProportion(echantillon,0.95)
```