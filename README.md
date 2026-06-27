# 🌍 ExoticTravel — PWA

Persoonlijke reisapp als Progressive Web App. Draait in je browser, werkt als app op je iPhone thuisscherm. Alleen een **Supabase account** en een **GitHub account** nodig.

---

## 🚀 In 4 stappen live

### Stap 1 — Supabase instellen

1. Ga naar [supabase.com](https://supabase.com) → maak een gratis project
2. Ga naar **SQL Editor** → plak de inhoud van `schema.sql` → klik **Run**
3. Ga naar **Project Settings → API** en kopieer:
   - **Project URL** (bijv. `https://abcdefgh.supabase.co`)
   - **anon / public key**
4. Open `index.html` en vervang bovenaan:
   ```js
   const SUPA_URL = 'https://JOUW_PROJECT_ID.supabase.co';
   const SUPA_KEY = 'JOUW_ANON_KEY';
   ```

### Stap 2 — GitHub repo aanmaken

1. Maak een nieuwe **public** repository op GitHub (bijv. `exotic-travel`)
2. Upload alle bestanden uit deze map naar de repo (of gebruik `git push`)

### Stap 3 — GitHub Pages inschakelen

1. Ga in je repo naar **Settings → Pages**
2. Onder **Source**: kies **GitHub Actions**
3. De eerste deployment start automatisch na je push
4. Je app is live op: `https://JOUW_GEBRUIKERSNAAM.github.io/exotic-travel/`

### Stap 4 — Installeren op iPhone

1. Open de URL in **Safari** op je iPhone
2. Tik op het **Delen** icoon (vierkant met pijl omhoog)
3. Kies **Zet op beginscherm**
4. De app staat nu als icoon op je thuisscherm en werkt volledig offline-capabel

---

## 📱 Hoe werkt de JSON import?

Vraag Claude om een bezienswaardigheid te beschrijven in dit formaat:

> *"Zoek informatie over [naam bezienswaardigheid] en genereer een JSON bestand in dit formaat: naam, categorie, stad, land, lat, lng, beschrijving, tips (array), labels (array), beste_periode. Alleen de JSON, geen extra tekst."*

Sla het JSON bestand op in **iCloud Drive** of **Bestanden** op je iPhone.

Open de app → tik op je reis → **JSON importeren** → kies het bestand.

**Voorbeeld JSON:**
```json
{
  "naam": "Himeji Castle",
  "categorie": "Kasteel",
  "stad": "Himeji",
  "land": "Japan",
  "lat": 34.8394,
  "lng": 134.6939,
  "beschrijving": "Het best bewaarde feodale kasteel van Japan, gebouwd in 1333.",
  "tips": ["Kom vroeg in de ochtend", "April voor kersenbloesem"],
  "labels": ["UNESCO", "Must-see"],
  "beste_periode": "April–mei"
}
```

Je kunt ook een **array** van meerdere bezienswaardigheden importeren in één bestand.

---

## 📁 Bestanden

```
exotic-travel/
├── index.html          ← De volledige app (één bestand)
├── manifest.json       ← PWA configuratie voor iPhone thuisscherm
├── schema.sql          ← Supabase database schema
├── icon.png            ← App icoon (voeg zelf toe, 180×180px)
└── .github/
    └── workflows/
        └── deploy.yml  ← Automatische GitHub Pages deployment
```

---

## 🔒 Privacy & beveiliging

- Anonieme login bij eerste gebruik — geen account aanmaken nodig
- Elke gebruiker ziet alleen zijn eigen data (Row Level Security in Supabase)
- Data staat in jouw eigen Supabase project, nergens anders
