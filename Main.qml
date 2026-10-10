import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic
import QtMultimedia
import CameraFotosCarnet
import QtQuick.Dialogs
import QtCore            // for StandardPaths


ApplicationWindow {
    id: window
    width: 320
    height: 450
    minimumWidth: 320
    minimumHeight: 450
    maximumWidth: 320
    maximumHeight: 450
    visible: true
    title: qsTr("Càmera per fotos de carnet")

    PhotoManager {
        id: photoManager
    }

    property string tempPhotoPath: ""

    FileDialog {
        id: saveDialog
        title: qsTr("Desa la foto")
        fileMode: FileDialog.SaveFile                // "Save as" dialog
        nameFilters: [qsTr("Imatges JPEG (*.jpg)")]
        defaultSuffix: "jpg"                         // appends .jpg if not typed
        currentFolder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)

        onAccepted: photoManager.processPhoto(window.tempPhotoPath, selectedFile,
                                              viewfinder.width, viewfinder.height)
        onRejected: photoManager.discardPhoto(window.tempPhotoPath)   // cancelled
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            id: cameraArea
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "lightgray"

            CaptureSession {
                id: captureSession
                camera: Camera {
                    id: camera
                    active: true            // starts the camera
                }
                imageCapture: ImageCapture {
                    id: photoCapture
                    onImageSaved: (id, filePath) => {
                        window.tempPhotoPath = filePath
                        saveDialog.open()
                    }
                }
                videoOutput: viewfinder
            }

            VideoOutput {
                id: viewfinder
                anchors.fill: parent
                fillMode: VideoOutput.PreserveAspectCrop
            }
        }

        Rectangle {
            id: buttonArea
            width: 320
            height: 50
            Button {
                id: photoButton
                text: qsTr("Fer foto")
                width: 320
                height: 50
                font.pointSize: 14
                font.bold: true
                anchors.centerIn: parent
                onClicked: photoCapture.captureToFile()
                background: Rectangle {
                    color: photoButton.down ? "#d0d0d0" : "lightgray"   // darker while pressed
                    border.color: "black"
                    border.width: 2
                }
            }
        }
    }
    Window {
        id: instructionsWindow
        width: 450
        height: 200
        minimumWidth: 450
        minimumHeight: 200
        maximumWidth: 450
        maximumHeight: 200
        visible: true                      // opens when the app starts
        title: qsTr("Instruccions")

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 16
            spacing: 12

            Label {
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pointSize: 11
                wrapMode: Text.WordWrap    // automatic line wrap
                text: qsTr("1. Col·loca't davant la càmera.\n" +
                           "2. Centra la cara a la imatge i mira a la webcam.\n" +
                           "3. Prem «Fer foto» per desar-la.\n" +
                           "4. S'obrirà la finestra per seleccionar on vols desar la imatge.\n" +
                           "5. Selecciona una ubicació i desa la imatge.\n")
            }

            Button {
                id: instructionsButton
                text: qsTr("Entesos")
                Layout.fillWidth: true          // takes the full width, centered between the margins
                Layout.preferredHeight: 35
                font.pointSize: 11
                font.bold: true
                onClicked: instructionsWindow.close()
                background: Rectangle {
                    color: instructionsButton.down ? "#d0d0d0" : "lightgray"   // darker while pressed
                    border.color: "black"
                    border.width: 2
                }
            }
        }
    }
}
