# outer-joins-ministore

Análisis de inventario y ventas de MiniStore usando LEFT, RIGHT y FULL OUTER JOIN.

## Archivos
- `schema.sql`: crea las tablas `productos` y `ventas` y carga los datos de prueba.
- `soluciones.sql`: las tres consultas que responden las preguntas de negocio.

## 1. ¿Por qué LEFT JOIN en la Consulta 1 y no INNER JOIN?
La pregunta es qué productos nunca se vendieron, así que necesito conservar todos los
productos del catálogo aunque no tengan ventas. Un LEFT JOIN con `productos` a la izquierda
hace eso. Con INNER JOIN se perderían los productos 108 (Hub USB-C 7p) y 109 (Parlante
Bluetooth): justo los que busco, porque no tienen ninguna fila en `ventas`.

## 2. ¿Por qué RIGHT JOIN en la Consulta 2?
Acá la tabla que debe conservar todas sus filas es `ventas`, porque quiero detectar ventas
cuyo producto no está en el catálogo. En mi consulta `productos` está a la izquierda (FROM)
y `ventas` a la derecha (RIGHT JOIN). Así aparece la venta 10, cuyo `producto_id` es 999 y no
existe en el catálogo. Con INNER JOIN esa fila desaparecería.

## 3. ¿Qué representan los NULL?
- **Consulta 1:** que `venta_id` sea NULL significa que el producto no encontró ninguna venta
  en `ventas`. Por ejemplo, el producto 108 (Hub USB-C 7p) nunca se vendió.
- **Consulta 2:** que `producto_id` de `productos` sea NULL significa que la venta no tiene
  un producto asociado en el catálogo. Por ejemplo, la venta 10 apunta al producto 999, que
  no existe: probablemente es un error de carga de datos.
En ambos casos el NULL no es un error de la consulta, es la información que se busca.

## 4. ¿Cuándo usaría FULL OUTER JOIN?
Cuando necesito auditar dos fuentes de datos a la vez sin perder nada de ninguna. Por
ejemplo, conciliar pedidos del sistema contra facturas del sistema contable: veo en una sola
vista lo que está en ambos, lo que solo está en uno y lo que solo está en el otro.
