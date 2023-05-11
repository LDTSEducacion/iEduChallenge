//
//  loginView.swift
//  Proyecto EduChalenge
//
//  Created by LDTS Educacion on 24/3/23.
//

import SwiftUI

struct loginView: View {
    
    @State private var showRegistration = false
    @State var sesionIniciada = false
    @State var username: String = ""
    @State var password: String = ""
    @State var usuarios: [usuario] = []
    @State private var action: Int? = 0
    
    var body: some View {
        
        if(!sesionIniciada){
            VStack{
                Text("Bienvenido!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom,20)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20.0)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))                .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
               Button {
                   loaddatausu()
                   if(usuarios.count==0){
                       print("Cuenta Incorrecta")
                   }
                   else{
                       sesionIniciada.toggle()
                       UserDefaults.standard.set(self.sesionIniciada, forKey: "sesion")
                       UserDefaults.standard.set(self.username, forKey: "usuario")   
                   }
                                   } label: {
                                     Text("Sign In")
                                     .font(.title2)
                                     .bold()
                                     .foregroundColor(.white)
                                   }
                                   .frame(height: 50)
                                   .frame(maxWidth: .infinity)
                                   .background(Color.blue)
                                   .cornerRadius(20)
                                   .padding()
                                   
                                   Button {
                                      print("Registrar")
                                       showRegistration.toggle()
                                    } label: {
                                      Text("Crear cuenta")
                                      .font(.title3)
                                      .bold()
                                      .foregroundColor(.black)
                                    }
                                    .frame(height: 5.0)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .sheet(isPresented: $showRegistration, content:{
                                        registerView()
                                    })
                                   
                               }.padding()
                           }else{
                               VStack{
                                   Text("Haz iniciado sesion correctamente")
                                   
                               }
        }
        
        
        
    }
    
    func loaddatausu() {
        //ESTA FUNCIÓN CONECTA CON LA API POR HTTPS Y RECIBE LA INFO EN JSON
        //PARA QUE PUEDA USAR LAS VARIABLE models Y SER LLAMADA DESDE body,
        //TIENE QUE DEFINIRSE DENTRO DEL MISMO STRUCT.
        guard let url: URL = URL(string: "https://alcerreca.es/phplab/edu3.php?usuario="+username+"&passwd="+password) else {
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
            do {
                self.usuarios = try  //...INTENTO DECODIFICAR EL JSON QUE DEBE CUADRAR CON EL MODELO ResponseModel
                JSONDecoder().decode(
                    [usuario].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }
}

struct loginView_Previews: PreviewProvider {
    static var previews: some View {
        loginView()
    }
}

class usuario: Codable, Identifiable{
    //ESTE ES EL MODELO CON EL QUE DECODIFICARE EL JSON QUE RECIBA POR HTTPS...
    //TIENE QUE CASAR CON LA QUERY Y EL OBJETO JSON DE LA API EN EL SERVIDOR HTTPS
    var usuarioId: String? = ""
    
    
}
