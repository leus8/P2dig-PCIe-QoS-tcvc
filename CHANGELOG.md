# Change Log

## v1.0.0 - Oct. 24, 2020

Lanzamiento inicial y creación del repositiorio en GitHub.

**Se agrega:**
- Leonardo Agüero:
  - README
  - CHANGELOG (Se utilizará como bitácora).
  

## v1.1.0 - Oct. 24, 2020

Desarrollo de FIFO y dual-port memory. Se debe debatir aspectos que aunque no dañan el funcionamiento del FIFO puede ser que causen problemas en un futuro. Uno de estos es lo que se guarda en el mem[0] una vez que se vacía el stack. En la implementación actual se deja el valor que últimamente se ha escrito en esta dirección de la memoria, se debe discutir si cambiar esto a 0x000000. Como se dijo anteriormente esto no causa problemas en el funcionamiento pero preocupa que en las próximas integraciones esto cause bugs indeseados. Próximamente v1.1.1 con el plan de pruebas y un posible cambio en el FIFO.

**Se agrega:**
- Leonardo Agüero:
  - Memoria FIFO conductual (dual-port_memory/fifo.v).
  - Memoria FIFO estructural (dual-port_memory/fifo_estr.v).
  - Probador que interactúa con la señal fifo_full de la memoria FIFO (dual-port_memory/probador.v).
  
  ## v1.2.0 - Nov. 4, 2020
  
  Se trabaja en la clasificación, enrutamiento, control de flujo, máquina de estados de la arquitectura. Se trabajan en forma de cajas aisladas entre sí simulando mediante probadores externos las señales **en la forma que son 'sentidas/vistas' por las cajas**. Próximo trabajo será realizar la interconexión de ellas y los arreglos de los retardos que puedan encontrarse.
  
  **Se agrega:**
  
  -Leonardo Agüero:
    - Demux con selector vcid tanto conductual como estructural (demux_vcid/demux_vc_id.v)(demux_vcid/demux_vc_id_estr.v).
    - Demux con selector dest tanto conductual como estructural (demux_dest/demux_dest.v)(demux_vcid/demux_dest_estr.v).
    - Lógica pop del vc0 tanto conductual como estructural (pop_delay_vc0/pop_delay_vc0.v)(pop_delay_vc0/pop_delay_vc0_estr.v).
    - Lógica pop del fifo principal tanto conductual como estructural (fifo_pop/fifo_main_pop.v)(fifo_pop/fifo_main_pop_estr.v).
    - Mux tanto conductual como estructural (mux/mux.v)(mux/mu_estr.v).
  
  -Daniel Vargas:
    - Máquina de estados tanto conductual como estructural (FSM/maquina_estados_cond.v)(FSM/maquina_estados_estr.v).
    
## v1.3.0 - Nov. 11, 2020
  Esta semana se trabaja en la integración entre la interconexión y la máquina de estados.
  
  **Se agrega:**
  
  - Por los 2 integrantes:
    - Todos los archivos en el directorio intFSM (intFSM/* ).
    
## v1.4.0 - Nov. 17, 2020
  Esta semana se trabaja en las pruebas de verificación de llenado, umbrales, caminos, errores y prueba de latencia. Se realizan mejoras considerables en la implementación y se obtiene unos resultados que se consideran bastante robustos. Aunque definimos quien iba a realizar cada prueba de verificación, **todos tuvimos participación en todas las pruebas dado la complejidad de las mismas**.
  
  **Se agrega:**
  - Leonardo Agüero:
    - Prueba de llenado (verificacion/prueba_llenado).
    - Prueba de umbrales (verificacion/prueba_umbrales).
  
  - Daniel Vargas:
    - Prueba de caminos (verificación/camino_v0_d0).
    - Prueba de caminos (verificación/camino_v0_d1).
    - Prueba de caminos (verificación/camino_v1_d0).
    - Prueba de caminos (verificación/camino_v1_d1).
    - Prueba de error de los FIFO D (verificación/error_d).
    - Prueba de error de los FIFO Main (verificación/error_main).
    - Prueba de error de los FIFO Main (verificación/tasa_datos).
  
