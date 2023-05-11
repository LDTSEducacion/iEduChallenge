//
//  MainView.swift
//  Proyecto EduChalenge
//
//  Created by LDTS Educacion on 24/3/23.
//

import SwiftUI

struct MainView: View {
    @State var desafios: [desafio] = []
    @State private var sesion = UserDefaults.standard.bool(forKey: "sesion")
    @State private var usu = UserDefaults.standard.string(forKey: "usuario")

    
    var body: some View {
        
        /* Section {
            Label("Altair CRM", systemImage: "applewatch")
                .font(.subheadline)
            Label("by LDTS", systemImage: "signature")
                .font(.footnote)
        }
        

        Divider().padding(.top, 1.0).padding(.bottom, 1.0).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
         */
        
        
        NavigationView{
            
            VStack {
                if(sesion){
                    Text("Bienvenido ")
                }else{
                    NavigationLink("Iniciar Sesion",destination: loginView())

                }
                
                
                //ANTES DE MOSTRAR ESTA VSTACK SE EJECUTARA EL onAppear QUE ESTA DEBAJO...
                List (self.desafios) { (Desafio) in
                    @State var t1 = Desafio.id_Desafio ?? ""
                    VStack{
                        	
                        
                        HStack{
                            Text("Desafio "+t1).bold()
                            //Text(t2).fontWeight(Font.Weight.light)
                            
                            NavigationLink("",destination: DesafioView(done: $desafios, t1: $t1))
                            
                        }.padding(.bottom, 2)
                        
                        
                    }
                }.refreshable {
                    //ESTO SE EJECUTA CUANDO ARRASTRO LA LISTA HACIA ABAJO...
                    loaddata()
                }
                
            }.onAppear(perform: {
                //ESTO SE EJECUTA ANTES DE QUE APAREZCA EL VStack
                loaddata()
            })
            .padding()
            .navigationTitle("Edu Chalenge")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
            //AQUI ESTA EL CONTENIDO PRINCIPAL: LA LISTA VERTICAL
            
            
        
        
        func loaddata() {
            //ESTA FUNCIÓN CONECTA CON LA API POR HTTPS Y RECIBE LA INFO EN JSON
            //PARA QUE PUEDA USAR LAS VARIABLE models Y SER LLAMADA DESDE body,
            //TIENE QUE DEFINIRSE DENTRO DEL MISMO STRUCT.
            guard let url: URL = URL(string: "https://alcerreca.es/phplab/edu1.php") else {
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
                    self.desafios = try  //...INTENTO DECODIFICAR EL JSON QUE DEBE CUADRAR CON EL MODELO ResponseModel
                    JSONDecoder().decode(
                        [desafio].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            }).resume()
        }
        
    

    

    
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
    
}
class desafio: Codable, Identifiable{
    //ESTE ES EL MODELO CON EL QUE DECODIFICARE EL JSON QUE RECIBA POR HTTPS...
    //TIENE QUE CASAR CON LA QUERY Y EL OBJETO JSON DE LA API EN EL SERVIDOR HTTPS
    var id_Desafio: String? = ""
    var pregunta: String? = ""
    var solucion: String? = ""
}
