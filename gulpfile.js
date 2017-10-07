var gulp      = require('gulp'), // Подключаем Gulp
    sass        = require('gulp-sass'), //Подключаем Sass пакет,
    browserSync = require('browser-sync'), // Подключаем Browser Sync
    autoprefixer = require('gulp-autoprefixer'),// Подключаем библиотеку для автоматического добавления префиксов
    concat      = require('gulp-concat'), // Подключаем gulp-concat (для конкатенации файлов)
    uglify      = require('gulp-uglifyjs'), // Подключаем gulp-uglifyjs (для сжатия JS)
    babel       = require('gulp-babel');

gulp.task('sass', function() { // Создаем таск "sass"
  return gulp.src(['public/sass/**/*.sass', 'public/sass/**/*.scss']) // Берем источник
    .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError)) // Преобразуем Sass в CSS посредством gulp-sass
    .pipe(autoprefixer(['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true })) // Создаем префиксы
    .pipe(gulp.dest('public/stylesheets')) // Выгружаем результата в папку css
    .pipe(browserSync.reload({stream: true})) // Обновляем CSS на странице при изменении
  });
  gulp.task('browser-sync', function() { // Создаем таск browser-sync
    browserSync({ // Выполняем browser Sync
        server: { // Определяем параметры сервера
            baseDir: '' // Директория для сервера - app
        },
        notify: false // Отключаем уведомления
    });
});

// gulp.task('scripts', function() {
//     return gulp.src([ // Берем все необходимые библиотеки
//         'shop/public/js/footer.js'
//         ])
//         .pipe(babel({presets: ['es2015']}))
//         .pipe(concat('footer.min.js')) // Собираем их в кучу в новом файле libs.min.js
//         .pipe(uglify()) // Сжимаем JS файл
//         .pipe(gulp.dest('shop/public/js/')); // Выгружаем в папку app/js
// });

gulp.task('watch',['browser-sync', 'sass'/*, 'scripts'*/], function() {
  gulp.watch(['public/sass/**/*.sass', 'public/sass/**/*.scss'], ['sass']); // Наблюдение за sass файлами в папке sass
});

gulp.task('default', ['watch']);
