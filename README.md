# Campus Spoor Kanban

Kanbanbord (TODO → DOING → DONE) voor de backlog uit *Waar knelt het schoentje?* — website Campus Het Spoor.

## Live site

**Groepslink (deel met je team):**

https://walter-white-the-creator.github.io/campus-spoor-kanban/?room=spoor

Iedereen die dezelfde link opent (zelfde `room=…`) ziet hetzelfde bord. Verplaats je een kaart, dan verschijnt die bij de anderen binnen enkele seconden.

- **Kopieer link** — knop bovenaan op het bord  
- **Andere kamer** — wijzig de kamercode (bijv. `team7`) en stuur die nieuwe link door  

### Kortere URL (optioneel)

Op GitHub: **Settings → Pages → Custom domain** kun je een eigen domein koppelen (bijv. `kanban.jouwschool.be`), zodat je geen lange `github.io`-link meer nodig hebt.

## Betrouwbare sync op school-WiFi

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
