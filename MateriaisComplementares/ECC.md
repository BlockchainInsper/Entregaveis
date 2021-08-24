# Curvas Elípticas

## Apresentação

A Criptografia de Curvas Elípticas (ECC, em inglês) é um protocolo criptográfico assimétrico que, como RSA e Diffie-Hellman (DH), depende de uma **trapdoor function**. Para relembrar: as trapdoor functions permitem que alguém mantenha os dados em segredo, executando uma operação matemática que é computacionalmente fácil de fazer, mas atualmente entendida como muito difícil de desfazer. 

Para o RSA, a trapdoor function depende da dificuldade em fatorar grandes números. Para Diffie-Hellman, a trapdoor function depende da dificuldade do [problema de logaritmo discreto](https://pt.wikipedia.org/wiki/Logaritmo_discreto). Tanto para RSA quanto para DH, as operações matemáticas utilizadas no protocolo são familiares para nós. Multiplicar números e calcular a potência dos números são coisas que aprendemos a fazer na escola. ECC, no entanto, se destaca, porque as operações matemáticas utilizadas no protocolo não vão aparecer na sua vida a menos que você esteja procurando por elas.

Vamos começar a pensar sobre o ECC observando o que entendemos por curva elíptica. Estaremos estudando as equações de Weierstrass, que são da forma:

```
Y^2 = X^3 + a*X + b
```

As curvas elípticas têm uma característica incrível: podemos definir um operador que chamaremos de adição de ponto. Este operador pega dois pontos em alguma curva e produz um terceiro ponto na curva.

### Então, como funciona o adição de ponto?

Geometricamente, podemos entender a adição de pontos ```P + Q``` da seguinte forma. 

1. Faça uma curva elíptica e marque dois pontos P, Q ao longo da curva com suas coordenadas x, y.
2. Desenhe uma linha reta que passa por ambos os pontos. 
3. Agora continue a linha até que cruze sua curva pela terceira vez. Marque esta nova interseção R.
4. Finalmente, pegue R e reflita ao longo da direção y para produzir ```R' = R(x, -y)```. 
5. O resultado da adição de pontos é ```P + Q = R'```
 
E se quisermos somar dois pontos iguais: ```P + P```? 

Não podemos desenhar uma linha única através de um único ponto, mas podemos escolher uma linha única calculando a linha tangente à curva no ponto. 

1. Calcule a linha tangente no ponto P.
2. Continue a linha até que ela cruze com a curva no ponto R. 
3. Reflita este ponto como antes: ```P + P = R' = R (x, -y).```

O que acontece se não houver uma terceira interseção? 

Às vezes, você escolherá dois pontos P, Q e a linha não tocará a curva novamente. Nesse caso, dizemos que a linha se cruza com o ponto (O), que é um ponto localizado no final de cada linha vertical no infinito. Por isso, podemos dizer que a adição de pontos para uma curva elíptica é definida no espaço 2D, com um ponto adicional localizado no infinito.

![](https://cryptohack.org/static/img/ECClines.svg)

Além disso, o ponto O também atua como operador identidade: ```P + O = P``` e ```P + (-P) = O```

Isso nos trás ao momento de definir uma curva elíptica.

**Definição**

Uma curva elíptica E é o conjunto de soluções para uma equação de Weierstrass
```
E: Y^2 = X^3 + a*X + b
```

junto com um ponto no infinito O. Além disso, as constantes a, b devem satisfazer a seguinte relação para garantir que não haja singularidades na curva (pontos onde a curva cruza ela mesma).
```
4a^3 + 27b^2 ≠ 0
```

Formalmente, seja E uma curva elíptica, a adição de pontos tem as seguintes propriedades
```
(a) P + O = O + P = P
(b) P + (−P) = O
(c) (P + Q) + R = P + (Q + R)
(d) P + Q = Q + P
```

No ECC, estudamos curvas elípticas sobre um **campo finito** Fp. Isso significa que precisamos utilizar o módulo da curva. Neste caso a curva elíptica não será mais uma curva, mas sim uma coleção de pontos cujas coordenadas x, y são números inteiros em Fp. 

Os desafios iniciais a seguir irão guiá-lo pelos cálculos do ECC e acostumá-lo às operações básicas em que o ECC foi construído. Divirta-se!

## Subtask 1 - Negação de pontos

Na introdução, cobrimos o básico de como podemos ver a adição de pontos sobre uma curva elíptica

Naquele caso, permitimos que as coordenadas da curva fossem qualquer número real. No entanto, para aplicarmos curvas elípticas em um ambiente criptográfico, estudamos curvas elípticas que têm coordenadas em um campo finito Fp. Ainda estaremos considerando curvas elípticas da forma E: Y2 = X3 + a X + b, que satisfazem as seguintes condições: a, b ∈ Fp e 4a3 + 27 b2 ≠ 0. No entanto, não pensamos mais na curva elíptica como um objeto geométrico, mas sim um conjunto de pontos definidos por:
```
E(Fp) = {(x,y) : x,y ∈ Fp | y2 = x3 + a x + b} ∪ O
```

Para todos os desafios deste arquivo, estaremos trabalhando com a curva elíptica:
```
E: Y^2 = X^3 + 497*X + 1768, p: 9739
``` 

Usando a curva acima e o ponto P (8045,6936), encontre o ponto Q (x, y) de modo que P + Q = O.

**Resposta: `Q=(8045,2803)`**

## Subtask 2 - Adição de pontos

Ao trabalhar com criptografia de curvas elípticas, precisaremos somar pontos. Na explicação da introdução, fizemos isso geometricamente, encontrando uma linha que passava por dois pontos, encontrando a terceira interseção e refletindo ao longo do eixo y. Acontece que existe um algoritmo eficiente para calcular a lei de adição de pontos para uma curva elíptica. Retirado de "An Introduction to Mathematical Cryptography", Jeffrey Hoffstein, Jill Pipher, Joseph H. Silverman, o seguinte algoritmo irá calcular a adição de dois pontos em uma curva elíptica Algoritmo para a adição de dois pontos: P + Q

**Algorithm for the addition of two points: P + Q**
```
(a) Se P = O, então P + Q = Q.
(b) Senão, se Q = O, então P + Q = P.
(c) Senão, anote P = (x1, y1) e Q = (x2, y2).
(d) Se x1 = x2 e y1 = −y2, então P + Q = O.
(e) Senão:
  (e1) Se P ≠ Q: λ = (y2 - y1) / (x2 - x1)
  (e2) Se P = Q: λ = (3x12 + a) / 2y1
(f) x3 = λ2 − x1 − x2,     y3 = λ(x1 −x3) − y1
(g) P + Q = (x3, y3)
```

**Estamos trabalhando com um campo finito, então os cálculos acima devem ser feitos mod p, e não "dividimos" por um inteiro, em vez disso, multiplicamos pelo [inverso modular de um número](https://pt.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-inverses). por exemplo. 1/5 = 9 mod 11.**

Vamos trabalhar com a seguinte curva elíptica e o primo:
```
E: Y^2 = X^3 + 497*X + 1768, p: 9739
```

Alguns testes para o seu algoritmo:
```
X + Y = (1024, 4440) 
X + X = (7284, 2107) 

Sendo X = (5274, 2841) e Y = (8669, 740)
```

Usando a curva acima e os pontos P = (493, 5564), Q = (1539, 4742), R = (4403,5202), encontre o ponto S (x, y) = P + P + Q + R implementando o algoritmo acima.

**Não se esqueça que estamos em um campo finito**

**Resposta: `S(x,y) = (4215,2162)`**

## Subtask 3 - Multiplicação escalar

A multiplicação escalar de dois pontos é definida pela adição repetida: 3P = P + P + P. 

Nos próximos desafios, usaremos a multiplicação escalar para criar um segredo compartilhado em um canal inseguro de maneira semelhante aos desafios Diffie-Hellman. 

Retirado de "An Introduction to Mathematical Cryptography", Jeffrey Hoffstein, Jill Pipher, Joseph H. Silverman, o seguinte algoritmo calculará com eficiência a multiplicação escalar de um ponto em uma curva elíptica

**Algoritmo para a multiplicação escalar do ponto P por n**

```
Entrada: P em E (Fp) e um inteiro n > 0 
1. Defina Q = P e R = O. 
2. Loop enquanto n > 0.
    3. Se n ≡ 1 mod 2, defina R = R + Q. 
    4. Defina Q = 2Q e n = ⌊n / 2⌋. 
    5. Se n> 0, continue com o loop na Etapa 2. 
6. Retorne o ponto R, que é igual a nP. 
```

Este não é o algoritmo mais eficiente, existem muitas maneiras interessantes de melhorar esse cálculo, mas isso será suficiente para o nosso trabalho.
 
Vamos trabalhar com a seguinte curva elíptica e primo: 
```
E: Y^2 = X^3 + 497*X + 1768, p: 9739
``` 

Alguns testes para o seu algoritmo:
```
1337X = (1089, 6931)

Sendo X = (5323, 5438)
```

Usando a curva acima e os pontos P = (2339, 2213), encontre o ponto Q (x, y) = 7863P implementando o algoritmo acima.

**Não se esqueça que estamos em um campo finito**

**Resposta: `Q(x,y) = (9467, 2742)`**

## Subtask 4 - Curvas e Logs

O problema do logaritmo discreto da curva elíptica (ECDLP) é o problema de encontrar um inteiro n tal que Q = nP.

Como nos deparamos com o problema do logaritmo discreto, a multiplicação escalar de um ponto em E (Fp) parece ser um problema difícil de desfazer, com o algoritmo mais eficiente executando no tempo p^(1 / 2). Isso o torna um ótimo candidato para uma **trapdoor function**. 

Alice e Bob estão conversando e querem criar uma chave compartilhada para que possam começar a criptografar suas mensagens com algum protocolo criptográfico simétrico. 

Alice e Bob não confiam em sua conexão, então eles precisam de uma maneira de criar um segredo que outros não possam replicar.

Alice e Bob concordam em uma curva E, um primo p e um ponto gerador G.

Na criptografia de curva elíptica, é importante que a ordem de G seja primo. 

```
Construir curvas seguras é complicado, por isso é recomendado usar uma curva pré-construída onde um você recebe a os parâmetros A e B, o primo e o gerador para usar.
```

1. Alice gera um inteiro aleatório secreto n_A e calcula Q_A = n_A*G

2. Bob gera um número inteiro aleatório secreto n_B e calcula Q_B = n_B*G

3. Alice envia a Bob Q_A e Bob envia a Alice Q_B.
 
Devido à dificuldade computacional do ECDLP, um espião Eve é incapaz de calcular n_A_B em um tempo razoável. 

4. Alice então calcula n_A*Q_B e Bob calcula n_B*Q_A.
 
Devido à associatividade da multiplicação escalar, S = n_A*Q_B = n_B*Q_A.

Alice e Bob podem então usar S como sua chave simétrica compartilhada. 


Usando a curva, o primo e gerador:
```
E: Y^2 = X^3 + 497*X + 1768, p: 9739, G: (1804,5368)
``` 

Calcule o segredo compartilhado depois que Alice enviar para você Q_A = (815, 3190), com o seu número inteiro secreto n_B = 1829. 

Gere uma chave calculando o hash SHA1 da coordenada x (pegue a representação decimal da coordenada e converta-a em uma string). A resposta é o número hexadecinal que você encontra.

**Resposta: `80e5212754a824d3a4aed185ace4f9cac0f908bf`**
