# Passo a passo: Supabase + GitHub + usar no iPhone e no computador

Você já tem conta e projetos no Supabase e no GitHub. Este guia usa o que você já tem **sem mexer no que já existe**.

**Como funciona, em uma frase:** os dados de todos os alunos ficam guardados na sua conta do Supabase (online). O app, que fica no GitHub, só mostra e edita. Cada aparelho guarda no próprio celular uma cópia dos alunos que você escolher, para usar sem internet, e tudo se acerta sozinho quando a internet volta.

> O GitHub guarda só o **programa**. Nenhum dado de aluno vai para o GitHub.

---

## Parte 1 · Supabase (o banco de dados online)

### 1.1 Escolher o projeto (sem bagunçar o que já existe)

- **Recomendado: usar um projeto que você já tem.** O plano gratuito permite 2 projetos ativos, e assim você não gasta uma vaga. As tabelas deste app começam com `fmg_`, então não se misturam com as do seu app de relatórios. Seus dados antigos não são tocados.
- **Se preferir separar tudo:** crie um projeto novo (botão **New project**). Dá o mesmo resultado, só usa uma vaga do gratuito.

Aviso do plano gratuito: o Supabase **pausa projetos sem nenhum acesso por 7 dias**. Usando o app toda semana, isso não acontece. Se pausar, é só clicar em *Restore* no painel e os dados voltam.

### 1.2 Criar as tabelas

1. Abra o projeto escolhido no painel do Supabase.
2. No menu lateral, clique em **SQL Editor** e depois em **New query**.
3. Abra o arquivo `docs/supabase-setup.sql` (está no pacote do app), copie **tudo** e cole na janela.
4. Clique em **Run**. Deve aparecer *Success. No rows returned*. Pode rodar de novo sem problema.

Isso cria as tabelas `fmg_alunos` e `fmg_config` e a regra de segurança: **cada usuário só enxerga as próprias linhas**, e quem não fez login não acessa nada.

### 1.3 Criar o seu login do app

- **Se você já tem um usuário** (o mesmo e-mail do seu app de relatórios), pode usá-lo e pular este passo.
- Para criar um usuário só para o app: **Authentication → Users → Add user → Create new user**. Escreva e-mail e senha, e marque **Auto Confirm User**. Anote os dois.

> Se o seu app de relatórios deixa novas pessoas se cadastrarem, não desligue isso. Mesmo assim os dados dos seus alunos ficam protegidos: quem se cadastrar só vê as próprias linhas, que estarão vazias.

### 1.4 Copiar os dois dados que o app pede

Vá em **Project Settings → API** (em versões novas pode aparecer como **API Keys**) e copie:

1. **Project URL**, algo como `https://abcdxyz.supabase.co`.
2. A chave pública, chamada **anon public** (ou **Publishable key**, que começa com `sb_publishable_`).

**Nunca copie** a chave `service_role` (ou *secret*). Ela dá acesso total e não deve entrar em lugar nenhum do app. A chave pública é feita para ficar no aparelho e é segura porque quem protege os dados é a regra do passo 1.2.

---

## Parte 2 · GitHub (onde o app fica publicado)

Você já tem conta e outros repositórios. Vamos criar um **repositório novo** para o app.

1. Em github.com, clique no **+** (canto superior direito) → **New repository**.
2. Nome: `treinos` (se já existir um com esse nome, use `treinos-fmg`). Marque **Public**. Não marque README. Clique em **Create repository**.
3. **Descompacte** o `treinos-para-github.zip` no computador.
4. Na página do repositório novo, clique em **uploading an existing file**. Arraste **o conteúdo da pasta descompactada** (os arquivos `index.html`, `sw.js`, `manifest.webmanifest`, `README.md` e as pastas `icons` e `docs`), não o zip. Role a página e clique em **Commit changes**.
5. Vá em **Settings → Pages**. Em *Build and deployment*, escolha **Deploy from a branch**, branch `main`, pasta `/ (root)` e **Save**.
6. Espere 1 a 2 minutos e atualize. O endereço do app aparece no topo: `https://SEU-USUARIO.github.io/treinos/`.

Não suba os arquivos de dados privados (o zip `dados-privados-NAO-SUBIR-NO-GITHUB`).

**Um cuidado:** todos os sites que você publica no GitHub Pages da mesma conta compartilham o mesmo "endereço-base" (`SEU-USUARIO.github.io`), e o navegador permite que uma página leia as informações guardadas por outra desse mesmo endereço. Como o seu outro app é seu e não usa scripts de terceiros, o risco é baixo. Se algum dia colocar algo de terceiros nessa conta, use outra conta do GitHub ou um domínio próprio para o app de treinos.

---

## Parte 3 · Primeiro uso

### 3.1 No computador (Firefox), onde estão seus dados hoje

1. No app **atual** (onde estão seus alunos), vá em **Exercícios e ajustes → Exportar tudo (backup em arquivo)**. Guarde o arquivo. *(Se você ainda não usou o app para valer, pode usar o `dados-completos-backup.json` do zip de dados privados.)*
2. Abra o endereço novo do GitHub Pages. Na primeira tela, escolha **Usar só neste aparelho**, crie um usuário e senha e **anote o código de recuperação**.
3. Vá em **Exercícios e ajustes → Restaurar backup de arquivo** e escolha o arquivo do passo 1.
4. Ainda em **Exercícios e ajustes**, na caixa **Nuvem e modo offline**, toque em **Conectar ao servidor**. Cole o **Project URL**, a **chave pública**, o **e-mail** e a **senha** do passo 1.3 da Parte 1. Toque em **Conectar**.
5. O app sobe tudo. O indicador no topo vira **☁ ✓** quando terminar.

A partir daí o seu login passa a ser o e-mail e a senha da nuvem, e o app também funciona sem internet com o que já está no aparelho.

### 3.2 No iPhone

1. Abra o endereço do app no **Safari**.
2. Toque em **Compartilhar → Adicionar à Tela de Início**, e abra pelo ícone novo.
3. Na primeira tela, escolha **Entrar com minha conta (nuvem)**. Cole o Project URL, a chave pública, o e-mail e a senha. *(Dica: mande o endereço e a chave para o celular por AirDrop ou Notas.)*
4. Quando o app oferecer, ative o **Face ID**.
5. Em **Exercícios e ajustes → Nuvem e modo offline → Escolher alunos para usar sem internet**, marque os alunos que você quer ter sempre no celular.

### 3.3 Como funciona o modo offline

- Os alunos **marcados** ficam salvos no celular e funcionam sem internet: abrir treino, marcar séries, finalizar.
- Os **não marcados** aparecem na lista com ☁. Ao tocar, o app pergunta se quer baixar para o celular, e isso precisa de internet.
- O indicador no topo mostra o estado: **☁ ✓** tudo enviado · **☁ ↻** sincronizando · **☁ offline** sem internet (o que você fizer fica no aparelho e sobe sozinho depois) · **☁ ⚠** erro (toque para tentar de novo) · **☁ entrar** é preciso entrar de novo.
- **Antes de ir a um lugar sem sinal:** abra o app com internet, espere ☁ ✓ e confirme que os alunos do dia estão marcados.
- Se o computador e o celular mudarem o mesmo aluno ao mesmo tempo, o app junta os treinos feitos nos dois. Para a ficha (cargas, exercícios), vale a edição mais recente.

---

## Segurança, em linguagem simples

- A senha **não** fica guardada em texto: o servidor guarda de forma protegida, e o aparelho guarda só um código embaralhado dela, para conseguir entrar sem internet.
- Os alunos só aparecem para quem entrar com o seu e-mail e senha.
- O Face ID é um atalho para não digitar a senha no iPhone. Ele só liga em endereço seguro (https), como o do GitHub Pages.
- O app bloqueia sozinho depois de um tempo fora e depois de 5 tentativas erradas. Você ajusta o tempo em **Exercícios e ajustes**.
- Se esquecer a senha: no Supabase, **Authentication → Users**, clique no seu usuário e defina uma senha nova. Depois entre no app com internet.
- **Backup:** continue exportando um arquivo de vez em quando (Exercícios e ajustes → Exportar tudo). O backup do app inclui só os alunos salvos no aparelho.

## Se algo der errado

| O que aparece | O que fazer |
|---|---|
| "E-mail ou senha incorretos" ao conectar | Confira o e-mail e a senha do Supabase (Authentication → Users). |
| "O servidor recusou" | Confira o Project URL (começa com `https://`) e a chave pública (sem espaço sobrando). |
| ☁ ⚠ e a mensagem fala em tabela ou permissão | Rode o `supabase-setup.sql` de novo (Parte 1.2) no projeto certo. |
| ☁ entrar | A sessão venceu. Bloqueie e entre de novo, com internet. |
| Projeto pausado | No painel do Supabase, clique em **Restore**. |
| Aluno aparece com ☁ e eu preciso dele sem internet | Com internet, toque no aluno e baixe, ou marque em *Escolher alunos para usar sem internet*. |
