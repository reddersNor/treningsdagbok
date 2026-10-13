# Treningsdagbok

En treningsdagbok på nett. Alle kan lage sin egen konto og logge styrke-, kondisjons- og fotballøkter. Hver bruker ser bare sine egne økter.

- **Nettsiden** ligger gratis på GitHub Pages.
- **Innlogging og database** ligger gratis i Supabase.

## Filene

| Fil | Hva den gjør |
|---|---|
| `index.html` | Selve appen: innlogging, ny økt, historikk og oversikt |
| `config.js` | Adressen og nøkkelen til Supabase-prosjektet ditt |
| `supabase.sql` | Lager tabellen for økter og reglene for hvem som får se hva |

---

## Steg 1: Lag et Supabase-prosjekt

1. Gå til [supabase.com](https://supabase.com) og trykk **Start your project**. Logg inn med GitHub-kontoen din. Det er enklest.
2. Trykk **New project**.
3. Gi prosjektet et navn, for eksempel `treningsdagbok`.
4. Lag et database-passord og lagre det et trygt sted. Du trenger det ikke i appen.
5. Velg en region i Europa, for eksempel **Frankfurt** eller **Stockholm**.
6. Trykk **Create new project** og vent et par minutter.

## Steg 2: Lag databasetabellen

1. I Supabase, velg **SQL Editor** i menyen til venstre.
2. Åpne `supabase.sql` på PC-en, kopier alt, og lim det inn.
3. Trykk **Run**. Du skal se «Success. No rows returned».
4. Sjekk under **Table Editor** at tabellen `okter` finnes.

## Steg 3: Koble appen til Supabase

1. Trykk på **Connect** øverst i Supabase, eller gå til **Project Settings → API Keys**.
2. Kopier **Project URL**. Den ser slik ut: `https://abcdefgh.supabase.co`.
3. Kopier **Publishable key**. Den starter med `sb_publishable_`.
4. Åpne `config.js` i Notisblokk eller VS Code, og lim inn de to verdiene:

```js
window.TRENING_CONFIG = {
  supabaseUrl: "https://abcdefgh.supabase.co",
  supabaseKey: "sb_publishable_..."
};
```

> **Bruk aldri** «secret key» eller «service_role» her. De gir full tilgang til databasen. Publishable key er laget for å være offentlig.

## Steg 4: Legg appen på GitHub

1. Logg inn på [github.com](https://github.com) og lag en konto hvis du ikke har det.
2. Trykk **+** øverst til høyre og velg **New repository**.
3. Kall det `treningsdagbok`, velg **Public**, og trykk **Create repository**.
4. Trykk på lenken **uploading an existing file**.
5. Dra inn `index.html`, `config.js`, `supabase.sql` og `README.md`.
6. Trykk **Commit changes**.

## Steg 5: Slå på GitHub Pages

1. Gå til **Settings** i repoet, og velg **Pages** i menyen til venstre.
2. Under **Build and deployment**, velg **Deploy from a branch**.
3. Velg branch **main** og mappe **/ (root)**. Trykk **Save**.
4. Vent 1–2 minutter og last inn siden på nytt. Øverst står adressen, for eksempel `https://brukernavn.github.io/treningsdagbok/`.

## Steg 6: Fortell Supabase hvor appen ligger

Dette trengs for at lenkene i e-poster (bekreftelse og nytt passord) skal gå til appen din.

1. I Supabase, gå til **Authentication → URL Configuration**.
2. Sett **Site URL** til GitHub Pages-adressen din, for eksempel `https://brukernavn.github.io/treningsdagbok/`.
3. Under **Redirect URLs**, legg til den samme adressen.
4. Trykk **Save**.

## Steg 7: E-post (viktig)

Supabase sin innebygde e-posttjeneste er bare for testing. Den sender **bare til e-postadressene til teammedlemmene i Supabase-prosjektet** og har en lav grense per time. Vanlige brukere får derfor ikke bekreftelses-e-posten. Du har to valg:

**A. Enklest for å komme i gang:** Slå av e-postbekreftelse.
Gå til **Authentication → Sign In / Providers → Email**, slå av **Confirm email**, og lagre. Da kommer nye brukere rett inn etter at de har laget konto. «Glemt passord» virker fortsatt bare for teammedlemmer.

**B. Når flere skal bruke appen:** Koble til en egen e-posttjeneste.
Lag en gratis konto hos for eksempel [Resend](https://resend.com) eller [Brevo](https://www.brevo.com). Legg inn SMTP-opplysningene deres under **Authentication → Emails → SMTP Settings** i Supabase. Da kan du slå bekreftelse på igjen, og «Glemt passord» virker for alle.

## Steg 8: Test

1. Åpne GitHub Pages-adressen.
2. Trykk **Lag konto** og registrer deg.
3. Logg en økt og sjekk at den dukker opp under **Historikk**.
4. I Supabase, under **Table Editor → okter**, ser du økta som en rad.
5. Lag gjerne en konto til med en annen e-post og sjekk at den ikke ser den første brukerens økter.

---

## Gjøre endringer senere

1. Endre filen på PC-en.
2. Gå til repoet på GitHub, trykk **Add file → Upload files**, og dra inn den endrede filen.
3. Trykk **Commit changes**. Etter et minutt er nettsiden oppdatert.

## Hvis noe ikke virker

| Problem | Løsning |
|---|---|
| Siden sier «Nesten klar» | `config.js` mangler URL eller nøkkel, eller filen er ikke lastet opp til GitHub |
| «Feil e-post eller passord» | Sjekk at du har laget konto. Har du bekreftelse på, må du klikke lenken i e-posten først |
| Ingen bekreftelses-e-post | Se steg 7 |
| «Kunne ikke lagre» eller «Kunne ikke hente» | Sjekk at du kjørte `supabase.sql` i steg 2 |
| E-postlenken går til feil side | Sjekk Site URL og Redirect URLs i steg 6 |
| Siden er tom på GitHub | Vent et par minutter etter steg 5, og sjekk at `index.html` ligger øverst i repoet |
| Supabase-prosjektet er satt på pause | Gratisprosjekter pauses etter en tids inaktivitet. Trykk **Restore** i Supabase |
