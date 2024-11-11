<h1>md-stashes</h1>
<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img src="https://files.fivemerr.com/images/7ae3f8d3-60bc-4ec5-8502-93bb8a807eff.png" width =200px>
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

<h1> Inventory Compatability </h1>

- qb
- ps
- lj
- ox <- You should **only** be using thing inventory if you run qb at all
- qs maybe

<h1> Disclaimer </h1>
since qb updated their inventory and <b>changed</b> their event names it caused suit for others to change event names as well so here is a little guide how to set this correctly

- if you use ox 
  - set Config.Inv = 'ox'
- if you use **old** qb (click tab and if two inventorys pop up side by side its old) 
  - Config.Inv = 'oldqb'
- if you use **new** qb (click tab and if one inventory pops up) then 
  - Config.Inv = 'qb'
- if you use ps-inventory then **try**
  - Config.Inv = 'qb'
    - if that doesn't work do Config.Inv = 'oldqb'
      - if that doesn't work then set Config.Inv = 'outdated'
- if you use lj-inventory 
  - Config.Inv = 'outdated'
- if you use qs-inventory then 
  - Config.Inv = 'outdated'
- if you use ak47_qb_inventory then 
  - Config.Inv = stop. he is known for leaks switch to ox


### some inventories hate special character so just dont use - or _ symbols just write the name

<h1>How to install like a fuckin boss</h1>

<b> Step One </b>

- Run The SQL
  - How Do I Do That?
    - Youtube has a lot of videos
  - Do I need To?
    - I just said to. 
  - How Do I Find My Database
    - Ask your server host

<b> Step Two </b>
  
- Fill out your config
  - follow the disclaimer above

<p> </p>

<h1>How It Works</h1>

- use command newstash and fill in the things you want
- use command editStashes to edit the required data to open stashes
- use command DeleteStashes to delete stashes -- thanks @bobatari

<h1> Common Questions </h1>

- the items wont get out of the inventory and into my pockets
  - not my scripts problem. This is merely a way to **open** stashes. thats it. once you open the stash my script stops. 
- weapons lose durability when i put them in the stash
  - again, not my script.

<h1>Fivemerr</h1>
This is NOT a requirement but something I personally use and believe in.


- to integrate with fivemerr make sure you have  ```set fivemerrLogs "API_KEY"```   in your server.cfg
   
- Head to /server/bridge.lua and line 3 turn local logs = true
  
- profit

Why integrate with Fivemerr? Its a great place to store logs as it doesnt rely on discord webhooks and its far easier to search through

As well as a place to offload images and videos from fivem that doesnt rely on discord since discord API will be automatically deleting images and videos after a certain amount of time If you need an invite to their server look below
- [Fivemerr Discord](https://discord.com/invite/fivemerr)
- [Fivemerr Docs](https://docs.fivemerr.com/)
