/* Copyright 2017 Esri
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */
import QtQuick 2.7
import QtQuick.Controls 2.1
import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0
//import Esri.ArcGISRuntime 100.1
import "./MyButton"
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.1
import ArcGIS.AppFramework 1.0
import ArcGIS.AppFramework.Controls 1.0
import Esri.ArcGISRuntime 100.1


App {
    id: app
    width: 400
    height: 640
    Loader {
       id:loder
       anchors.fill: parent
     }

    Item {
        width: 200
        height: 200
      }

    Rectangle {
            id: bgr_rect
            width: app.width
            height: app.height
            color: "grey"
            opacity: 0.5
            anchors.centerIn: parent

            MapView {
                id: mv
                anchors.fill: parent

                Map {
                    id:map
                    BasemapOpenStreetMap {}
                    initialViewpoint:springViewpoint
                }

                //Busy Indicator
                BusyIndicator {
                    anchors.centerIn: parent
                    height: 48 * scaleFactor
                    width: height
                    running: true
                    Material.accent:"#8f499c"
                    visible: (mv.drawStatus === Enums.DrawStatusInProgress)
                }
            }

            // Create the intial Viewpoint
            ViewpointExtent {
                id: springViewpoint
                extent: Envelope {
                    xMin:482293.38
                    xMax:483311.54
                    yMin:2631983.19
                    yMax:2978128.02
                    spatialReference: SpatialReference { wkid: 102100 }
                }
            }
            ComboBox {
                id: comboBoxBasemap
                anchors.left: parent.left
                width: 150
                height: 50
                Material.accent:"#8f499c"
                background: Rectangle {
                    radius: 6 * scaleFactor
                    border.color: "darkgrey"
                    width: 140 * scaleFactor
                    height: 30 * scaleFactor
                }

                model: ["Topographic","Streets","Imagery","Oceans"]
                onCurrentTextChanged: {
                    // Call this JavaScript function when the current selection changes
                    if (map.loadStatus === Enums.LoadStatusLoaded)
                        changeBasemap();
                }

                function changeBasemap() {
                    // Determine the selected basemap, create that type, and set the Map's basemap
                    switch (comboBoxBasemap.currentText) {
                    case "Topographic":
                        map.basemap = ArcGISRuntimeEnvironment.createObject("BasemapTopographic");
                        break;
                    case "Streets":
                        map.basemap = ArcGISRuntimeEnvironment.createObject("BasemapStreets");
                        break;
                    case "Imagery":
                        map.basemap = ArcGISRuntimeEnvironment.createObject("BasemapImagery");
                        break;
                    case "Oceans":
                        map.basemap = ArcGISRuntimeEnvironment.createObject("BasemapOceans");
                        break;
                    default:
                        map.basemap = ArcGISRuntimeEnvironment.createObject("BasemapTopographic");
                        break;
                    }
                }
            }

}
        MessageDialog {
            id: messageDialog
            title: "May I have your attention please"
            text: "It's so cool that you are using Qt Quick."
            onAccepted: {
                console.log("And of course you could only agree.")
                Qt.quit()
            }
            Component.onCompleted: {
                    mouseArea.clicked.connect(Qtjs.func)
                }
        }




}


