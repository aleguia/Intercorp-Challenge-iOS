

import Foundation
class User {
    
    var nombre: String
    var apellido: String
    var edad: Int
    var fechaDeNacimiento: String
    var email: String
    
    init() {
        nombre = ""
        apellido = ""
        edad = 0
        fechaDeNacimiento = ""
        email = ""
    }
    
    init(_nombre: String, _apellido: String, _edad: Int, _fechaDeNacimiento: String, _email: String) {
        nombre = _nombre
        apellido = _apellido
        edad = _edad
        fechaDeNacimiento = _fechaDeNacimiento
        email = _email
    }
}
