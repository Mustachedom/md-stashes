#  md-stashes    - An easy way to place stashes throughout your server


<div align="center">
  <a href="https://discord.gg/sAMzrB4DDx">
    <img src="https://i.imgur.com/t65G9Z0.png" width="200" alt="Mustache Scripts Logo">
  </a>
  <br>
  <a href="https://discord.gg/sAMzrB4DDx"><strong>Join Mustache Scripts Discord</strong></a>
</div>

## 📦 Dependencies

| Dependency | Link |
|----------|------|
| `ps_lib` | [GitHub - Project-Sloth/ps_lib](https://github.com/Project-Sloth/ps_lib) |
| `Read`   | [Read Docs](https://letters.hookedonphonics.com/us/read-guaranteed-G14.html) |

> ⚠️ Ensure all dependencies are installed, up to date, and ensure **BEFORE** this script, before proceeding.

<h1>Credits</h1>

- shout out to my beta testers who had to deal with me a lot!

- Our partner [1of1 Servers]( https://1of1servers.com/) and their [discord](https://discord.gg/1of1servers) for their amazing server hosting! absolutely top notch.


<h1>How to install like a fuckin boss</h1>

### STEP 1
- `Run SQL`
    - if you dont know how, click this image below
    - [![YouTube Video](https://img.youtube.com/vi/8QpFOluK_xo/hqdefault.jpg)](https://www.youtube.com/watch?v=8QpFOluK_xo)

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
