"""ExpenseTracker URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path,include

from ExpenseTracker import settings
from . import views
urlpatterns = [

    path('',views.main),
    path('registration_code',views.registration_code),
    path('login',views.login),
    path('user_home',views.user_home),
    path('Expense',views.Expense),
    path('addexpense',views.addexpense),
    path('Income',views.Income),
    path('addIncome',views.addIncome),
    path('addSettings',views.addSettings),
    path('Settings',views.Settings),
    path('addcomplaints',views.addcomplaints),
    path('complaints',views.complaints),
    path('feedback',views.feedback),
    path('addfeedback',views.addfeedback),
    path('deletefeedback/<id>',views.deletefeedback),
    path('deletecomplaint/<id>',views.deletecomplaint),
    path('deleteexpense/<id>',views.deleteexpense),
    path('deleteincome/<id>',views.deleteincome),
    path('profile/',views.profile),
    path('view_noti',views.view_noti),
    path('report',views.report),
    path('updateprofile',views.updateprofile),
    path('update_post',views.update_post),
    path('change_password',views.change_password),
    path('chg_password',views.chg_password),




    path('adminhome',views.adminhome),
    path('admin_view_users',views.admin_view_users),
    path('admin_view_feedback',views.admin_view_feedback),
    path('admin_view_complaints',views.admin_view_complaints),
    path('addreply',views.addreply),
    path('reply/<id>',views.admin_reply),
    path('deletecat/<id>',views.deletecat),
    path('admin_view_category',views.admin_view_category),
    path('addcat',views.addcat),
]
