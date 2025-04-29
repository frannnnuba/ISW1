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
IDIOM: expresiones idiomaticas bien conocidas
Evitar modelos redundantes: si se puede calcular con recursion de los objetos algo que me estaba guardando con una variable es redundante y no quieren en la materia.
Por ej en el stack no guardar el size si no hacer que lo calcule desde el top y cuando llega a la base suma 0.
No diseñar por querer hacer repeticiones tempranas (el size se obtiene en O(1) pero quizas se usa una sola vez versus cada vez que hago un push pop etc hacer mil sumas restas etc)
1) Modelar en especifico para un sentence finder para un prefix especifico, un one time only. Esto es clausurarlo, si se hace particular es mas facil que querer hacerlo generico
Method object: sirve para modelar metodos con objetos (quiero sacar un metodo fuera de lo que podria llegar a estar dentro del objeto y muy probablemente va a usar
variables locales como colaboradores internos para no tener que andar pasandolos como parametros constantemente y son esenciales al metodo pues se desprende del objeto).
fijarse como escribir los if para ver el orden en que los vamos a sacar despues tenga sentido (en el de los penales si se arrancaba con el arquero despues delantero despues
pelota no seria tan intuitivo, se puede igual pero cuesta)
lo que cambia es la condicion, lo que hay que chequear.
como parametrizar valores que usa la funcion mientras que en otra cambia la funcion
parametrizar el como se hacen las cosas se hace con closure. Si lo que cambia es el como es una cosa(closure), y otras son los parametros(numeros etc)
meter chequeos en asserts (assert direccion etc) lo hace mas declarativo (separar el que del como)
arqueroCoordenadasCorrectas y fuerza suficiente, closures que chequean las condiciones.
la forma ahora de como estan escritos nos permite sacar los if de manera mucho mas facil a como estaban antes.
jerarquia polimorfica estrategiadetiro subclasifica aMatar y aColocar que sepa  responder el mensaje m, el arquero tiene que tener un mensaje que le mande a la jerarquia y sepa responder, si desde penales quisiera obtener la estrategia para mandarle msj rompe encapsulamiento.
en este caso los setters son las variables temporales, en la mayoria de casos esta mal, pero como es un method object que hacia eso originalmente no esta mal ni esta rompiendo encapsulamiento.
cadena de que con cada objeto encapsula el como
jerarquia atajada
si no se quiere  un method object se tiene que tener muchos metodos con parametros donde se defina con lo que se cambio desde la instancia mas baja (o un closure quizas etc)
el que introdujo el tema a el problema tiene que tenerlo luego de sacar los if etc.
