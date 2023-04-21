script="
from django.contrib.auth.models import User;
username = 'labapp';
password = '123';
email = '1@1.com';
if User.objects.filter(username=username).count()==0:
    User.objects.create_superuser(username, email, password);
    print('Superuser created.');
else:
    print('Superuser creation skipped.');
"
printf "$script" | python manage.py shell
