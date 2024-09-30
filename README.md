<h1>md-stashes</h1>
<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img align="center" src="https://cdn.discordapp.com/attachments/1164709522691076120/1185676859363557457/Discord_logo.svg.png?ex=65907aa0&is=657e05a0&hm=dd2a8924c3a3d84507747ab2bac036e5fc219c697e084c9aa13ba468ff725bde&" width="100">
  </a><br>
  <a href="https://discord.gg/sAMzrB4DDx">Mustache Scripts Discord</a><br>
</div>

<h1>Credits</h1>

- Big Credit to [Bostra](https://discord.gg/5ncbwMNq). if you have been around you may have seen him post some free scripts and help people, There was definetly times I dm'd him saying what the fuck am I doing and he helped keep me sane as well as making the raycast thing.

- shout out to my beta testers who had to deal with me a lot!

- Our partner [1of1 Servers]( https://1of1servers.com/) and their [discord](https://discord.gg/1of1servers) for their amazing server hosting! absolutely top notch.

<h1>Showcase Video Done By ShooterMcGamin</h1>

- [Link](https://www.youtube.com/watch?v=N0zdbZ3CM9Y)

<h1>Dependencies</h1>


- [ox_lib](https://github.com/overextended/ox_lib/releases)

- [World Interactions](https://github.com/darktrovx/interact) - optional

- [qb-target](https://github.com/qbcore-framework/qb-target)  - [ox_target](https://github.com/overextended/ox_target) - optionals

- Ox - Ps - Lj - Qb Inventory

<h1> Disclaimer </h1>
 if you use qb-inventory, they have a bug in their code that skips over data once a stash has been opened. in essense if you change weight and slot size from a pre existing stash it wont work. 
You can find a fix for it in qb-inventory pull requests as I have sent one in to fix that. 

### some inventories hate special character so just dont use - or _ symbols just write the name

<h1>How to install like a fuckin boss</h1>

- **STEP 1**
Drag Resource into your script folder

- **STEP 2** 
fill out your config

- **STEP 3**
IF YOU USE OLD QB-INVENTORY/ LJ-INVENTORY OR PS-INVENTORY PRIOR TO 07/24/2024 THEN MARK CONFIG.INV TO oldqb

- **STEP 4**
Run The SQL


IF YOU USE NEW QB OR NEW PS-INVENTORY FROM 07/24/2024 OR AFTER  mark Config.Inv to be qb
- **STEP 5**
SAVE A COPY OF YOUR MDSTASHES SQL TABLE BY EXPORTING IT

IF YOU USE AN OLD VERSION USE THE COMMAND ImportConfigStashes TO IMPORT THE STASHES FROM YOUR config
THEN USE ConvertStashSQL TO USE THE NEWEST VERSION OF THE SQL IT WILL BE FUNKY FOR ABOUT 2 MINUTES THEN YOU WILL BE GOOD

<h1>How It Works</h1>

1) use command newstash and fill in the things you want


if you do not want an option LEAVE BLANK
for example. if you dont want the stash job locked, leave the job category blank.
when you hit enter it will create a stash in the sql. If you fuck up, how? its fill in the blank. BUT IF YOU DO, just delete the line in the table and restart the script. Badabing badaboop

<h1>Fivemerr</h1>
This is NOT a requirement but something I personally use and believe in.


- to integrate with fivemerr make sure you have  ```set fivemerrLogs "API_KEY"```   in your server.cfg
   
- Head to /server/bridge.lua and line 3 turn local logs = true
  
- profit

Why integrate with Fivemerr? Its a great place to store logs as it doesnt rely on discord webhooks and its far easier to search through

As well as a place to offload images and videos from fivem that doesnt rely on discord since discord API will be automatically deleting images and videos after a certain amount of time If you need an invite to their server look below
- [Fivemerr Discord](https://discord.com/invite/fivemerr)
- [Fivemerr Docs](https://docs.fivemerr.com/)
