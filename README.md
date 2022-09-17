<h1 align='center'>[NPWD] Services App</a></h1><p align='center'><b><a href='https://discord.gg/uy5N7jT5aJ'>Discord</a> - <a href='https://github.com/project-error'>Github</a> - <a href='https://projecterror.dev/docs/'>Documentation</a></b></h5>
~
External NPWD app for Calling Services.

Framework is automatically detected for ESX and QBCore

![preview](https://user-images.githubusercontent.com/97451137/184982211-754f223f-8163-44ac-8b11-b7b07fece10c.png)

## Requirements

- NPWD (1.5.0 or higher)
- oxmysql
- ESX *or* QBcore

## Install
1. Download the `npwd_services.zip` from releases. DO NOT CHANGE THE RESOURCE NAME. If you want to change it, you'll have to download the source code, alter `fetchNui.ts`, and build the project.
2. Unzip and add the resource to your server resources folder
3. Ensure `npwd_services` BEFORE `npwd`
4. Add app to NPWD config.json in the `apps` section `"apps": ["npwd_services]`

#### PS: thanks chip cuz I stole half of it from esx app

# Credits

- chip (most of it from esx app)
- Mycroft (Conveting to ESX)
  