# [Show Finder](https://show-finder.herokuapp.com/)

This Ruby on Rails API searches tv/movie shows.

The following are valid parameters when creating a [new Search](#post-searches):

| title*   | year     | format   |
| -------- | -------- | -------- |
| required | optional | optional |
| fargo    | 2014     | series   |

After a Search is created, the data returned is saved under `content` in json format:

```json
  "id": 6,
  "title": "fargo",
  "year": "2014",
  "format": "series",
 *"content": {
      "Title": "Fargo",
      "Year": "2014–",
      "Rated": "TV-MA",
      "Released": "15 Apr 2014",
      "Runtime": "53 min",
      "Genre": "Crime, Drama, Thriller"...
```

## Endpoints

The following endpoints can be appended to https://show-finder.herokuapp.com/ :

### GET /searches(/:id)

To retreive all search history, run `GET /searches`. The results will be ordered alphabetically.

To retreive search history by title, run `GET /searches/?title=fargo`. The results will include movie and television types.

To retrieve search history singularly by ID, run `GET /searches/1`.

### POST /searches

When searching for titles not in the database, the app uses a 3rd party API that is similar to IMDB.

To search for new titles, run `POST /searches?title=fargo`. To create a more detailed search, you can add year and format to your search like so: `POST /searches?format=movie&title=fargo&year=1996`.

### PUT/PATCH /searches/1

To update a record in the search history, run `PUT /searches/1?format=movie`.

### DELETE /searches/1

To delete search history singularly by ID, run `DELETE /searches/1`.
