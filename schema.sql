-- FreightCRM v4 — Supabase Schema
-- Запустить: Supabase → SQL Editor → New Query → Run

create table if not exists employees (
  id uuid default gen_random_uuid() primary key,
  name text not null, role text, dept text,
  email text unique, phone text, salary text,
  status text default 'Active', loads int default 0,
  revenue text default '$0', hired date default now(),
  avatar text, created_at timestamp default now()
);

create table if not exists carriers (
  id uuid default gen_random_uuid() primary key,
  name text not null, mc text, dot text,
  contact text, phone text, email text, city text,
  lanes text, equipment text, status text default 'Active',
  rating numeric default 5.0, loads int default 0,
  pay_method text default 'Standard 30',
  factoring_co text, factoring_fee text,
  w9 boolean default false, insurance text default '$1M',
  bank_name text, routing text, account text,
  created_at timestamp default now()
);

create table if not exists loads (
  id text primary key, type text default 'FTL',
  origin text, dest text, pickup text, delivery text,
  commodity text, weight text, dims text, pallets int,
  freight_class text, rate numeric default 0,
  margin numeric default 0, miles int default 0,
  equipment text default 'Dry Van',
  status text default 'Available',
  carrier text, shipper text, broker text,
  notes text, photos jsonb default '[]',
  created_at timestamp default now()
);

create table if not exists accounting (
  id uuid default gen_random_uuid() primary key,
  type text, description text, amount numeric default 0,
  status text default 'Pending', date text,
  due_date text, invoice_num text,
  created_at timestamp default now()
);

create table if not exists pipeline (
  id uuid default gen_random_uuid() primary key,
  company text, contact text, stage text default 'prospect',
  value text, probability int default 20,
  broker text, notes text, last_touch text,
  created_at timestamp default now()
);

create table if not exists messages (
  id uuid default gen_random_uuid() primary key,
  contact_id text, contact_name text, company text,
  from_type text, text text, time text, agent_name text,
  created_at timestamp default now()
);

create table if not exists tasks (
  id uuid default gen_random_uuid() primary key,
  title text, due text, priority text default 'Medium',
  related text, done boolean default false,
  created_at timestamp default now()
);

-- Row Level Security
alter table employees enable row level security;
alter table carriers enable row level security;
alter table loads enable row level security;
alter table accounting enable row level security;
alter table pipeline enable row level security;
alter table messages enable row level security;
alter table tasks enable row level security;

create policy "auth_only" on employees for all using (auth.role() = 'authenticated');
create policy "auth_only" on carriers for all using (auth.role() = 'authenticated');
create policy "auth_only" on loads for all using (auth.role() = 'authenticated');
create policy "auth_only" on accounting for all using (auth.role() = 'authenticated');
create policy "auth_only" on pipeline for all using (auth.role() = 'authenticated');
create policy "auth_only" on messages for all using (auth.role() = 'authenticated');
create policy "auth_only" on tasks for all using (auth.role() = 'authenticated');
