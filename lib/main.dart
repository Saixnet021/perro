import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PrimeDoxApp());
}

class PrimeDoxApp extends StatelessWidget {
  const PrimeDoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Dox',
      debugShowCheckedModeBanner: false,
      home: const PrimeDoxHome(),
    );
  }
}

class PrimeDoxHome extends StatelessWidget {
  const PrimeDoxHome({super.key});

  // Método para abrir WhatsApp con número
  void launchWhatsApp(String numero) async {
    final url = Uri.parse('https://wa.me/$numero');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('No se pudo abrir WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // CABECERA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
            ),
            child: const Column(
              children: [
                Text(
                  'PRIME DOX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Servicios Profesionales de Información',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // CONTENIDO
          Expanded(
            child: Row(
              children: [
                // SERVICIOS
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SERVICIOS DISPONIBLES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                            children: [
                              servicioItem('RENIEC', Icons.person, Colors.blue),
                              servicioItem('TELEFONIA', Icons.phone, Colors.green),
                              servicioItem('DELITOS', Icons.security, Colors.red),
                              servicioItem('SUNARP', Icons.home, Colors.orange),
                              servicioItem('GENERADOR', Icons.build, Colors.purple),
                              servicioItem('FAMILIARES', Icons.group, Colors.pink),
                              servicioItem('SPAM', Icons.mail, Colors.indigo),
                              servicioItem('SEEKER', Icons.search, Colors.teal),
                              servicioItem('ACTAS', Icons.folder, Colors.brown),
                              servicioItem('EXTRA', Icons.add, Colors.cyan),
                              servicioItem('INFO BURRO', Icons.star, Colors.amber),
                              servicioItem('RQ', Icons.diamond, Colors.deepPurple),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // CONTACTOS
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 270,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'CONTACTOS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // SCROLL
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  contactoItem(
                                    nombre: 'PEDRO DOXING',
                                    rol: 'DUEÑO',
                                    assetImage: 'assets/pedro.jpg',
                                    numeroWhatsApp: '51950321131',
                                  ),
                                  const SizedBox(height: 20),
                                  contactoItem(
                                    nombre: 'JOSE',
                                    rol: 'JOSE',
                                    assetImage: 'assets/jose.jpg',
                                    numeroWhatsApp: '51913447999',
                                  ),
                                  const SizedBox(height: 20),
                                  contactoItem(
                                    nombre: 'ANÓNIMO DOX',
                                    rol: 'HACKER',
                                    assetImage: 'assets/anonimo.jpg',
                                    numeroWhatsApp: '51973108528',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET SERVICIO
  Widget servicioItem(String titulo, IconData icono, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET CONTACTO
  Widget contactoItem({
    required String nombre,
    required String rol,
    required String assetImage,
    required String numeroWhatsApp,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(assetImage),
          ),
          const SizedBox(height: 10),
          Text(
            nombre,
            style: const TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text(rol),
          ),
          const SizedBox(height: 6),
          ElevatedButton.icon(
            onPressed: () {
              launchWhatsApp(numeroWhatsApp);
            },
            icon: const Icon(Icons.chat),
            label: const Text('Contactar'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
