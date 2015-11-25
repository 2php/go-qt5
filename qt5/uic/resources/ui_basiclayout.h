/********************************************************************************
** Form generated from reading UI file 'basiclayout.ui'
**
** Created by: Qt User Interface Compiler version 5.5.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_BASICLAYOUT_H
#define UI_BASICLAYOUT_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QCheckBox>
#include <QtWidgets/QDoubleSpinBox>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpinBox>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Form
{
public:
    QVBoxLayout *verticalLayout;
    QLabel *titleLabel;
    QPushButton *buttonExample;
    QCheckBox *checkBoxButton;
    QDoubleSpinBox *numberEdit;
    QSpinBox *intSpinBox;

    void setupUi(QWidget *Form)
    {
        if (Form->objectName().isEmpty())
            Form->setObjectName(QStringLiteral("Form"));
        Form->resize(624, 514);
        QSizePolicy sizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
        sizePolicy.setHorizontalStretch(3);
        sizePolicy.setVerticalStretch(3);
        sizePolicy.setHeightForWidth(Form->sizePolicy().hasHeightForWidth());
        Form->setSizePolicy(sizePolicy);
        Form->setMinimumSize(QSize(10, 10));
        verticalLayout = new QVBoxLayout(Form);
        verticalLayout->setObjectName(QStringLiteral("verticalLayout"));
        verticalLayout->setContentsMargins(15, 15, 15, 15);
        titleLabel = new QLabel(Form);
        titleLabel->setObjectName(QStringLiteral("titleLabel"));

        verticalLayout->addWidget(titleLabel);

        buttonExample = new QPushButton(Form);
        buttonExample->setObjectName(QStringLiteral("buttonExample"));

        verticalLayout->addWidget(buttonExample);

        checkBoxButton = new QCheckBox(Form);
        checkBoxButton->setObjectName(QStringLiteral("checkBoxButton"));
        checkBoxButton->setChecked(true);

        verticalLayout->addWidget(checkBoxButton);

        numberEdit = new QDoubleSpinBox(Form);
        numberEdit->setObjectName(QStringLiteral("numberEdit"));
        numberEdit->setValue(15);

        verticalLayout->addWidget(numberEdit);

        intSpinBox = new QSpinBox(Form);
        intSpinBox->setObjectName(QStringLiteral("intSpinBox"));
        intSpinBox->setValue(2);

        verticalLayout->addWidget(intSpinBox);


        retranslateUi(Form);

        QMetaObject::connectSlotsByName(Form);
    } // setupUi

    void retranslateUi(QWidget *Form)
    {
        Form->setWindowTitle(QApplication::translate("Form", "Form", 0));
        titleLabel->setText(QApplication::translate("Form", "This is our test widget", 0));
        buttonExample->setText(QApplication::translate("Form", "Push Me!", 0));
        checkBoxButton->setText(QApplication::translate("Form", "Is this working?", 0));
    } // retranslateUi

};

namespace Ui {
    class Form: public Ui_Form {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_BASICLAYOUT_H
