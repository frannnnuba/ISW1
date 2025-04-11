# ISW1
Metodos colaboradore internos y externos(vars y parametros) minusculaYCamelCase
Objetos globales: MayusculaCamelCase
Convencion de la materia
"Hablar" de manera correcta, no mandarle fruta a los nombres o los profes se van a enojar.
createChildNamed ... te genera una copia, no copia los mensajes explicitamente pero sabe responder los mismos mensajes que el que copio
cloneNamed copia y tiene los atributos copiados, el createChildNamed no.
Notas clase 3:
Programa = conj de objetos que colaboran entre si enviandose mensajes.
Todo es un objeto, no hay ints bools etc solo objetos. Luego no hay rangos para ints en poo; en otros paradigmas estan los rangos.
Objeto: representacion esencial(hace que sea lo que es y no otra cosa) de un ente del del dominio del problema(recorte de la realidad).
Mensaje: parte declarativa del modelo (lo que sabe responder que lo representa, el 'que')
Acoplamiento: medida de relacion entre objetos. Tratar de hacer el menor acoplamiento posible, facilita el cambio(todo acople no deberia sacar esencia al diseño).
Metodo: implementacion de un mensaje, osea la implementacion del 'que' ---> parte implementativa del modelo. Es un objeto
Codigo fuente != codigo (codigo fuente es el que escribe el programador)
SendTo define la esencia de un mensaje, mientras que un metodo recibe un executeWith: (ejecutate).
La forma de saber si un objeto pertenece a la esencia del ente del dominio es cuando no le puedo sacar cosas a ese mensaje. Si se puede sacar un mensaje y sigue cumpliendo
entonces no formaba parte de la esencia.
Colaboracion: hecho de que un objeto le envie un msj a otro. Cuando el receptor recibe un msj buca el metodo asociado (si lo encuentr) y devuelve un resultado. Caracc: dirigidas, sincronicas(no puede hacer nada mas mientras espera respuesta), siempre hay respuesta, el receptor desconoce el emisor.
Colaboracion sintaxis: objeto receptor mensaje (el emisor no se escribe nunca).
CreateChildOf: te permite no copiar codigo si no que un objeto va a servir de prototipo, el codigo va a estar en el prototipo. 
Notas clase 4:
¿codigo fuente vs codigo?
En smalltalk no es solo texto es codigo.
Refactory automatizado: son modificar las herramientas del ambiente para cambiar el codigo fuente (cambiar nombres,cambiar referencias, implementadores)
Senders: lugares donde se envia el mensaje.
Implementor: donde se implementa el mensaje.
Cohesion medida de representacion del objeto con un ente real.
alta cohesion bajo acoplamiento (goal).

Idea sacarIfs 1.4: tiene 5 colaboradores de instancia: state, type,speed,altitude,engineType, where.
Lo que queremos es abstraer objetos de la realidad en objetos computables QUE SE COMPORTAN COMO.
Si inicializo un vehiculo apagado, lo prendo y despues lo apago no quiero que me cambie el auto 3 veces, quiero que el estado del motor de ESE auto se cambie a lo que corresponde, luego es el motor quien debe COMPORTARSE COMO el tipo que sea (apagado/prendido).Aca quiero saber quien es el vehiculo cuyo estado es la instancia asi que sera un colaborador interno de instancia.
Luego tenemos el motor de ESE auto, los motores se pueden subclasificar en base a que consumen para andar, y deben poder conocer su estado (prendido/apagado), no les importa ni la velocidad ni el tipo de vehiculo ni la altura ni en donde se mueve. Su colaborador interno sera con power status. ese auto deberia ser capaz de saber que tipo de motor tiene, mas no la vuelta.
El where viene dado por el tipo de motor aparentemente y no tiene que ser simetrica la relacion.
por lo visto ademas hay codigo repetido en los tests, en principio abstraerlo a nuevos mensajes.
