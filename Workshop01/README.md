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

### Imagen B/W e Histograma
Para conseguir el efecto B/W en las imagenes se usaron dos metodos: 
* AVG: Sacar el promedio de los 3 canales RGB
* Luma: Donde los pesos para cada canal son los usados por los sistemas NTSC y PAL.
En el caso de AVG en imagenes con zonas claras y oscuras, no se notaba mucho la diferencia entre estas tonalidades, en cambio con Luma se aprecia que las zonas claras son mas faciles de visualizar de las oscuras.

Para el histograma se saco del canal rojo el nivel de la tonalidad para la toma de los datos, y con ello armar el histograma. Se hizo que se puedan selecionar rangos en el histograma haciendo uso de los 2 botones del Mouse, donde se muestra una imagen en la cual se dibuja el rango seleccionado. Dependiendo de donde uno seleccione el rango, si al final o al comienzo, se pueden filtrar en la imagen las zonas mas oscuras o mas claras de la imagen.

### Kernels
Para los kernels, se adapto la funcion creada dentro de un foro para aplicar kernels 3x3, y ademas se modifico para que soportara matrices 4x4 y 5x5. De los kernels 3x3 aplicados tenemos:
* Edge Detection: Cuando la imagen tiene demasiados objetos, no se pueden distinguir bien los bordes, en cambio con una imagen mas sencilla, los bordes son apreciados mejor.
* Sharpen: Con este kernels, las imagenes se ven mas asperas en los detalles.
* Gaussian Blur: Se difuminan un poco los detalles de la imagen.

Para los kernels 4x4 solo se uso:
* Emboss: Se parece a Edge Detection ya que muestra los bordes de la imagen pero mas gruesos, ademas de resaltar los colores de los bordes.

Para los kernels 5x5 se aplicaron 2:
* Gaussian Blur: Aqui los detalles estan mas difuminados que su version 3x3, por lo que es mas facil ver el efecto.
* Unsharp Masking: Es el mismo que Sharpen pero suavizado.

Para aplicar los efectos, decidimos no aplicarlos en los bordes de la imagen para evitar problemas de rango, con los filtros 3x3 se ignoraron 1 pixel de grosor en los bordes, mientras que con los 5x5 los bordes ignorados son de 2 pixeles.

### Implementación para video

Se aplicaron todas las operaciones a cada uno de los fotogramas obtenidos con el video utilizado. En esta tarea se observó que los cuadros por segundo se reducen considerablemente con cada operación. Al aplicar las escalas de grises (AVG y Luma) se reduce un poco y dependiendo del computador en el que se ejecute el programa se reduce la velocidad de reproducción. 
En cuanto a la aplicación de las mascaras de convolución se obtuvieron diferentes resultados dependiendo del tamaño de la matriz utilizada. En el caso de la matriz 3x3 el efecto ‘Edge Detection’ es el que más reduce los cuadros por segundo, seguido por ‘Gaussian Blur’ y por último ‘Sharpen’. Consideramos que esto se debe a que al ejecutar el análisis por bordes se modifican los colores de la imagen requiriendo un alto nivel de procesamiento para cada fotograma del video. En el caso de la matriz 4x4 se reducen considerablemente los cuadros por segundo, de forma similar al efecto ‘Edge Detection’. Por último, para el caso de la matriz 5x5 la reducción es mayor que al utilizar la matriz 3x3, esto se debe a que el efecto es mucho más definido y hacerlo sobre una secuencia de imágenes consume muchos recursos del computador.

### Bibliografía
[Convolution matrix to a RGB image](https://forum.processing.org/two/discussion/25076/convolution-matrix-to-an-rgb-image "Processing Forum")


## Entrega

* Plazo para hacer _push_ del repositorio a github: 29/9/19 a las 24h.
