# README
<h3>Versions</h3>
    Ruby - 2.7.0<br>
    Rails - 6.0.2<br>


<h3>Instructions</h3>
Create a <a href="https://developer.spotify.com/">spotify developer account</a>

Add spotify client_id and client_secret to your credentials.yml.enc file with
```bsh
$  EDITOR="code --wait" bin/rails credentials:edit
```

Feel free to replace code with your preferred editor. The wait command is necessary to prevent it saving and encrypting again. Within the editor add your client_id and client_secret in this format.

<pre>
spotify:
  client_id: your_client_id
  client_secret: your_client_secret
</pre>

<br/>
<h3>Endpoints</h3>
<li>'/login' - expects a </li>