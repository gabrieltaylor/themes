# Theme Service

Serves json themes used to dynamically style components.

# How to use
Requests for a theme are mapped to sub folders by interpolating the `client-slug` header into the path.

Thus a request like
```
curl -X GET \
  http://localhost:3000/theme.json \
  -H 'Accept: */*' \
  -H 'Accept-Encoding: gzip, deflate' \
  -H 'Connection: keep-alive' \
  -H 'client-slug: chicago'
```

Will return the file at `/themes/chicago/theme.json`.

To add a new client, create a new directory under themes where the directory name is the client-slug of the client.
In the new directory add a json file for the theme.
