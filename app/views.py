from django.contrib import messages
from django.contrib.auth import update_session_auth_hash
from django.core.files.storage import FileSystemStorage
from django.http.response import HttpResponse
from django.shortcuts import render, redirect
from .models import *
from datetime import datetime
# Create your views here.
def main(request):
    return render(request,"login2.html")

def adminhome(request):
    ob=User.objects.all()
    uc=len(ob)
    request.session['uc']=uc

    ob=Feedback.objects.all()
    fc=len(ob)
    request.session['fc']=fc

    comp=Complaint.objects.filter(Reply='pending')
    request.session['cc']=len(comp)
    return render(request,"Admin/admin.html")

def registration_code(request):
    name=request.POST['name']
    phone=request.POST['phone']
    email=request.POST['email']
    image=request.FILES['image']
    password=request.POST['password']
    ob=Login()
    ob.Username=email
    ob.Password=password
    ob.Type='user'
    ob.save()

    obu=User()
    obu.Name=name
    obu.Phone=phone
    obu.Image=image
    obu.LOGIN=ob
    obu.save()
    request.session['lid']=ob.id
    request.session['name']=obu.Name
    request.session['img']=obu.Image.url
    return redirect("/user_home")


def login(request):
    uname=request.POST['username']
    pwd=request.POST['pass']
    try:
        ob=Login.objects.get(Username=uname,Password=pwd)
        if ob.Type=='admin':

            request.session['name'] = "Admin"
            request.session['img'] = "/media/logo.png"
            return HttpResponse('''<script>alert('Welcome');window.location='/adminhome'</script>''')
        elif ob.Type == "user":

            request.session['lid'] = ob.id
            obu=User.objects.get(LOGIN__id=ob.id)
            request.session['name'] = obu.Name
            request.session['img'] = obu.Image.url
            return redirect("/user_home")
            return HttpResponse('''<script>alert('Welcome');window.location='/user_home'</script>''')
    except:
        return HttpResponse('''<script>alert('Invalid username or password');window.location='/'</script>''')
    return render(request, "Users/userindex.html")



def user_home(request):
    obex=Transaction.objects.filter(USER__LOGIN__id=request.session['lid'],Type='Expense',Date__year=datetime.now().strftime("%Y"),Date__month=datetime.now().strftime("%m"))
    texp=0
    for i in obex:
        texp+=i.Amount
    obex = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                      Date__year=datetime.now().strftime("%Y"))
    yexp = 0
    for i in obex:
        yexp += i.Amount
    obin=Transaction.objects.filter(USER__LOGIN__id=request.session['lid'],Type='Income',Date__year=datetime.now().strftime("%Y"),Date__month=datetime.now().strftime("%m"))
    tinc=0
    for i in obin:
        tinc+=i.Amount
    obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                      Date__year=datetime.now().strftime("%Y"))
    yinc = 0
    for i in obin:
        yinc += i.Amount
    s=False
    per=0
    obs=Threshold.objects.filter(USER__LOGIN__id=request.session['lid'])
    if len(obs)>0:
        s=True
        tamt=obs[0].Threshold
        per=(texp/tamt)*100
        if per>100:
            per=100
        per=str(per).split(".")[0]
    #     Expense graph
    elist=[]
    for i in range(1,13):
        obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                          Date__year=datetime.now().strftime("%Y"),
                                          Date__month=i)
        listsum = 0
        for j in obin:
            listsum += j.Amount
        elist.append(listsum)
    # print(elist,"expl")

    # income graph
    ilist = []
    for i in range(1, 13):
        obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                          Date__year=datetime.now().strftime("%Y"),
                                          Date__month=i)
        listsum = 0
        for j in obin:
            listsum += j.Amount
        ilist.append(listsum)
    # print(elist, "expl")


    # ================= expense details
    expensedetails = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                      Date__year=datetime.now().strftime("%Y"),
                                      Date__month=datetime.now().strftime("%m"))
    edlist=[]
    typelist=[]
    expenseamt=[]
    tamt=0
    for i in expensedetails:
        tamt+=i.Amount
        if i.CATEGORY.Name not in typelist:
            typelist.append(i.CATEGORY.Name)
            expenseamt.append(i.Amount)
        else:
            index=typelist.index(i.CATEGORY.Name)
            expenseamt[index]+=i.Amount
    for i in range(0,len(expenseamt)):
        d={"cat":typelist[i],"amt":str(expenseamt[i])+"/"+str(tamt),"p":str((expenseamt[i]/tamt)*100).split(".")[0]}
        edlist.append(d)

    # ================= expense details
    expensedetails = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                                Date__year=datetime.now().strftime("%Y"),
                                                Date__month=datetime.now().strftime("%m"))
    idlist = []
    typelist = []
    expenseamt = []
    tamt = 0
    for i in expensedetails:
        tamt += i.Amount
        if i.CATEGORY.Name not in typelist:
            typelist.append(i.CATEGORY.Name)
            expenseamt.append(i.Amount)
        else:
            index = typelist.index(i.CATEGORY.Name)
            expenseamt[index] += i.Amount
    for i in range(0, len(expenseamt)):
        d = {"cat": typelist[i], "amt": str(expenseamt[i]) + "/" + str(tamt),
             "p": str((expenseamt[i] / tamt) * 100).split(".")[0]}
        idlist.append(d)

    nob=Notification.objects.filter(USER__LOGIN__id=request.session['lid'],Status='pending').order_by("-id")
    nc=""
    if len(nob)>0:
        nc=str(len(nob))+"+"


    return render(request, "Users/userindex.html",{"mex":texp,"yex":yexp,"min":tinc,"yin":yinc,"s":s,"p":per,"expl":elist,'ilist':ilist,"edlist":edlist,"idlist":idlist,"nc":nc,"nob":nob})

def Expense(request):
    ob=Category.objects.all()
    ob1=Transaction.objects.filter(USER__LOGIN__id=request.session['lid'],Type='Expense').order_by('-Date')
    return render(request, "Users/expense.html",{"val":ob,"val1":ob1})

def deleteexpense(request,id):

    ob1=Transaction.objects.get(id=id)
    ob1.delete()
    return redirect("/Expense")

def addexpense(request):
    cat=request.POST['cat']
    date=request.POST['date']
    amt=request.POST['amount']
    Details=request.POST['Details']
    ob=Transaction()
    ob.USER=User.objects.get(LOGIN__id=request.session['lid'])
    ob.CATEGORY=Category.objects.get(id=cat)
    ob.Date=date
    ob.Details=Details
    ob.Type='Expense'
    ob.Amount=amt
    ob.save()

    obex = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                      Date__year=datetime.now().strftime("%Y"),
                                      Date__month=datetime.now().strftime("%m"))
    texp = 0
    for i in obex:
        texp += i.Amount

    ob=Threshold.objects.filter(USER__LOGIN__id=request.session['lid'])

    if len(ob)>0:
        if ob[0].Threshold<texp:
            obn=Notification()
            obn.USER=User.objects.get(LOGIN__id=request.session['lid'])
            obn.Notification="You exceeded your current target of ₹"+str(ob[0].Threshold)+", you already spend ₹"+str(texp)
            obn.Status='pending'
            obn.Date=datetime.today()
            obn.save()




    return redirect('/user_home')

def Income(request):
    ob=Category.objects.all()
    ob1 = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense').order_by('-Date')
    return render(request, "Users/income.html",{"val":ob,"val1":ob1})

def deleteincome(request,id):

    ob1=Transaction.objects.get(id=id)
    ob1.delete()
    return redirect("/Income")
def Settings(request):
    ob=Threshold.objects.filter(USER__LOGIN__id=request.session['lid'])
    v=""
    if len(ob)>0:
        v=ob[0].Threshold
    return render(request, "Users/settings.html",{"v":v})

def addSettings(request):

    amt=request.POST['amount']
    ob = Threshold.objects.filter(USER__LOGIN__id=request.session['lid'])
    v = ""
    if len(ob) > 0:
        ob=ob[0]
    else:
        ob=Threshold()
    ob.Threshold=amt
    ob.Date=datetime.today()
    ob.USER=User.objects.get(LOGIN__id=request.session['lid'])
    ob.save()
    return redirect('/user_home')

def addIncome(request):
    cat=request.POST['cat']
    date=request.POST['date']
    amt=request.POST['amount']
    Details=request.POST['Details']
    ob=Transaction()
    ob.USER=User.objects.get(LOGIN__id=request.session['lid'])
    ob.CATEGORY=Category.objects.get(id=cat)
    ob.Date=date
    ob.Details=Details
    ob.Type='Income'
    ob.Amount=amt
    ob.save()
    return redirect('/user_home')

def complaints(request):
    ob=Complaint.objects.filter(USER__LOGIN__id=request.session['lid'])
    return render(request,"Users/complaints.html",{"val":ob})

from _datetime import datetime, date, timedelta
import calendar

def get_dates_in_current_month():
    # Get the current year and month
    current_year = datetime.now().year
    current_month = datetime.now().month

    # Get the number of days in the current month
    num_days = calendar.monthrange(current_year, current_month)[1]

    # Create a list of all dates in the current month
    dates_in_month = [date(current_year, current_month, day) for day in range(1, num_days + 1)]

    return dates_in_month

def get_current_week_dates():
    # Get today's date
    today = datetime.today()

    # Find the start of the current week (Monday)
    start_of_week = today - timedelta(days=today.weekday())

    # Generate all days from Monday to Sunday
    week_dates = [start_of_week + timedelta(days=i) for i in range(7)]

    return week_dates

def report(request):
    current_year = datetime.now().year
    current_month = datetime.now().month
    current_week = datetime.now().isocalendar()[1]  # ISO week number

    # Get the report type from the request (default to 'yearly')
    report_type = request.GET.get('report_type', 'yearly')

    records = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'])
    elist = []
    ilist = []
    x=[]
    # Filter records based on the selected report type
    if report_type == 'yearly':
        # Filter by current year
        records = records.filter(Date__year=current_year)
        report_title = f"Yearly Report - {current_year}"


        for i in range(1, 13):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                              Date__year=datetime.now().strftime("%Y"),
                                              Date__month=i)
            listsum = 0
            x.append(i)
            for j in obin:
                listsum += j.Amount
            elist.append(listsum)
        print(elist, "expl")

        # income graph

        for i in range(1, 13):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                              Date__year=datetime.now().strftime("%Y"),
                                              Date__month=i)
            listsum = 0
            for j in obin:
                listsum += j.Amount
            ilist.append(listsum)
        print(elist, "expl")




    elif report_type == 'monthly':


        # Filter by current month and year
        records = records.filter(Date__year=current_year, Date__month=current_month)
        report_title = f"Monthly Report - {datetime.now().strftime('%B %Y')}"
        dates = get_dates_in_current_month()
        for i in range(len(dates)):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                              Date=dates[i] )
            listsum = 0
            x.append(i+1)
            for j in obin:
                listsum += j.Amount
            elist.append(listsum)
        print(elist, "expl")

        # income graph

        for i in range(len(dates)):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                              Date=dates[i])
            listsum = 0
            for j in obin:
                listsum += j.Amount
            ilist.append(listsum)
        print(elist, "expl")




    elif report_type == 'weekly':
        # Filter by current year and week
        records = records.filter(Date__year=current_year, Date__week=current_week)
        report_title = f"Weekly Report - Week {current_week}, {current_year}"

        dates = get_current_week_dates()
        for i in range(len(dates)):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Expense',
                                              Date=dates[i])
            listsum = 0
            x.append(i + 1)
            for j in obin:
                listsum += j.Amount
            elist.append(listsum)
        print(elist, "expl")

        # income graph

        for i in range(len(dates)):
            obin = Transaction.objects.filter(USER__LOGIN__id=request.session['lid'], Type='Income',
                                              Date=dates[i])
            listsum = 0
            for j in obin:
                listsum += j.Amount
            ilist.append(listsum)
        print(elist, "expl")

    else:
        # Default to yearly report
        records = records.filter(date__year=current_year)
        report_title = f"Yearly Report - {current_year}"







    texp=0
    tincm=0
    for i in records:
        if i.Type == "Expense":
            texp+=i.Amount
        else:
            tincm+=i.Amount
    res="Nutral"
    pamt=0
    if tincm>texp:
        pamt = tincm - texp
        res="Profit"
    elif texp>tincm:
        pamt =  texp- tincm
        res="Loss"

    edlist = []
    typelist = []
    expenseamt = []
    tamt = 0
    for i in records:
        if i.Type == "Expense":
            tamt += i.Amount
            if i.CATEGORY.Name not in typelist:
                typelist.append(i.CATEGORY.Name)
                expenseamt.append(i.Amount)
            else:
                index = typelist.index(i.CATEGORY.Name)
                expenseamt[index] += i.Amount
    for i in range(0, len(expenseamt)):
        d = {"cat": typelist[i], "amt": str(expenseamt[i]) + "/" + str(tamt),
             "p": str((expenseamt[i] / tamt) * 100).split(".")[0]}
        edlist.append(d)

    # ================= expense details

    idlist = []
    typelist = []
    expenseamt = []
    tamt = 0
    for i in records:
        if i.Type == "Income":
            tamt += i.Amount
            if i.CATEGORY.Name not in typelist:
                typelist.append(i.CATEGORY.Name)
                expenseamt.append(i.Amount)
            else:
                index = typelist.index(i.CATEGORY.Name)
                expenseamt[index] += i.Amount
    for i in range(0, len(expenseamt)):
        d = {"cat": typelist[i], "amt": str(expenseamt[i]) + "/" + str(tamt),
             "p": str((expenseamt[i] / tamt) * 100).split(".")[0]}
        idlist.append(d)











    context = {
        'records': records,
        'report_type': report_type,
        'report_title': report_title,
        "res":res,
        "pamt":pamt,
        "te":texp,"ti":tincm,"expl":elist,'ilist':ilist,"x":x,"edlist":edlist,"idlist":idlist
    }
    return render(request,"Users/report.html",context)

def addcomplaints(request):
    ob=Complaint()
    ob.Complaint=request.POST['comp']
    ob.Date=datetime.today()
    ob.USER=User.objects.get(LOGIN__id=request.session['lid'])
    ob.Reply='pending'
    ob.save()



    return redirect('/complaints')

def feedback(request):
    ob = Feedback.objects.filter(USER__LOGIN__id=request.session['lid'])
    return render(request, "Users/feedback.html", {"val": ob})
def deletefeedback(request,id):
    ob = Feedback.objects.get(id=id)
    ob.delete()
    return redirect("/feedback")
def deletecomplaint(request,id):
    ob = Complaint.objects.get(id=id)
    ob.delete()
    return redirect("/complaints")
def addfeedback(request):
    ob = Feedback()
    ob.Feedback=request.POST['fbk']
    ob.Date = datetime.today()
    ob.USER = User.objects.get(LOGIN__id=request.session['lid'])

    ob.save()
    return redirect("/feedback")

def profile(request):
    ob=User.objects.get(LOGIN__id=request.session['lid'])
    return render(request,"Users/profile.html",{"i":ob})

def updateprofile(request):
    ob=User.objects.get(LOGIN__id=request.session['lid'])
    return render(request,"Users/updateprofile.html",{"i":ob})


def update_post(request):
    try:
        name = request.POST['name']
        phone = request.POST['phone']
        email = request.POST['email']
        image = request.FILES['image']
        fs=FileSystemStorage()
        fsave=fs.save(image.name,image)
        obu = User.objects.get(LOGIN__id=request.session['lid'])
        obu.Name = name
        obu.Phone = phone
        obu.Image = fsave
        obu.save()
        kk = Login.objects.get(id=request.session['lid'])
        kk.Username=email
        kk.save()
        return redirect("/profile")
    except:
        name = request.POST['name']
        phone = request.POST['phone']
        email = request.POST['email']
        obu = User.objects.get(LOGIN__id=request.session['lid'])
        obu.Name = name
        obu.Phone = phone
        obu.save()
        kk = Login.objects.get(id=request.session['lid'])
        kk.Username = email
        kk.save()
        return redirect("/profile")


def view_noti(request):
    ob=Notification.objects.filter(USER__LOGIN__id=request.session['lid']).order_by("-id")
    for i in ob:
        i.Status="viewed"
        i.save()
    return render(request,"Users/noti.html",{"data":ob})



def admin_view_users(request):
    ob=User.objects.all().order_by("-id")

    return render(request,"admin/users.html",{"data":ob})


def admin_view_feedback(request):
    ob=Feedback.objects.all().order_by("-id")
    return render(request,"admin/feedback.html",{"data":ob})


def admin_view_category(request):
    ob=Category.objects.all()

    return render(request,"admin/category.html",{"data":ob})

def addcat(request):
    img=request.FILES['img']
    cat=request.POST['cat']
    ob=Category()
    ob.Name=cat
    ob.Image=img
    ob.save()
    return redirect("/admin_view_category")
def deletecat(request,id):


    ob=Category.objects.get(id=id)

    ob.delete()
    return redirect("/admin_view_category")
def admin_view_complaints(request):
    ob=Complaint.objects.filter(Reply='pending').order_by("-id")

    return render(request,"admin/complaints.html",{"data":ob})
def admin_reply(request,id):
    request.session['rid']=id

    return render(request,"admin/reply.html")
def addreply(request):

    id=request.session['rid']
    oc=Complaint.objects.get(id=id)
    oc.Reply=request.POST['r']
    oc.save()

    return redirect("/admin_view_complaints")





def admin_view_complaints(request):
    ob=Complaint.objects.filter(Reply='pending').order_by("-id")
    return render(request,"admin/complaints.html",{"data":ob})



def chg_password(request):
    return render(request, "Users/change password.html")

def change_password(request):
    current_password = request.POST['current_password']
    new_password = request.POST['new_password']
    confirm_password = request.POST['confirm_password']
    ll=Login.objects.get(id=request.session['lid'])
    if current_password ==ll.Password :
        if new_password==confirm_password:
            ll.Password=confirm_password
            ll.save()
            return HttpResponse(
                '''<script>alert('current password changed into new password');window.location='/profile'</script>''')

        else:
            return HttpResponse('''<script>alert('new password not equal to confirm password');window.location='/profile'</script>''')
    else:
        return HttpResponse(
            '''<script>alert('current password wrong');window.location='/profile'</script>''')

