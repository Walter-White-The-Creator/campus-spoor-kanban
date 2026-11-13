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
- De beheerder ziet bovenaan het blok **Toegangsaanvragen** met de knoppen **Toelaten** en **Weigeren**. Aanvragen verschijnen zolang de deelnemer in de wachtruimte staat (de beheerder moet dus ook online zijn).

### Beheerderswachtwoord wijzigen

In de code staat alleen de SHA-256-hash van het wachtwoord. Nieuwe hash maken (in de browserconsole):

```js
crypto.subtle.digest("SHA-256", new TextEncoder().encode("NIEUW_WACHTWOORD"))
  .then(b => console.log([...new Uint8Array(b)].map(x => x.toString(16).padStart(2, "0")).join("")))
```

Plak de uitkomst in `ADMIN_PASSWORD_HASH` in `index.html`.

> Let op: dit is een statische site zonder eigen server. Alle controles gebeuren in de browser, dus iemand met technische kennis kan ze omzeilen. Voor echte beveiliging is een backend met authenticatie nodig (bijv. Firebase Auth of Supabase Auth met databaseregels).

## Live samenwerken

Het bord synchroniseert standaard via **gratis publieke MQTT-servers** (EMQX, HiveMQ en Mosquitto, tegelijk voor reserve). Je hoeft niets in te stellen.

- Verplaatst iemand een kaart, dan glijdt die bij iedereen binnen ongeveer een seconde naar de nieuwe kolom, met kort een paars label met de naam van wie hem verplaatste.
- Elke kaart wordt apart samengevoegd: als twee mensen tegelijk verschillende kaarten verplaatsen, blijven beide wijzigingen bewaard.
- De laatste toestand van het bord wordt op de server bewaard, dus wie later binnenkomt ziet meteen het actuele bord.
- Eigen servers gebruiken? Zet `window.KANBAN_MQTT_BROKERS = ["wss://..."]` in `firebase-config.js`.

> Publieke servers zijn voor iedereen toegankelijk. Gebruik een unieke kamercode en zet er geen gevoelige gegevens op.

### Firebase (optioneel)

Wil je liever een eigen database, maak dan een gratis [Firebase](https://console.firebase.google.com/) project met **Realtime Database** aan, gebruik deze tijdelijke regels:

```json
{
  "rules": {
    "rooms": {
      "$roomId": { ".read": true, ".write": true }
    }
  }
}
```

en vul je gegevens in `firebase-config.js` in (zie `firebase-config.example.js`). Is Firebase ingevuld, dan gebruikt het bord Firebase in plaats van MQTT.

## Lokaal openen

Open `index.html` in de browser, of serveer de map met een simpele static server.
