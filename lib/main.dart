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

  // Helper methods for responsive design
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 900;
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 900;

  int getGridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 2;
    if (isTablet(context)) return 3;
    return 4;
  }

  double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 600) return baseSize * 0.8;
    if (screenWidth < 900) return baseSize * 0.9;
    return baseSize;
  }

  double getResponsivePadding(BuildContext context, double basePadding) {
    if (isMobile(context)) return basePadding * 0.7;
    if (isTablet(context)) return basePadding * 0.85;
    return basePadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // CABECERA RESPONSIVE
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: getResponsivePadding(context, 20),
              horizontal: getResponsivePadding(context, 16),
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
            child: Column(
              children: [
                Text(
                  'PRIME DOX',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, 28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getResponsivePadding(context, 6)),
                Text(
                  'Servicios Profesionales de Información',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: getResponsiveFontSize(context, 16),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // CONTENIDO RESPONSIVE
          Expanded(
            child: isMobile(context)
                ? _buildMobileLayout(context)
                : _buildDesktopLayout(context),
          ),
        ],
      ),
    );
  }

  // Layout para móviles (columna vertical)
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SERVICIOS
          Padding(
            padding: EdgeInsets.all(getResponsivePadding(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SERVICIOS DISPONIBLES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getResponsivePadding(context, 10)),
                _buildServicesGrid(context),
              ],
            ),
          ),

          // CONTACTOS
          Padding(
            padding: EdgeInsets.all(getResponsivePadding(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CONTACTOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getResponsivePadding(context, 16)),
                _buildContactsList(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Layout para tablet/desktop (fila horizontal)
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // SERVICIOS
        Expanded(
          flex: isDesktop(context) ? 3 : 2,
          child: Padding(
            padding: EdgeInsets.all(getResponsivePadding(context, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SERVICIOS DISPONIBLES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: getResponsivePadding(context, 10)),
                Expanded(child: _buildServicesGrid(context)),
              ],
            ),
          ),
        ),

        // CONTACTOS
        Container(
          width: isDesktop(context) ? 300 : 250,
          padding: EdgeInsets.symmetric(
            horizontal: getResponsivePadding(context, 12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getResponsivePadding(context, 16)),
              Padding(
                padding: EdgeInsets.only(
                  left: getResponsivePadding(context, 20),
                ),
                child: Text(
                  'CONTACTOS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: getResponsiveFontSize(context, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: getResponsivePadding(context, 16)),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: _buildContactsList(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Grid de servicios responsive
  Widget _buildServicesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: isMobile(context),
      physics: isMobile(context) ? const NeverScrollableScrollPhysics() : null,
      crossAxisCount: getGridCrossAxisCount(context),
      crossAxisSpacing: getResponsivePadding(context, 10),
      mainAxisSpacing: getResponsivePadding(context, 10),
      childAspectRatio: isMobile(context) ? 1.1 : 0.9,
      children: [
        servicioItem('RENIEC', Icons.person, Colors.blue, context),
        servicioItem('TELEFONIA', Icons.phone, Colors.green, context),
        servicioItem('DELITOS', Icons.security, Colors.red, context),
        servicioItem('SUNARP', Icons.home, Colors.orange, context),
        servicioItem('GENERADOR', Icons.build, Colors.purple, context),
        servicioItem('FAMILIARES', Icons.group, Colors.pink, context),
        servicioItem('SPAM', Icons.mail, Colors.indigo, context),
        servicioItem('SEEKER', Icons.search, Colors.teal, context),
        servicioItem('ACTAS', Icons.folder, Colors.brown, context),
        servicioItem('EXTRA', Icons.add, Colors.cyan, context),
        servicioItem('INFO BURRO', Icons.star, Colors.amber, context),
        servicioItem('RQ', Icons.diamond, Colors.deepPurple, context),
      ],
    );
  }

  // Lista de contactos responsive
  Widget _buildContactsList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        contactoItem(
          nombre: 'PEDRO DOXING',
          rol: 'DUEÑO',
          assetImage: 'assets/pedro.jpg',
          numeroWhatsApp: '51950321131',
          context: context,
        ),
        SizedBox(height: getResponsivePadding(context, 20)),
        contactoItem(
          nombre: 'JOSE',
          rol: 'JOSE',
          assetImage: 'assets/jose.jpg',
          numeroWhatsApp: '51913447999',
          context: context,
        ),
        SizedBox(height: getResponsivePadding(context, 20)),
        contactoItem(
          nombre: 'ANÓNIMO DOX',
          rol: 'HACKER',
          assetImage: 'assets/anonimo.jpg',
          numeroWhatsApp: '51973108528',
          context: context,
        ),
      ],
    );
  }

  // WIDGET SERVICIO RESPONSIVE
  Widget servicioItem(
    String titulo,
    IconData icono,
    Color color,
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, color: Colors.white, size: isMobile(context) ? 24 : 30),
            SizedBox(height: getResponsivePadding(context, 8)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getResponsivePadding(context, 4),
              ),
              child: Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getResponsiveFontSize(context, 12),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET CONTACTO RESPONSIVE
  Widget contactoItem({
    required String nombre,
    required String rol,
    required String assetImage,
    required String numeroWhatsApp,
    required BuildContext context,
  }) {
    double avatarRadius = isMobile(context) ? 35 : 40;

    return Container(
      width: isMobile(context) ? double.infinity : null,
      padding: EdgeInsets.all(getResponsivePadding(context, 12)),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundImage: AssetImage(assetImage),
          ),
          SizedBox(height: getResponsivePadding(context, 10)),
          Text(
            nombre,
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: getResponsiveFontSize(context, 14),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: getResponsivePadding(context, 10)),
          SizedBox(
            width: isMobile(context) ? double.infinity : null,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(
                  horizontal: getResponsivePadding(context, 16),
                  vertical: getResponsivePadding(context, 8),
                ),
              ),
              child: Text(
                rol,
                style: TextStyle(fontSize: getResponsiveFontSize(context, 12)),
              ),
            ),
          ),
          SizedBox(height: getResponsivePadding(context, 6)),
          SizedBox(
            width: isMobile(context) ? double.infinity : null,
            child: ElevatedButton.icon(
              onPressed: () {
                launchWhatsApp(numeroWhatsApp);
              },
              icon: Icon(Icons.chat, size: getResponsiveFontSize(context, 16)),
              label: Text(
                'Contactar',
                style: TextStyle(fontSize: getResponsiveFontSize(context, 12)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: getResponsivePadding(context, 16),
                  vertical: getResponsivePadding(context, 8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
