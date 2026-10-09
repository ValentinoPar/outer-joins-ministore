-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor:Valentino Parmigiani
-- Fecha: 09/10/2026
-- ══════════════════════════════════════════

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
--Hub USB-C 7p
--Parlante Bluetooth
-- Mostrá todos los productos y sus ventas asociadas.
-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.
select
p.producto_id,
p.nombre,
p.categoria,
p.precio,
v.venta_id,
v.cantidad,
v.fecha_venta
from 
dbo.productos as p
left join dbo.ventas as v
on p.producto_id=v.producto_id
ORDER BY p.producto_id;

SELECT p.producto_id, p.nombre, p.categoria, p.precio, v.venta_id
FROM dbo.productos AS p
LEFT JOIN dbo.ventas AS v
    ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL;

-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo? (posible error de carga de datos)
--si existen
-- Los registros huérfanos aparecerán con NULL en las columnas de productos.
select
v.venta_id,
v.producto_id AS producto_id_venta,
v.cliente_id,
v.cantidad,
v.fecha_venta,
p.producto_id AS producto_id_catalogo,
p.nombre
from 
dbo.productos as p
right join dbo.ventas as v
on p.producto_id = v.producto_id
ORDER BY v.venta_id;

select
v.venta_id, 
v.producto_id, 
v.cliente_id, 
v.cantidad, 
v.fecha_venta
from 
dbo.productos as p
right join dbo.ventas as v
on p.producto_id=v.producto_id
where p.producto_id is null;
-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila,
-- identificando tanto productos sin ventas como ventas sin producto.
select
p.producto_id AS producto_id_catalogo,
p.nombre,
v.venta_id,
v.producto_id AS producto_id_venta,
v.cantidad
from
dbo.productos as p
full outer join dbo.ventas as v 
on p.producto_id=v.producto_id
order by coalesce(p.producto_id, v.producto_id);
