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
