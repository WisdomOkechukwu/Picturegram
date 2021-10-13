
## Base SetUp
  
## Run Locally

Clone the  project

```bash
  git clone https://git@github.com:WisdomOkechukwu/Picturegram.git
```


Install composer

```bash
     https://getcomposer.org/download/
     
```
Clone the Laravel Api and run migrations

```bash
     git clone https://git@github.com:WisdomOkechukwu/FlutterAPI.git
     migrations => php artisan migrate
```

Go to the project directory

```bash
  cd my-project
```

Check  your dependencies

```bash
  flutter pub get
```

to run the API locally
hotspot your laptop 
and run ipconfig in CMD
Get the IPv4 Address and run this 

```bash
  php artisan serve --host IPv4 Address --port 8000
  
```




## API Reference

#### Login

```http
  POST /api/login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `email` | `email` | **Required**.|
| `password` | `String` | **Required**.|
| `api_key` | `String` | **Required**. Your API key |

#### Register

```http
  POST /api/login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `name` | `String` | **Required**.|
| `image` | `String` | |
| `email` | `email` | **Required**.|
| `password` | `String` | **Required**.|
| `api_key` | `String` | **Required**. Your API key |


#### User Details

```http
  GET /api/user
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### User Update

```http
  PUT /api/user
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `name` | `string` | **Required**. |
| `image` | `string` |.|
| `api_key` | `string` | **Required**. Your API key |



  
>>>>>>> 83ffbdaf4529fe3f2dd10d0a7068dbdf943a0d6e
