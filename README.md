# Proyecto #2 del curso Circuitos Digitales II - UCR

### Integrantes:

* Leonardo Agüero Villagra [B70103]
* Daniel Vargas Díaz

## Tabla de contenidos:
1. [Correr el proyecto](#correrProyecto)
2. [Descripción](#descripcion)
3. [Plan de Pruebas](#planPruebas)


## Correr el proyecto:

Para correr el proyecto basta con dar Make en cualquiera de los módulos, el proyecto completa se considera cualquiera dentro del directorio verificación y basta con escribir make en la terminal para correr el proyecto. Si se desea correr un módulo en específico se tiene que cambiar a su directorio respectivo y correr make.

## Descripción: <a name="descripcion"></a>

El proyecto consiste en diseñar una capa de transacción para una interfaz PCIe y/o USB mediante una arquitectura adaptada según la presentación QoS_TC_VC_switch.pdf

## Plan de pruebas: <a name="planPruebas"></a>

Para el plan de pruebas se piensa primero construir las cajas de forma aislada y de esta forma crear probadores propios para ellos de manera que se pueda validar su funcionamiento. Se piensa realizar los siguientes módulos:

- Fifo y dual-port memory (juntos)
- Demux con selector conectado a vc_id.
- Demux con selector conectado a dest.
- Máquina de estados.
- Lógica pop del fifo principal.
- Lógica pop del VC0.
- Mux con selector conectado a lógica del pop del VC0.

Como se dijo anteriormente dentro del repositorio se piensa crear estos módulos de forma aislada con su propio probador y testbench y una vez funcionando se extrae sus módulos conductuales y se prosigue con la etapa final que es realizar la interconexión. 

La interconexión será un módulo por aparte (probador y testbench) donde se realizará las pruebas finales. Una vez que se considere que está listo se prosigue a la sección de verificación de la arquitectura completa que está compuesto por las pruebas:

- Prueba de llenado/vaciado de todos los FIFOs.
- Envío de un único tipo de tráfico.
- Prueba de errores.
- Prueba con 1 valor distinto para cada umbral.
- Medir la latencia y tasa de salida de datos.

Una vez verificadas y aprobadas las pruebas se considerará el proyecto como listo.
