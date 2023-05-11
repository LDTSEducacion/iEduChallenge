//
//  DesafioView.swift
//  Proyecto EduChalenge
//
//  Created by LDTS Educacion on 28/3/23.
//

import SwiftUI

struct DesafioView: View {
    @Binding var done: [desafio]
    @Binding var t1: String
    
    @State private var respuesta1: String = ""
    @State private var respondido: Bool = false
    @State private var ver: Bool = false
    @State var respuestas: [respuesta] = []
    
    var body: some View {
        
            
            VStack{
                if(!ver){
                    
                
                if(!respondido){
                Text(done[Int(t1)!-1].pregunta ?? "")
                TextField(
                    "Respuesta",
                    text: $respuesta1
                ).padding()
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.848))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20.0)
                
                
                    Button {
                        respondido.toggle()
                    } label: {
                        Text("Enviar Respuesta")
                            .font(.title2)
                            .bold()
                        .foregroundColor(.blue)}
                }
                else if(respondido){
                    Button {
                        ver.toggle()
                    } label: {
                        Text("Ver Respuestas")
                            .font(.title2)
                            .bold()
                        .foregroundColor(.blue)}
                }
                }
                else if(ver){
                    
                    List(self.respuestas) { (Respuesta) in
                        let t2 = Respuesta.respuestaUsu
                        
                        let t4 = Respuesta.nombreUsu
                        VStack{

                            HStack{
                                Text("Usuario: " + (t4 ?? "Sin Nombre")).bold()
                                Text("Respuesta: " + (t2 ?? "")).bold()
                                //Text(t2).fontWeight(Font.Weight.light)
                                                                
                            }.padding(.bottom, 2)
                            
                            
                        }
                    }.refreshable {
                        //ESTO SE EJECUTA CUANDO ARRASTRO LA LISTA HACIA ABAJO...
                        loaddata1()
                        
                    }.onAppear(perform: {
                        //ESTO SE EJECUTA ANTES DE QUE APAREZCA EL VStack
                        loaddata1()
                        
                    })
                    
                }
            }.padding()
                
            
        
        
        }
    
    func loaddata1() {
        //ESTA FUNCIÓN CONECTA CON LA API POR HTTPS Y RECIBE LA INFO EN JSON
        //PARA QUE PUEDA USAR LAS VARIABLE models Y SER LLAMADA DESDE body,
        //TIENE QUE DEFINIRSE DENTRO DEL MISMO STRUCT.
        guard let url: URL = URL(string: "https://alcerreca.es/phplab/edu2.php?id="+t1) else {
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
                self.respuestas = try  //...INTENTO DECODIFICAR EL JSON QUE DEBE CUADRAR CON EL MODELO ResponseModel
                JSONDecoder().decode(
                    [respuesta].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }).resume()
    }
    
    
    
    
    }
class respuesta: Codable, Identifiable{
    //ESTE ES EL MODELO CON EL QUE DECODIFICARE EL JSON QUE RECIBA POR HTTPS...
    //TIENE QUE CASAR CON LA QUERY Y EL OBJETO JSON DE LA API EN EL SERVIDOR HTTPS
    var respuestaUsu: String? = ""
    var idUsuario: String? = ""
    var nombreUsu: String? = ""

}


