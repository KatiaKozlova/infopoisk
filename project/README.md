## Проект Кати Козловой по Базам Данных
### Ссылки
За основу базы данных взята сводная CSV-таблица с соревнования на Kaggle под названием [30000 Spotify Songs](https://www.kaggle.com/datasets/joebeachcapital/30000-spotify-songs/). В изначальном виде она лежит [тут](data/spotify_songs.csv).
### Устройство папки
1. Файл [`project_picture.png`](project_picture.png) - это картинка с нотациями Чена и Мартина для моей базы данных.
2. Файл [`project_(preprocessing).ipynb`](project_(preprocessing).ipynb) содержит препроцессинг оригинальной таблицы и переводит ее в 6 отдельных таблиц, которые записаны в папке [`data`](data):
* [`tracks.csv`](data/tracks.csv) - таблица с треками;
* [`playlists.csv`](data/playlists.csv) - таблица с плейлистами;
* [`albums.csv`](data/albums.csv) - таблица с альбомами;
* [`track_characteristics.csv`](data/track_characteristics.csv) - таблица с характеристикой треков;
* [`track_to_album.csv`](data/track_to_album.csv) - таблица с сопоставлением треков к альбомам;
* [`track_to_playlist.csv`](data/track_to_playlist.csv) - таблица с сопоставлением треков к плейлистам.
3. Файл [`project.sql`](project.sql) содержит скрипт с комментариями и всеми решениями.
4. В папке [`sql_files`](sql_files) лежат этот же скрипт, но разбитый на подзадачи, пронумерованные от 1 до 9 по принципу как в сообщении:
  ```
  1. Создание БД
  2. CRUD
  3. SELECT  + фильтрация
  4. SELECT + группировка и агрегация
  5. SELECT + вложенный запрос
  6. SELECT + JOIN + что-то — запрос должен быть относительно сложным
  7. Процедура или функция
  8. Триггер или Транзакция
  9. Ещё одна любая практическая вещь, которая понравилась на курсе
  ```
