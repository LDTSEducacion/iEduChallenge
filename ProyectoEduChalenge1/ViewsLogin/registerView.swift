//
//  registerView.swift
//  Proyecto EduChalenge
//
//  Created by LDTS Educacion on 24/3/23.
//

import SwiftUI

struct registerView: View {
    @State var nombre: String = ""
    @State var apellidos: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var email: String = ""
    
    var body: some View {
        VStack{
            Text("Crear Cuenta")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom,20)
            
            
            TextField("Nombre", text: $nombre)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                .cornerRadius(5.0)
                .padding(.bottom, 20.0)
            TextField("Apellidos", text: $apellidos)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                .cornerRadius(5.0)
                .padding(.bottom, 20.0)
            TextField("Nombre de Usuario", text: $username)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                .cornerRadius(5.0)
                .padding(.bottom, 20.0)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                .cornerRadius(5.0)
                .padding(.bottom, 20.0)
            
            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))                .cornerRadius(5.0)
                .padding(.bottom, 20.0)
            
           Button {
              
               if( !username.isEmpty && !email.isEmpty && !password.isEmpty && !nombre.isEmpty && !apellidos.isEmpty){
                   loaddatausu12()
                   print("Cuenta Creada")
               }
            } label: {
              Text("Crear Cuenta")
              .font(.title2)
              .bold()
              .foregroundColor(.white)
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(20)
            .padding()
            
            
            
        }.padding()
        
        
        
    }
    func loaddatausu12() {
        //ESTA FUNCIÓN CONECTA CON LA API POR HTTPS Y RECIBE LA INFO EN JSON
        //PARA QUE PUEDA USAR LAS VARIABLE models Y SER LLAMADA DESDE body,
        //TIENE QUE DEFINIRSE DENTRO DEL MISMO STRUCT.
        
        let direccion = "https://alcerreca.es/phplab/edu4.php?usuario="+username+"&passwd="+password+"&email="+email+"&nombre="+nombre+"&apellidos="+apellidos
        
        guard let url: URL = URL(string: direccion) else {
            print("HTTPS Server Connection Error")
            return
            
        }
        
        var urlRequest: URLRequest =
        URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        //A CONTINUACIÓN CONECTAMOS...
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else {
                print("Invalid HTTPS Response")
                return
            }
            
            //SI HA CONECTADO BIEN Y SE HA RECIBIDO LOS DATOS EN JSON EN LA VARIABLE data...
            
        }).resume()
    }
}

struct registerView_Previews: PreviewProvider {
    static var previews: some View {
        registerView()
    }
}
