# Diffie-Hellman

## Apresentação

O artigo de 1976 de Whitfield Diffie e Martin Hellman, "New Directions in Cryptography", representou um grande salto para o campo da criptografia. O paper definiu os conceitos de criptosistemas de chave pública, trapdoor functions e assinaturas digitais, além de descrever um método de troca de chaves para compartilhar segredos com segurança em um canal inseguro. 

![](https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Diffie-Hellman-Schl%C3%BCsselaustausch.png/400px-Diffie-Hellman-Schl%C3%BCsselaustausch.png)

Embora tenham sido descobertos de forma independente no GCHQ (Government Communications Headquarters) alguns anos antes, Diffie e Hellman foram os primeiros a compartilhar esse conhecimento marcante com o mundo. A troca de chaves Diffie-Hellman (DH) é fundamental para a segurança da Internet hoje. Como parte do handshake TLS, é normalmente usado para calcular com segurança uma chave de criptografia AES compartilhada pela Internet entre um navegador da web e um servidor. Embora vários outros algoritmos possam ser usados ​​para troca de chaves, DH é a única opção disponível na última revisão da especificação TLS (1.3), mostrando como ela se manteve ao longo dos anos. Isso se deve principalmente à facilidade com que o DH pode ser adaptado para oferecer suporte ao ["sigilo antecipado"](https://en.wikipedia.org/wiki/Forward_secrecy), que discutiremos com mais detalhes a seguir. 

DH se baseia na suposição de que o problema do logaritmo discreto (DLP) é difícil de se resolver. No entanto, na prática, os parâmetros precisam ser escolhidos com cuidado ou o logaritmo discreto pode ser fácil de quebrar, o que exploraremos nesses desafios. Além disso, a versão mais básica do protocolo é vulnerável a um ataque man-in-the-middle, mostrando como o DH requer autenticação cuidadosa da pessoa com quem você está falando.

## Subtask 1
O conjunto de inteiros usado na álgebra modular, junto com as operações de adição e multiplicação pode ser representado por um anel. Isso significa que adicionar ou multiplicar quaisquer dois elementos no conjunto retorna outro elemento no conjunto, ou seja ele sempre volta para o ponto de início.

Também é possível pensar nisso como um relógio de ponteiros, por exemplo.

![](https://i.ytimg.com/vi/yhgkH7sY9Mk/maxresdefault.jpg)

Quando o módulo é primo: n = p, temos a garantia de um número inverso para cada elemento no conjunto, portanto, o anel é promovido a um campo.

Referimo-nos a este campo como um campo finito Fp. O protocolo Diffie-Hellman trabalha com elementos de algum campo finito Fp, onde o módulo é tipicamente um primo grande. 

Dado o primo p = 991 e o elemento g = 209, encontre o elemento inverso d tal que g * d mod 991 = 1.

**Resposta: `569`**

## Subtask 2
Cada elemento em um campo finito Fp pode ser usado para fazer um subgrupo H sob ação repetida de multiplicação.

Em outras palavras, para um elemento g: H = {g, g ^ 2, g ^ 3, ...}

Um elemento primitivo de Fp é um elemento que pertence ao subgrupo H = Fp, ou seja, cada elemento de Fp, pode ser escrito como g ^ n mod p para algum inteiro n. Por causa disso, os elementos primitivos às vezes são chamados de geradores do campo finito. 

Para o campo finito com p = 28151 encontre o menor elemento g que é um elemento primitivo de Fp.

**Resposta: `7`**

## Subtask 3
O protocolo Diffie-Hellman é usado, pois o logaritmo discreto é considerado um cálculo "difícil" para casos cuidadosamente escolhidos.

O primeiro passo do protocolo é estabelecer um primo p e algum gerador do campo finito g.

Eles devem ser escolhidos com cuidado para evitar casos especiais onde o log discreto pode ser resolvido com algoritmos eficientes. Por exemplo, um primo seguro p = 2*q + 1 é geralmente escolhido de forma que os únicos fatores de p - 1 são {2, q} onde q é algum outro primo grande. Isso protege o DH do algoritmo Pohlig – Hellman. 

O usuário então escolhe um inteiro secreto a < p e calcula g ^ a mod p. 

Isso pode ser transmitido por uma rede insegura e devido à dificuldade assumida do logaritmo discreto, se o protocolo foi implementado corretamente, o número inteiro secreto deve ser inviável para calcular.

Dados os parâmetros NIST (National Institute of Standards and Technology):
```
g: 2 
p: 2410312426921032588552076022197566074856950548502459942654116941958108831682612228890093858261341614673227141477904012196503648957050582631942730706805009223062734745341073406696246014589361659774041027169249453200378729434170325843778659198143763193776859869524088940195577346119843545301547043747207749969763750084308926339295559968882457872412993810129130294592999947926365264059284647209730384947211681434464714438488520940127459844288859336526896320919633919
``` 

Calcule o valor de g ^ a mod p para:
```
a: 972107443837033796245864316200458246846904598488981605856765890478853088246897345487328491037710219222038930943365848626194109830309179393018216763327572120124760140018038673999837643377590434413866611132403979547150659053897355593394492586978400044375465657296027592948349589216415363722668361328689588996541370097559090335137676411595949335857341797148926151694299575970292809805314431447043469447485957669949989090202320234337890323293401862304986599884732815
```

**Resposta: `1806857697840726523322586721820911358489420128129248078673933653533930681676181753849411715714173604352323556558783759252661061186320274214883104886050164368129191719707402291577330485499513522368289395359523901406138025022522412429238971591272160519144672389532393673832265070057319485399793101182682177465364396277424717543434017666343807276970864475830391776403957550678362368319776566025118492062196941451265638054400177248572271342548616103967411990437357924`**

## Subtask 4
Agora é hora de calcular uma chave compartilhada usando os dados recebidos de sua amiga Alice. Como antes, usaremos os parâmetros NIST:
```
g: 2 
p: 2410312426921032588552076022197566074856950548502459942654116941958108831682612228890093858261341614673227141477904012196503648957050582631942730706805009223062734745341073406696246014589361659774041027169249453200378729434170325843778659198143763193776859869524088940195577346119843545301547043747207749969763750084308926339295559968882457872412993810129130294592999947926365264059284647209730384947211681434464714438488520940127459844288859336526896320919633919
```

Você recebeu o seguinte inteiro da Alice:
```
A: 70249943217595468278554541264975482909289174351516133994495821400710625291840101960595720462672604202133493023241393916394629829526272643847352371534839862030410331485087487331809285533195024369287293217083414424096866925845838641840923193480821332056735592483730921055532222505605661664236182285229504265881752580410194731633895345823963910901731715743835775619780738974844840425579683385344491015955892106904647602049559477279345982530488299847663103078045601
```

Você gera seu número inteiro secreto b e calcula seu número B público, que você envia para Alice.

```
b: 12019233252903990344598522535774963020395770409445296724034378433497976840167805970589960962221948290951873387728102115996831454482299243226839490999713763440412177965861508773420532266484619126710566414914227560103715336696193210379850575047730388378348266180934946139100479831339835896583443691529372703954589071507717917136906770122077739814262298488662138085608736103418601750861698417340264213867753834679359191427098195887112064503104510489610448294420720

B: 518386956790041579928056815914221837599234551655144585133414727838977145777213383018096662516814302583841858901021822273505120728451788412967971809038854090670743265187138208169355155411883063541881209288967735684152473260687799664130956969450297407027926009182761627800181901721840557870828019840218548188487260441829333603432714023447029942863076979487889569452186257333512355724725941390498966546682790608125613166744820307691068563387354936732643569654017172
```

Você e Alice agora podem calcular uma chave compartilhada, a qual seria inviável calcular sabendo apenas {g, p, A, B}. 

Qual é o seu segredo compartilhado?

**Dica: Use como referência o primeiro diagrama apresentado no início da página**

**Resposta: `1174130740413820656533832746034841985877302086316388380165984436672307692443711310285014138545204369495478725102882673427892104539120952393788961051992901649694063179853598311473820341215879965343136351436410522850717408445802043003164658348006577408558693502220285700893404674592567626297571222027902631157072143330043118418467094237965591198440803970726604537807146703763571606861448354607502654664700390453794493176794678917352634029713320615865940720837909466`**

