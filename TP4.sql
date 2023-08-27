------------------------------------------------------------------------------------------------
------------------------------------Trabajo Práctico Nº4----------------------------------------
------------------------------------------------------------------------------------------------
----Trabajo Práctico Grupal---------------------------------------------------------------------
------------------------------------------------------------------------------------------------
----Integrantes:
---<*>Cendra Sebastián Andres
---<*>Gomez Leo Gabriel
---<*>López Otero Rafael Ariel

set search_path='main';

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 1--------------------------------------------
------------------------------------------------------------------------------------------------
----1. Hallar el código de los clientes que realizaron pedidos al vendedor 10.
--
--select id_cliente from pedidos where id_vend = 10; 
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 2--------------------------------------------
------------------------------------------------------------------------------------------------
----2. Mostrar el id_pedido y total de aquellos pedidos con importes superiores a $700.
--
--select id_pedido, total from pedidos where total > 700; 
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 3--------------------------------------------
------------------------------------------------------------------------------------------------
----3. Listar los pedidos no entregados.
--
--select id_pedido,pedido_cumplido from pedidos where pedido_cumplido = 'F'; 
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 4--------------------------------------------
------------------------------------------------------------------------------------------------
----4. Listar el nombre, apellido y nombre de la provincia, de los clientes que no 
----sean de la provincia de Santa Fe.
--
----OPCION 1
--select c.nombres as nom,c.apellidos,p.nombre 
--from clientes c, localidades l, provincias p
--where c.cod_post=l.cod_post AND c.cod_post_aux=l.cod_post_aux 
--AND l.id_prov=p.id_prov AND p.nombre <> 'SANTA FE'
--ORDER BY nom;
--
----OPCION 2
--select c.nombres,c.apellidos,p.nombre as pnom
--FROM clientes c, localidades l, provincias p
--WHERE c.cod_post=l.cod_post AND c.cod_post_aux=l.cod_post_aux AND l.id_prov=p.id_prov
--
--EXCEPT
--
--select c.nombres,c.apellidos,p.nombre as pnom
--FROM clientes c, localidades l, provincias p
--WHERE p.nombre = 'SANTA FE'
--ORDER BY pnom;
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 5--------------------------------------------
------------------------------------------------------------------------------------------------
----5. Mostrar los pedidos recibidos en la primera quincena de Marzo de 2020, incluyendo el
----apellido del vendedor que recibió el pedido y el apellido del cliente.
--
----OPCION 1
--SELECT p.id_pedido as pedido, v.apellidos,c.apellidos
--FROM pedidos p, vendedores v, clientes c
--WHERE p.id_cliente=c.id_cliente AND p.id_vend=v.id_vend AND p.id_vend=c.id_vend
--AND p.fecha_recepcion BETWEEN '2020-03-01' AND '2020-03-15'
--ORDER BY pedido;
--
----OPCION 2
--
--SELECT p.id_pedido as pedido, v.apellidos,c.apellidos
--FROM pedidos p, vendedores v, clientes c
--WHERE p.id_cliente=c.id_cliente AND p.id_vend=v.id_vend AND p.id_vend=c.id_vend
--
--EXCEPT
--
--SELECT p.id_pedido as pedido, v.apellidos,c.apellidos
--FROM pedidos p, vendedores v, clientes c
--WHERE p.fecha_recepcion NOT BETWEEN '2020-03-01' AND '2020-03-15'
--ORDER BY pedido;
--
----OPCION 3
--
--SELECT p.id_pedido as pedido, v.apellidos,c.apellidos
--FROM pedidos p, vendedores v, clientes c
--WHERE p.id_cliente=c.id_cliente AND p.id_vend=v.id_vend AND p.id_vend=c.id_vend
--
--INTERSECT
--
--SELECT p.id_pedido as pedido, v.apellidos,c.apellidos
--FROM pedidos p, vendedores v, clientes c
--WHERE p.fecha_recepcion BETWEEN '2020-03-01' AND '2020-03-15'
--ORDER BY pedido;
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 6--------------------------------------------
------------------------------------------------------------------------------------------------
----6. Hallar la cantidad de productos diferentes que son provistos por cada uno de los
----proveedores de la base de datos.
--
--SELECT id_proveedor as id, count (DISTINCT id_producto)
--FROM main.productos
--GROUP BY id_proveedor
--ORDER BY id;
--
------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 7--------------------------------------------
------------------------------------------------------------------------------------------------
----7. Mostrar los nombres y apellidos de los diferentes clientes que hicieron pedidos 
----a la oficina de ventas 1.
SELECT C.Nombres as nom, C.Apellidos
FROM CLIENTES C, VENDEDORES V
WHERE	C.id_vend = V.id_vend AND V.id_oficina = 1
ORDER BY nom;

--SELECT*FROM localidades limit 5;
--SELECT*FROM provincias limit 5;


------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 8--------------------------------------------
------------------------------------------------------------------------------------------------
----8. Mostrar la cantidad de clientes distintos que hicieron pedidos a la oficina de ventas 1.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 9--------------------------------------------
------------------------------------------------------------------------------------------------
----9. Listar aquellas localidades donde resida al menos un cliente y al menos un vendedor.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 10-------------------------------------------
------------------------------------------------------------------------------------------------
----10. Mostrar, para cada pedido, la identificación de cada uno y el importe total (cantidad *
----precio unitario).

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 11-------------------------------------------
------------------------------------------------------------------------------------------------
----11. Por cada cliente, mostrar los importes máximo, mínimo y promedio de todos los renglones
----de pedidos realizados.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 12-------------------------------------------
------------------------------------------------------------------------------------------------
----12. Mostrar todos los pedidos para los cuales el total de los renglones de pedido supere al
----total de los renglones del pedido número 113.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 13-------------------------------------------
------------------------------------------------------------------------------------------------
----13. Mostrar la descripción del producto menos vendido.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 14-------------------------------------------
------------------------------------------------------------------------------------------------
----14. Mostrar el nombre de las oficinas donde existan productos cuyas existencias estén por
----debajo del punto de repedido.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 15-------------------------------------------
------------------------------------------------------------------------------------------------
----15. Mostrar el id_producto, la descripción y el precio_unitario de los productos que no hayan
----sido solicitados en ningún pedido.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 16-------------------------------------------
------------------------------------------------------------------------------------------------
----16. Mostrar el id_producto, la descripción y precio unitario del producto que fue pedido por
----todos los clientes.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 17-------------------------------------------
------------------------------------------------------------------------------------------------
----17. Mostrar los nombres y apellidos de todos los vendedores agregando, cuando corresponda,
----el apellido de los clientes asignados a cada uno de ellos.

------------------------------------------------------------------------------------------------
-----------------------------------------EJERCICIO 18-------------------------------------------
------------------------------------------------------------------------------------------------
----18. Listar aquellas localidades donde resida un vendedor o un cliente, pero no los dos. 
