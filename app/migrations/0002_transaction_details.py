# Generated by Django 5.1 on 2024-10-23 19:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='transaction',
            name='Details',
            field=models.CharField(default=1, max_length=50),
            preserve_default=False,
        ),
    ]
