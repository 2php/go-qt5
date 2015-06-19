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

#ifndef QTSHELL_H
#define QTSHELL_H

#include "qtapp.h"
#include <QListWidgetItem>
#include <QStandardItem>

class ShellListWidgetItem : public QListWidgetItem
{
public:
    ShellListWidgetItem() : QListWidgetItem()
    {
    }

    ShellListWidgetItem(const QString &text) : QListWidgetItem(text)
    {

    }

    ~ShellListWidgetItem()
    {
        theApp->deleteObj(this);
    }
};

class ShellStandardItem : public QStandardItem
{
public:
    ShellStandardItem() : QStandardItem()
    {
    }

    ShellStandardItem(const QString & text) : QStandardItem(text)
    {
    }

    ShellStandardItem(const QIcon & icon, const QString & text) : QStandardItem(icon, text)
    {
    }

    ShellStandardItem(int rows, int columns = 1) : QStandardItem(rows, columns)
    {
    }

    ~ShellStandardItem()
    {
        theApp->deleteObj(this);
    }
};

class ShellModelIndex : public QModelIndex
{
public:
    ShellModelIndex() : QModelIndex()
    {
    }

    QString stringData()
    {
        return QModelIndex::data().toString();
    }

    int integerData()
    {
        return QModelIndex::data().toInt();
    }

    double floatData()
    {
        return QModelIndex::data().toDouble();
    }

    ~ShellModelIndex()
    {
        theApp->deleteObj(this);
    }
};

#endif // QTSHELL_H
