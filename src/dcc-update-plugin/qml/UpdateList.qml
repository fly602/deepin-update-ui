// SPDX-FileCopyrightText: 2024 UnionTech Software Technology Co., Ltd.
// SPDX-License-Identifier: GPL-3.0-or-later
import QtQuick 2.0
import QtQuick.Controls 2.0
import Qt.labs.qmlmodels 1.2
import QtQuick.Layouts 1.15

import org.deepin.dtk 1.0 as D
import org.deepin.dtk.style 1.0 as DS
import org.deepin.dcc 1.0

Rectangle {
    id: root

    property alias model: repeater.model
    signal clicked(int index, bool checked)

    color: "transparent"
    implicitHeight: layoutView.height
    Layout.fillWidth: true

    ColumnLayout {
        id: layoutView
        clip: true
        width: parent.width
        spacing: 10

        Repeater {
            id: repeater

            delegate: D.ItemDelegate {
                id: itemCtl
                Layout.fillWidth: true
                leftPadding: 10
                rightPadding: 10
                topPadding: 10
                cascadeSelected: true
                contentFlow: true
                spacing: 0

                content: RowLayout {
                    spacing: 10

                    D.DciIcon {
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        name: model.iconName
                        sourceSize {
                            width: 28
                            height: 28
                        }
                    }

                    ColumnLayout {
                        Layout.alignment: Qt.AlignRight
                        spacing: 10

                        RowLayout {
                            Label {
                                Layout.alignment: Qt.AlignLeft
                                text: model.title
                                font.pixelSize: 14
                                width: 100
                                Layout.fillWidth: true
                            }

                            DccCheckIcon {
                                Layout.alignment: Qt.AlignRight
                                checked: model.checked
                                size: 18

                                onClicked: {
                                    repeater.model.setChecked(index, !model.checked)
                                }
                            }
                        }

                        D.Label {
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            Layout.fillWidth: true
                            font.pixelSize: 12
                            text: model.titleDescription
                            wrapMode: Text.WordWrap
                        }

                        Rectangle {
                            visible: false
                            height: 1
                            color: parent.palette.window
                            Layout.topMargin: 10
                            Layout.bottomMargin: 10
                            Layout.fillWidth: true
                        }

                        D.Label {
                            visible: false
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            font.pixelSize: 12
                            text: qsTr("Updates:")
                        }

                        D.Label {
                            id: shortLog
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            text: model.updateLog
                            font.pixelSize: 12
                            Layout.fillWidth: true
                            opacity: 0.7
                            wrapMode: Text.WordWrap
                        }

                        D.Label {
                            id: detailLog
                            visible: false
                            Layout.alignment: Qt.AlignLeft
                            horizontalAlignment: Text.AlignLeft
                            text: ""
                            font.pixelSize: 12
                            Layout.fillWidth: true
                            opacity: 0.7
                            wrapMode: Text.WordWrap
                        }

                        RowLayout {
                            RowLayout {
                                visible: releaseContent.text.length !== 0
                                Layout.alignment: Qt.AlignLeft
                                D.Label {
                                    id: releaseTitle
                                    Layout.alignment: Qt.AlignLeft
                                    horizontalAlignment: Text.AlignLeft
                                    font.pixelSize: 12
                                    text: qsTr("Release time:")
                                    opacity: 0.7
                                }

                                D.Label {
                                    id: releaseContent
                                    Layout.alignment: Qt.AlignLeft
                                    horizontalAlignment: Text.AlignLeft
                                    font.pixelSize: 12
                                    text: model.releaseTime
                                    opacity: 0.7
                                }
                            }

                            Item {
                                Layout.fillWidth: true
                            }

                            D.ToolButton {
                                Layout.alignment: Qt.AlignRight
                                visible: detailLog.visible
                                text: shortLog.visible ? qsTr("View Details") : qsTr("Collapse")
                                textColor: DS.Style.highlightedButton.text

                                onClicked: {
                                    shortLog.visible = !shortLog.visible
                                    detailLog.visible = !detailLog.visible
                                }
                            }
                        }
                    }
                }

                background: DccItemBackground {
                    separatorVisible: true
                    //highlightEnable: false
                }

                onClicked: {
                    root.clicked(index, !model.checked)
                }
            }
        }
    }
}

