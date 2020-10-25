# Change Log

## v1.0.0 - Oct. 24, 2020

Lanzamiento inicial

**Se agrega:**
- Leonardo Agüero:
  - README
  - CHANGELOG (Se utilizará como bitácora).
  

## v1.1.0 - Oct. 24, 2020

Desarrollo de FIFO y dual-port memory. Se debe debatir aspectos que aunque no dañan el funcionamiento del FIFO puede ser que causen problemas en un futuro. Uno de estos es lo que se guarda en el mem[0] una vez que se vacía el stack. En la implementación actual se deja el valor que últimamente se ha escrito en esta dirección de la memoria, se debe discutir si cambiar esto a 0x000000. Como se dijo anteriormente esto no causa problemas en el funcionamiento pero preocupa que en las próximas integraciones esto cause bugs indeseados. Próximamente v1.1.1 con el plan de pruebas y un posible cambio en el FIFO.

**Se agrega:**
- Leonardo Agüero:
  - Memoria FIFO conductual (fifo.v).
  - Memoria FIFO estructural (fifo_estr.v).
  - Probador que interactúa con la señal fifo_full de la memoria FIFO (probador.v).
