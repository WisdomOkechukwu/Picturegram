## Base SetUp

Open a base Flutter project after flutter and dart installation
```bash
  Flutter create --appname
```
install dependencies in the pubspec.yaml file

```bash
 flutter pub get
```

Add this to the new flutter project Andriod manifest

```bash
-- flutterappname\android\app\src\main\AndroidManifest.xml
```

```bash
put this under  package="com.example.--flutterappname">
<uses-permission android:name="android.permission.INTERNET" /> 
```

```bash
put this under
<application>

        android:usesCleartextTraffic="true"
        android:requestLegacyExternalStorage="true">
```

Set the miniSDK to 21

```bash
pathtofile => --flutterappname\android\app\build.gradle
  minSdkVersion 21
```


  
## Run Locally

Clone the  project

```bash
  git clone https://git@github.com:WisdomOkechukwu/Picturegram.git
```


Install composer

```bash
     php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo                                                                                 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
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



  
