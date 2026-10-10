# Càmera per fotos de carnet

Aplicació d'escriptori per a Windows que fa fotos de carnet amb la webcam. Mostra la imatge de la càmera en format vertical, fa la foto en prémer un botó i la desa on triïs, retallada amb el mateix enquadrament que es veu a la finestra.

Està feta amb Qt 6 (Qt Quick/QML per a la interfície i C++ per al tractament de la imatge).

## Com funciona

1. En obrir l'app apareix la finestra de la càmera i una finestra amb les instruccions.
2. Col·loca't davant la càmera, centra la cara i prem **Fer foto**.
3. S'obre un diàleg per triar la carpeta i el nom del fitxer.
4. La foto es desa en JPEG, retallada a la mida de la vista de càmera (320 × 400 píxels).

Si cancel·les el diàleg, la foto es descarta.

## Instal·lar una release

Només hi ha versió per a Windows de 64 bits.

1. Ves a l'apartat [Releases](https://github.com/nilis24/CameraFotosCarnet/releases) i obre la darrera versió.
2. Descarrega `CameraFotosCarnet-<versió>-win64-setup.exe` i executa'l.
3. Windows pot mostrar l'avís «Windows ha protegit el teu PC» perquè l'instal·lador no està signat. Prem **Més informació** i després **Executa igualment**.
4. Segueix l'assistent. No calen permisos d'administrador.

L'app queda al menú d'inici i es pot desinstal·lar des de *Configuració → Aplicacions*.

Si no la vols instal·lar, descarrega el fitxer `CameraFotosCarnet-<versió>-win64.zip`, descomprimeix-lo i executa `appCameraFotosCarnet.exe`.

La primera vegada, comprova que Windows permet l'accés a la càmera a *Configuració → Privadesa i seguretat → Càmera*.

## Executar-la amb Qt Creator

### Requisits

- Qt 6.10 o posterior (el projecte es desenvolupa amb Qt 6.12.0), amb el kit **MinGW 64-bit**.
- El mòdul addicional **Qt Multimedia**, que s'ha de marcar a l'instal·lador de Qt.
- Qt Creator i CMake, que s'instal·len amb Qt.

### Passos

1. Clona el repositori:

   ```bash
   git clone https://github.com/nilis24/CameraFotosCarnet.git
   ```

2. Obre Qt Creator, ves a *File → Open File or Project...* i tria el fitxer `CMakeLists.txt`.
3. Selecciona el kit **Desktop Qt 6.x MinGW 64-bit** i prem **Configure Project**.
4. Executa l'app amb **Ctrl+R** (el triangle verd).

Els missatges de depuració surten al panell *Application Output*.

## Estructura del projecte

| Fitxer | Contingut |
|---|---|
| `Main.qml` | Interfície: finestra de càmera, botó, diàleg de desar i finestra d'instruccions |
| `PhotoManager.h` / `.cpp` | Classe C++ que escala, retalla i desa la foto |
| `main.cpp` | Punt d'entrada; carrega el QML i posa la icona de l'app |
| `assets/` | Icones de l'aplicació |
| `installer/` | Script d'Inno Setup per generar l'instal·lador |
| `.github/workflows/ci.yml` | Integració contínua i publicació de releases |

## Publicar una versió nova

A cada push a `master`, GitHub Actions compila el projecte amb els avisos com a errors i passa `qmllint`. Per publicar una release, puja un tag que comenci per `v`:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Si la compilació passa, l'instal·lador i el zip es publiquen automàticament a l'apartat de Releases.

## Llicència

El codi d'aquest projecte es publica sota la [llicència MIT](LICENSE).

Les releases inclouen les biblioteques de Qt, que es distribueixen sota la llicència LGPL v3.
