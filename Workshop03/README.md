# Taller raster

## Propósito

Comprender algunos aspectos fundamentales del paradigma de rasterización.

## Tareas

Emplee coordenadas baricéntricas para:

1. Rasterizar un triángulo.
2. Sombrear su superficie a partir de los colores de sus vértices.
3. Implementar un [algoritmo de anti-aliasing](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation) para sus aristas.

Referencias:

* [The barycentric conspiracy](https://fgiesen.wordpress.com/2013/02/06/the-barycentric-conspirac/)
* [Rasterization stage](https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-stage)

Implemente la función ```triangleRaster()``` del sketch adjunto para tal efecto, requiere la librería [nub](https://github.com/visualcomputing/nub/releases) (versión >= 0.2).

## Integrantes

Complete la tabla:

| Integrante | github nick |
|------------|-------------|
|Edwin Javier Jimenez Casares|ejjimenezc|
|Juan Sebastian Alcina|jsalcinar|

## Discusión

Describa los resultados obtenidos. En el caso de anti-aliasing describir las técnicas exploradas, citando las referencias.

Para la implementación del anti-aliasing se utilizó el método descrito en la página sugerida por el profesor [Scratch a Pixel] (https://www.scratchapixel.com/lessons/3d-basic-rendering/rasterization-practical-implementation/rasterization-practical-implementation). En esta página se explica como este efecto consiste en tomar una sección del borde de la figura y dividir cada pixel en varios pixeles más pequeños a los cuales se les realiza una revisión del color. Posteriormente se toma el promedio de colores y se aplican estos cambios al pixel original. Esto es lo que genera el efecto de suavizado.

## Referencias

* [Orientation of three ordered points](https://www.geeksforgeeks.org/orientation-3-ordered-points/)

## Entrega

* Plazo: ~~20/10/19~~ 27/10/19 a las 24h.
