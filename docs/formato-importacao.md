# Formato de importação de treino (treinos-v1)

O app importa um arquivo **.json** para um **aluno que já existe**: aluno → aba **Treinos** → **⬆ Importar treino (arquivo)**.
Antes de salvar, o app mostra uma tela de revisão editável. Campos que não ficaram claros aparecem em **laranja**.
Exemplo completo: `exemplo-importacao.json` (mesma pasta).

## Estrutura

```json
{
  "formato": "treinos-v1",
  "programa": "Hipertrofia fase 2",
  "unidade": "Academia Central",
  "treinos": [
    {
      "nome": "Treino A - Peito, ombros e tríceps",
      "exercicios": [
        { "nome": "Supino reto", "grupo": "Peito", "series": 4, "reps": "8-10",
          "carga": 60, "metodo": "Tradicional", "descanso": 120, "obs": "Descer em 2s" }
      ]
    }
  ]
}
```

## Campos

| Campo | Onde | Obrigatório | Regra |
|---|---|---|---|
| `formato` | raiz | não | use `"treinos-v1"` |
| `programa` | raiz | não | Nome do programa (ex.: "Hipertrofia fase 2"). Se vier, o app oferece criar um programa novo com esse nome (arquivando o atual). Se não vier, os treinos entram no programa atual. |
| `unidade` | raiz | não | Nome da academia do aluno, igual ao cadastrado (sem diferenciar maiúsculas). Se não vier ou não existir, usa a unidade selecionada no aluno. |
| `treinos` | raiz | **sim** | Lista, na ordem em que serão feitos (A, B, C...). |
| `nome` | treino | sim | Ex.: "Treino A - Peito e tríceps". |
| `exercicios` | treino | **sim** | Lista, na ordem de execução. |
| `nome` | exercício | **sim** | Nome do exercício. Se já existir na biblioteca (sem diferenciar acentos/maiúsculas), o grupo é completado sozinho. |
| `grupo` | exercício | não (opcional; o app não pede mais o grupo) | Um destes: `Peito`, `Costas`, `Ombros`, `Bíceps`, `Tríceps`, `Quadríceps`, `Posterior de coxa`, `Glúteos`, `Panturrilha`, `Abdômen`, `Core`, `Mobilidade`. Aceita também sem acento. Outro valor fica em laranja na revisão. |
| `series` | exercício | **sim** | Número inteiro. |
| `reps` | exercício | **sim** | **Texto**: `"10"`, `"8-10"`, `"12/10/8"` (pirâmide), `"falha"`. |
| `carga` | exercício | não | Número em kg, com ponto decimal (`22.5`). Sem carga definida: `0`. |
| `tempo` | exercício | não | `true` para exercício medido em **segundos** (prancha, isometria, elíptico): então `reps` é o tempo, ex. `"30"`. Também aceita `"medida": "tempo"`. Se omitido, o app reconhece sozinho nomes como prancha, isometria e elíptico. |
| `metodo` | exercício | não | Texto livre. Padrão do app: `Tradicional`, `Drop set`, `Rest-pause`, `Bi-set`, `Pirâmide`, `Cluster`, `Isometria`, `Negativa`. Se faltar, vira `Tradicional`. |
| `descanso` | exercício | não | **Segundos**, como número (`90`). Também aceita `"1:30"` ou `"1min30"`. Se faltar, vira 90. |
| `obs` | exercício | não | Observação curta do exercício. |

## Regras para gerar o arquivo a partir de um treino colado

- Mobilidade e core do treino entram como exercícios normais, com `grupo` `"Mobilidade"` ou `"Core"`, **antes** da lista principal (na ordem em que aparecem no texto).
- Item de mobilidade/core que o texto repete ("igual ao Upper A") deve ser escrito por extenso em cada treino.
- Bi-set: dois exercícios seguidos, ambos com `metodo: "Bi-set"` e o par citado em `obs`.
- "X ou Y": um exercício só, com os dois no nome ou na `obs` (a escolha é feita no dia).
- Um treino por divisão (A, B, C...). Mantenha a ordem dos exercícios do texto original.
- `reps` sempre entre aspas (texto). `series`, `carga` e `descanso` são números, sem unidade.
- Não invente: se o texto não trouxer carga, use `0`; sem descanso, omita o campo; sem método, omita.
- Texto solto sobre o exercício (cuidados, tempo de execução) vai em `obs`.
- Exercício em bi-set com outro: `metodo: "Bi-set"` e cite o par em `obs`.
- O arquivo deve ser JSON válido (aspas duplas, sem vírgula sobrando no fim, sem comentários).
- Se houver dúvida sobre grupo, série ou reps, deixe o campo fora ou vazio: o app marca em laranja para o personal corrigir.

## O que o app faz ao salvar

- Treino com o mesmo nome já existente na unidade: pergunta se **adiciona como novo** ou **substitui**.
- Se o aluno tiver mais de uma unidade, pergunta em quais outras aplicar (copia com as cargas).
- Exercícios novos entram na biblioteca do app.

---

# Base de exercícios (lista do Fernando)

A base é a lista de exercícios que aparece ao montar um treino (com busca) e que define o grupo muscular de cada nome.
No app: **Início → Exercícios e ajustes → Importar lista de exercícios**. Dá para colar o texto ou escolher um arquivo `.txt`/`.json`.
Dois botões: **Adicionar à base** (mantém o que já existe, ignora repetidos) e **Substituir a base** (pede confirmação; treinos já montados não mudam).

## Formato texto (um exercício por linha)

```
Peito:
Supino reto
Supino inclinado com halteres
Crossover

Costas:
- Puxada frontal
- Remada baixa

Agachamento sumo ; Glúteos
```

- Um título de grupo (`Peito:`) vale para as linhas seguintes, até o próximo título.
- Também vale `Nome ; Grupo` (ou `Nome | Grupo`) em cada linha, que tem prioridade sobre o título.
- Marcadores (`-`, `•`, `1.`) são ignorados.
- Grupos aceitos: Peito, Costas, Ombros, Bíceps, Tríceps, Quadríceps, Posterior de coxa, Glúteos, Panturrilha, Abdômen, Core, Mobilidade (sem acento também).
- Linha sem grupo reconhecido **não é importada**: o app lista essas linhas no aviso final para você corrigir.

## Formato JSON

```json
{ "exercicios": [
  { "nome": "Supino reto", "grupo": "Peito" },
  { "nome": "Hack", "grupo": "Quadríceps" },
  { "nome": "Prancha", "grupo": "Core", "tempo": true }
] }
```

---

## Importar por texto colado (sem JSON)

Na tela inicial: **Colar treino (texto)**. Na ficha do aluno, aba Treinos: **Colar treino (texto)**. O app lê o texto, mostra tudo para conferir (com avisos do que não ficou claro) e só salva depois do seu OK.

```
Maria Souza - Academia Centro        ← 1ª linha: Aluno - Academia (sem academia = "Academia")

Treino A - Lower A                     ← "Treino X" abre um treino (título solto com ":" também, ex.: "Lower B:")
Hack Machine - 4x 8-12: 65 kg          ← Nome - séries x reps: carga
Elevacao pelvica: 4x 15 - 100kg - Metodo: Drop: 15 (-10)/12 (-10)/10
Cadeira flexora: 4x 12 : 72,5kg (Pode ser Mesa flexora: 45kg, 4x12)   ← alternativa vira substituto salvo
Cadeira Extensora: 4x12 - 52,5kg (metodo unilateral)

Biset                                  ← vale para os 2 exercícios seguintes
Supino Maquina: 4x12 : 27,5kg
Rosca martelo: 4x12 - 7kg
Facepull: 3x12 - 16.25 + .625kg        ← carga somada (16,875) e anotada na observação
```

- Método: `Drop`, `Rest-pause`, `Pirâmide`, `Isometria`, `Unilateral`, etc., dentro de parênteses ou depois de `Metodo:`. O que sobrar (ex.: "20 s") vai para a observação.
- Tempo: `3x30s` ou `3x30 seg` marca o exercício por tempo.
- Nomes parecidos com a sua base são ligados ao nome da base (aviso na revisão). Nome desconhecido entra como exercício novo.
- Sem séries/reps: dentro de um bi-set copia do par; fora, fica em laranja para você preencher.
