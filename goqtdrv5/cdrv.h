/********************************************************************
** Copyright 2012 visualfc <visualfc@gmail.com>. All rights reserved.
**
** This library is free software; you can redistribute it and/or
** modify it under the terms of the GNU Lesser General Public
** License as published by the Free Software Foundation; either
** version 2.1 of the License, or (at your option) any later version.
**
** This library is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
** Lesser General Public License for more details.
*********************************************************************/
#include "qtdrv_global.h"
#include "qtsignal.h"
#include "qtevent.h"
#include "qtapp.h"
#include "qtshell.h"

#include <QApplication>
#include <QWidget>
#include <QLayout>
#include <QMetaType>
#include <QVariant>
#include <QEvent>
#include <QSlider>
#include <QSystemTrayIcon>
#include <QToolButton>
#include <QIcon>
#include <QPixmap>
#include <QPen>
#include <QBrush>
#include <QDebug>
#include <QSizePolicy>
#include <QLineEdit>
#include <QMessageBox>
#include <QHeaderView>
#include <QMediaPlaylist>
#include <QFile>
#include <iostream>

class QDockWidget;
class QToolBar;
class QMenu;
class QMenuBar;
class QAction;
class QLayout;
class QStatusBar;
class QListWidgetItem;
class QLineEdit;

#include <stdint.h>
#if UINTPTR_MAX == 0xffffffff
// 32 bit build
typedef int32_t goInt;
typedef uint32_t goUint;
#else
// 64 bit build
typedef int64_t goInt;
typedef uint64_t goUint;
#endif
typedef uint8_t goBool;


#define drvInvalid (void*)-1

void utf8_info_copy(void*, const char*, goInt);

struct handle_head {
    void *native;
    goInt classid;
};

struct string_head {
    char *data;
    goInt len;
};

struct slice_head {
    const char *data;
    goInt len;
    goInt cap;
};

struct point_head {
    goInt x;
    goInt y;
};

struct pointf_head {
    double x;
    double y;
};

struct size_head {
    goInt width;
    goInt hegiht;
};

struct sizef_head {
    double width;
    double height;
};

struct rect_head {
    goInt x;
    goInt y;
    goInt width;
    goInt height;
};

struct rectf_head {
    double x;
    double y;
    double width;
    double height;
};

struct margins_head {
    goInt left;
    goInt top;
    goInt right;
    goInt bottom;
};

struct color_head {
    quint32 r;
    quint32 g;
    quint32 b;
    quint32 a;
};

typedef unsigned char byte;

inline QString drvGetString(void *param)
{
    if (param == 0) {
        return QString();
    }
    string_head *h = (string_head*)param;
    return QString::fromUtf8(h->data, h->len);
}

inline void drvSetString(void *param, const QString &s)
{
    if (param == 0) {
        return;
    }
    const QByteArray & ar = s.toUtf8();
    // It's done this way to make sure the content isn't collected by the GO GC.
    utf8_info_copy(param, ar.constData(), ar.length());
}

inline QColor drvGetColor(void *param)
{
    if (param == 0) {
        return QColor();
    }
    return QColor(*(QRgb*)param);
}

inline void drvSetColor(void *param, const QColor &clr)
{
    if (param == 0) {
        return;
    }
    *(QRgb*)param = clr.rgba();
}

inline QPoint drvGetPoint(void *param)
{
    if (param == 0) {
        return QPoint();
    }
    point_head *h = (point_head*)param;
    return QPoint(h->x, h->y);
}

inline QPointF drvGetPointF(void *param)
{
    if (param == 0) {
        return QPointF();
    }
    pointf_head *h = (pointf_head*)param;
    return QPointF(h->x, h->y);
}

inline QVector<QPoint> drvGetPointArray(void *param)
{
    if (param == 0) {
        return QVector<QPoint> ();
    }
    slice_head *sh = (slice_head*)param;
    QVector<QPoint> vec(sh->len);
    point_head *h = (point_head*)sh->data;
    for (int i = 0; i < sh->len; i++) {
        vec[i] = QPoint(h[i].x, h[i].y);
    }
    return vec;
}

inline QVector<QRect> drvGetRectArray(void *param)
{
    if (param == 0) {
        return QVector<QRect>();
    }
    slice_head *sh = (slice_head*)param;
    QVector<QRect> vec(sh->len);
    rect_head *h = (rect_head*)sh->data;
    for (int i = 0; i < sh->len; i++) {
        vec[i] = QRect(h[i].x, h[i].y, h[i].width, h[i].height);
    }
    return vec;
}

inline QByteArray drvGetByteArray(void *param)
{
    if (param == 0) {
        return QByteArray();
    }
    slice_head *sh = (slice_head*)param;
    return QByteArray(sh->data, sh->len);
}

inline void drvSetByteArray(void *param, const QByteArray& array)
{
    if (param == 0) {
        return;
    }

    slice_head *sh = (slice_head*)param;
    sh->len = array.size();
    sh->data = array.data();
}

inline QStringList drvGetStringArray(void *param)
{
    if (param == 0) {
        return QStringList();
    }
    slice_head *sh = (slice_head*)param;
    QStringList stringList;
    string_head *goStrings = (string_head*)sh->data;

    for (goInt i=0; i<sh->len; i++) {
        QString str = QString::fromUtf8(goStrings[i].data, goStrings[i].len);
        stringList.push_back(str);
    }
    return stringList;
}

inline void drvSetStringArray(void *param, const QStringList &s)
{
    if (param == 0) {
        return;
    }

    // Get the slice head and set its size
    slice_head *sh = (slice_head*)param;
    sh->len = s.size();
    sh->cap = s.size();

    string_head *stringData = new string_head[sh->len];
    sh->data = (char*)stringData;

    for (goInt i = 0; i < sh->len; i++) {
        // Convert the string as normal
        const QByteArray& ar = s[i].toUtf8();
        utf8_info_copy(&(stringData[i]), ar.constData(), ar.length());
    }
}

inline void drvSetPoint(void *param, const QPoint &pt)
{
    if (param == 0) {
        return;
    }
    point_head *sh = (point_head*)param;
    sh->x = pt.x();
    sh->y = pt.y();
}

inline QSize drvGetSize(void *param)
{
    if (param == 0) {
        return QSize();
    }
    size_head *h = (size_head*)param;
    return QSize(h->width, h->hegiht);
}

inline void drvSetSize(void *param, const QSize &sz)
{
    if (param == 0) {
        return;
    }
    size_head *h = (size_head*)param;
    h->width = sz.width();
    h->hegiht = sz.height();
}

inline QRect drvGetRect(void *param)
{
    if (param == 0) {
        return QRect();
    }
    rect_head *h = (rect_head*)param;
    return QRect(h->x, h->y, h->width, h->height);
}

inline QRectF drvGetRectF(void *param)
{
    if (param == 0) {
        return QRectF();
    }
    rectf_head *h = (rectf_head*)param;
    return QRectF(h->x, h->y, h->width, h->height);
}


inline void drvSetRect(void *param, const QRect &rc)
{
    if (param == 0) {
        return;
    }
    rect_head *h = (rect_head*)param;
    h->x = rc.x();
    h->y = rc.y();
    h->width = rc.width();
    h->height = rc.height();
}

inline QMargins drvGetMargins(void *param)
{
    if (param == 0) {
        return QMargins();
    }
    margins_head *h = (margins_head*)param;
    return QMargins(h->left, h->top, h->right, h->bottom);
}

inline void drvSetMargins(void *param, const QMargins &mr)
{
    if (param == 0) {
        return;
    }
    margins_head *h = (margins_head*)param;
    h->left = mr.left();
    h->top = mr.top();
    h->right = mr.right();
    h->bottom = mr.bottom();
}

inline bool drvGetBool(void *param)
{
    return *(goBool*)param != 0;
}

inline void drvSetBool(void *param, bool b)
{
    *(goBool*)param = b ? 1 : 0;
}

inline int drvGetInt(void *param)
{
    return *(goInt*)param;
}

inline int drvGetUint(void *param)
{
    return *(goUint*)param;
}

inline void drvSetInt(void *param, int value)
{
    *(goInt*)param = value;
}

inline QSystemTrayIcon::MessageIcon drvGetMessageIconType(void *param)
{
    return QSystemTrayIcon::MessageIcon(*(goInt*)param);
}

inline QMessageBox::Icon drvGetMessageBoxIcon(void *param)
{
    return QMessageBox::Icon(*(goInt*)param);
}

inline void drvSetMessageBoxIcon(void *param, QMessageBox::Icon value)
{
    *(goInt*)param = value;
}

inline QHeaderView::ResizeMode drvGetHeaderResizeMode(void *param)
{
    return QHeaderView::ResizeMode(*(goInt*)param);
}

inline void drvSetHeaderResizeMode(void *param, QHeaderView::ResizeMode value)
{
    *(goInt*)param = value;
}

inline QMessageBox::StandardButtons drvGetStandardButtons(void *param)
{
    return (QMessageBox::StandardButtons)(int)(*(goInt*)param);
}

inline void drvSetStandardButtons(void *param, QMessageBox::StandardButtons value)
{
    *(goInt*)param = value;
}

inline Qt::ItemFlags drvGetItemFlags(void *param)
{
    return (Qt::ItemFlags)(int)(*(goInt*)param);
}

inline void drvSetItemFlags(void *param, Qt::ItemFlags value)
{
    *(goInt*)param = value;
}

inline Qt::CheckState drvGetCheckState(void *param)
{
    return (Qt::CheckState)(int)(*(goInt*)param);
}

inline void drvSetCheckState(void *param, Qt::CheckState value)
{
    *(goInt*)param = value;
}

inline Qt::Alignment drvGetAlignment(void *param)
{
    return (Qt::Alignment)(int)(*(goInt*)param);
}

inline void drvSetAlignment(void *param, Qt::Alignment value)
{
    *(goInt*)param = value;
}

// STS added EchoMode 2013-09-18
inline QLineEdit::EchoMode drvGetEchoMode(void *param)
{
    return (QLineEdit::EchoMode)(*(goInt*)param);
}

inline void drvSetEchoMode(void *param, QLineEdit::EchoMode value)
{
    *(goInt*)param = value;
}


inline Qt::Orientation drvGetOrientation(void *param)
{
    return (Qt::Orientation)(*(goInt*)param);
}

inline void drvSetOrientation(void *param, Qt::Orientation value)
{
    *(goInt*)param = value;
}

inline QSlider::TickPosition drvGetTickPosition(void *param)
{
    return (QSlider::TickPosition)(*(goInt*)param);
}

inline void drvSetTickPosition(void *param, QSlider::TickPosition value)
{
    *(goInt*)param = value;
}

inline Qt::ToolButtonStyle drvGetToolButtonStyle(void *param)
{
    return (Qt::ToolButtonStyle)(*(goInt*)param);
}

inline void drvSetToolButtonStyle(void *param, Qt::ToolButtonStyle value)
{
    *(goInt*)param = value;
}

inline QToolButton::ToolButtonPopupMode drvGetToolButtonPopupMode(void *param)
{
    return (QToolButton::ToolButtonPopupMode)(*(goInt*)param);
}

inline void drvSetToolButtonPopupMode(void *param, QToolButton::ToolButtonPopupMode value)
{
    *(goInt*)param = value;
}


inline double drvGetFloat64(void *param)
{
    return *(double*)param;
}

inline void drvSetFloat64(void *param, double value)
{
    *(double*)param = value;
}

inline void drvSetHandle(void *param, void *obj)
{
    if (obj && param) {
        handle_head *head = (handle_head*)param;
        head->native = obj;
    }
}

inline void* drvGetNative(void *param)
{
    if (param == 0) {
        return 0;
    }
    return ((handle_head*)param)->native;
}

inline QObject* drvGetObject(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QObject*)((handle_head*)param)->native;
}

inline void drvSetObject(void *param, QObject *object)
{
    drvSetHandle(param, object);
}

inline QWidget* drvGetWidget(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QWidget*)((handle_head*)param)->native;
}

inline void drvSetWidget(void *param, QWidget *widget)
{
    drvSetHandle(param, widget);
}

inline QLayout* drvGetLayout(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QLayout*)((handle_head*)param)->native;
}

inline QMenu* drvGetMenu(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QMenu*)((handle_head*)param)->native;
}

inline QMenuBar* drvGetMenuBar(void *param)
{
    return (QMenuBar*)drvGetNative(param);
}

inline QHeaderView* drvGetHeaderView(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QHeaderView*)drvGetNative(param);
}

inline void drvSetHeaderView(void *param, QHeaderView* header)
{
    drvSetHandle(param, header);
}

inline QAction* drvGetAction(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QAction*)((handle_head*)param)->native;
}

inline QIcon drvGetIcon(void *param)
{
    QIcon *icon = (QIcon*)drvGetNative(param);
    if (!icon) {
        return QIcon();
    }
    return *icon;
}

inline void drvSetModelIndex(void *param, QModelIndex index)
{
    drvSetHandle(param, &index);
}

inline QModelIndex drvGetModelIndex(void *param)
{
    QModelIndex *index = (QModelIndex *)drvGetNative(param);
    if (!index) {
        return QModelIndex();
    }
    return *index;
}


inline void drvSetIcon(void *param, const QIcon &icon)
{
    drvSetHandle(param, theApp->insertIcon(icon));
}

inline QFont drvGetFont(void *param)
{
    QFont *font = (QFont*)drvGetNative(param);
    if (!font) {
        return QFont();
    }
    return *font;
}

inline void drvSetFont(void *param, const QFont &font)
{
    drvSetHandle(param, theApp->insertFont(font));
}

inline void drvSetAction(void *param, QAction *act)
{
    drvSetHandle(param, act);
}

inline void drvSetMenu(void *param, QMenu *menu)
{
    drvSetHandle(param, menu);
}

inline void drvSetMenuBar(void *param, QMenuBar *bar)
{
    drvSetHandle(param, bar);
}

inline void drvSetStatusBar(void *param, QStatusBar *bar)
{
    drvSetHandle(param, bar);
}

inline QStatusBar* drvGetStatusBar(void *param)
{
    return (QStatusBar*)drvGetNative(param);
}

inline QToolBar* drvGetToolBar(void *param)
{
    return (QToolBar*)drvGetNative(param);
}

inline QDockWidget* drvGetDockWidget(void *param)
{
    return (QDockWidget*)drvGetNative(param);
}

inline QListWidgetItem* drvGetListWidgetItem(void *param)
{
    return (QListWidgetItem*)drvGetNative(param);
}

inline void drvSetListWidgetItem(void *param, QListWidgetItem* item)
{
    drvSetHandle(param, item);
}

inline QTableWidgetItem* drvGetTableWidgetItem(void *param)
{
    return (QTableWidgetItem*)drvGetNative(param);
}

inline void drvSetTableWidgetItem(void *param, QTableWidgetItem* item)
{
    drvSetHandle(param, item);
}

inline QPixmap drvGetPixmap(void *param)
{
    QPixmap *pixmap = (QPixmap*)drvGetNative(param);
    if (!pixmap) {
        return QPixmap();
    }
    return *pixmap;
}

inline void drvSetPixmap(void *param, const QPixmap &pixmap)
{
    drvSetHandle(param, theApp->insertPixmap(pixmap));
}

inline void drvSetPixmap(void *param, const QPixmap *pixmap)
{
    if (pixmap == 0) {
        return;
    }
    drvSetHandle(param, theApp->insertPixmap(*pixmap));
}

inline QImage drvGetImage(void *param)
{
    QImage *image = (QImage*)drvGetNative(param);
    if (!image) {
        return QImage();
    }
    return *image;
}

inline void drvSetImage(void *param, const QImage &image)
{
    drvSetHandle(param, theApp->insertImage(image));
}

inline void drvSetImage(void *param, const QImage *image)
{
    if (image == 0) {
        return;
    }
    drvSetHandle(param, theApp->insertImage(*image));
}

inline QPen drvGetPen(void *param)
{
    QPen *pen = (QPen*)drvGetNative(param);
    if (!pen) {
        return QPen();
    }
    return *pen;
}

inline void drvSetPen(void *param, const QPen &pen)
{
    drvSetHandle(param, theApp->insertPen(pen));
}

inline QBrush drvGetBrush(void *param)
{
    QBrush *brush = (QBrush*)drvGetNative(param);
    if (!brush) {
        return QBrush();
    }
    return *brush;
}

inline void drvSetBrush(void *param, const QBrush &brush)
{
    drvSetHandle(param, theApp->insertBrush(brush));
}

inline void drvNewObj(void *a0, QObject *obj, bool reg = true)
{
    handle_head *head = (handle_head*)a0;
    head->native = obj;
    if (reg) {
        QObject::connect(obj, SIGNAL(destroyed(QObject*)), theApp, SLOT(deleteObject(QObject*)));
    }
}

inline void drvNewObj(void *a0, QWidget *obj, bool reg = true, bool delete_close = true)
{
    handle_head *head = (handle_head*)a0;
    head->native = obj;
    if (delete_close) {
        obj->setAttribute(Qt::WA_DeleteOnClose);
    }
    if (reg) {
        QObject::connect(obj, SIGNAL(destroyed(QObject*)), ((QtApp*)qApp), SLOT(deleteObject(QObject*)));
    }
}

inline void drvNewObj(void *a0, void *obj)
{
    handle_head *head = (handle_head*)a0;
    head->native = obj;
}

template <typename T>
inline void drvDelObj(void *a0, T *obj)
{
    if (obj != 0) {
        delete obj;
        obj = 0;
    }

    if (a0 == 0) {
        return;
    }

    handle_head *head = (handle_head*)a0;
    if (head->native == 0 || head->native == drvInvalid) {
        return;
    }
    head->native = 0;
}

inline void drvDelFont(void *a0, QFont *font)
{
    theApp->removeFont(font);
    drvDelObj(a0, font);
}

inline void drvDelIcon(void *a0, QIcon *icon)
{
    theApp->removeIcon(icon);
    drvDelObj(a0, icon);
}

inline void drvDelPixmap(void *a0, QPixmap *pixmap)
{
    theApp->removePixmap(pixmap);
    drvDelObj(a0, pixmap);
}

inline void drvDelImage(void *a0, QImage *image)
{
    theApp->removeImage(image);
    drvDelObj(a0, image);
}

inline void drvDelPen(void *a0, QPen *pen)
{
    theApp->removePen(pen);
    drvDelObj(a0, pen);
}

inline void drvDelBrush(void *a0, QBrush *brush)
{
    theApp->removeBrush(brush);
    drvDelObj(a0, brush);
}

inline QtSignal* drvNewSignal(QObject *parent, void *fn, void *param = 0)
{
    QtSignal *s = new QtSignal(0, fn);
    s->moveToThread(parent->thread());
    s->setParent(parent);
    return s;
}

inline void drvNewEvent(int type, void *a0, void *a1, void *a2 = 0)
{
    handle_head* head = (handle_head*)a0;
    QObject *obj = (QObject*)head->native;
    QtApp *app = (QtApp*)qApp;
    app->eventLock.lock();
    QtEvent *ev = ((QtApp*)qApp)->eventMap.value(obj);
    if (ev == 0) {
        ev = new QtEvent;
        ev->moveToThread(obj->thread());
        ev->setParent(obj);
        obj->installEventFilter(ev);
        ((QtApp*)qApp)->eventMap.insert(obj, ev);
    }
    ev->setEvent(type, a1);
    app->eventLock.unlock();
}


int drv_callback(void* fn, void *a1, void* a2, void* a3, void* a4);
int drv_result(void* ch, int r);
int drv_appmain();

extern "C"
int QTDRVSHARED_EXPORT drv(int drvclass, int drvid, void *exp, void *a0, void* a1, void* a2, void* a3, void* a4, void* a5, void* a6);

int _drv(int drvclass, int drvid, void *a0, void* a1, void* a2, void* a3, void* a4, void* a5, void* a6);

inline Qt::AspectRatioMode drvGetAspectRatioMode(void *param)
{
    return (Qt::AspectRatioMode)(*(goInt*)param);
}

inline Qt::TransformationMode drvGetTransformationMode(void *param)
{
    return (Qt::TransformationMode)(*(goInt*)param);
}

inline QSizePolicy::Policy drvGetSizePolicyPolicy(void *param)
{
    if (param == 0) {
        return QSizePolicy::Fixed;
    }

    return (QSizePolicy::Policy)(*(goInt*)param);
}

inline void drvSetSizePolicyPolicy(void *param, QSizePolicy::Policy policy)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)policy;
}

inline QSizePolicy::ControlType drvGetSizePolicyControlType(void *param)
{
    if (param == 0) {
        return QSizePolicy::DefaultType;
    }

    return (QSizePolicy::ControlType)(*(goInt*)param);
}

inline void drvSetSizePolicyControlType(void *param, QSizePolicy::ControlType control)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)control;
}

inline void drvSetSizePolicy(void *param, const QSizePolicy &p) // FIXME
{
    QSizePolicy* policy = (QSizePolicy*)drvGetNative(param);
    if (policy == 0) {
        drvSetHandle(param, new QSizePolicy(p));
        return;
    }
    *policy = p;
}

inline QSizePolicy drvGetSizePolicy(void *param) // FIXME
{
    QSizePolicy* policy = (QSizePolicy*)drvGetNative(param);
    if (policy == 0) {
        return QSizePolicy();
    }

    return QSizePolicy(*policy);
}

inline void drvSetScrollBar(void *param, const QScrollBar *scrollbar)
{
    if (scrollbar == 0) {
        return;
    }
    drvSetHandle(param, (void*)scrollbar);
}

inline QMultimedia::AvailabilityStatus drvGetMediaAvailabilityStatus(void *param)
{
    if (param == 0) {
        return QMultimedia::Available;
    }

    return (QMultimedia::AvailabilityStatus)(*(goInt*)param);
}

inline void drvSetMediaAvailabilityStatus(void *param, QMultimedia::AvailabilityStatus status)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)status;
}

inline QMultimedia::EncodingMode drvGetMediaEncodingMode(void *param)
{
    if (param == 0) {
        return QMultimedia::ConstantQualityEncoding;
    }

    return (QMultimedia::EncodingMode)(*(goInt*)param);
}

inline void drvSetMediaEncodingMode(void *param, QMultimedia::EncodingMode mode)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)mode;
}

inline QMultimedia::EncodingQuality drvGetMediaEncodingQuality(void *param)
{
    if (param == 0) {
        return QMultimedia::NormalQuality;
    }

    return (QMultimedia::EncodingQuality)(*(goInt*)param);
}

inline void drvSetMediaEncodingQuality(void *param, QMultimedia::EncodingQuality quality)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)quality;
}

inline QMediaPlaylist::Error drvGetMediaPlaylistError(void *param)
{
    if (param == 0) {
        return QMediaPlaylist::NoError;
    }

    return (QMediaPlaylist::Error)(*(goInt*)param);
}

inline void drvSetMediaPlaylistError(void *param, QMediaPlaylist::Error error)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)error;
}

inline QMediaPlaylist::PlaybackMode drvGetMediaPlaylistPlaybackMode(void *param)
{
    if (param == 0) {
        return QMediaPlaylist::CurrentItemOnce;
    }

    return (QMediaPlaylist::PlaybackMode)(*(goInt*)param);
}

inline void drvSetMediaPlaylistPlaybackMode(void *param, QMediaPlaylist::PlaybackMode mode)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)mode;
}

inline QIODevice::OpenMode drvGetIODeviceOpenMode(void *param)
{
    if (param == 0) {
        return QIODevice::NotOpen;
    }

    return (QIODevice::OpenMode)(int)(*(goInt*)param);
}

inline void drvSetIODeviceOpenMode(void *param, QIODevice::OpenMode mode)
{
    if (param == 0) {
        return;
    }

    (*(goInt*)param) = (int)mode;
}

inline QIODevice* drvGetIODevice(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QIODevice*)((handle_head*)param)->native;
}

inline void drvSetIODevice(void *param, QIODevice* device)
{
    drvSetHandle(param, device);
}

inline QIODevice* drvGetFile(void *param)
{
    if (param == 0) {
        return 0;
    }
    return (QFile*)((handle_head*)param)->native;
}

inline void drvSetFile(void *param, QFile* file)
{
    drvSetHandle(param, file);
}

inline QFileDevice::Permissions drvGetFileDevicePermissions(void *param)
{
    return (QFileDevice::Permissions)(int)(*(goInt*)param);
}

inline void drvSetFileDevicePermissions(void *param, QFileDevice::Permissions value)
{
    *(goInt*)param = value;
}