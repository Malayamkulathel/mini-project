from django.db import models

# Create your models here.

class Login(models.Model):
    Username=models.CharField(max_length=50)
    Password=models.CharField(max_length=50)
    Type=models.CharField(max_length=15)


class User(models.Model):
    LOGIN=models.ForeignKey(Login,on_delete=models.CASCADE)
    Name=models.CharField(max_length=50)
    Phone=models.CharField(max_length=50)
    Image=models.FileField()

class Category(models.Model):

    Name=models.CharField(max_length=50)
    Image=models.FileField()


class Transaction(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    CATEGORY=models.ForeignKey(Category,on_delete=models.CASCADE)
    Date=models.DateField()
    Details=models.CharField(max_length=50)
    Type=models.CharField(max_length=50)
    Amount=models.IntegerField()
class Threshold(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    Threshold=models.IntegerField()
    Date=models.DateField()

class Notification(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)
    Notification=models.CharField(max_length=100)
    Status=models.CharField(max_length=100)
    Date=models.DateField()

class Feedback(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)

    Date=models.DateField()
    Feedback=models.CharField(max_length=50)

class Complaint(models.Model):
    USER=models.ForeignKey(User,on_delete=models.CASCADE)

    Date=models.DateField()
    Complaint=models.CharField(max_length=50)
    Reply=models.CharField(max_length=50)
