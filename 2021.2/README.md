# Entregáveis 2021.2

Propostas de Entregáveis usadas na turma de 2021.2 

## Criptografia

O primeiro entregável será o uso de criptografia para o envio de mensagens em uma rede lightning simulada. Os arquivos necessários para o entregável estão disponíveis [aqui](https://drive.google.com/file/d/1wesL4O9HK7S0Z6MdqazG8k2TbYDNuyO1/view?usp=sharing).

Sua entrega deve ser feita seguindo o modelo no final do README. E o único arquivo que deve ser enviado é o ```node.py```. 

**Lembrando que qualquer dúvida, todos os membros veteranos estão disponíveis!**

1. Encriptando mensagens
  
  a) Faça com que o Nó seja inicializado com uma chave pública e privada utilizando a biblioteca [rsa](https://www.geeksforgeeks.org/how-to-encrypt-and-decrypt-strings-in-python/). Se quiser utilizar outra biblioteca de sua preferência, fique à vontade.
  
  b) Complete o método ```encrypt```, o mesmo deve receber (nesta ordem) uma mensagem a ser encriptada e o nó a qual deseja mandar a mensagem. Assim o método deve devolver uma mensagem encriptada.
  
  c) Complete o método ```decrypt```, deve receber apenas uma mensagem e desencriptar a mesma utilizando a chave do nó que chama a função.
  
  d) Rode o arquivo Test.py e verifique se o primeiro teste passou!

2. Passando mensagens encriptadas entre nós não conectados

  a) Complete o método ```pass_message```, o mesmo deve receber uma mensagem e um nó a qual deseja enviar a mensagem, criar um canal entre o nó que chama a função e o nó que a função recebe, encriptar a mensagem recebida, e colocar a mensagem na lista de ambos os nós.

  b) Rode o arquivo Test.py e verifique se o segundo teste passou!

3. Passando mensagens encriptadas entre nós conectados

  a) Se toda vez que um nó fosse querer mandar mensagem a outro fosse necessário criar um canal entre eles, a lightning network não seria eficiente. Dessa forma, antes de criar um canal é interessante verificar se já existe um canal prévio entre ambos os nós. Modifique o método ```pass_message``` para que antes de criar um canal entre os nós, o mesmo verifique se já existe um canal prévio, caso já exista, coloque a informação na lista do nó que deve receber a mesma. Caso contrário, repita os passos do item 2. (O nó que manda a mensagem deve ter a mesma em sua lista de mensagens de qualquer jeito)
  
  b) Modifique o método ```decrypt_messages``` para que o mesmo desencripte todas as mensagens recebidas por um nó com sua chave privada

  c) Rode o arquivo Test.py e verifique se o terceiro, quarto e quinto testes passaram!

4. Passando informações encriptadas utilizando "pontes" entre os nós
  
  a) Agora sim vamos criar um primeiro modelo bem simplificado para exemplificar o funcionamento das lightning networks. Modifique a função ```pass_message``` para que a mesma após checar se um nó já tem um canal com o nó que se deseja passar uma mensagem, verifica se sua conexão tem um canal com o nó de interesse. (Assuma que existam 3 nós na rede, por exemplo A,B,C. Neste caso, vamos imaginar que o nó A tem canal com o B, e o B tem canal com o C. Além disso, o A deseja mandar mensagem para o C. Faça com que isso aconteça por meio da conexão com B). Dica: Passar a informação por meio de B significa apenas guardar a informação em B e depois em C.
  
  b) Rode o arquivo Test.py e verifique se o sexto e sétimo testes passaram!


**Opcional:**

- [Material Complementar](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/Criptografia.md)
- [Entregável DH](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/DH.md)
- [Entregável RSA](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/RSA.md)
- [Entregável ECC](https://github.com/BlockchainInsper/Entregaveis/blob/master/MateriaisComplementares/ECC.md)
  - **Todos os exercícios estão acompanhados de respostas, portanto sua tarefa é criar um programa que chegue a esses resultados da maneira que achar mais conveniente**
  - Além disso, os exercícios assumem que você tenha um conhecimento prévio em álgebra modular, o qual pode ser adquirido através do Material Complementar. 
  - Também estão ordenados por ordem de dificuldade, sendo o Diffie-Hellman o mais fácil e as Curvas Elípticas o mais difícil

---

## Como fazer as entregas?

1. Faça um fork deste repositório
2. Clone o respositório que você fez o fork no seu computador
3. Faça o entregável e salve-o com a seguinte estrutura de pastas

```.
├── 2021.2
|   ├── Seu Nome
│   |   ├── Nome do Entregável
│   │   |   ├── Arquivos
└── MateriaisComplementares
```

4. Faça o commit para o repositório que fez o fork
5. Crie um pull-request para o repositório principal

6. Ficou com alguma dúvida? [Este link pode te ajudar](https://www.freecodecamp.org/news/how-to-make-your-first-pull-request-on-github-3/)
