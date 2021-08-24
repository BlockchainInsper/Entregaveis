# RSA

## Apresentação

O RSA, apresentado pela primeira vez em 1977, é o sistema de criptografia de public-key mais famoso. Ele possui os dois principais casos de usos:

- A [criptografia de chave pública](https://en.wikipedia.org/wiki/Public-key_cryptography) permite que um usuário, Alice, distribua uma chave pública e outros possam usar essa chave pública para criptografar mensagens para ela. Alice pode então usar sua chave privada para descriptografar as mensagens.

- As [assinaturas digitais](https://en.wikipedia.org/wiki/Digital_signature) permitem que Alice use sua chave privada para "assinar" uma mensagem. Qualquer pessoa pode usar a chave pública de Alice para verificar se a assinatura foi criada com sua chave privada correspondente e se a mensagem não foi adulterada.

Embora a segurança do RSA seja baseada na dificuldade de fatorar grandes números compostos, nos últimos anos o este método tem recebido críticas por ser fácil de implementar **incorretamente**. As principais falhas foram encontradas em implementações comuns, a mais notória delas sendo a [vulnerabilidade ROCA](https://en.wikipedia.org/wiki/ROCA_vulnerability), que levou a Estônia a suspender 760.000 carteiras de identidade nacionais.

Os exercícios abaixo apresentam a você alguns dos detalhes por trás do RSA.

## Subtask 1

Todas as operações no RSA envolvem [exponenciação modular](https://pt.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/modular-exponentiation).

A exponenciação modular é uma operação amplamente usada em criptografia e normalmente é escrita como: 2^10 mod 17

Você pode pensar nisso como elevar algum número a uma certa potência (2^10 = 1024) e, em seguida, obter o restante da divisão por algum outro número (1024 mod 17 = 4). Em Python, há um operador integrado para realizar esta operação: pow (base, expoente, módulo)

No RSA, a exponenciação modular, juntamente com o problema de fatoração de primos, nos ajuda a construir uma ["trapdoor function"](https://en.wikipedia.org/wiki/Trapdoor_function). Esta é uma função fácil de calcular em uma direção, mas difícil de revertê-la, a menos que você tenha as informações corretas. Ela nos permite criptografar uma mensagem e apenas a pessoa com a chave pode realizar a operação inversa para descriptografá-la.

**Encontre a solução para 10117 mod 22663 (em código)**

**Resposta: `19906`**

## Subtask 2

A criptografia RSA é a exponenciação modular de uma mensagem com um expoente “e” e um módulo “N” que normalmente é um produto de dois primos: N = p * q.

```
Cifra = m^e mod N

m = Mensagem (Sequência de bits, hash da mensagem, etc)
e = expoente
N = multiplicação de dois primos p e q
```

Juntos, o expoente e o módulo formam uma "chave pública" RSA (N, e). O valor mais comum para o expoente “e” é 0x10001 (hexadecimal) ou 65537 (base 10).

**"Criptografe" o número 12 usando o expoente e = 65537 e os primos p = 17 eq = 23. Qual número você obtém como texto cifrado?**

**Resposta: `301`**

## Subtask 3

O RSA depende da dificuldade de fatoração do módulo N. Se os primos podem ser encontrados, então podemos calcular o [totiente de Euler de N](https://leimao.github.io/article/RSA-Algorithm/) e, assim, descriptografar o texto cifrado.

Dado que N = p * q (dois primos):

```
p = 857504083339712752489993810777

q = 1029224947942998075080348647219
```

**Qual é o totiente de N?**

**Resposta: `882564595536224140639625987657529300394956519977044270821168`**

## Subtask 4

A chave privada “d” é usada para descriptografar textos cifrados criados com a chave pública correspondente (também pode ser usada para "assinar" uma mensagem, como foi dito anteriormente).

A chave privada é a informação secreta ou "trapdoor". Se o RSA estiver bem implementado, e você não possuir a chave privada, a maneira mais rápida de descriptografar o texto cifrado é primeiro tentar fatorar o totiente.

Em RSA, a chave privada é o [inverso multiplicativo modular](https://en.wikipedia.org/wiki/Modular_multiplicative_inverse) do expoente e como módulo o totiente de N.

```
Private Key = e^-1 mod phi

phi = Totiente de N = (p-1)*(q-1)
```

Dados os dois primos:

```
p = 857504083339712752489993810777

q = 1029224947942998075080348647219
```

e o expoente:

```
e = 65537
```

**Qual é a chave privada “d”?**

**Resposta: `121832886702415731577073962957377780195510499965398469843281`**

## Subtask 5

Um número secreto foi codificado para você usando apenas os parâmetros de sua chave pública (N, e):

```
N = 882564595536224140639625987659416029426239230804614613279163

e = 65537
```

**Use a chave privada que você encontrou na subtask anterior para descriptografar este texto cifrado:**

```
c = 77578995801157823671636298847186723593814843845525223303932
```

**Resposta: `13371337`**

## Subtask 6

**Como você pode garantir que a pessoa que está recebendo sua mensagem saiba que você a escreveu?**

Você foi convidado para um encontro e quer enviar uma mensagem dizendo que adoraria ir, mas um amante ciumento não fica tão feliz com isso.

Quando você envia sua mensagem dizendo “sim”, seu amante ciumento intercepta a mensagem e a corrompe, então agora ela diz “não”!

Podemos nos proteger contra esses ataques assinando a mensagem.

Imagine que você escreve uma mensagem M. Você criptografa esta mensagem com a **chave pública de seu amigo**: <code>C = M<sup>e<sub>0</sub></sup> mod N<sub>0</sub></code>.

Para assinar esta mensagem, você faz o hash da mensagem: H (M) e "criptografa" isso com **a sua chave privada**: <code>S = H(M)<sup>d<sub>1</sub></sup> mod N<sub>1</sub></code>.

[**Em sistemas de criptografia reais, a melhor prática é usar chaves separadas para criptografar e assinar mensagens**](https://crypto.stackexchange.com/questions/12090/using-the-same-rsa-keypair-to-sign-and-encrypt/12138#12138)

Seu amigo pode descriptografar a mensagem usando **a chave privada dele**: <code>m = C<sup>d<sub>0</sub></sup> mod N<sub>0</sub></code>. E usando **a sua chave pública**, ele calcula <code>s = S<sup>e<sub>1</sub></sup> mod N<sub>1</sub></code>.

Agora, fazendo o hash da mensagem H (m) e comparando-o com "s": H (m) == s, ele pode garantir que a mensagem que você enviou é a mensagem que ele recebeu!

**Assine a flag <code>crypto{Immut4ble_m3ssag1ng}</code> usando sua chave privada e a função hash SHA256.**

[private.key](https://cryptohack.org/static/challenges/private_0a1880d1fffce9403686130a1f932b10.key)

**Resposta: `0x6ac9bb8f110b318a40ad8d7e57defdcce2652f5928b5f9b97c1504d7096d7af1d34e477b30f1a08014e8d525b14458b709a77a5fa67d4711bd19da1446f9fb0ffd9fdedc4101bdc9a4b26dd036f11d02f6b56f4926170c643f302d59c4fe8ea678b3ca91b4bb9b2024f2a839bec1514c0242b57e1f5e77999ee67c450982730252bc2c3c35acb4ac06a6ce8b9dbf84e29df0baa7369e0fd26f6dfcfb22a464e05c5b72baba8f78dc742e96542169710918ee2947749477869cb3567180ccbdfe6fdbe85bcaca4bf6da77c8f382bb4c8cd56dee43d1290ca856318c97f1756b789e3cac0c9738f5e9f797314d39a2ededb92583d97124ec6b313c4ea3464037d3`**

**Dica: O "0x" na frente do número representa que ele é um hexadecimal**
