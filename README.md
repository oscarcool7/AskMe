# Учебное приложение "Askme"

В приложении можно зарегистрироваться, задавать и отвечать на вопросы своих друзей и анонимных пользователей.

Деплой на [heroku](https://hey-ask-me.herokuapp.com/).

Приложение написано на `Ruby 3.1.1` и `Rails 7.0.3`.

Для борьбы со спамом добавлена reCAPTCHA.

### Запуск

1. Клонируйте git репозиторий.
2. Перейдите в консоли в папку с приложением и установите библиотеки:
```
bundle
```
3. Также потребуется прогнать миграции:
```
bundle exec rails db:migrate
```
