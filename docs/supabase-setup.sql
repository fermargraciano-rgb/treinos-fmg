-- FMG Controle de treinos: estrutura no Supabase.
-- Todas as tabelas começam com fmg_ para não misturar com o que você já tem no projeto.
-- Cole TUDO isto em: Supabase > SQL Editor > New query > Run. Pode rodar mais de uma vez.

create table if not exists public.fmg_alunos (
  user_id   uuid   not null default auth.uid() references auth.users(id) on delete cascade,
  id        text   not null,
  nome      text   not null default '',
  dados     jsonb  not null default '{}'::jsonb,
  m         bigint not null default 0,            -- hora da última edição feita no aparelho (ms)
  apagado   boolean not null default false,
  srv       bigint not null default 0,            -- hora em que o servidor recebeu (usada para baixar só o novo)
  primary key (user_id, id)
);

create table if not exists public.fmg_config (
  user_id   uuid   primary key default auth.uid() references auth.users(id) on delete cascade,
  dados     jsonb  not null default '{}'::jsonb,   -- base de exercícios, pendências, passo de carga
  m         bigint not null default 0,
  srv       bigint not null default 0
);

create index if not exists fmg_alunos_srv_idx on public.fmg_alunos (user_id, srv);

-- Marca a hora do servidor e impede que um aparelho com dados velhos sobrescreva dados mais novos.
create or replace function public.fmg_carimbo() returns trigger language plpgsql as $$
begin
  if tg_op = 'UPDATE' and new.m < old.m then
    return null;                                   -- edição mais antiga: ignora
  end if;
  new.srv := (extract(epoch from clock_timestamp()) * 1000)::bigint;
  return new;
end $$;

drop trigger if exists fmg_alunos_carimbo on public.fmg_alunos;
create trigger fmg_alunos_carimbo before insert or update on public.fmg_alunos for each row execute function public.fmg_carimbo();
drop trigger if exists fmg_config_carimbo on public.fmg_config;
create trigger fmg_config_carimbo before insert or update on public.fmg_config for each row execute function public.fmg_carimbo();

-- Segurança: cada usuário só enxerga e altera as próprias linhas.
alter table public.fmg_alunos enable row level security;
alter table public.fmg_config enable row level security;

drop policy if exists "fmg_alunos_dono" on public.fmg_alunos;
create policy "fmg_alunos_dono" on public.fmg_alunos for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

drop policy if exists "fmg_config_dono" on public.fmg_config;
create policy "fmg_config_dono" on public.fmg_config for all to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Ninguém sem login (chave pública "anon") acessa nada.
revoke all on public.fmg_alunos from anon;
revoke all on public.fmg_config from anon;
grant select, insert, update, delete on public.fmg_alunos to authenticated;
grant select, insert, update, delete on public.fmg_config to authenticated;
