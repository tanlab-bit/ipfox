#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import smtplib
import socket
from email.header import Header
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from time import asctime


def send_an_email(email_content):  # email_content是一个字符串
    mail_host = "smtp.163.com"  # 这个去邮箱找
    mail_user = "bitqiuyu@163.com"
    mail_auth_code = "YCQVNMUZPOLQETIM"  # 授权码
    mail_sender = mail_user  # 用mail_user 作为发送人
    mail_receivers = ["pengrongq@163.com"]
    message = MIMEMultipart()
    message["From"] = Header(mail_sender)  # 寄件人
    message["Subject"] = Header("cs928-1080本机ip地址")
    message.attach(MIMEText(asctime(), "plain", "utf-8"))
    message.attach(MIMEText(email_content, "plain", "utf-8"))
    print("message is {}".format(message.as_string()))  # debug用
    smtpObj = smtplib.SMTP(mail_host)
    # smtpObj.set_debuglevel(1) # 同样是debug用的
    smtpObj.login(mail_user, mail_auth_code)  # 登陆
    smtpObj.sendmail(mail_sender, mail_receivers, message.as_string())  # 真正发送邮件就是这里


def get_ip():
    # hostname = socket.gethostname()
    # addr_infos = socket.getaddrinfo(hostname, None)
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(("8.8.8.8", 80))
    res = s.getsockname()[0]
    print(res)
    # ips = set([addr_info[-1][0] for addr_info in addr_infos])
    # global_ips = [ip for ip in ips if ip.startswith("24")]
    # print(global_ips)
    # whether_to_send, send_ip = get_temp_ip(global_ips)
    # send_ip = json.dumps(send_ip)
    send_ip = res
    whether_to_send = True
    return whether_to_send, send_ip


if __name__ == "__main__":
    whether_to_send, global_ips = get_ip()
    if whether_to_send:
        send_an_email(global_ips)
    else:
        print("wait and no send")
