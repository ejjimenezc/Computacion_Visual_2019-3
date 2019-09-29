# Taller de análisis de imágenes por software

## Propósito

Introducir el análisis de imágenes/video en el lenguaje de [Processing](https://processing.org/).

## Tareas

Implementar las siguientes operaciones de análisis para imágenes/video:

* Conversión a escala de grises: promedio _rgb_ y [luma](https://en.wikipedia.org/wiki/HSL_and_HSV#Disadvantages).
* Aplicación de algunas [máscaras de convolución](https://en.wikipedia.org/wiki/Kernel_(image_processing)).
* (solo para imágenes) Despliegue del histograma.
* (solo para imágenes) Segmentación de la imagen a partir del histograma.
* (solo para video) Medición de la [eficiencia computacional](https://processing.org/reference/frameRate.html) para las operaciones realizadas.

Emplear dos [canvas](https://processing.org/reference/PGraphics.html), uno para desplegar la imagen/video original y el otro para el resultado del análisis.

### Alternativas para video en Linux y `gstreamer >=1`

Distribuciones recientes de Linux que emplean `gstreamer >=1`, requieren alguna de las siguientes librerías de video:

1. [Beta oficial](https://github.com/processing/processing-video/releases).
2. [Gohai port](https://github.com/gohai/processing-video/releases/tag/v1.0.2).

Descompriman el archivo `*.zip` en la caperta de `libraries` de su sketchbook (e.g., `$HOME/sketchbook/libraries`) y probar cuál de las dos va mejor.

## Integrantes

Completar la tabla:

| Integrante | github nick |
|------------|-------------|
|Edwin Javier Jimenez Casares               |  ejjimenezc           |
|Juan Sebastián Alcina Rodríguez            |  jsalcinar            |

## Discusión

### Implementación para video

Se aplicaron todas las operaciones a cada uno de los fotogramas obtenidos con el video utilizado. En esta tarea se observó que los cuadros por segundo se reducen considerablemente con cada operación. Al aplicar las escalas de grises (AVG y Luma) se reduce un poco y dependiendo del computador en el que se ejecute el programa se reduce la velocidad de reproducción. 
En cuanto a la aplicación de las mascaras de convolución se obtuvieron diferentes resultados dependiendo del tamaño de la matriz utilizada. En el caso de la matriz 3x3 el efecto ‘Edge Detection’ es el que más reduce los cuadros por segundo, seguido por ‘Gaussian Blur’ y por último ‘Sharpen’. Consideramos que esto se debe a que al ejecutar el análisis por bordes se modifican los colores de la imagen requiriendo un alto nivel de procesamiento para cada fotograma del video. En el caso de la matriz 4x4 se reducen considerablemente los cuadros por segundo, de forma similar al efecto ‘Edge Detection’. Por último, para el caso de la matriz 5x5 la reducción es mayor que al utilizar la matriz 3x3, esto se debe a que el efecto es mucho más definido y hacerlo sobre una secuencia de imágenes consume muchos recursos del computador.

### Bibliografía

https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image

## Entrega

* Plazo para hacer _push_ del repositorio a github: 29/9/19 a las 24h.
