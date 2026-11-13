# Campus Spoor Kanban

Kanbanbord (TODO → DOING → DONE) voor de backlog uit *Waar knelt het schoentje?* — website Campus Het Spoor.

## Live site link = https://walter-white-the-creator.github.io/campus-spoor-kanban/?room=spoor

**Groepslink (deel met je team):**

https://walter-white-the-creator.github.io/campus-spoor-kanban/?room=spoor

Iedereen die dezelfde link opent (zelfde `room=…`) ziet hetzelfde bord. Verplaats je een kaart, dan verschijnt die bij de anderen binnen enkele seconden.

- **Kopieer link** — knop bovenaan op het bord  
- **Andere kamer** — wijzig de kamercode (bijv. `team7`) en stuur die nieuwe link door  

### Kortere URL (optioneel)

Op GitHub: **Settings → Pages → Custom domain** kun je een eigen domein koppelen (bijv. `kanban.jouwschool.be`), zodat je geen lange `github.io`-link meer nodig hebt.

## Inloggen en goedkeuring

- Iedereen krijgt eerst het **inlogscherm**; het bord is pas zichtbaar na inloggen.
- **Deelnemer**: vult zijn naam in en komt in de wachtruimte tot de beheerder op **Toelaten** klikt. Geweigerd? Dan krijgt die persoon een melding en kan hij opnieuw aanvragen.
- Een goedgekeurd toestel wordt onthouden (per kamer), maar moet wel telkens via het inlogscherm.
- **Beheerder**: kies het tabblad *Beheerder* en vul het beheerderswachtwoord in. Je slaat de wachtruimte over en ziet bovenaan de nieuwe aanvragen.
- Goedkeuren werkt alleen als de beheerder en de deelnemer tegelijk verbonden zijn via een werkende sync (Firebase of een signaalserver, zie hieronder).

### Beheerderswachtwoord wijzigen

In de code staat alleen de SHA-256-hash van het wachtwoord. Nieuwe hash maken (in de browserconsole):

```js
crypto.subtle.digest("SHA-256", new TextEncoder().encode("NIEUW_WACHTWOORD"))
  .then(b => console.log([...new Uint8Array(b)].map(x => x.toString(16).padStart(2, "0")).join("")))
```

Plak de uitkomst in `ADMIN_PASSWORD_HASH` in `index.html`.

> Let op: dit is een statische site zonder eigen server. Alle controles gebeuren in de browser, dus iemand met technische kennis kan ze omzeilen. Voor echte beveiliging is een backend met authenticatie nodig (bijv. Firebase Auth of Supabase Auth met databaseregels).

## Betrouwbare sync op school-WiFi

**Belangrijk:** de openbare WebRTC-signaalservers van y-webrtc (`signaling.yjs.dev`, `y-webrtc-eu.fly.dev`) zijn offline. Zonder Firebase of een eigen signaalserver synchroniseert het bord niet tussen toestellen en kan de beheerder niemand toelaten. Een eigen signaalserver stel je in met `window.KANBAN_SIGNALING = ["wss://jouw-server"]` in `firebase-config.js`.


Standaard gebruikt het bord **WebRTC** (geen account nodig). Op sommige netwerken werkt dat niet goed. Voor vaste live-sync:

1. Maak een gratis [Firebase](https://console.firebase.google.com/) project aan.  
2. Schakel **Realtime Database** in (regio naar keuze).  
3. Tijdelijke regels (alleen voor dit schoolproject):

   ```json
   {
     "rules": {
       "rooms": {
         "$roomId": { ".read": true, ".write": true }
       }
     }
   }
   ```

4. Kopieer `firebase-config.example.js` naar `firebase-config.js` en vul je projectgegevens in.  
5. Push opnieuw naar GitHub — Pages deployt automatisch.

## Lokaal openen

Open `index.html` in de browser, of serveer de map met een simpele static server.
