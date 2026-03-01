-- Enable necessary extensions
create extension if not exists "uuid-ossp";

-- PROFILES TABLE (Public user data)
create table public.profiles (
  id uuid references auth.users on delete cascade not null primary key,
  email text,
  full_name text,
  avatar_url text,
  updated_at timestamptz default now()
);

alter table public.profiles enable row level security;

create policy "Public profiles are viewable by everyone."
  on profiles for select
  using ( true );

create policy "Users can insert their own profile."
  on profiles for insert
  with check ( auth.uid() = id );

create policy "Users can update own profile."
  on profiles for update
  using ( auth.uid() = id );

-- CARTS TABLE (Shopping History & Active Carts)
create table public.carts (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users not null,
  name text, -- Friendly name e.g. "Grocery Run"
  status text default 'active', -- 'active', 'completed', 'saved'
  store_name text,
  total_amount numeric default 0,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.carts enable row level security;

create policy "Users can view own carts."
  on carts for select
  using ( auth.uid() = user_id );

create policy "Users can insert own carts."
  on carts for insert
  with check ( auth.uid() = user_id );

create policy "Users can update own carts."
  on carts for update
  using ( auth.uid() = user_id );

create policy "Users can delete own carts."
  on carts for delete
  using ( auth.uid() = user_id );

-- CART ITEMS TABLE (Items within a cart)
create table public.cart_items (
  id uuid default uuid_generate_v4() primary key,
  cart_id uuid references public.carts on delete cascade not null,
  item_name text not null,
  category text, -- For Analytics e.g. "Groceries", "Tech"
  price numeric not null,
  quantity integer not null default 1,
  created_at timestamptz default now()
);

alter table public.cart_items enable row level security;

create policy "Users can view own cart items."
  on cart_items for select
  using (
    exists (
      select 1 from public.carts
      where carts.id = cart_items.cart_id
      and carts.user_id = auth.uid()
    )
  );

create policy "Users can insert own cart items."
  on cart_items for insert
  with check (
    exists (
      select 1 from public.carts
      where carts.id = cart_items.cart_id
      and carts.user_id = auth.uid()
    )
  );

create policy "Users can update own cart items."
  on cart_items for update
  using (
    exists (
      select 1 from public.carts
      where carts.id = cart_items.cart_id
      and carts.user_id = auth.uid()
    )
  );

create policy "Users can delete own cart items."
  on cart_items for delete
  using (
    exists (
      select 1 from public.carts
      where carts.id = cart_items.cart_id
      and carts.user_id = auth.uid()
    )
  );
  
-- SHOPPING LISTS TABLE
create table public.shopping_lists (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users not null,
  name text not null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.shopping_lists enable row level security;

create policy "Users can view own shopping lists."
  on shopping_lists for select
  using ( auth.uid() = user_id );

create policy "Users can insert own shopping lists."
  on shopping_lists for insert
  with check ( auth.uid() = user_id );

create policy "Users can update own shopping lists."
  on shopping_lists for update
  using ( auth.uid() = user_id );

create policy "Users can delete own shopping lists."
  on shopping_lists for delete
  using ( auth.uid() = user_id );

-- SHOPPING LIST ITEMS TABLE
create table public.shopping_list_items (
  id uuid default uuid_generate_v4() primary key,
  list_id uuid references public.shopping_lists on delete cascade not null,
  name text not null,
  category text,
  quantity integer default 1,
  is_checked boolean default false,
  created_at timestamptz default now()
);

alter table public.shopping_list_items enable row level security;

create policy "Users can view own list items."
  on shopping_list_items for select
  using (
    exists (
      select 1 from public.shopping_lists
      where shopping_lists.id = shopping_list_items.list_id
      and shopping_lists.user_id = auth.uid()
    )
  );

create policy "Users can manage own list items."
  on shopping_list_items for all
  using (
    exists (
      select 1 from public.shopping_lists
      where shopping_lists.id = shopping_list_items.list_id
      and shopping_lists.user_id = auth.uid()
    )
  );

-- BUDGETS TABLE (Future-proofing for cloud sync)
create table public.budgets (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users not null,
  monthly_amount numeric default 0,
  currency text default 'JMD',
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.budgets enable row level security;

create policy "Users can view own budgets."
  on budgets for select
  using ( auth.uid() = user_id );

create policy "Users can insert own budgets."
  on budgets for insert
  with check ( auth.uid() = user_id );

create policy "Users can update own budgets."
  on budgets for update
  using ( auth.uid() = user_id );

-- FUNCTIONS & TRIGGERS

-- Function to handle new user signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, full_name, avatar_url)
  values (new.id, new.email, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  return new;
end;
$$ language plpgsql security definer;

-- Trigger to create profile on signup
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Function to update updated_at timestamp
create or replace function handle_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- Triggers for updated_at
create trigger handle_updated_at_profiles
  before update on public.profiles
  for each row execute procedure handle_updated_at();

create trigger handle_updated_at_carts
  before update on public.carts
  for each row execute procedure handle_updated_at();

create trigger handle_updated_at_budgets
  before update on public.budgets
  for each row execute procedure handle_updated_at();

create trigger handle_updated_at_shopping_lists
  before update on public.shopping_lists
  for each row execute procedure handle_updated_at();
