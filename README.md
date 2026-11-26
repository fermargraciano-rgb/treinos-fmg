# Controle de treinos · FMG Personal Trainer

App simples para o personal controlar os treinos dos alunos, no celular ou no computador.
Funciona direto no navegador, sem servidor e sem cadastro em nenhum serviço.

- Treino do dia em uma tela só: séries, reps, carga, método e observação.
- Salva a cada toque; o treino em andamento não se perde se o celular bloquear.
- Histórico, evolução, RPE e 1RM estimado.
- Academias diferentes (máquina muda, peso livre não), casais, bi-sets.
- Importa treinos por texto colado ou por arquivo.
- Acesso protegido por usuário e senha, com Face ID opcional no iPhone.

## Onde ficam os dados dos alunos

No seu **Supabase** (online, protegido por login) e, para uso sem internet, em uma cópia no aparelho dos alunos que você escolher. Também funciona 100% local, sem nuvem.
Este repositório contém só o código do app, **sem nenhum dado de aluno e sem chaves**. Veja o guia completo em [`docs/PASSO-A-PASSO.md`](docs/PASSO-A-PASSO.md) e o SQL em [`docs/supabase-setup.sql`](docs/supabase-setup.sql).

O backup em arquivo continua útil: em **Exercícios e ajustes → Exportar tudo (backup em arquivo)** gere um arquivo e guarde no Drive ou no iCloud.
Se limpar os dados do navegador ou trocar de celular, use **Restaurar backup de arquivo**.

> Nunca coloque arquivos de backup ou de alunos neste repositório. O `.gitignore` já bloqueia os nomes mais comuns, e a pasta `privado/` fica só no seu computador.

## Publicar no GitHub Pages (passo a passo)

1. No GitHub, crie um repositório novo (por exemplo `treinos`).
2. Envie todos os arquivos desta pasta (`index.html`, `manifest.webmanifest`, `sw.js`, `icons/`, `docs/`, `README.md`, `.gitignore`) para a raiz do repositório.
3. Vá em **Settings → Pages**. Em *Build and deployment*, escolha **Deploy from a branch**, branch `main`, pasta `/ (root)`, e salve.
4. Em um ou dois minutos o app abre em `https://SEU-USUARIO.github.io/NOME-DO-REPOSITORIO/`.

Para atualizar o app depois, basta substituir o `index.html` no repositório (e aumentar o número em `VERSAO` dentro de `sw.js`).

## Instalar no iPhone (como aplicativo)

1. Abra o endereço acima no **Safari**.
2. Toque em **Compartilhar → Adicionar à Tela de Início**.
3. Abra pelo ícone novo. No primeiro acesso, crie **usuário e senha** e **anote o código de recuperação** que aparece.
4. Quando o app oferecer, ative o **Face ID**. Ele exige endereço `https` (o GitHub Pages já é).

Atenção: o app instalado na tela de início e o Safari guardam dados **separados**. Escolha um (recomendado: o instalado) e restaure o backup nele.

## Sobre a segurança (leia)

- O usuário e a senha ficam guardados **no aparelho**, apenas como *hash* (nunca em texto). O código do app é público, e a senha não está nele.
- É uma proteção contra uso casual (alguém pegar o celular desbloqueado ou abrir o app). **Não é segurança de banco de dados**: quem tiver acesso técnico ao navegador do aparelho consegue ver os dados armazenados.
- O Face ID funciona como atalho de desbloqueio depois de criar a senha; a senha continua valendo.
- Esqueceu a senha: use o **código de recuperação**. Sem ele, só apagando os dados do site (o que apaga os alunos; por isso o backup).

## Formato de importação

Veja [`docs/formato-importacao.md`](docs/formato-importacao.md) e o exemplo em [`docs/exemplo-importacao.json`](docs/exemplo-importacao.json).
